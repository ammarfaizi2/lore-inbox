Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbTFGScy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbTFGScx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:32:53 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:25101 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S263365AbTFGSck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:32:40 -0400
Date: Sat, 7 Jun 2003 15:47:28 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: list.h: improve hlist
Message-ID: <20030607184728.GA10340@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

	Please consider pulling from:

bk://kernel.bkbits.net/acme/hlist-2.5

	I discussed this with Andi and he gave me an ACK to submit, please
let me know if you don't like anything and I'll be happy to fix it. The
hlist_for_each_entry is being used in my current work of converting net/
to use hlist_{head,node}.

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1320, 2003-06-07 14:22:10-03:00, acme@conectiva.com.br
  o list.h: improve hlist
  
  This changeset:
  
  1. Implements hlist_add_after
  2. uses prefetch in hlist_for_each, using a trick that ends up being
     equivalent to having the prefetch instruction in the first block
     of the hlist_for_each for block, the compiler optimizes the second
     "test" away, as its result is constant
  3. implements hlist_for_each_entry and hlist_for_each_entry safe,
     using a struct hlist_node as iterator to avoid the extra branches a
     similar implementation to list_for_each_entry would have if used
     a typed iterator, but while avoiding having to have the explicit
     hlist_entry as in hlist_for_each.
  
  4. Converts the hlist_for_each users that had explicit prefetches, i.e.
     removed the explicit prefetch
  
  5. fix a harmless list_entry use in a hlist_for_each in inode.c
     


 fs/dcache.c          |    3 ---
 fs/inode.c           |    4 +---
 include/linux/list.h |   35 ++++++++++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 7 deletions(-)


diff -Nru a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c	Sat Jun  7 15:39:03 2003
+++ b/fs/dcache.c	Sat Jun  7 15:39:03 2003
@@ -983,8 +983,6 @@
 		struct dentry *dentry; 
 		unsigned long move_count;
 		struct qstr * qstr;
-		
-		prefetch(node->next);
 
 		smp_read_barrier_depends();
 		dentry = hlist_entry(node, struct dentry, d_hash);
