Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261806AbSJQFSC>; Thu, 17 Oct 2002 01:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSJQFSC>; Thu, 17 Oct 2002 01:18:02 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:46351 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S261806AbSJQFR5>; Thu, 17 Oct 2002 01:17:57 -0400
Date: Thu, 17 Oct 2002 02:23:49 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: remove the hack, using seq->private to hold state
Message-ID: <20021017052349.GB11445@conectiva.com.br>
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

	Changesets for the other cases and to remove the use of temporary
sprintf stack buffers as well will be sent in the next days.

	It is extremely fortunate that all this discussion about seq_file
proper usage has happened at the start of a long series of changesets that will
be sent as required to convert all the tree to seq_file :-)

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.860, 2002-10-17 02:16:44-03:00, acme@conectiva.com.br
  o ipv4: remove the hack, using seq->private to hold state


 ip_proc.c |  102 ++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 64 insertions(+), 38 deletions(-)


diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Thu Oct 17 02:19:17 2002
+++ b/net/ipv4/ip_proc.c	Thu Oct 17 02:19:17 2002
@@ -68,44 +68,42 @@
 #endif /* CONFIG_AX25 */
 
 struct arp_iter_state {
-	loff_t  is_pneigh: 1,
-		bucket:	   6,
-		pos:	   sizeof(loff_t) * 8 - 7;
+	int is_pneigh, bucket;
 };
 
-static __inline__ struct neighbour *neigh_get_bucket(loff_t *pos)
+static __inline__ struct neighbour *neigh_get_bucket(struct seq_file *seq,
+						     loff_t *pos)
 {
 	struct neighbour *n = NULL;
-	struct arp_iter_state* state = (struct arp_iter_state *)pos;
-	loff_t l = state->pos;
-	int i, bucket = state->bucket;
+	struct arp_iter_state* state = seq->private;
+	loff_t l = *pos;
+	int i;
 
-	for (; bucket <= NEIGH_HASHMASK; ++bucket)
-		for (i = 0, n = arp_tbl.hash_buckets[bucket]; n;
+	for (; state->bucket <= NEIGH_HASHMASK; ++state->bucket)
+		for (i = 0, n = arp_tbl.hash_buckets[state->bucket]; n;
 		     ++i, n = n->next)
 			/* Do not confuse users "arp -a" with magic entries */
 			if ((n->nud_state & ~NUD_NOARP) && !l--) {
-				state->pos    = i;
-				state->bucket = bucket;
+				*pos = i;
 				goto out;
 			}
 out:
 	return n;
 }
 
-static __inline__ struct pneigh_entry *pneigh_get_bucket(loff_t *pos)
+static __inline__ struct pneigh_entry *pneigh_get_bucket(struct seq_file *seq,
+							 loff_t *pos)
 {
 	struct pneigh_entry *n = NULL;
-	struct arp_iter_state* state = (struct arp_iter_state *)pos;
-	loff_t l = state->pos;
-	int i, bucket = state->bucket;
+	struct arp_iter_state* state = seq->private;
+	loff_t l = *pos;
+	int i;
 
-	for (; bucket <= PNEIGH_HASHMASK; ++bucket)
-		for (i = 0, n = arp_tbl.phash_buckets[bucket]; n;
+	for (; state->bucket <= PNEIGH_HASHMASK; ++state->bucket)
+		for (i = 0, n = arp_tbl.phash_buckets[state->bucket]; n;
 		     ++i, n = n->next)
 			if (!l--) {
-				state->pos    = i;
-				state->bucket = bucket;
+				*pos = i;
 				goto out;
 			}
 out:
@@ -114,18 +112,16 @@
 
 static __inline__ void *arp_get_bucket(struct seq_file *seq, loff_t *pos)
 {
-	void *rc = neigh_get_bucket(pos);
+	void *rc = neigh_get_bucket(seq, pos);
 
 	if (!rc) {
-		struct arp_iter_state* state = (struct arp_iter_state *)pos;
+		struct arp_iter_state* state = seq->private;
 
 		read_unlock_bh(&arp_tbl.lock);
 		state->is_pneigh = 1;
 		state->bucket	 = 0;
-		state->pos	 = 0;
-		/* HACK: till there is state we can pass to seq_show...  */
-		seq->private = (void *)1;
-		rc = pneigh_get_bucket(pos);
+		*pos		 = 0;
+		rc = pneigh_get_bucket(seq, pos);
 	}
 	return rc;
 }
@@ -146,33 +142,31 @@
 		goto out;
 	}
 
-	state = (struct arp_iter_state *)pos;
+	state = seq->private;
 	if (!state->is_pneigh) {
 		struct neighbour *n = v;
 
 		rc = n = n->next;
 		if (n)
 			goto out;
-		state->pos = 0;
+		*pos = 0;
 		++state->bucket;
-		rc = neigh_get_bucket(pos);
+		rc = neigh_get_bucket(seq, pos);
 		if (rc)
 			goto out;
 		read_unlock_bh(&arp_tbl.lock);
-		/* HACK: till there is state we can pass to seq_show...  */
-		seq->private	 = (void *)1;
 		state->is_pneigh = 1;
 		state->bucket	 = 0;
-		state->pos	 = 0;
-		rc = pneigh_get_bucket(pos);
+		*pos		 = 0;
+		rc = pneigh_get_bucket(seq, pos);
 	} else {
 		struct pneigh_entry *pn = v;
 
 		pn = pn->next;
 		if (!pn) {
 			++state->bucket;
-			state->pos = 0;
-			pn = pneigh_get_bucket(pos);
+			*pos = 0;
+			pn   = pneigh_get_bucket(seq, pos);
 		}
 		rc = pn;
 	}
@@ -183,7 +177,9 @@
 
 static void arp_seq_stop(struct seq_file *seq, void *v)
 {
-	if (!seq->private)
+	struct arp_iter_state* state = seq->private;
+
+	if (!state->is_pneigh)
 		read_unlock_bh(&arp_tbl.lock);
 }
 
@@ -241,7 +237,9 @@
 		seq_puts(seq, "IP address       HW type     Flags       "
 			      "HW address            Mask     Device\n");
 	else {
-		if (seq->private)
+		struct arp_iter_state* state = seq->private;
+
+		if (state->is_pneigh)
 			arp_format_pneigh_entry(seq, v);
 		else
 			arp_format_neigh_entry(seq, v);
@@ -405,7 +403,35 @@
 
 static int arp_seq_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &arp_seq_ops);
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct arp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+       
+	if (!s)
+		goto out;
+
+	rc = seq_open(file, &arp_seq_ops);
+	if (rc)
+		goto out_kfree;
+
+	seq	     = file->private_data;
+	seq->private = s;
+	memset(s, 0, sizeof(*s));
+out:
+	return rc;
+out_kfree:
+	kfree(s);
+	goto out;
+}
+
+static int arp_seq_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = (struct seq_file *)file->private_data;
+
+	kfree(seq->private);
+	seq->private = NULL;
+
+	return seq_release(inode, file);
 }
 
 static int fib_seq_open(struct inode *inode, struct file *file)
