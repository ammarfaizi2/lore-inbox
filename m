Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261574AbSJQAzs>; Wed, 16 Oct 2002 20:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261599AbSJQAzs>; Wed, 16 Oct 2002 20:55:48 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:21518 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261574AbSJQAzn>; Wed, 16 Oct 2002 20:55:43 -0400
Date: Wed, 16 Oct 2002 22:01:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: make arp seq_file show method only produce one record per call
Message-ID: <20021017010135.GR7541@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

- Arnaldo


You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.859, 2002-10-16 21:41:11-03:00, acme@conectiva.com.br
  o ipv4: make arp seq_file show method only produce one record per call


 ip_proc.c |  214 +++++++++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 150 insertions(+), 64 deletions(-)


diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Wed Oct 16 21:44:36 2002
+++ b/net/ipv4/ip_proc.c	Wed Oct 16 21:44:36 2002
@@ -67,99 +67,185 @@
 }
 #endif /* CONFIG_AX25 */
 
+struct arp_iter_state {
+	loff_t  is_pneigh: 1,
+		bucket:	   6,
+		pos:	   sizeof(loff_t) * 8 - 7;
+};
+
+static __inline__ struct neighbour *neigh_get_bucket(loff_t *pos)
+{
+	struct neighbour *n = NULL;
+	struct arp_iter_state* state = (struct arp_iter_state *)pos;
+	loff_t l = state->pos;
+	int i, bucket = state->bucket;
+
+	for (; bucket <= NEIGH_HASHMASK; ++bucket)
+		for (i = 0, n = arp_tbl.hash_buckets[bucket]; n;
+		     ++i, n = n->next)
+			/* Do not confuse users "arp -a" with magic entries */
+			if ((n->nud_state & ~NUD_NOARP) && !l--) {
+				state->pos    = i;
+				state->bucket = bucket;
+				goto out;
+			}
+out:
+	return n;
+}
+
+static __inline__ struct pneigh_entry *pneigh_get_bucket(loff_t *pos)
+{
+	struct pneigh_entry *n = NULL;
+	struct arp_iter_state* state = (struct arp_iter_state *)pos;
+	loff_t l = state->pos;
+	int i, bucket = state->bucket;
+
+	for (; bucket <= PNEIGH_HASHMASK; ++bucket)
+		for (i = 0, n = arp_tbl.phash_buckets[bucket]; n;
+		     ++i, n = n->next)
+			if (!l--) {
+				state->pos    = i;
+				state->bucket = bucket;
+				goto out;
+			}
+out:
+	return n;
+}
+
+static __inline__ void *arp_get_bucket(struct seq_file *seq, loff_t *pos)
+{
+	void *rc = neigh_get_bucket(pos);
+
+	if (!rc) {
+		struct arp_iter_state* state = (struct arp_iter_state *)pos;
+
+		read_unlock_bh(&arp_tbl.lock);
+		state->is_pneigh = 1;
+		state->bucket	 = 0;
+		state->pos	 = 0;
+		/* HACK: till there is state we can pass to seq_show...  */
+		seq->private = (void *)1;
+		rc = pneigh_get_bucket(pos);
+	}
+	return rc;
+}
+
 static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	return (void *)(unsigned long)++*pos;
+	read_lock_bh(&arp_tbl.lock);
+	return *pos ? arp_get_bucket(seq, pos) : (void *)1;
 }
 
 static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	return (void *)(unsigned long)((++*pos) >=
-				       (NEIGH_HASHMASK +
-					PNEIGH_HASHMASK - 1) ? 0 : *pos);
+	void *rc;
+	struct arp_iter_state* state;
+
+	if (v == (void *)1) {
+		rc = arp_get_bucket(seq, pos);
+		goto out;
+	}
+
+	state = (struct arp_iter_state *)pos;
+	if (!state->is_pneigh) {
+		struct neighbour *n = v;
+
+		rc = n = n->next;
+		if (n)
+			goto out;
+		state->pos = 0;
+		++state->bucket;
+		rc = neigh_get_bucket(pos);
+		if (rc)
+			goto out;
+		read_unlock_bh(&arp_tbl.lock);
+		/* HACK: till there is state we can pass to seq_show...  */
+		seq->private	 = (void *)1;
+		state->is_pneigh = 1;
+		state->bucket	 = 0;
+		state->pos	 = 0;
+		rc = pneigh_get_bucket(pos);
+	} else {
+		struct pneigh_entry *pn = v;
+
+		pn = pn->next;
+		if (!pn) {
+			++state->bucket;
+			state->pos = 0;
+			pn = pneigh_get_bucket(pos);
+		}
+		rc = pn;
+	}
+out:
+	++*pos;
+	return rc;
 }
 
 static void arp_seq_stop(struct seq_file *seq, void *v)
 {
+	if (!seq->private)
+		read_unlock_bh(&arp_tbl.lock);
 }
 
 #define HBUFFERLEN 30
 
