Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262363AbSKKXW4>; Mon, 11 Nov 2002 18:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSKKXW4>; Mon, 11 Nov 2002 18:22:56 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:527 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S264758AbSKKXWw>; Mon, 11 Nov 2002 18:22:52 -0500
Date: Mon, 11 Nov 2002 21:29:32 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: convert /proc/net/netstat to seq_file
Message-ID: <20021111232932.GA27558@conectiva.com.br>
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

master.kernel.org:BK/net-2.5

Best Regards,

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.824, 2002-11-11 21:17:30-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/netstat to seq_file


 proc.c |   50 +++++++++++++++++++++++++++-----------------------
 1 files changed, 27 insertions(+), 23 deletions(-)


diff -Nru a/net/ipv4/proc.c b/net/ipv4/proc.c
--- a/net/ipv4/proc.c	Mon Nov 11 21:27:23 2002
+++ b/net/ipv4/proc.c	Mon Nov 11 21:27:23 2002
@@ -164,13 +164,11 @@
 /* 
  *	Output /proc/net/netstat
  */
- 
-int netstat_get_info(char *buffer, char **start, off_t offset, int length)
+static int netstat_seq_show(struct seq_file *seq, void *v)
 {
-	int len, i;
+	int i;
 
-	len = sprintf(buffer,
-		      "TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed"
+	seq_puts(seq, "TcpExt: SyncookiesSent SyncookiesRecv SyncookiesFailed"
 		      " EmbryonicRsts PruneCalled RcvPruned OfoPruned"
 		      " OutOfWindowIcmps LockDroppedIcmps ArpFilter"
 		      " TW TWRecycled TWKilled"
@@ -196,31 +194,37 @@
 		      " TCPAbortOnMemory TCPAbortOnTimeout TCPAbortOnLinger"
 		      " TCPAbortFailed TCPMemoryPressures\n"
 		      "TcpExt:");
-	for (i=0; i<offsetof(struct linux_mib, __pad)/sizeof(unsigned long); i++)
-		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)net_statistics, sizeof(struct linux_mib), i));
-
-	len += sprintf (buffer + len, "\n");
+	for (i = 0;
+	     i < offsetof(struct linux_mib, __pad) / sizeof(unsigned long);
+	     i++)
+		seq_printf(seq, " %lu",
+			   fold_field((unsigned long *)net_statistics,
+				      sizeof(struct linux_mib), i));
+	seq_putc(seq, '\n');
+	return 0;
+}
 
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
+static int netstat_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, netstat_seq_show, NULL);
 }
 
+static struct file_operations netstat_seq_fops = {
+	.open	 = netstat_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = single_release,
+};
+
 int __init ip_misc_proc_init(void)
 {
 	int rc = 0;
+	struct proc_dir_entry *p = create_proc_entry("netstat", S_IRUGO, proc_net);
 
-	if (!proc_net_create("netstat", 0, netstat_get_info))
+	if (!p)
 		goto out_netstat;
+	p->proc_fops = &netstat_seq_fops;
+
 	if (!proc_net_create("snmp", 0, snmp_get_info))
 		goto out_snmp;
 	if (!proc_net_create("sockstat", 0, afinet_get_info))
@@ -230,7 +234,7 @@
 out_sockstat:
 	proc_net_remove("snmp");
 out_snmp:
-	proc_net_remove("netstat");
+	remove_proc_entry("netstat", proc_net);
 out_netstat:
 	rc = -ENOMEM;
 	goto out;

===================================================================


This BitKeeper patch contains the following changesets:
1.824
## Wrapped with gzip_uu ##


begin 664 bkpatch27768
M'XL(`-L\T#T``\U576_;-A1]%G_%K8NM=B+;)"59'YF+KG7;!0W6P%G>"@B*
M1,5"9%$5:;?9W/^^2\EV$O<++?8P63+%2]YSSCV\AA_#I1)-9"7I4I#'\(=4
M.K)268E4%^MDE,KEZ*K!A;F4N#!>R*48/W\SKH0>\I%'<.4\T>D"UJ)1D<5&
MSCZB;VL16?.7KR_/?I\3,IW"BT5278L+H6$Z)5HVZZ3,U+-$+TI9C7235&HI
M=,NYV6_=<$HY?CSF.]2;;-B$NOXF91ECB<M$1KD;3-P[-"/PFU@,+XI0GK_A
M@3,)R0S8*.`N4#YF#&_@+&)^Y-`AY1&E8)QY=N@('#,84O(<_MLR7I`4)!3U
MVHT`*=%4#>.ZD:DQW#Q*)QHY08GW<5Z4@KP!4X5/SN_<)<,?O`BA"25/OU.+
M46"4M7I&Z?V*0B_8..[$#S<BG'`G]7,GI`$-G*LON_=%+',PW&$>#38T='VO
M;9F#C=]OG)]227Y`)>4A<QS*^<8+`H^U[3-YV#Q>1(-O-P_W8<B=_T7[M%:_
MA6'SH;VQ&\X/7?^)AIJQB0^<G+))`(P8VB*%HM*P%1$;!6HA/_25;E:IWBN"
M(WRS82V+#([6`P3R*2*<=H-E((H3$^4MO.^8J$FN5UKUV]S>7VG]\J..X.*V
M2J6\*82Z$)AW-YV+='UO^BI!XJR'J&$(+CE%IR$D5BX;Z!<P!7I"+#!7`;^!
MS',EM,QWPLNB6GV,E\65#7%<)]D`QJ"*OP7N6%6JN*Y$!GBRUX,]R/'Q@%B=
MY@;KR;>JX9=RU;-QQ6S+99FA'Z+,^@]AX&B`%L:MHPI-56U&A[SC/50VL*$8
M&/ZM3VG'^.1=]<1$&Z%7366J_$1FG+K`T%G./'"^=G"R%M6.I:ADAJ?6#C9L
M@]U)FN\!^6?/H(KJNA1=MEFS/^L&&_Z\/#M#4<CO@[_COX=JLAL,RDH]R,YE
MK?"HD&QD\"V8?J88G1HU(LG,FHF9=Q,K2R7$S2[:3KJMI4B4,.%.]S9@DT\G
MY!TJY&U';K697TJ<%4V,G=;<PE&->2DR:!&W2VVXW]MJZMEP$9_.+U^_M;M,
MC&/5,\ZY:?9NL(H<^H_J@9D[V.U6/7S:;M[6^NMA_4;6C#M."]$.Z/Q2KK\F
=X1[S_E\[78CT1JV64S?)KSSA)>1?J'L:6B((````
`
end
