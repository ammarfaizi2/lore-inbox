Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264898AbSJPGTJ>; Wed, 16 Oct 2002 02:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSJPGTJ>; Wed, 16 Oct 2002 02:19:09 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:7696 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264898AbSJPGTE>; Wed, 16 Oct 2002 02:19:04 -0400
Date: Wed, 16 Oct 2002 03:24:49 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: udp seq_file support: produce only one record per seq_show
Message-ID: <20021016062449.GC1352@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
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

	Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.858, 2002-10-16 03:11:34-03:00, acme@conectiva.com.br
  o ipv4: udp seq_file support: produce only one record per seq_show


 ip_proc.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 59 insertions(+), 15 deletions(-)


diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Wed Oct 16 03:17:17 2002
+++ b/net/ipv4/ip_proc.c	Wed Oct 16 03:17:17 2002
@@ -198,16 +198,64 @@
 
 /* ------------------------------------------------------------------------ */
 
+#define UDP_HASH_POS_BITS (sizeof(loff_t) * 8 - 8)
+#define UDP_HASH_BITS (((loff_t)127) << UDP_HASH_POS_BITS)
+#define UDP_HASH_BUCKET(p) ((p & UDP_HASH_BITS) >> UDP_HASH_POS_BITS)
+
+static __inline__ struct sock *udp_get_bucket(struct seq_file *seq, loff_t *pos)
+{
+	struct sock *sk = NULL;
+	loff_t ppos = *pos & ~UDP_HASH_BITS, l = ppos;
+	loff_t bucket = UDP_HASH_BUCKET(*pos);
+
+	for (; bucket < UDP_HTABLE_SIZE; ++bucket)
+		for (sk = udp_hash[bucket]; sk; sk = sk->next) {
+			if (sk->family != PF_INET)
+				continue;
+			if (l--)
+				continue;
+			*pos = (bucket << UDP_HASH_POS_BITS) | ppos;
+			/*
+			 * temporary HACK till we have a solution to
+			 * get more state passed to seq_show -acme
+			 */
+			seq->private = (void *)(int)bucket;
+			goto out;
+		}
+out:
+	return sk;
+}
+
 static void *udp_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	read_lock(&udp_hash_lock);
-	return (void *)(unsigned long)++*pos;
+	return *pos ? udp_get_bucket(seq, pos) : (void *)1;
 }
 
 static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	return (void *)(unsigned long)((++*pos) >=
-				       (UDP_HTABLE_SIZE - 1) ? 0 : *pos);
+	int next_bucket;
+	struct sock *sk;
+
+	if (v == (void *)1) {
+		sk = udp_get_bucket(seq, pos);
+		goto out;
+	}
+
+	sk = v;
+	sk = sk->next;
+	if (sk) 
+		goto out;
+
+	next_bucket = UDP_HASH_BUCKET(*pos) + 1;
+	if (next_bucket >= UDP_HTABLE_SIZE) 
+		goto out;
+
+	*pos = (loff_t)next_bucket << UDP_HASH_POS_BITS;
+	sk = udp_get_bucket(seq, pos);
+out:
+	++*pos;
+	return sk;
 }
 
 static void udp_seq_stop(struct seq_file *seq, void *v)
@@ -215,7 +263,7 @@
 	read_unlock(&udp_hash_lock);
 }
 
