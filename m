Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264733AbSKJEMY>; Sat, 9 Nov 2002 23:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264736AbSKJEMY>; Sat, 9 Nov 2002 23:12:24 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:57610 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264733AbSKJEMV>; Sat, 9 Nov 2002 23:12:21 -0500
Date: Sun, 10 Nov 2002 02:18:55 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-bk3: BUG in skbuff.c:178
Message-ID: <20021110041855.GA17760@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <6F45EB551A2@vcnet.vc.cvut.cz> <20021108220215.GA2437@vana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108220215.GA2437@vana>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 08, 2002 at 11:02:15PM +0100, Petr Vandrovec escreveu:
> On Fri, Nov 08, 2002 at 09:33:24PM +0200, Petr Vandrovec wrote:
> > On  8 Nov 02 at 12:01, Andrew Morton wrote:
 
> Patch below removes 'bucket' from arp_iter_state, and merges it to the pos.
> It is based on assumption that there is no more than 16M of entries in each
> bucket, and that NEIGH_HASHMASK + 1 + PNEIGH_HASHMASK + 1 < 127

I did that in the past, but it gets too ugly, see previous changeset in
bk tree, lemme see... 1.781.1.52, but anyway, I was aware of this bug but I
was on the run, going to Japan and back in 5 days :-\ Well, I have already
sent this one to several people, so if you could review/test it...

===== net/ipv4/arp.c 1.13 vs edited =====
--- 1.13/net/ipv4/arp.c	Mon Oct 21 01:17:08 2002
+++ edited/net/ipv4/arp.c	Wed Nov  6 08:00:22 2002
@@ -1140,67 +1140,122 @@
 
 struct arp_iter_state {
 	int is_pneigh, bucket;
+	union {
+		struct neighbour    *n;
+		struct pneigh_entry *pn;
+	} u;
 };
 
-static __inline__ struct neighbour *neigh_get_bucket(struct seq_file *seq,
-						     loff_t *pos)
+static struct neighbour *neigh_get_first(struct seq_file *seq)
 {
-	struct neighbour *n = NULL;
 	struct arp_iter_state* state = seq->private;
-	loff_t l = *pos;
-	int i;
 
-	for (; state->bucket <= NEIGH_HASHMASK; ++state->bucket)
-		for (i = 0, n = arp_tbl.hash_buckets[state->bucket]; n;
-		     ++i, n = n->next)
-			/* Do not confuse users "arp -a" with magic entries */
-			if ((n->nud_state & ~NUD_NOARP) && !l--) {
-				*pos = i;
-				goto out;
-			}
-out:
-	return n;
+	state->is_pneigh = 0;
+
+	for (state->bucket = 0;
+	     state->bucket <= NEIGH_HASHMASK;
+	     ++state->bucket) {
+		state->u.n = arp_tbl.hash_buckets[state->bucket];
+		while (state->u.n && !(state->u.n->nud_state & ~NUD_NOARP))
+			state->u.n = state->u.n->next;
+		if (state->u.n)
+			break;
+	}
+
+	return state->u.n;
 }
 
