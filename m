Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267176AbSKMLlQ>; Wed, 13 Nov 2002 06:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267177AbSKMLlQ>; Wed, 13 Nov 2002 06:41:16 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:40459 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267176AbSKMLlK>; Wed, 13 Nov 2002 06:41:10 -0500
Date: Wed, 13 Nov 2002 09:47:54 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: convert /proc/net/sockstat to seq_file
Message-ID: <20021113114753.GB3440@conectiva.com.br>
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

Hi David,

	Please pull from:

master.kernel.org:/home/acme/BK/net-2.5

	Now there are two outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.826, 2002-11-13 09:38:15-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/sockstat to seq_file
  
  Also only compile/link socket_seq_show (previously socket_get_info) in
  net/socket.c if CONFIG_PROC_FS is enabled.


 ipv4/proc.c |   85 ++++++++++++++++++++++++++----------------------------------
 socket.c    |   22 ++++-----------
 2 files changed, 43 insertions(+), 64 deletions(-)


diff -Nru a/net/ipv4/proc.c b/net/ipv4/proc.c
--- a/net/ipv4/proc.c	Wed Nov 13 09:44:17 2002
+++ b/net/ipv4/proc.c	Wed Nov 13 09:44:17 2002
@@ -23,7 +23,7 @@
  *		Alan Cox	:	Handle dead sockets properly.
  *	Gerhard Koerting	:	Show both timers
  *		Alan Cox	:	Allow inode to be NULL (kernel socket)
- *	Andi Kleen		:	Add support for open_requests and 
+ *	Andi Kleen		:	Add support for open_requests and
  *					split functions for more readibility.
  *	Andi Kleen		:	Add support for /proc/net/netstat
  *	Arnaldo C. Melo		:	Convert to seq_file
@@ -33,21 +33,11 @@
  *		as published by the Free Software Foundation; either version
  *		2 of the License, or (at your option) any later version.
  */
-#include <asm/system.h>
-#include <linux/sched.h>
-#include <linux/socket.h>
-#include <linux/net.h>
-#include <linux/un.h>
-#include <linux/in.h>
-#include <linux/param.h>
-#include <linux/inet.h>
-#include <linux/netdevice.h>
-#include <net/ip.h>
+#include <linux/types.h>
 #include <net/icmp.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/udp.h>
-#include <linux/skbuff.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <net/sock.h>
@@ -58,7 +48,7 @@
 	int res = 0;
 	int cpu;
 
-	for (cpu=0; cpu<NR_CPUS; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		res += proto->stats[cpu].inuse;
 
 	return res;
@@ -67,38 +57,35 @@
 /*
  *	Report socket allocation statistics [mea@utu.fi]
  */
-int afinet_get_info(char *buffer, char **start, off_t offset, int length)
+static int sockstat_seq_show(struct seq_file *seq, void *v)
 {
-	/* From  net/socket.c  */
-	extern int socket_get_info(char *, char **, off_t, int);
+	/* From net/socket.c */
+	extern void socket_seq_show(struct seq_file *seq);
 
-	int len  = socket_get_info(buffer,start,offset,length);
+	socket_seq_show(seq);
+	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %d\n",
+		   fold_prot_inuse(&tcp_prot), atomic_read(&tcp_orphan_count),
+		   tcp_tw_count, atomic_read(&tcp_sockets_allocated),
+		   atomic_read(&tcp_memory_allocated));
+	seq_printf(seq, "UDP: inuse %d\n", fold_prot_inuse(&udp_prot));
+	seq_printf(seq, "RAW: inuse %d\n", fold_prot_inuse(&raw_prot));
+	seq_printf(seq,  "FRAG: inuse %d memory %d\n", ip_frag_nqueues,
+		   atomic_read(&ip_frag_mem));
+	return 0;
+}
 
