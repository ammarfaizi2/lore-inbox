Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSKXXMo>; Sun, 24 Nov 2002 18:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbSKXXMn>; Sun, 24 Nov 2002 18:12:43 -0500
Received: from 5-005.ctame701-2.telepar.net.br ([200.181.169.5]:55307 "EHLO
	brinquendo.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261874AbSKXXMk>; Sun, 24 Nov 2002 18:12:40 -0500
Date: Sun, 24 Nov 2002 21:19:46 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/core/dev.c: convert /proc/net/softnet_stat to seq_file
Message-ID: <20021124231945.GQ31074@conectiva.com.br>
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

	Now there are five outstanding changesets.

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.862, 2002-11-24 21:11:03-02:00, acme@conectiva.com.br
  o net/core/dev.c: convert /proc/net/softnet_stat to seq_file


 dev.c      |  100 ++++++++++++++++++++++++++++++++++++++-----------------------
 wireless.c |    5 ---
 2 files changed, 63 insertions(+), 42 deletions(-)


diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Sun Nov 24 21:12:03 2002
+++ b/net/core/dev.c	Sun Nov 24 21:12:03 2002
@@ -1796,45 +1796,49 @@
 	return 0;
 }
 
-static int dev_proc_stats(char *buffer, char **start, off_t offset,
-			  int length, int *eof, void *data)
+static struct netif_rx_stats *softnet_get_online(loff_t *pos)
 {
-	int i;
-	int len = 0;
+	struct netif_rx_stats *rc = NULL;
 
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-
-		len += sprintf(buffer + len, "%08x %08x %08x %08x %08x %08x "
-					     "%08x %08x %08x\n",
-			       netdev_rx_stat[i].total,
-			       netdev_rx_stat[i].dropped,
-			       netdev_rx_stat[i].time_squeeze,
-			       netdev_rx_stat[i].throttled,
-			       netdev_rx_stat[i].fastroute_hit,
-			       netdev_rx_stat[i].fastroute_success,
-			       netdev_rx_stat[i].fastroute_defer,
-			       netdev_rx_stat[i].fastroute_deferred_out,
-#if 0
-			       netdev_rx_stat[i].fastroute_latency_reduction
-#else
-			       netdev_rx_stat[i].cpu_collision
-#endif
-			       );
-	}
+	while (*pos < NR_CPUS)
+	       	if (cpu_online(*pos)) {
+			rc = &netdev_rx_stat[*pos];
+			break;
+		} else
+			++*pos;
+	return rc;
+}
 
-	len -= offset;
+static void *softnet_seq_start(struct seq_file *seq, loff_t *pos)
+{
+	return softnet_get_online(pos);
+}
 
-	if (len > length)
-		len = length;
-	if (len < 0)
-		len = 0;
+static void *softnet_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+{
+	++*pos;
+	return softnet_get_online(pos);
+}
 
-	*start = buffer + offset;
-	*eof = 1;
+static void softnet_seq_stop(struct seq_file *seq, void *v)
+{
+}
 
-	return len;
+static int softnet_seq_show(struct seq_file *seq, void *v)
+{
+	struct netif_rx_stats *s = v;
+
+	seq_printf(seq, "%08x %08x %08x %08x %08x %08x %08x %08x %08x\n",
+		   s->total, s->dropped, s->time_squeeze, s->throttled,
+		   s->fastroute_hit, s->fastroute_success, s->fastroute_defer,
+		   s->fastroute_deferred_out,
+#if 0
+		   s->fastroute_latency_reduction
+#else
+		   s->cpu_collision
+#endif
+		  );
+	return 0;
 }
 
 static struct seq_operations dev_seq_ops = {
@@ -1856,12 +1860,29 @@
 	.release = seq_release,
 };
 
+static struct seq_operations softnet_seq_ops = {
+	.start = softnet_seq_start,
+	.next  = softnet_seq_next,
+	.stop  = softnet_seq_stop,
+	.show  = softnet_seq_show,
+};
+
+static int softnet_seq_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &softnet_seq_ops);
+}
+
+static struct file_operations softnet_seq_fops = {
+	.open    = softnet_seq_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release,
+};
+
 #ifdef WIRELESS_EXT
 extern int wireless_proc_init(void);
-extern int wireless_proc_exit(void);
 #else
 #define wireless_proc_init() 0
-#define wireless_proc_exit()
 #endif
 
 static int __init dev_proc_init(void)
@@ -1873,12 +1894,17 @@
 	if (!p)
 		goto out;
 	p->proc_fops = &dev_seq_fops;
-	if (wireless_proc_init())
+	p = create_proc_entry("softnet_stat", S_IRUGO, proc_net);
+	if (!p)
 		goto out_dev;
-	create_proc_read_entry("net/softnet_stat", 0, 0, dev_proc_stats, NULL);
+	p->proc_fops = &softnet_seq_fops;
+	if (wireless_proc_init())
+		goto out_softnet;
 	rc = 0;
 out:
 	return rc;