@@ -1072,7 +1070,6 @@
 	spin_lock(&dcache_lock);
 	base = d_hash(dparent, dentry->d_name.hash);
 	hlist_for_each(lhp,base) { 
-		prefetch(lhp->next);
 		/* read_barrier_depends() not required for d_hash list
 		 * as it is parsed under dcache_lock
 		 */
diff -Nru a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	Sat Jun  7 15:39:03 2003
+++ b/fs/inode.c	Sat Jun  7 15:39:03 2003
@@ -484,7 +484,6 @@
 
 repeat:
 	hlist_for_each (node, head) { 
-		prefetch(node->next);
 		inode = hlist_entry(node, struct inode, i_hash);
 		if (inode->i_sb != sb)
 			continue;
@@ -510,8 +509,7 @@
 
 repeat:
 	hlist_for_each (node, head) {
-		prefetch(node->next);
-		inode = list_entry(node, struct inode, i_hash);
+		inode = hlist_entry(node, struct inode, i_hash);
 		if (inode->i_ino != ino)
 			continue;
 		if (inode->i_sb != sb)
diff -Nru a/include/linux/list.h b/include/linux/list.h
--- a/include/linux/list.h	Sat Jun  7 15:39:03 2003
+++ b/include/linux/list.h	Sat Jun  7 15:39:03 2003
@@ -443,17 +443,50 @@
 	*(n->pprev) = n;
 }
 
+static __inline__ void hlist_add_after(struct hlist_node *n,
+				       struct hlist_node *next)
+{
+	next->next	= n->next;
+	*(next->pprev)	= n;
+	n->next		= next;
+}
+
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
 
 /* Cannot easily do prefetch unfortunately */
 #define hlist_for_each(pos, head) \
-	for (pos = (head)->first; pos; \
+	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
 	     pos = pos->next) 
 
 #define hlist_for_each_safe(pos, n, head) \
 	for (pos = (head)->first; n = pos ? pos->next : 0, pos; \
 	     pos = n)
 
+/**
+ * hlist_for_each_entry	- iterate over list of given type
+ * @tpos:	the type * to use as a loop counter.
+ * @pos:	the &struct hlist_node to use as a loop counter.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry(tpos, pos, head, member)			 \
+	for (pos = (head)->first;					 \
+	     pos && ({ prefetch(pos->next); 1;}) &&			 \
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
+	     pos = pos->next)
+/**
+ * hlist_for_each_entry_safe - iterate over list of given type safe against removal of list entry
+ * @tpos:	the type * to use as a loop counter.
+ * @pos:	the &struct hlist_node to use as a loop counter.
+ * @n:		another &struct hlist_node to use as temporary storage
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry_safe(tpos, pos, n, head, member) 		 \
+	for (pos = (head)->first;					 \
+	     pos && ({ n = pos->next; 1; }) && 				 \
+		({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
+	     pos = n)
 #else
 #warning "don't include kernel headers in userspace"
 #endif /* __KERNEL__ */

===================================================================


This BitKeeper patch contains the following changesets:
1.1320
## Wrapped with gzip_uu ##


M'XL( $<QXCX  ^U9;6_;-A#^+/V*0PL4=F;+I%[\%KC(E@Q;L $KNO73.ABT
M1$5")-$3*:=9W?^^(VD[MN,F35!L_6#)D&3>\>[XW/$Y.7D)[R2OQPZ+2^Z^
MA)^%5&,G%A6/5;Y@7BQ*;U:CX*T0*.AEHN2]V74O*W*INKX7N2A[PU2<P8+7
M<NQ0+]B,J-LY'SMO?_SIW:_?OW7=R03.,U9=\=^Y@LG$5:)>L"*19TQEA:@\
M5;-*EEP9K\N-ZM(GQ,<SHH. 1/TE[9-PL(QI0BD+*4^('P[[H5LW4MV>Z6LL
MZKD)G#6[5@+2)P-]HW3IAR$-W0N@'@U\ B3HD7Z/#("&8]\?4](EP9@0T+"<
M[<,!WP70)>X/\'57<.[&($ #ZV5CR,MY+18<#-(HP<\?62XA-E8E5V,[2#VX
M+.<%+WFEI-6>LB29LE3Q&N6^!XWD$N8U3[G.2EZMM%)13SF+LPXJY-45,%!U
M'E^#RI@"7B42FCG,.(K0#![\[P8Q*- /+APRMM"35,:W34M5-PB5J+0;+4OS
M6BJ8%2*^ME9$:L9W0P!\L$H=(T7XYGG!:Q!SE9?Y/QB_'I8<4Y%8.R\4E^H%
ML!MVVP$F(<?5UUPVA0*-DL!06*6!"SR-Y2Y :[]3'*MO@57)88%D*>]8?VN,
M[ I7ZI5(N'7.:X;5H(%A"Y$G)ES^ 0L"9E@4<88K8-:0Q 45K+X+BAF\E$W]
M?@0WHBD2#3:'/-697"V?F=V5;#QW8-8HN,D0-1N!CG:=(V$-V)CF11[GREJQ
MJUB!(.^7AF=K+/3@7%2XP94\E#R,JI:V;#*6;%QLZH++#N0>]ZS/FI=8U\E.
M-!M5ZR_RL&X^X!HS5I<%EQ*VXD1O.E"V'T6N:P[SX<76C_L+^$$_&+IO[FC'
M[3[Q<%W"B/OZD9V>RM[*]?96'P7#)6YM.EK."!T&0YZ.2)+,^@$]3"M[9@Q;
M43P)789#GT9?$D82(Q0'XO )]?UE.F T(,,1BV(_B>/X\W%LV]D.A(["0?!H
M('D5%TW">T5>-1]ZEM%V(QHM?4J#:.E'<1+/(I(,_2CEGT7F<P:W0R.$1$/3
M9;;B?[S//!DTEUW/R[,DO^)"&_AS;?ZO^[A%?N3[- C\I1\$PY%I-]%@I]G0
MP9C0AYL-@6YP;#;'9G-L-M]TL['4^!MTZQOSP>;Q9IN*GM%[+D;#/OCN!26#
M".B:VU:.OXC:GM26'F2VG<YDB8WZ9!GY9#0PQ#9Z,K'1([$=B>U(;-\ZL=F7
MS_O$MM9[!J^%0^0(]R*B =+;941#_.8XQB!,MO%LZ:'.NEQR^RV?9DQF[5-#
MB(=>#1^GQN>_H;I/?4.-\ RB 7*EWQ]AA]!<&9"G<F400I<>R?)(ED>R_*;)
M$G^"[C'E(69X!F=>AF$$0U?JW,4PG>85&N33*9C<[VW"UOV2.:DZ2+&. _8X
MI(#%TW8_NHY^Z+[65V<"E7TZ=9V3EA7,$;E%6XMP<"5V]%>C]LE]C_P>$63T
M2WMS]$YKS85$:F]EG"7M[FNS1T]!#[YZ!:V/FVQH/6NR?0KT%#[A[;VVA"_"
MD=L[.7'AY.#&<;JKPN2 N:Y-^O3.O\H7O#*5JV>>*;0_=G0AZ"$<P4K5Z<52
M9% (,<=]W%1HR#/J&^U7]P%[>*9>J)VJGPS;W(K&QF4U2E[.])_>M4[%2K[+
M4\;%3:ZR%:M9_WIFSWV9\!23?Q"'EEYA!\Q%>^Z ]=/6N7__0#(<9Z5AZN/1
MS'QJHWPUPT$U96UN]VX3@X99I*T3+6]O@K$63G?<3>#.PT.9GFJ*A$?3;9@4
MV!73+<)2 "NTBE$UEO[;BJC&CL,J@7/KAR<K7LY%S70S0)IE5_Q_+2@#]W95
M57N%!<\LK&H[XZO-KD7.5ZZJJGWW3RKL#/&U;,H)932=D5GJ_@M\)<.9 1L 
!    
 
