Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262887AbSJRD40>; Thu, 17 Oct 2002 23:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262888AbSJRD40>; Thu, 17 Oct 2002 23:56:26 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:20740 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262887AbSJRD4Y>; Thu, 17 Oct 2002 23:56:24 -0400
Date: Fri, 18 Oct 2002 01:02:18 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: remove the hack, make udp seq_file functions use seq->private
Message-ID: <20021018040217.GO1572@conectiva.com.br>
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


ChangeSet@1.861, 2002-10-18 00:49:22-03:00, acme@conectiva.com.br
  o ipv4: remove the hack, make udp seq_file functions use seq->private


 ip_proc.c |   65 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 45 insertions(+), 20 deletions(-)


diff -Nru a/net/ipv4/ip_proc.c b/net/ipv4/ip_proc.c
--- a/net/ipv4/ip_proc.c	Fri Oct 18 00:57:11 2002
+++ b/net/ipv4/ip_proc.c	Fri Oct 18 00:57:11 2002
@@ -282,28 +282,24 @@
 
 /* ------------------------------------------------------------------------ */
 
-#define UDP_HASH_POS_BITS (sizeof(loff_t) * 8 - 8)
-#define UDP_HASH_BITS (((loff_t)127) << UDP_HASH_POS_BITS)
-#define UDP_HASH_BUCKET(p) ((p & UDP_HASH_BITS) >> UDP_HASH_POS_BITS)
+struct udp_iter_state {
+	int bucket;
+};
 
 static __inline__ struct sock *udp_get_bucket(struct seq_file *seq, loff_t *pos)
 {
+	int i;
 	struct sock *sk = NULL;
-	loff_t ppos = *pos & ~UDP_HASH_BITS, l = ppos;
-	loff_t bucket = UDP_HASH_BUCKET(*pos);
+	loff_t l = *pos;
+	struct udp_iter_state *state = seq->private;
 
-	for (; bucket < UDP_HTABLE_SIZE; ++bucket)
-		for (sk = udp_hash[bucket]; sk; sk = sk->next) {
+	for (; state->bucket < UDP_HTABLE_SIZE; ++state->bucket)
+		for (i = 0, sk = udp_hash[state->bucket]; sk; ++i, sk = sk->next) {
 			if (sk->family != PF_INET)
 				continue;
 			if (l--)
 				continue;
-			*pos = (bucket << UDP_HASH_POS_BITS) | ppos;
-			/*
-			 * temporary HACK till we have a solution to
-			 * get more state passed to seq_show -acme
-			 */
-			seq->private = (void *)(int)bucket;
+			*pos = i;
 			goto out;
 		}
 out:
@@ -318,8 +314,8 @@
 
 static void *udp_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	int next_bucket;
 	struct sock *sk;
+	struct udp_iter_state *state;
 
 	if (v == (void *)1) {
 		sk = udp_get_bucket(seq, pos);
@@ -331,11 +327,11 @@
 	if (sk) 
 		goto out;
 
-	next_bucket = UDP_HASH_BUCKET(*pos) + 1;
-	if (next_bucket >= UDP_HTABLE_SIZE) 
+	state = seq->private;
+	if (++state->bucket >= UDP_HTABLE_SIZE) 
 		goto out;
 
-	*pos = (loff_t)next_bucket << UDP_HASH_POS_BITS;
+	*pos = 0;
 	sk = udp_get_bucket(seq, pos);
 out:
 	++*pos;
@@ -372,8 +368,9 @@
 			   "inode");
 	else {
 		char tmpbuf[129];
+		struct udp_iter_state *state = seq->private;
 
-		udp_format_sock(v, tmpbuf, (int)seq->private);
+		udp_format_sock(v, tmpbuf, state->bucket);
 		seq_printf(seq, "%-127s\n", tmpbuf);
 	}
 	return 0;
@@ -441,7 +438,35 @@
 
 static int udp_seq_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &udp_seq_ops);
+	struct seq_file *seq;
+	int rc = -ENOMEM;
+	struct udp_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+       
+	if (!s)
+		goto out;
+
+	rc = seq_open(file, &udp_seq_ops);
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
+static int udp_seq_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *seq = (struct seq_file *)file->private_data;
+
+	kfree(seq->private);
+	seq->private = NULL;
+
+	return seq_release(inode, file);
 }
 
 static struct file_operations arp_seq_fops = {
@@ -462,7 +487,7 @@
 	.open           = udp_seq_open,
 	.read           = seq_read,
 	.llseek         = seq_lseek,
-	.release	= seq_release,
+	.release	= udp_seq_release,
 };
 
 /* ------------------------------------------------------------------------ */