+out_softnet:
+	remove_proc_entry("softnet_stat", proc_net);
 out_dev:
 	remove_proc_entry("dev", proc_net);
 	goto out;
diff -Nru a/net/core/wireless.c b/net/core/wireless.c
--- a/net/core/wireless.c	Sun Nov 24 21:12:03 2002
+++ b/net/core/wireless.c	Sun Nov 24 21:12:03 2002
@@ -406,11 +406,6 @@
 		rc = -ENOMEM;
 	return rc;
 }
-
-void __init wireless_proc_exit(void)
-{
-	remove_proc_entry("wireless", proc_net);
-}
 #endif	/* CONFIG_PROC_FS */
 
 /************************** IOCTL SUPPORT **************************/

===================================================================


This BitKeeper patch contains the following changesets:
1.862
## Wrapped with gzip_uu ##


begin 664 bkpatch21921
M'XL(`,-<X3T``\U76T_;2!1^]OR*6="B4'*9\=UA4[6EJVY5U"(03\O*,N,Q
ML7`\QIX$V)K_OF?&<2`A"5NT*S6$C'WNYSO?C)-=?%[Q<FA$;,+1+OY#5')H
M,)%S)M-9U&=BTK\L07$J!"@&8S'A@P]?!CF7/;/O(-"<1)*-\8R7U="@?6LA
MD?<%'QJGOW\Z/WY_BM!HA(_&47[%S[C$HQ&2HIQ%65R]B^0X$WE?EE%>3;C4
M.>N%:6T28L*?0SV+.&Y-76)[-:,QI9%->4Q,VW=MI,I_MUKV2A1*3=L$;]NI
M'6KY!'W$M.^[)B;F@-*!:6.3#BD=$JM'S"$A>&U0?&#B'D$?\'_;P!%B6&"`
M=<!$R0<QG_79$$-R`%;B05$*ID`?5"*1L(:5C"24@"M^$R9IQM$7#$T%+CIY
MA!GU?O"%$(D(>HL+-<#U?2TJO$U+GO&JZK.V0Y<0ZEIN;1'B6[47N8X=,-MB
M`8L=;SV8&\/I65F4.$'MVI[I0%';\5Y&[BGH@>/7U/2H7?N6XP6)SV+;C2^M
MX*62'B,]J<9T@X!J-J\I7?'Z?\!N`[NW8J=X;M;$#6Q+\]Q=9CD9.L%VEA/<
M<WY&EC=T^(9[Y:U^`VM/ULWB%>3_:),`.\O#U26^?%Z]@GXO376%?FJ@M+:)
M"?13`[6]'YVH:^&>Y?V,,VTVU::9ZHBO&2?U@@";Z#/U`12*5.*4X4J64R95
M^#0)RSM=3X7?M.5=P;_(LS3GG4PD22CQFT)4^Q#-)^8\F@71C`UQ2F`+_GI^
M?'RH71P8CO(Q'>PCXW8,#>..BHA_PU]/PZ.3\[-]9.#F9:0)[K!BVA:@,^_C
M[\@P#!UW#[(!'&VZ/Y7!7X=*?5GRZ%I=/6">55R)#@Z4&F0EE],RQR4[1`^J
M*-/#34T>MEM49B*-'T%0LP%%*3OS+MMA@0F_Z>(E9+XO,JS!4%FT:0-(!VDM
M$S;9QK0YO]N4M3&>/4^_VNGV.BR[&:/E8&NICN7N1;&]#)6YB3>'4ZV+QM)<
M+L<;B]N7XVTB506SGQVB"S``WZ*$Z$E'.^_\2OP[_"\_+O*=+C`#F%;UWDHA
MHZRKKN)2%`6/];5,)SRL;J:<_\T;P;@44F:@7G@F$90III*'XU1VER75E#$X
M?U>D,4]XN2Z`5I0\#N&NBW:!_V2-519)GK/[$`P!G53D:'=.\L92;1DFLBRM
M&ET>IXE6[C]R@ARJ&3D^IL'*2:`@%04O(Q6Y6IJ:*!3R,)>^W@UP_6R'0%=]
MQ5F\HE2RKG84Q:I.R;0.2/%,![(N>E##WD`EJ#5OJ93F(@8>Z:7;-M1P2WTN
M;<[652FZ>&^E3[T[+E:@4::;L$D>P5%AU?DU>E:GZA).IGBN!:FZ4](,!LBO
M6ZF^:8PS'E5\8:SOYGC`7G,I[#6UVLWJN<W>@]5$1@%N#!(`9=1C)^2Y+.\[
M.T^?/#M=?!9^/CW_]*V+M0TH%$O4R?M+H8]YSY_'].%\,(K>6VTW;W=O%8*Y
M;_O%HTF<YJGL[,/!;EP)>-0!B<.YGV:A3Z':)\*A&M)$S+:6_:3:Q6\L-N;L
5NII.1@0>S68"W_7^`?"]WH_0#0``
`
end