-static void udp_format_sock(struct sock *sp, char *tmpbuf, int i)
+static void udp_format_sock(struct sock *sp, char *tmpbuf, int bucket)
 {
 	struct inet_opt *inet = inet_sk(sp);
 	unsigned int dest = inet->daddr;
@@ -225,7 +273,7 @@
 
 	sprintf(tmpbuf, "%4d: %08X:%04X %08X:%04X"
 		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %lu %d %p",
-		i, src, srcp, dest, destp, sp->state, 
+		bucket, src, srcp, dest, destp, sp->state, 
 		atomic_read(&sp->wmem_alloc), atomic_read(&sp->rmem_alloc),
 		0, 0L, 0, sock_i_uid(sp), 0, sock_i_ino(sp),
 		atomic_read(&sp->refcnt), sp);
@@ -233,19 +281,15 @@
 
 static int udp_seq_show(struct seq_file *seq, void *v)
 {
-	char tmpbuf[129];
-	struct sock *sk;
-	unsigned long l = (unsigned long)v - 1;
-
-	if (!l)
+	if (v == (void *)1)
 		seq_printf(seq, "%-127s\n",
 			   "  sl  local_address rem_address   st tx_queue "
-			   "rx_queue tr tm->when retrnsmt   uid  timeout inode");
+			   "rx_queue tr tm->when retrnsmt   uid  timeout "
+			   "inode");
+	else {
+		char tmpbuf[129];
 
-	for (sk = udp_hash[l]; sk; sk = sk->next) {
-		if (sk->family != PF_INET)
-			continue;
-		udp_format_sock(sk, tmpbuf, l);
+		udp_format_sock(v, tmpbuf, (int)seq->private);
 		seq_printf(seq, "%-127s\n", tmpbuf);
 	}
 	return 0;

===================================================================


This BitKeeper patch contains the following changesets:
1.858
## Wrapped with gzip_uu ##


begin 664 bkpatch21667
M'XL(`&T$K3T``\U6VW+:2!!]UGQ%KUVUQ4V@T04$!#:^9>VR*Z%\>=EL2B5+
M0U"!-(IFA.-=LM^^/1+"8)-4>2L/RT4CU-UGNON<ECB$.\&R@>8',2.'<,Z%
M'&@!3U@@HZ7?#GC<OL_0<,TY&CHS'K/.\64G85(WVPY!R\27P0R6+!,#C;:M
MS17YF+*!=GWV^]W5T34AHQ&<S/SD,[MA$D8C(GFV]!>A>.O+V8(G;9GYB8B9
M+/9<;5Q7IF&8^'9HSS*<[HIV#;NW"FA(J6]3%AJF[7;M)S25X`^QJ($0EMFW
M>BO'L&V3G`)MNXX+AMFA1H=VP;`&E`XL6\<3PP#5F;?/.P)-"KI!CN'GEG%"
M`N`0I4M[`'F8@F!?O&FT8"#R-.69'$":\3`/&/!D\8@'!AD+>!9"RK+"6\SX
M`[D$+*W;)Y.GEA/]E2]"#-\@X_WEKY#_CDH3#QZF%+2#JKF4=AW'LE:&T<,Z
M`]=T7<N9NJ;5M>Y-Y]5P7:-K]*F+7/5[;J&BE[Y*3C\WS5?#V?AQ3+JR3=LQ
M"DDY.X(R^@/J_EA03A]TZOR?):48^`!Z]E!\4"*3/63\!Z%=8"5@NN0P9-,(
M][\[G7CG1S?GWN3#C7=\<7L#-1']Q?BTMN#3J2?KT``7='#K+T-*]UKE2<U>
M'=Z\>0FY+_3NY/+LMI;6,3Z%7W<QZS`>[T/YDPCIRR@`SXN2!>)Y'@B9Y8$$
MP8,Y-+#GWF<FO?L\F#-9JVP5"PT\:T&9+312+NKD;Z+M((@YC.#]W=75D&AK
M1V1.X$7ECXG^LY,IHJ%)>3SYEYOCY>?%%CL.L0IMRC.H#2O/=<=NCXZOSKR;
MBS_.AM!LEK8ZT4KG(B]5WLP7LX^E\=,0Q%Q]T23F^CAA7Y$NK$C3HJD*T<=3
M/XY0:+^,8/+.NWA_=JL`-?7,D5&2LV'EN]#U/99&67FMRG,?M;"JRM>T3D,=
M43"2Q2AW/WN$\Z.32Y#18@$/#&;^DH&/G5[D,N()#M_:'SF#F&<X)\@O@]07
M@H5HWHP$Z,4SL_#NJ`4-^CC-<*;1'U-<\BB$1KT6);)>IEMD])DC",^+']\(
MG@R(EC&99XEJ'?F&9)R:A@U4S85:*FM1^F_P7%!*/XI%&&RVI$,%T0<3(2B.
MEDDT3`(4&=XFDV<:*T2@^K[$V^D34DG>ANI]&ZM"MHI2!90!R^'ZI%+"D*Q5
M4(>=&`S8RNU[,H4FT#7"MO=X]%RK+]$KU:SO"MOA^Q14Y?W]BDO:FLU&J;,M
M_DY-ZA;<%<OZYE!T4Z'AX,2^]%33:[L$I"T(9GX&#1FG]_FT!8JQ:N).3;,$
M+19-*Z^W0&1!<<#@D`E9'O&'2/5QH=L68*S5!0=C;4/%[J$876RK@,?%+A0-
M<)!]];[D+&<@,Y"Q/GZ8L00?#3+#AY%$AQRC<8QBAKV`@RHJ2GC(#I0FV$*P
M0CQ%6655'ZG9_Z1Z9#NX$>Y7EO.\,\L65%THIF=[LA!Z\Q<SF+%@+O)X%#(?
._RJXC/P+OD48;L\*````
`
end