===================================================================


This BitKeeper patch contains the following changesets:
1.861
## Wrapped with gzip_uu ##


begin 664 bkpatch3160
M'XL(`)>&KST``\U6;6_:2!#^[/T5<ZIT@H27?;&-`T?4IN%:%)JB]/+EKB?+
M,>MB@;V<=^%>2O_[S:X3DA`4*:=^.$`>-#O[S/,\,T*\@FLMJ[Z7I(4DK^"]
MTJ;OI:J4J<DW22=51>>FPH,KI?"@.U>%[)Y==$MIVKP3$#R9)B:=PT96NN^Q
MCMAES-\KV?>N1N^N)V^N"!D.X>T\*;_(3]+`<$B,JC;)<J9?)V:^5&7'5$FI
M"VE<S^VN=,LIY?@.6$_0(-RRD/J];<IFC"4^DS/*_2CTB:7_>I_V'@JCK(<X
MH>]O`^H'(3D'UHE"!I1W&>VR""CM^R=]SMM4]"F%@Z!PS*!-R1E\7P%O20H*
M\M7&[T,E"[618.82YDFZ:$&1+"2L9RO0\H\XRY<2LG6)I%2I8:VE3;=/5Q62
M-))<`*H+`S*]]YNT7_@BA":4G!YV8(O#[UJF^(A7E4H[Z9V_C(5!(,26TAY*
M32,>12+((BY"<<.#%\-%5/@G+-KZ$0M\MT)/:^TN?5^:+X:KMXIM>:_G\WJK
M]G>*1<_OE!]`F_^_MZH>PD=H5W^Z#V[)],`\_L.NG?,H`$'&/.IAT*9:I\82
MBW,CJU@;[`]?B9>7!F[6Z4*:`?DVP/(3"JQ.YP,$.>'`;59@\)8JRV(#2QC"
MT4KI`?$.XQ[58?A(K4,+:K30HF6J@L8`7&W[M"8!/\'U^31^_\N;L\DH_C3^
M=32`X^-')4WBU5=S;$!;H!<8+8%YHN>_/2K]'=$7%B"_+=.+]FDI_S)-E'XN
M*(.0C`4-K6+/LY*PQLH6G&%N+#BW1\^)M,7"MZJ$L.*\P]*]/(/&GA`X'>Z+
M;8*%BUQO%^Y(41R-Z/F.Z,L\%[W0P?5JE?86NE<D)M8J730V+3#%ZF:=M1X/
MHHE7?=\V'-O`3W8V[!;["+\-ZE6I\!<#VJ/+CQ]&'Y[9"BQ:%,ERJ=*&SO^1
M*FL<Z68+WOT\C2]&5Y>C"7:%^E4[]H.VT_ZBC`*UQ@W]3#S7RG)0*UDV+)$6
M_&@[U3G=O#6[2A]>C1=9):4#P#K/M1B"O;WS*IXE)AFX\UW.ML)4(0LM34.W
MW+[MF&,KA.XC)VG658DNN$3="],N-ARC>PG?D(/U(T_!.G?'O))+F6BLKJW+
M2S5#QURPDW')VG7[;)*OA^>!A!M/\LU#.C_O^#W0VWRJ__)Z,JF-KT4^)'M+
LSS&R^Q(&;E]<\#JW5=YP7V3K_A]..I?I0J^+H<C"*(FBC/P+EL[!8CP)````
`
end
