Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSKHVzz>; Fri, 8 Nov 2002 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262472AbSKHVzz>; Fri, 8 Nov 2002 16:55:55 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:5248 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262469AbSKHVzu>;
	Fri, 8 Nov 2002 16:55:50 -0500
Date: Fri, 8 Nov 2002 23:02:15 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: akpm@diego.com
Cc: linux-kernel@vger.kernel.org, bwindle@fint.org, acme@conectiva.com.br
Subject: Re: 2.5.46-bk3: BUG in skbuff.c:178
Message-ID: <20021108220215.GA2437@vana>
References: <6F45EB551A2@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6F45EB551A2@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 09:33:24PM +0200, Petr Vandrovec wrote:
> On  8 Nov 02 at 12:01, Andrew Morton wrote:
> > > Single-CPU system, running 2.5.46-bk3. Whiling compiling bk4, and running
> > > a script that was pinging every host on my subnet (I was running arp -a
> > > to see what was in the arp table at the time), I hit this BUG.
> > 
> > I'd be suspecting the seq_file conversion in arp.c.  The read_lock_bh()
> > stuff in there looks, umm, unclear ;)
> 
> Yes, see my emails from 23th Oct, 25th Oct (2.5.44: Strange oopses from 
> userspace), from Nov 6th + Nov 7th: Preempt count check when leaving
> IRQ.
> 
> But while yesterday I had no idea, today I have one (it looks like that
> nobody else is going to fix it for me :-( ) :
> seq subsystem can call arp_seq_start/next/stop several times, but
> state->is_pneigh is set to 0 only once, by memset in arp_seq_open :-(
> 
> I think that arp_seq_start should do
> 
>   {
> +   struct arp_iter_state* state = seq->private;
> +   seq->is_pneigh = 0;
> +   seq->bucket = 0;
>     read_lock_bh(&arp_tbl.lock);
>     return *pos ? arp_get_bucket(seq, pos) : (void *)1;
>   }
> 
> and we can drop memset from arp_seq_open. I'll try it, and if it will
> survive my tests, I'll send real patch.  

It was not that trivial: arp was storing current position in three fields:
pos, bucket and is_pneigh - so any code seeking in /proc/net/arp just
returned random data, and eventually locked up box...

Patch below removes 'bucket' from arp_iter_state, and merges it to
the pos. It is based on assumption that there is no more than 16M of
entries in each bucket, and that NEIGH_HASHMASK + 1 + PNEIGH_HASHMASK + 1 < 127
(currently it is 48). As loff_t is 64bit even on i386, there is plenty
of space to grow, but it could require apps compiled with O_LARGEFILE,
so I decided to use only 31bit space.

I also removed __inline__ from neigh_get_bucket. This way all functions
were compiled by gcc-2.95.4 on i386 without local variables on stack...

Because of there is now only one entry in arp_iter_state, it is possible
to use seq->private directly instead of allocating memory for arp_iter_state.
Also whole lock obtaining in arp_seq_start could be greatly simplified,
but I'd like to hear your opinions whether merging pos + bucket together
in the way I did is way to go or not, before I'll dig into this more.

I tested code below here: box no more crashes, and I believe that
whole arp table is visible in /proc/net/arp.

					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux-2.5.46-c985.dist/net/ipv4/arp.c	2002-11-08 21:44:01.000000000 +0100
+++ linux-2.5.46-c985/net/ipv4/arp.c	2002-11-08 22:46:44.000000000 +0100
@@ -1139,23 +1139,39 @@
 #endif /* CONFIG_AX25 */
 
 struct arp_iter_state {
-	int is_pneigh, bucket;
+	int is_pneigh;
 };
 
-static __inline__ struct neighbour *neigh_get_bucket(struct seq_file *seq,
+#define ARP_FIRST_NEIGH		(1)
+#define ARP_FIRST_PNEIGH	(ARP_FIRST_NEIGH + NEIGH_HASHMASK + 1)
+
+static inline unsigned int get_arp_pos(loff_t pos, unsigned int* idx) {
+	*idx = pos & 0x00FFFFFF;
+	return pos >> 24;
+}
+
+static inline unsigned int make_arp_pos(unsigned int bucket, unsigned int idx) {
+	return (bucket << 24) | idx;
+}
+
+static inline loff_t next_bucket(loff_t pos) {
+	return (pos + 0x00FFFFFF) & ~0x00FFFFFF;
+}
+
+static struct neighbour *neigh_get_bucket(struct seq_file *seq,
 						     loff_t *pos)
 {
 	struct neighbour *n = NULL;
-	struct arp_iter_state* state = seq->private;
-	loff_t l = *pos;
+	unsigned int l;
+	unsigned int bucket = get_arp_pos(*pos, &l) - ARP_FIRST_NEIGH;
 	int i;
 
-	for (; state->bucket <= NEIGH_HASHMASK; ++state->bucket)
-		for (i = 0, n = arp_tbl.hash_buckets[state->bucket]; n;
+	for (; bucket <= NEIGH_HASHMASK; ++bucket)
+		for (i = 0, n = arp_tbl.hash_buckets[bucket]; n;
 		     ++i, n = n->next)
 			/* Do not confuse users "arp -a" with magic entries */
 			if ((n->nud_state & ~NUD_NOARP) && !l--) {
-				*pos = i;
+				*pos = make_arp_pos(bucket + ARP_FIRST_NEIGH, i);
 				goto out;
 			}
 out:
@@ -1166,15 +1182,15 @@
 							 loff_t *pos)
 {
 	struct pneigh_entry *n = NULL;
-	struct arp_iter_state* state = seq->private;
-	loff_t l = *pos;
+	unsigned int l;
+	unsigned int bucket = get_arp_pos(*pos, &l) - ARP_FIRST_PNEIGH;
 	int i;
 
-	for (; state->bucket <= PNEIGH_HASHMASK; ++state->bucket)
-		for (i = 0, n = arp_tbl.phash_buckets[state->bucket]; n;
+	for (; bucket <= PNEIGH_HASHMASK; ++bucket)
+		for (i = 0, n = arp_tbl.phash_buckets[bucket]; n;
 		     ++i, n = n->next)
 			if (!l--) {
-				*pos = i;
+				*pos = make_arp_pos(bucket + ARP_FIRST_PNEIGH, i);
 				goto out;
 			}
 out:
@@ -1190,8 +1206,7 @@
 
 		read_unlock_bh(&arp_tbl.lock);
 		state->is_pneigh = 1;
-		state->bucket	 = 0;
-		*pos		 = 0;
+		*pos		 = make_arp_pos(ARP_FIRST_PNEIGH, 0);
 		rc = pneigh_get_bucket(seq, pos);
 	}
 	return rc;
@@ -1199,8 +1214,21 @@
 
 static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
 {
+	struct arp_iter_state* state = seq->private;
+	unsigned int idx;
+	unsigned int bucket;
+	
+	state->is_pneigh = 0;
 	read_lock_bh(&arp_tbl.lock);
-	return *pos ? arp_get_bucket(seq, pos) : (void *)1;
+	bucket = get_arp_pos(*pos, &idx);
+	if (bucket < ARP_FIRST_NEIGH)
+		return (void *)1;
+	if (bucket < ARP_FIRST_PNEIGH) {
+		return arp_get_bucket(seq, pos);
+	}
+	read_unlock_bh(&arp_tbl.lock);
+	state->is_pneigh = 1;
+	return pneigh_get_bucket(seq, pos);
 }
 
 static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1209,34 +1237,33 @@
 	struct arp_iter_state* state;
 
 	if (v == (void *)1) {
+		*pos = make_arp_pos(1, 0);
 		rc = arp_get_bucket(seq, pos);
 		goto out;
 	}
-
 	state = seq->private;
 	if (!state->is_pneigh) {
 		struct neighbour *n = v;
 
+		BUG_ON((*pos < make_arp_pos(ARP_FIRST_NEIGH, 0)) || (*pos >= make_arp_pos(ARP_FIRST_PNEIGH, 0)));
 		rc = n = n->next;
 		if (n)
 			goto out;
-		*pos = 0;
-		++state->bucket;
+		*pos = next_bucket(*pos);
 		rc = neigh_get_bucket(seq, pos);
 		if (rc)
 			goto out;
 		read_unlock_bh(&arp_tbl.lock);
 		state->is_pneigh = 1;
-		state->bucket	 = 0;
-		*pos		 = 0;
+		*pos		 = make_arp_pos(ARP_FIRST_PNEIGH, 0);
 		rc = pneigh_get_bucket(seq, pos);
 	} else {
 		struct pneigh_entry *pn = v;
 
+		BUG_ON(*pos < make_arp_pos(ARP_FIRST_PNEIGH, 0));
 		pn = pn->next;
 		if (!pn) {
-			++state->bucket;
-			*pos = 0;
+			*pos = next_bucket(*pos);
 			pn   = pneigh_get_bucket(seq, pos);
 		}
 		rc = pn;
