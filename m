Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278383AbRJSM5u>; Fri, 19 Oct 2001 08:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278385AbRJSM5l>; Fri, 19 Oct 2001 08:57:41 -0400
Received: from zero.aec.at ([195.3.98.22]:1799 "HELO zero.aec.at")
	by vger.kernel.org with SMTP id <S278383AbRJSM5a>;
	Fri, 19 Oct 2001 08:57:30 -0400
Message-ID: <20011019145750.A22193@zero.firstfloor.org>
Date: Fri, 19 Oct 2001 14:57:50 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Simon Kirby <sim@netnation.com>, Andi Kleen <andi@firstfloor.org>,
        kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
In-Reply-To: <20011018094222.A31919@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <20011018094222.A31919@netnation.com>; from Simon Kirby on Thu, Oct 18, 2001 at 09:42:22AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 09:42:22AM -0700, Simon Kirby wrote:
> There is definitely something really broken here.  One of our web servers
> that was having the problem before has now decided to hit a load average
> of 50 because identd is taking so long to parse /proc/net/tcp and give
> back ident information.

See my last mail. The hash tables are too big. Set a smaller one
during this patch by using the new tcpehashorder= command line option.
It sets the hash table size as 2^order*4096 on i386. You can see the
default order by looking at the dmesg of an machine booted without
this option set.
You can find out how much it costs you by looking at 
/proc/net/sockstat. If the tcp_ehash_buckets value is the same as 
with the default hash tab size then it didn't cost you anything.
If the value is very similar it's probably still ok; just if you
get e.g. average bucket length >5-10 it's probably too small.
The smaller the hash table the faster should identd work.

-Andi

P.S.: It would be possible to create a shortcut for identd that does
a direct hash lookup and avoid an full walk; but so far I'm not 
convinced that is necessary.

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
+	buffer += sprintf(buffer, "tcp_ehash_buckets %d\n", tcp_ehash_size*2); 
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