-	len += sprintf(buffer+len,"TCP: inuse %d orphan %d tw %d alloc %d mem %d\n",
-		       fold_prot_inuse(&tcp_prot),
-		       atomic_read(&tcp_orphan_count), tcp_tw_count,
-		       atomic_read(&tcp_sockets_allocated),
-		       atomic_read(&tcp_memory_allocated));
-	len += sprintf(buffer+len,"UDP: inuse %d\n",
-		       fold_prot_inuse(&udp_prot));
-	len += sprintf(buffer+len,"RAW: inuse %d\n",
-		       fold_prot_inuse(&raw_prot));
-	len += sprintf(buffer+len, "FRAG: inuse %d memory %d\n",
-		       ip_frag_nqueues, atomic_read(&ip_frag_mem));
-	if (offset >= len)
-	{
-		*start = buffer;
-		return 0;
-	}
-	*start = buffer + offset;
-	len -= offset;
-	if (len > length)
-		len = length;
-	if (len < 0)
-		len = 0;
-	return len;
+static int sockstat_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sockstat_seq_show, NULL);
 }
 
+static struct file_operations sockstat_seq_fops = {
+	.open	 = sockstat_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = single_release,
+};
+
 static unsigned long fold_field(unsigned long *begin, int sz, int nr)
 {
 	unsigned long res = 0;
@@ -106,14 +93,14 @@
 
 	sz /= sizeof(unsigned long);
 
-	for (i=0; i<NR_CPUS; i++) {
-		res += begin[2*i*sz + nr];
-		res += begin[(2*i+1)*sz + nr];
+	for (i = 0; i < NR_CPUS; i++) {
+		res += begin[2 * i * sz + nr];
+		res += begin[(2 * i + 1) * sz + nr];
 	}
 	return res;
 }
 
-/* 
+/*
  *	Called from the PROCfs module. This outputs /proc/net/snmp.
  */
 static int snmp_seq_show(struct seq_file *seq, void *v)
@@ -160,7 +147,7 @@
 
 	seq_printf(seq, "\nUdp: InDatagrams NoPorts InErrors OutDatagrams\n"
 			"Udp:");
-	
+
 	for (i = 0;
 	     i < offsetof(struct udp_mib, __pad) / sizeof(unsigned long); i++)
 		seq_printf(seq, " %lu",
@@ -183,7 +170,7 @@
 	.release = single_release,
 };
 
-/* 
+/*
  *	Output /proc/net/netstat
  */
 static int netstat_seq_show(struct seq_file *seq, void *v)
@@ -243,7 +230,7 @@
 {
 	int rc = 0;
 	struct proc_dir_entry *p;
-		
+
 	p = create_proc_entry("netstat", S_IRUGO, proc_net);
 	if (!p)
 		goto out_netstat;
@@ -254,8 +241,10 @@
 		goto out_snmp;
 	p->proc_fops = &snmp_seq_fops;
 
-	if (!proc_net_create("sockstat", 0, afinet_get_info))
+	p = create_proc_entry("sockstat", S_IRUGO, proc_net);
+	if (!p)
 		goto out_sockstat;
+	p->proc_fops = &sockstat_seq_fops;
 out:
 	return rc;
 out_sockstat:
diff -Nru a/net/socket.c b/net/socket.c
--- a/net/socket.c	Wed Nov 13 09:44:17 2002
+++ b/net/socket.c	Wed Nov 13 09:44:17 2002
@@ -1839,29 +1839,19 @@
 #endif
 }
 
-int socket_get_info(char *buffer, char **start, off_t offset, int length)
+#ifdef CONFIG_PROC_FS
+void socket_seq_show(struct seq_file *seq)
 {
-	int len, cpu;
+	int cpu;
 	int counter = 0;
 
-	for (cpu=0; cpu<NR_CPUS; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		counter += sockets_in_use[cpu].counter;
 
 	/* It can be negative, by the way. 8) */
 	if (counter < 0)
 		counter = 0;
 
-	len = sprintf(buffer, "sockets: used %d\n", counter);
-	if (offset >= len)
-	{
-		*start = buffer;
-		return 0;
-	}
-	*start = buffer + offset;
-	len -= offset;
-	if (len > length)
-		len = length;
-	if (len < 0)
-		len = 0;
-	return len;
+	seq_printf(seq, "sockets: used %d\n", counter);
 }
+#endif /* CONFIG_PROC_FS */

===================================================================


This BitKeeper patch contains the following changesets:
1.826
## Wrapped with gzip_uu ##


begin 664 bkpatch15114
M'XL(`!$[TCT``^57;6_;-A#^+/Z*6X(5MN,74N]VZJ)IW&1&BR9P%NS#.AB*
M1"="95*5:*?9W/^^(V5[KNVT:;%O3122.MX=']ZK<@C7)2]Z5A1/.3F$WV2I
M>E8L!8]5.H_:L9RV;PK<&$F)&YT[.>6=5V\Z@JN6W?8([EQ&*KZ#.2_*GL7:
MSIJB'G+>LT:OSZ_?GHP(Z??A]"X2M_R**^CWB9+%/,J2\F6D[C(IVJJ(1#GE
MRIRY6+,N;$IM_/58X%#/7S"?NL$B9@ECD<MX0FTW]%VBX;_<AKVEA3'F4.IY
M-EW8H>,S,@#6#FT?J-UAK,,<H-V>$_:8UZ)VCU+8JQ2.;&A1\@K^WPN<DA@D
MI/G<[0$>B>94T,D+&6M3=TH9?RA5I/!0*/G'\23-.`K@<Y*5$J3('E!JFB.Y
MDZ7B`V@!KL::M[R3]U#+"SY/Y:Q$QN7>+?ZE8B+KD`I4M#J&JW8,Z01.+]Z=
M#<_'EZ.+T_'9%:0E<!'=9#QIDS=@AR[MDLO_/$I:W_E#"(TH>?$-*VZ"VC1D
MUPL6OAL$WB*FD\#VHXGG!9,;NQOO=]JN(AT,^(2,H:(N#9X$1;O'.&4;3;AP
M7#_H+GC7MYTXF#A=&M+0N?D*FFU=&X#T1$W&;#%^.V]^".4CV?,82IU#-%S8
M3N#3*H=V,HA]/8.<`%IN^)/G4.7E"V@5]^;!G+C<=O@/I-4`"QHC0S-"PSH1
M20IO,LZ%9?6LDR2!<I;G$BTSD07(G(MQP3_.>*E*B$1"!@X*4C)T/90_3$6<
MS1(.S]$@LT\=7=++]MT+,O`H;@]\IH\RHZ75U>)\!GV@QZ`7S^'=:'QZ>7UE
M7H^.ZF00:+&A&;4K4K224+#RS-K4M5(5LUBMW00-7#5A+M,$&G.MQP8;]3@X
M6IT&G!5R^J7Q&QUB\4^*%Z*2VO+EW@/JQZC8,P!QQ"OM"!D>2[_G!0*?U`RL
M@]]/+WMXD5G)X=<$9)%CW.J5NM=CE&4RUHLIG^+T7APTB64!H`.R!!5)'4(H
M6WNFXMR\UYL0*3E-8W1-E%3T2NLXEC.!^Y4"35?W%6V/2`6_'!L`D>+)2FZ'
M$Y')XF&#<>\UKP<;U]37V+W!+%G>8*^"T<D?WU)01/>/*X"#L]')^8:I*]PK
M96D^GA31[5A@.&-`[[OLB@4%S0D%5S,,$7I,/J/O`[`=,NQVP7DT.G7"K((G
M%1)3HV&F)BR)533IL4[^61]0IN(VXY6TWFONQGP3WEV_?8N@AHPR"%8(-M1J
M\0*)4I1?BD]D7F+:X7%M?8*%ZQW0:(VVMH'91)I>:UJ6E9Q_6%'-2\6:\0B-
MW%]!7Q*:Y/,Q>4\&C&HK#;$=X%3E?EIE?KJ9]REFO<:%=BCAJ`\W_#85?]K0
M0+8&E'_#$8CBK^-MAEK%<02L_@7;@#%3W*JITT""[QB"F32NL&((5PRV6Y5#
M,R&#[07F'2>L'3EBCM$4BNNHB\=<J.*A=K"R'@;5U7@XNCZ_:(+9QQJCPP9+
M>^V7O*[5A+KVY:T79GOIB&<[WCE>=_-UA7I2*_^^;Q^21',^?2EFJFP+[&!1
M&W7L^_2A^`W,NMA"T9#,-SW<<;^WB?O00MF?NX=7GXY[>OA*PX\T<!:Z=A7$
MKFYSA^DDX=LXR-.[FE'H+A7JV=)5#3ORL=D)ECO!DYLX"SU4XY@LTUFU6^B7
MG:<'6*>357DV;8H7IL*%OC[ND./'R02P@6\9&;OW^M_(^(ZCSV?3OA\X&*TW
+-^1?]!#&)[,.````
`
end