@@ -422,7 +448,7 @@
 	.open           = arp_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= seq_release,
+	.release	= arp_seq_release,
 };
 
 static struct file_operations fib_seq_fops = {

===================================================================


This BitKeeper patch contains the following changesets:
1.860
## Wrapped with gzip_uu ##


begin 664 bkpatch22554
M'XL(`%5(KCT``\U6;7/:.!#^;/V*O>G,#1!>)+\#1Z9IRR5,7II))I^N-Q['
MB-@38U%;<-.6^^^WDH"\0-.CEP^G9+Q&J]U]GD<KP1NXJ7C9L^)DRLD;.!&5
M[%F)*'@BLT7<3L2T?5NBXTH(='12,>6==Z>=@LN6W?8(>BYCF:2PX&75LUC;
MV<S(+S/>LZZ&QS=G1U>$#`;P/HV+.W[-)0P&1(IR$>?CZFTLTUP4;5G&137E
M4M=<;I8N;4IM_/-8X%#/7S*?NL$R86/&8I?Q,;7=T'>)@O_V.>QG61AE`:4N
M8VSI4=<-R0=@[="G0.T.HQT6X$N/^3W7;5&G1RGL3`H'#%J4O(/7)?">)"`@
MFRW<'I1\*A8<9,HAC9/[)LRKK+B#BG]N'<Y*A"+1*2`5^1@JB9_(*2`CSR>7
M#QJ3UIZ#$!I3<KB;]1(WO*/0X2.:E2)I)VM-&?,]SW&6E`9(+PGM,'2\26@[
MOG-K>WNG"U`IWV5+.PA<6[?-]EK5/Z\+<^]TNI-HN*2.X_NZDX*M/F(O]Y'O
M0LL)_W>=9(3_"*WR+_V/G7&Y8P]^HK\^!`P<,@H<8,3*"@E9%<T*GMVE3;B=
M)_=<]G&-C]X1/FVB$&4)1%%6Y%G!HP@QEO-$@HZY%?,2&OHUNN,R,AEJJR5(
M,9ID.8<&OC6)I0>HD8O)))+0F(FJCN6Z"E*H@%FKT+B<19GD9:05:1AA8/!$
MM3ZQ5GER]*A<_14EI!`Z"'X4NOBT)J*$6M_D:!T:C/#;`"Z&H^.3Z.3H^N3\
MZ/JT#P<'3Y;4$;$.S3`];4*!1N&2MWD[C:MTQ;;ZXTG4GWTH5/U0U^\JF7$H
M=!BND'6UN-T7Q34[$O%"EE^0V5X"6\_4[6IU\;B\IKR,:GT9?5'@R_^@\.R'
M$C,:&`SAML@,;P!4V1AK(;(Q-$J\LV!;2E0.E%(JRJ8Z2AMK/[$PV`-7!:N=
M-V!P+Y`7RF;IVCOV\7%QMZN+:V-]KXBGN\>8#6.J/:'Q&#7^!5G?1J!H?*VB
M'_PD[,#5\8&GXQ]!P@^S`@_[#S.$AA.:?3OT$W;D!&J_K-IC<Y=AV]NNJ[(J
MX^R[EYA6Y]V1UM7=-E+&[F[0/CF(JV.BM6L-+SZ>#\_[W^&%ZW'1_33.<Y'4
MJNPK%Y-:HZHWX?CWR^AT>'4Q/$.)P(PU675L[@1^9XBYU&!U*85!S'A14T":
M\*NJ9.:4RCJT3!Z'1O>3DANVN,Y<S`-0T1LIHG$LX[[V/WQ982F<FO)II3:R
MJ0[N`W(LA:E[B(G+>5F@"GK"U,)I;6L:T0.%OQ'#ZBY4RJV1ESSG<<77MUU6
MB#$JIDUS?5,:U=6S3K[MW@\$O'UAUG?Q_+3!]XAO?9O_Q<W9F1'>D'P,=@5/
M(\+F=O%64/VBC=5>K;(&STDV'W[&)RE/[JOY=.#0<3>83&+R#S;`HB$A#```
`
end
