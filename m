Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSKKEMm>; Sun, 10 Nov 2002 23:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbSKKEMm>; Sun, 10 Nov 2002 23:12:42 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:3345 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265437AbSKKEMi>; Sun, 10 Nov 2002 23:12:38 -0500
Date: Mon, 11 Nov 2002 02:19:08 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Marc Zyngier <mzyngier@freesurf.fr>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Burton Windle <bwindle@fint.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] arp: fix seq_file support
Message-ID: <20021111041908.GD20583@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Marc Zyngier <mzyngier@freesurf.fr>,
	Petr Vandrovec <vandrove@vc.cvut.cz>,
	Burton Windle <bwindle@fint.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

	Famous last words: this fixes the seq_file support in net/ipv4/arp.c,
please pull from:

kernel.bkbits.net:/home/acme/net-2.5

	Here is some stress testing on a UP machine, SMP kernel, kksymoops,
preempt, etc enabled:

[root@linux1 root]# cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     Device
[root@linux1 root]# ping 192.168.5.2
[root@linux1 root]# cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     Device
192.168.5.2      0x1         0x2         00:50:56:F2:A5:50     *        eth0
[root@linux1 root]# ping 192.168.5.3
[root@linux1 root]# cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     Device
192.168.5.2      0x1         0x2         00:50:56:F2:A5:50     *        eth0
192.168.5.3      0x1         0x2         00:50:56:C0:00:08     *        eth0
[root@linux1 root]# arp -s 192.168.5.20 1:2:3:4:5:20
[root@linux1 root]# cat /proc/net/arp
IP address       HW type     Flags       HW address            Mask     Device
192.168.5.2      0x1         0x2         00:50:56:F2:A5:50     *        eth0
192.168.5.3      0x1         0x2         00:50:56:C0:00:08     *        eth0
192.168.5.20     0x1         0x6         01:02:03:04:05:20     *        eth0
[root@linux1 root]# arp -s 192.168.5.21 1:2:3:4:5:21
[root@linux1 root]# for a in $(seq 30 70) ; do arp -s 192.168.5.$a 1:2:3:4:5:$a
; done
[root@linux1 root]# wc -l /proc/net/arp
     47

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.821, 2002-11-11 01:56:05-02:00, acme@conectiva.com.br
  o arp: fix seq_file support


 arp.c |  152 +++++++++++++++++++++++++++++++++++++++---------------------------
 1 files changed, 91 insertions(+), 61 deletions(-)


diff -Nru a/net/ipv4/arp.c b/net/ipv4/arp.c
--- a/net/ipv4/arp.c	Mon Nov 11 02:03:20 2002
+++ b/net/ipv4/arp.c	Mon Nov 11 02:03:20 2002
@@ -1142,65 +1142,115 @@
 	int is_pneigh, bucket;
 };
 
-static __inline__ struct neighbour *neigh_get_bucket(struct seq_file *seq,
-						     loff_t *pos)
+static struct neighbour *neigh_get_first(struct seq_file *seq)
 {
-	struct neighbour *n = NULL;
 	struct arp_iter_state* state = seq->private;
-	loff_t l = *pos;
-	int i;
+	struct neighbour *n;
+
+	state->is_pneigh = 0;
+
+	for (state->bucket = 0;
+	     state->bucket <= NEIGH_HASHMASK;
+	     ++state->bucket) {
+		n = arp_tbl.hash_buckets[state->bucket];
+		while (n && !(n->nud_state & ~NUD_NOARP))
+			n = n->next;
+		if (n)
+			break;
+	}
 
-	for (; state->bucket <= NEIGH_HASHMASK; ++state->bucket)
-		for (i = 0, n = arp_tbl.hash_buckets[state->bucket]; n;
-		     ++i, n = n->next)
-			/* Do not confuse users "arp -a" with magic entries */
-			if ((n->nud_state & ~NUD_NOARP) && !l--) {
-				*pos = i;
-				goto out;
-			}
-out:
 	return n;
 }
 
