Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278207AbRJLX5U>; Fri, 12 Oct 2001 19:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278206AbRJLX5K>; Fri, 12 Oct 2001 19:57:10 -0400
Received: from zero.aec.at ([195.3.98.22]:8465 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278205AbRJLX45>;
	Fri, 12 Oct 2001 19:56:57 -0400
Message-ID: <20011013015726.A28065@zero.firstfloor.org>
Date: Sat, 13 Oct 2001 01:57:26 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Simon Kirby <sim@netnation.com>, Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: Really slow netstat and /proc/net/tcp in 2.4
In-Reply-To: <20011011114736.A13722@netnation.com> <200110111930.XAA28404@ms2.inr.ac.ru> <20011011125538.C10868@netnation.com> <k2sncok4z2.fsf@zero.aec.at> <20011012151033.B12311@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <20011012151033.B12311@netnation.com>; from Simon Kirby on Fri, Oct 12, 2001 at 03:10:33PM -0700
X-Mutt-References: <20011012151033.B12311@netnation.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 03:10:33PM -0700, Simon Kirby wrote:
> On Fri, Oct 12, 2001 at 09:56:01PM +0200, Andi Kleen wrote:
> 
> > The hash table is likely to big anyways; eating cache and not helping that
> > much. If you're interested in some testing
> > I can send you patches to change it by hand and collect statistics for
> > average hash queue length. Then you can figure out a good size for your
> > workload with some work. Longer time I think the table sizing heuristics
> > are far too aggressive and need to be throttled back; but that needs more
> > data from real servers.
> 
> Wouldn't just counting the lines in /proc/net/tcp be sufficient to see
> how many buckets should be used in an ideal hash table distribution
> scenario?  (In which case the size of the hash table depends largely on a
> machine's work load...)

That won't tell you the list length of individual hash buckets. Keeping
that number in average slow is the goal of the big hash tables, but I suspect
the 2.4 ones are far too big; losing any possible benefit in cache non locality.

I attached a patch. It allows you to get some simple statistics from
/proc/net/sockstat (unfortunately costly too). It also adds a new kernel
boot argument tcpehashgoal=order. Order is the log2 of how many pages you
want to use for the hash table (so it needs 2^order * 4096 bytes on i386) 
You can experiment with various sizes and check which one gives still 
reasonable hash distribution under load.

The smallest one you can find is best.

BTW, it seems like the tables are 1/4 too big on SMP systems. the second
half reserved for time-wait have per bucket rwlocks too, but they're not 
used. If established and time-wait were split this wastage could be avoided. 
This way some memory (but not walk time) could be saved. It would also
lower the requirements on continuous memory by half; e.g. useful if tcp/ip
was ever turned into a module.

-Andi



--- net/ipv4/proc.c-o	Wed May 16 19:21:45 2001
+++ net/ipv4/proc.c	Sat Oct 13 03:37:55 2001
@@ -68,6 +68,7 @@
 {
 	/* From  net/socket.c  */
 	extern int socket_get_info(char *, char **, off_t, int);
+	extern int tcp_v4_hash_statistics(char *) ;
 
 	int len  = socket_get_info(buffer,start,offset,length);
 
@@ -82,6 +83,8 @@
 		       fold_prot_inuse(&raw_prot));
 	len += sprintf(buffer+len, "FRAG: inuse %d memory %d\n",
 		       ip_frag_nqueues, atomic_read(&ip_frag_mem));
+	len += tcp_v4_hash_statistics(buffer+len); 
+			   
 	if (offset >= len)
 	{
 		*start = buffer;
--- net/ipv4/tcp.c-o	Thu Oct 11 08:42:47 2001
+++ net/ipv4/tcp.c	Sat Oct 13 03:56:58 2001
@@ -2442,6 +2442,15 @@
   	return 0;
 }
 
+static unsigned tcp_ehash_order; 
+static int __init tcp_hash_setup(char *str)
+{
+	tcp_ehash_order = simple_strtol(str,NULL,0); 
+	return 0;
+} 
+
+__setup("tcpehashorder=", tcp_hash_setup); 
+
 
 extern void __skb_cb_too_small_for_tcp(int, int);
 
@@ -2486,8 +2495,12 @@
 	else
 		goal = num_physpages >> (23 - PAGE_SHIFT);
 
-	for(order = 0; (1UL << order) < goal; order++)
-		;
+	if (tcp_ehash_order) 
+		order = tcp_ehash_order;
+	else {	
+		for(order = 0; (1UL << order) < goal; order++)
+			;
+	} 		
 	do {
 		tcp_ehash_size = (1UL << order) * PAGE_SIZE /
 			sizeof(struct tcp_ehash_bucket);
--- net/ipv4/tcp_ipv4.c-o	Mon Oct  1 18:19:56 2001
+++ net/ipv4/tcp_ipv4.c	Sat Oct 13 03:41:57 2001
@@ -2162,6 +2162,62 @@
 	return len;
 }
 
+int tcp_v4_hash_statistics(char *buffer)
+{
+	int i;
+	int max_hlen = 0, hrun = 0, hcnt = 0 ;
+	char *bufs = buffer;
+
+	buffer += sprintf(buffer, "hash_buckets %d\n", tcp_ehash_size*2); 
+
+	local_bh_disable();
+	for (i = 0; i < tcp_ehash_size; i++) {
+		struct tcp_ehash_bucket *head = &tcp_ehash[i];
+		struct sock *sk;
+		struct tcp_tw_bucket *tw;
+		int len = 0; 
+
+		read_lock(&head->lock);
+		for(sk = head->chain; sk; sk = sk->next) {
+			if (!TCP_INET_FAMILY(sk->family))
+				continue;
+			++len; 
+		}
+
+		if (len > 0) { 
+			if (len > max_hlen) max_hlen = len;
+			++hcnt; 
+			hrun += len; 
+		} 
+
+		len = 0; 
+
+		for (tw = (struct tcp_tw_bucket *)tcp_ehash[i+tcp_ehash_size].chain;
+		     tw != NULL;
+		     tw = (struct tcp_tw_bucket *)tw->next) {
+			if (!TCP_INET_FAMILY(tw->family))
+				continue;
+			++len; 
+		}
+		read_unlock(&head->lock);
+
+		if (len > 0) { 
+			if (len > max_hlen) max_hlen = len;
+			++hcnt; 
+			hrun += len; 
+		} 
+	}
+
+	local_bh_enable();
+
+	buffer += sprintf(buffer, "used hash buckets: %d\n", hcnt); 
+	if (hcnt > 0) 
+		buffer += sprintf(buffer, "average length: %d\n", hrun / hcnt); 
+
+	return buffer - bufs; 
+}
+
+
 struct proto tcp_prot = {
 	name:		"TCP",
 	close:		tcp_close,
@@ -2210,3 +2266,4 @@
 	 */
 	tcp_socket->sk->prot->unhash(tcp_socket->sk);
 }
+