-static __inline__ struct pneigh_entry *pneigh_get_bucket(struct seq_file *seq,
-							 loff_t *pos)
+static struct neighbour *neigh_get_next(struct seq_file *seq)
 {
-	struct pneigh_entry *n = NULL;
 	struct arp_iter_state* state = seq->private;
-	loff_t l = *pos;
-	int i;
 
-	for (; state->bucket <= PNEIGH_HASHMASK; ++state->bucket)
-		for (i = 0, n = arp_tbl.phash_buckets[state->bucket]; n;
-		     ++i, n = n->next)
-			if (!l--) {
-				*pos = i;
-				goto out;
-			}
-out:
-	return n;
+	for (; state->bucket <= NEIGH_HASHMASK;
+	     ++state->bucket,
+	     state->u.n = arp_tbl.hash_buckets[state->bucket]) {
+		if (state->u.n)
+			do {
+				state->u.n = state->u.n->next;
+				/* Don't confuse "arp -a" w/ magic entries */
+			} while (state->u.n &&
+				 !(state->u.n->nud_state & ~NUD_NOARP));
+		if (state->u.n)
+			break;
+	}
+
+	return state->u.n;
+}
+
+static loff_t neigh_get_idx(struct seq_file *seq, loff_t pos)
+{
+	neigh_get_first(seq);
+	while (pos && neigh_get_next(seq))
+		--pos;
+	return pos;
+}
+
+static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
+{
+	struct arp_iter_state* state = seq->private;
+
+	state->is_pneigh = 1;
+
+	for (state->bucket = 0;
+	     state->bucket <= PNEIGH_HASHMASK;
+	     ++state->bucket) {
+		state->u.pn = arp_tbl.phash_buckets[state->bucket];
+		if (state->u.pn)
+			break;
+	}
+	return state->u.pn;
+}
+
+static struct pneigh_entry *pneigh_get_next(struct seq_file *seq)
+{
+	struct arp_iter_state* state = seq->private;
+
+	for (; state->bucket <= PNEIGH_HASHMASK;
+	     ++state->bucket,
+	     state->u.pn = arp_tbl.phash_buckets[state->bucket]) {
+		if (state->u.pn)
+			state->u.pn = state->u.pn->next;
+		
+		if (state->u.pn)
+			break;
+	}
+	return state->u.pn;
 }
 
-static __inline__ void *arp_get_bucket(struct seq_file *seq, loff_t *pos)
+static loff_t pneigh_get_idx(struct seq_file *seq, loff_t pos)
 {
-	void *rc = neigh_get_bucket(seq, pos);
+	pneigh_get_first(seq);
+	while (pos && pneigh_get_next(seq))
+		--pos;
+	return pos;
+}
+
+static void *arp_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct arp_iter_state* state = seq->private;
+	void *rc;
+	loff_t p;
+
+	read_lock_bh(&arp_tbl.lock);
+	p = neigh_get_idx(seq, pos);
 
-	if (!rc) {
+	if (p || !state->u.n) {
 		struct arp_iter_state* state = seq->private;
 
 		read_unlock_bh(&arp_tbl.lock);
-		state->is_pneigh = 1;
-		state->bucket	 = 0;
-		*pos		 = 0;
-		rc = pneigh_get_bucket(seq, pos);
-	}
+		pneigh_get_idx(seq, p);
+		rc = state->u.pn;
+	} else
+		rc = state->u.n;
 	return rc;
 }
 
 static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	read_lock_bh(&arp_tbl.lock);
-	return *pos ? arp_get_bucket(seq, pos) : (void *)1;
+	return *pos ? arp_get_idx(seq, *pos - 1) : (void *)1;
 }
 
 static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1209,38 +1264,19 @@
 	struct arp_iter_state* state;
 
 	if (v == (void *)1) {
-		rc = arp_get_bucket(seq, pos);
+		rc = arp_get_idx(seq, 0);
 		goto out;
 	}
 
 	state = seq->private;
 	if (!state->is_pneigh) {
-		struct neighbour *n = v;
-
-		rc = n = n->next;
-		if (n)
-			goto out;
-		*pos = 0;
-		++state->bucket;
-		rc = neigh_get_bucket(seq, pos);
+		rc = neigh_get_next(seq);
 		if (rc)
 			goto out;
 		read_unlock_bh(&arp_tbl.lock);
-		state->is_pneigh = 1;
-		state->bucket	 = 0;
-		*pos		 = 0;
-		rc = pneigh_get_bucket(seq, pos);
-	} else {
-		struct pneigh_entry *pn = v;
-
-		pn = pn->next;
-		if (!pn) {
-			++state->bucket;
-			*pos = 0;
-			pn   = pneigh_get_bucket(seq, pos);
-		}
-		rc = pn;
-	}
+		rc = pneigh_get_first(seq);
+	} else
+		rc = pneigh_get_next(seq);
 out:
 	++*pos;
 	return rc;
@@ -1291,7 +1327,6 @@
 static __inline__ void arp_format_pneigh_entry(struct seq_file *seq,
 					       struct pneigh_entry *n)
 {
-
 	struct net_device *dev = n->dev;
 	int hatype = dev ? dev->type : 0;
 	char tbuf[16];