-static __inline__ struct pneigh_entry *pneigh_get_bucket(struct seq_file *seq,
-							 loff_t *pos)
+static struct neighbour *neigh_get_next(struct seq_file *seq,
+					struct neighbour *n)
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
+	do {
+		n = n->next;
+		/* Don't confuse "arp -a" w/ magic entries */
+try_again:
+	} while (n && !(n->nud_state & ~NUD_NOARP));
+
+	if (n)
+		goto out;
+	if (++state->bucket > NEIGH_HASHMASK)
+		goto out;
+	n = arp_tbl.hash_buckets[state->bucket];
+	goto try_again;
 out:
 	return n;
 }
 
-static __inline__ void *arp_get_bucket(struct seq_file *seq, loff_t *pos)
+static struct neighbour *neigh_get_idx(struct seq_file *seq, loff_t *pos)
 {
-	void *rc = neigh_get_bucket(seq, pos);
+	struct neighbour *n = neigh_get_first(seq);
 
-	if (!rc) {
-		struct arp_iter_state* state = seq->private;
+	if (n)
+		while (*pos && (n = neigh_get_next(seq, n)))
+			--*pos;
+	return *pos ? NULL : n;
+}
+
+static struct pneigh_entry *pneigh_get_first(struct seq_file *seq)
+{
+	struct arp_iter_state* state = seq->private;
+	struct pneigh_entry *pn;
+
+	state->is_pneigh = 1;
+
+	for (state->bucket = 0;
+	     state->bucket <= PNEIGH_HASHMASK;
+	     ++state->bucket) {
+		pn = arp_tbl.phash_buckets[state->bucket];
+		if (pn)
+			break;
+	}
+	return pn;
+}
+
+static struct pneigh_entry *pneigh_get_next(struct seq_file *seq,
+					    struct pneigh_entry *pn)
+{
+	struct arp_iter_state* state = seq->private;
 
+	pn = pn->next;
+	while (!pn) {
+		if (++state->bucket > PNEIGH_HASHMASK)
+			break;
+		pn = arp_tbl.phash_buckets[state->bucket];
+	}
+	return pn;
+}
+
+static struct pneigh_entry *pneigh_get_idx(struct seq_file *seq, loff_t pos)
+{
+	struct pneigh_entry *pn = pneigh_get_first(seq);
+
+	if (pn)
+		while (pos && (pn = pneigh_get_next(seq, pn)))
+			--pos;
+	return pos ? NULL : pn;
+}
+
+static void *arp_get_idx(struct seq_file *seq, loff_t pos)
+{
+	void *rc;
+
+	read_lock_bh(&arp_tbl.lock);
+	rc = neigh_get_idx(seq, &pos);
+
+	if (!rc) {
 		read_unlock_bh(&arp_tbl.lock);
-		state->is_pneigh = 1;
-		state->bucket	 = 0;
-		*pos		 = 0;
-		rc = pneigh_get_bucket(seq, pos);
+		rc = pneigh_get_idx(seq, pos);
 	}
 	return rc;
 }
 
 static void *arp_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	read_lock_bh(&arp_tbl.lock);
-	return *pos ? arp_get_bucket(seq, pos) : (void *)1;
+	return *pos ? arp_get_idx(seq, *pos - 1) : (void *)1;
 }
 
 static void *arp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
@@ -1209,38 +1259,19 @@
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
+		rc = neigh_get_next(seq, v);
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
+		rc = pneigh_get_next(seq, v);
 out:
 	++*pos;
 	return rc;