-static __inline__ void arp_format_neigh_table(struct seq_file *seq, int entry)
+static __inline__ void arp_format_neigh_entry(struct seq_file *seq,
+					      struct neighbour *n)
 {
 	char hbuffer[HBUFFERLEN];
 	const char hexbuf[] = "0123456789ABCDEF";
-	struct neighbour *n;
 	int k, j;
+	char tbuf[16];
+	struct net_device *dev = n->dev;
+	int hatype = dev->type;
 
-	read_lock_bh(&arp_tbl.lock);
-	for (n = arp_tbl.hash_buckets[entry]; n; n = n->next) {
-		char tbuf[16];
-		struct net_device *dev = n->dev;
-		int hatype = dev->type;
-
-		/* Do not confuse users "arp -a" with magic entries */
-		if (!(n->nud_state & ~NUD_NOARP))
-			continue;
-
-		read_lock(&n->lock);
-		/* Convert hardware address to XX:XX:XX:XX ... form. */
+	read_lock(&n->lock);
+	/* Convert hardware address to XX:XX:XX:XX ... form. */
 #ifdef CONFIG_AX25
-		if (hatype == ARPHRD_AX25 || hatype == ARPHRD_NETROM)
-			ax2asc2((ax25_address *)n->ha, hbuffer);
-		else {
+	if (hatype == ARPHRD_AX25 || hatype == ARPHRD_NETROM)
+		ax2asc2((ax25_address *)n->ha, hbuffer);
+	else {
 #endif
-		for (k = 0, j = 0; k < HBUFFERLEN - 3 &&
-				   j < dev->addr_len; j++) {
-			hbuffer[k++] = hexbuf[(n->ha[j] >> 4) & 15];
-			hbuffer[k++] = hexbuf[n->ha[j] & 15];
-			hbuffer[k++] = ':';
-		}
-		hbuffer[--k] = 0;
+	for (k = 0, j = 0; k < HBUFFERLEN - 3 && j < dev->addr_len; j++) {
+		hbuffer[k++] = hexbuf[(n->ha[j] >> 4) & 15];
+		hbuffer[k++] = hexbuf[n->ha[j] & 15];
+		hbuffer[k++] = ':';
+	}
+	hbuffer[--k] = 0;
 #ifdef CONFIG_AX25
-		}
-#endif
-		sprintf(tbuf, "%u.%u.%u.%u",
-			NIPQUAD(*(u32*)n->primary_key));
-		seq_printf(seq, "%-16s 0x%-10x0x%-10x%s"
-				"     *        %s\n",
-			   tbuf, hatype, arp_state_to_flags(n), 
-			   hbuffer, dev->name);
-		read_unlock(&n->lock);
-	}
-	read_unlock_bh(&arp_tbl.lock);
-}
-
-static __inline__ void arp_format_pneigh_table(struct seq_file *seq, int entry)
-{
-	struct pneigh_entry *n;
-
-	for (n = arp_tbl.phash_buckets[entry]; n; n = n->next) {
-		struct net_device *dev = n->dev;
-		int hatype = dev ? dev->type : 0;
-		char tbuf[16];
-
-		sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->key));
-		seq_printf(seq, "%-16s 0x%-10x0x%-10x%s"
-				"     *        %s\n",
-			   tbuf, hatype, ATF_PUBL | ATF_PERM,
-			   "00:00:00:00:00:00",
-			   dev ? dev->name : "*");
 	}
+#endif
+	sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->primary_key));
+	seq_printf(seq, "%-16s 0x%-10x0x%-10x%s     *        %s\n",
+		   tbuf, hatype, arp_state_to_flags(n), hbuffer, dev->name);
+	read_unlock(&n->lock);
 }
 
-static int arp_seq_show(struct seq_file *seq, void *v)
+static __inline__ void arp_format_pneigh_entry(struct seq_file *seq,
+					       struct pneigh_entry *n)
 {
-	unsigned long l = (unsigned long)v - 1;
 
-	if (!l)
+	struct net_device *dev = n->dev;
+	int hatype = dev ? dev->type : 0;
+	char tbuf[16];
+
+	sprintf(tbuf, "%u.%u.%u.%u", NIPQUAD(*(u32*)n->key));
+	seq_printf(seq, "%-16s 0x%-10x0x%-10x%s     *        %s\n",
+		   tbuf, hatype, ATF_PUBL | ATF_PERM, "00:00:00:00:00:00",
+		   dev ? dev->name : "*");
+}
+
+static int arp_seq_show(struct seq_file *seq, void *v)
+{
+	if (v == (void *)1)
 		seq_puts(seq, "IP address       HW type     Flags       "
 			      "HW address            Mask     Device\n");
-
-	if (l <= NEIGH_HASHMASK)
-		arp_format_neigh_table(seq, l);
-	else
-		arp_format_pneigh_table(seq, l - NEIGH_HASHMASK);
+	else {
+		if (seq->private)
+			arp_format_pneigh_entry(seq, v);
+		else
+			arp_format_neigh_entry(seq, v);
+	}
 
 	return 0;
 }

===================================================================


This BitKeeper patch contains the following changesets:
1.859
## Wrapped with gzip_uu ##


begin 664 bkpatch14639
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
&HG+_$P``
`
end