@@ -1291,7 +1322,6 @@
 static __inline__ void arp_format_pneigh_entry(struct seq_file *seq,
 					       struct pneigh_entry *n)
 {
-
 	struct net_device *dev = n->dev;
 	int hatype = dev ? dev->type : 0;
 	char tbuf[16];

===================================================================


This BitKeeper patch contains the following changesets:
1.821
## Wrapped with gzip_uu ##


begin 664 bkpatch11726
M'XL(``@LSST``\57;4_C1A#^G/T5PYU$DU`GNWZ+G6LHW'$Z$)2+0'QJ*\MQ
M-HF/Q';M30"1ZV_O[#J$V/A*@BK56%K+.S,[\SSSC,-[N,EXVJWYP8R3]W`:
M9Z);"^*(!R)<^*T@GK4&*6Y<Q3%NM"?QC+<_GK<C+C2]91'<Z?LBF,""IUFW
MQEK&^HUX2'BW=O7YR\W%\14AO1Y\FOC1F%]S`;T>$7&Z\*?#[,@7DVD<M43J
M1]F,"W7F<FVZU"G5\<]B'8-:]I+9U.PL`S9DS#<9'U+==&R3/,399#3_%AY-
MPVA^KX7)PF[%Z;@4AZ$UHQ;5W:5N.ZY!3H"U')T!U=N,X0V4=2V[2RV-ZEU*
M0:)R5$8##AAHE'R$_[:$3R2`&/PTZ<(HO(>,_^6-PBF';)XD<2K(.6#.3H?T
MGW$DVHX7(=2GY/"5S)'<-B)HMC&95K"9OFLYB)S%W"4W',,<4!KH`1^YME4-
M554HAA<U+(O2I8T/CFJ-HMWK_?&6%,GV*<K;9!WJ+*EKZ4SU"3.+;6)A@_Q[
MF[C8)S;['QHEQ_4K:.F=NI'X?@GB-[3."6.F!3HYP]4&1C+ABS"`3*3S0&#X
M<#P9Q/,4FNK1&W.!>:69J*\LUHDV\:FAPCD8!E>+YF$M!LP@M8J('\@?\KTO
MN'889EZB]J`'5&V,XA3JJ]W!/+B5$T9NU4!>Q8U?>G#Y^>S+J7=Z?'WZV_'U
M^9/9P4'!L`&/I%:+,!#BY8G!M#7QLXF7;V:_%VS_Q!BUNXFLK1[!_C[LU2/M
M,)H//64&^_#WY<V)=_GU^*K?:*"MBBM-^+V0ON$('=7&(.7^+;[ZKG`QP)6K
MO8+=MG'=`G89MA+UG^41M2J`%1_VBH^.Y$.N!G3DN1T7F$YJPWB-R4;N[2:<
MQ-%/`E``HWG&X1T"!IK_#N[:,//'F"N/1!KR#)IM(M('SQ_[8=3%&F%KS!3-
M:Y3&L8@AGLOCY;L2<W!88KCDLCVGRFF=\0<)B6,B1&>K=0LJPN%]-1,PC4<C
M3T`SB3,%OF.O(LNUBB()>UE9**0\+2?O$,<%O;.!U`I@>8C$N%X,DO>)3"9J
MY'VI:=(42T^YF*>1R@Y^A<N;BPOH`D+P'8DHEIUKT9,</Z#]=N)_7%<HF0@%
M3W/:F[E:,4LTTPZ3%.>IX!_6UN7#?C07V%OF0G^'P9!L=E'RRFB0="1E?3]!
MG.R&ZFO:SBNKC+$[[-A1+E4=I>I-GF6_:JP]C*KPJ-9A_Z40UPCL!.&;X7I5
M?TI^CS]L,%5UI>I6`RG9U-F3S,I^ST)+GI56$%I!9Z4:%W$XA*9$:J>*<K<T
M4*DBZ$-O&@>WWF!2WW]"7;YHR"2"PEQ01\B(^S+6NM2]-)!DX[AQ=3!5<UAR
M5N7N9=!5M<K]A.&O&C6?=&I(A^)P*10FO=1[#5@#H:CG5328"L-T-2/S=77N
M"W>:'\D<<*2MOI%C%2.+W%S';YPE[4T#C(J:-JG'+Q>?9KS"ZD585WXGUO\3
8!1,>W&;S6<_OZ-;(=CGY!R^DC&"`#0``
`
end
