Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267104AbSKMCMs>; Tue, 12 Nov 2002 21:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267106AbSKMCMs>; Tue, 12 Nov 2002 21:12:48 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:62214 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S267104AbSKMCMo>; Tue, 12 Nov 2002 21:12:44 -0500
Date: Wed, 13 Nov 2002 00:19:26 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] ipv4: convert /proc/net/snmp to seq_file
Message-ID: <20021113021926.GA1890@conectiva.com.br>
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

- Arnaldo

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.825, 2002-11-12 22:55:20-02:00, acme@conectiva.com.br
  o ipv4: convert /proc/net/snmp to seq_file


 proc.c |  121 +++++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 74 insertions(+), 47 deletions(-)


diff -Nru a/net/ipv4/proc.c b/net/ipv4/proc.c
--- a/net/ipv4/proc.c	Wed Nov 13 00:18:37 2002
+++ b/net/ipv4/proc.c	Wed Nov 13 00:18:37 2002
@@ -26,6 +26,7 @@
  *	Andi Kleen		:	Add support for open_requests and 
  *					split functions for more readibility.
  *	Andi Kleen		:	Add support for /proc/net/netstat
+ *	Arnaldo C. Melo		:	Convert to seq_file
  *
  *		This program is free software; you can redistribute it and/or
  *		modify it under the terms of the GNU General Public License
@@ -115,52 +116,73 @@
 /* 
  *	Called from the PROCfs module. This outputs /proc/net/snmp.
  */
- 
-int snmp_get_info(char *buffer, char **start, off_t offset, int length)
+static int snmp_seq_show(struct seq_file *seq, void *v)
 {
 	extern int sysctl_ip_default_ttl;
-	int len, i;
+	int i;
 
-	len = sprintf (buffer,
-		"Ip: Forwarding DefaultTTL InReceives InHdrErrors InAddrErrors ForwDatagrams InUnknownProtos InDiscards InDelivers OutRequests OutDiscards OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs ReasmFails FragOKs FragFails FragCreates\n"
-		"Ip: %d %d", ipv4_devconf.forwarding ? 1 : 2, sysctl_ip_default_ttl);
-	for (i=0; i<offsetof(struct ip_mib, __pad)/sizeof(unsigned long); i++)
-		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)ip_statistics, sizeof(struct ip_mib), i));
-
-	len += sprintf (buffer + len,
-		"\nIcmp: InMsgs InErrors InDestUnreachs InTimeExcds InParmProbs InSrcQuenchs InRedirects InEchos InEchoReps InTimestamps InTimestampReps InAddrMasks InAddrMaskReps OutMsgs OutErrors OutDestUnreachs OutTimeExcds OutParmProbs OutSrcQuenchs OutRedirects OutEchos OutEchoReps OutTimestamps OutTimestampReps OutAddrMasks OutAddrMaskReps\n"
-		  "Icmp:");
-	for (i=0; i<offsetof(struct icmp_mib, dummy)/sizeof(unsigned long); i++)
-		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)icmp_statistics, sizeof(struct icmp_mib), i));
-
-	len += sprintf (buffer + len,
-		"\nTcp: RtoAlgorithm RtoMin RtoMax MaxConn ActiveOpens PassiveOpens AttemptFails EstabResets CurrEstab InSegs OutSegs RetransSegs InErrs OutRsts\n"
-		  "Tcp:");
-	for (i=0; i<offsetof(struct tcp_mib, __pad)/sizeof(unsigned long); i++)
-		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)tcp_statistics, sizeof(struct tcp_mib), i));
-
-	len += sprintf (buffer + len,
-		"\nUdp: InDatagrams NoPorts InErrors OutDatagrams\n"
-		  "Udp:");
-	for (i=0; i<offsetof(struct udp_mib, __pad)/sizeof(unsigned long); i++)
-		len += sprintf(buffer+len, " %lu", fold_field((unsigned long*)udp_statistics, sizeof(struct udp_mib), i));
+	seq_printf(seq, "Ip: Forwarding DefaultTTL InReceives InHdrErrors "
+			"InAddrErrors ForwDatagrams InUnknownProtos "
+			"InDiscards InDelivers OutRequests OutDiscards "
+			"OutNoRoutes ReasmTimeout ReasmReqds ReasmOKs "
+			"ReasmFails FragOKs FragFails FragCreates\nIp: %d %d",
+			ipv4_devconf.forwarding ? 1 : 2, sysctl_ip_default_ttl);
 
-	len += sprintf (buffer + len, "\n");
+	for (i = 0;
+	     i < offsetof(struct ip_mib, __pad) / sizeof(unsigned long); i++)
+		seq_printf(seq, " %lu",
+			   fold_field((unsigned long *)ip_statistics,
+				      sizeof(struct ip_mib), i));
 
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
+	seq_printf(seq, "\nIcmp: InMsgs InErrors InDestUnreachs InTimeExcds "
+			"InParmProbs InSrcQuenchs InRedirects InEchos "
+			"InEchoReps InTimestamps InTimestampReps InAddrMasks "
+			"InAddrMaskReps OutMsgs OutErrors OutDestUnreachs "
+			"OutTimeExcds OutParmProbs OutSrcQuenchs OutRedirects "
+			"OutEchos OutEchoReps OutTimestamps OutTimestampReps "
+			"OutAddrMasks OutAddrMaskReps\nIcmp:");
+
+	for (i = 0;
+	     i < offsetof(struct icmp_mib, dummy) / sizeof(unsigned long); i++)
+		seq_printf(seq, " %lu",
+			   fold_field((unsigned long *)icmp_statistics,
+				      sizeof(struct icmp_mib), i));
+
+	seq_printf(seq, "\nTcp: RtoAlgorithm RtoMin RtoMax MaxConn ActiveOpens "
+			"PassiveOpens AttemptFails EstabResets CurrEstab "
+			"InSegs OutSegs RetransSegs InErrs OutRsts\nTcp:");
+
+	for (i = 0;
+	     i < offsetof(struct tcp_mib, __pad) / sizeof(unsigned long); i++)
+		seq_printf(seq, " %lu",
+			   fold_field((unsigned long *)tcp_statistics,
+				      sizeof(struct tcp_mib), i));
+
+	seq_printf(seq, "\nUdp: InDatagrams NoPorts InErrors OutDatagrams\n"
+			"Udp:");
+	
+	for (i = 0;
+	     i < offsetof(struct udp_mib, __pad) / sizeof(unsigned long); i++)
+		seq_printf(seq, " %lu",
+			   fold_field((unsigned long *)udp_statistics,
+				      sizeof(struct udp_mib), i));
+
+	seq_putc(seq, '\n');
+	return 0;
 }
 
+static int snmp_seq_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, snmp_seq_show, NULL);
+}
+
+static struct file_operations snmp_seq_fops = {
+	.open	 = snmp_seq_open,
+	.read	 = seq_read,
+	.llseek	 = seq_lseek,
+	.release = single_release,
+};
+
 /* 
  *	Output /proc/net/netstat
  */
@@ -181,7 +203,8 @@
 		      " TCPPureAcks TCPHPAcks"
 		      " TCPRenoRecovery TCPSackRecovery"
 		      " TCPSACKReneging"
-		      " TCPFACKReorder TCPSACKReorder TCPRenoReorder TCPTSReorder"
+		      " TCPFACKReorder TCPSACKReorder TCPRenoReorder"
+		      " TCPTSReorder"
 		      " TCPFullUndo TCPPartialUndo TCPDSACKUndo TCPLossUndo"
 		      " TCPLoss TCPLostRetransmit"
 		      " TCPRenoFailures TCPSackFailures TCPLossFailures"
@@ -189,14 +212,14 @@
 		      " TCPTimeouts"
 		      " TCPRenoRecoveryFail TCPSackRecoveryFail"
 		      " TCPSchedulerFailed TCPRcvCollapsed"
-		      " TCPDSACKOldSent TCPDSACKOfoSent TCPDSACKRecv TCPDSACKOfoRecv"
+		      " TCPDSACKOldSent TCPDSACKOfoSent TCPDSACKRecv"
+		      " TCPDSACKOfoRecv"
 		      " TCPAbortOnSyn TCPAbortOnData TCPAbortOnClose"
 		      " TCPAbortOnMemory TCPAbortOnTimeout TCPAbortOnLinger"
 		      " TCPAbortFailed TCPMemoryPressures\n"
 		      "TcpExt:");
 	for (i = 0;
-	     i < offsetof(struct linux_mib, __pad) / sizeof(unsigned long);
-	     i++)
+	     i < offsetof(struct linux_mib, __pad) / sizeof(unsigned long); i++)
 		seq_printf(seq, " %lu",
 			   fold_field((unsigned long *)net_statistics,
 				      sizeof(struct linux_mib), i));
@@ -219,20 +242,24 @@
 int __init ip_misc_proc_init(void)
 {
 	int rc = 0;
-	struct proc_dir_entry *p = create_proc_entry("netstat", S_IRUGO, proc_net);
-
+	struct proc_dir_entry *p;
+		
+	p = create_proc_entry("netstat", S_IRUGO, proc_net);
 	if (!p)
 		goto out_netstat;
 	p->proc_fops = &netstat_seq_fops;
 
-	if (!proc_net_create("snmp", 0, snmp_get_info))
+	p = create_proc_entry("snmp", S_IRUGO, proc_net);
+	if (!p)
 		goto out_snmp;
+	p->proc_fops = &snmp_seq_fops;
+
 	if (!proc_net_create("sockstat", 0, afinet_get_info))
 		goto out_sockstat;
 out:
 	return rc;
 out_sockstat:
-	proc_net_remove("snmp");
+	remove_proc_entry("snmp", proc_net);
 out_snmp:
 	remove_proc_entry("netstat", proc_net);
 out_netstat:

===================================================================


This BitKeeper patch contains the following changesets:
1.825
## Wrapped with gzip_uu ##


begin 664 bkpatch4864
M'XL(`'VVT3T``\U7;7/:1A#^+/V*+9DTQL&@%\1;ZC0..`EC.Z:R_<TSC"P=
MH+&D(W<'CEORW[M[`@$N3IQ,FRG&OMN]V]WG=I][\3.XDDQTC"!,F?D,/G"I
M.D;(,Q:J>!Y40YY6;P0.^)SC0&W"4U9[>U++F#IPJIZ)(X-`A1.8,R$[AEUU
M"XVZG[*.X1^_OSH]\DWS\!"ZDR`;LPNFX/#05%S,@R22;P(U27A652+(9,J4
MCKDHIBX<RW+PQ[.;KN4U%G;#JC<7H1W9=E"W660Y]5:C;A+\-P]A/_!BX\=Q
MR<_":;F-IMD#N]IR/+"<FFW7;`<<I^-Y'<<ZL)R.9<%.I_#2A@/+?`O_[@*Z
M9@@<XNF\W@$,B>E44)L*'E*J:S)+IQ@0)/LT',4),T^`EF";@W52S8/O_)BF
M%5CFZV\LA,(3+`VF&FXNI^VU%FZ]T6PO6+OAN&%SY+:MEM5R;W:G;J<O+(IK
M69YGM1:.VVQ8FBD/)GZ;+S^$\A'6/(*2N$,HK7:]Z6GN-!\RQVI]G3G-.AS4
MF_\#[NA$G\.!N--?Y,+@8<Y_@$Y]IP6V"?O&D<AP=1RZ53AC"3>,CM%=XMH$
MTK/M%CAFW[;;:"=5H.(0XDP!01[2-#GA=WM2B5FH"C/8QUX%YCR.8']>1B^.
M@^;]O#'(/GY%VCJN$]7U!C1,@ZRG`@='>]J\U)]VX!T7=X&(XFP,/38*9HFZ
MO#R%?N:SD,5S)K'[(1+'0G`AH60:AE'J9T=1H2+[7J""L0A2FGR5W6;\+AL(
MKOC:H!?+$*/0A!Y+8CHIX7RF?/9IQJ32_6)*;H.:C]SG,X40?!;(]#).&8JY
M@(;14G]^LC+1XKL@3A"5",8T0.U:TQ4L0'_7&2W\>83?4H4LJ>3#B,V1.*/J
M:)V0W\&&#C@5D/<R5,DPGN(LG:.A4DF9,EQOZ;QCXYD&FL)>#(=@O3(-H$\,
MOP$?C213?+0J(GI)XYL*#(?3("I##63\)\/A62;C<<8BP-TP+K^"^.7+,J+[
M1]7@>3++<6.`$4\BI`1+HKUM![!?QD":4!(Y);5!#FH5<`M/N0)Q62_)L\`F
M1C9L<+T=K,'TA2DFL)^=R3%5=,D$*JU45QDF.9R02!4[_AQ&:QH,`I$B,VYH
M]$*$?\Q8ED_U610+/"FTNW"RP1R2?#9=^<,%I=O"<I`H>1;(VVV2DD9/0#II
MM-@NX1+E-O$6M%O#1F&-&(4-R)J\*\R%:0Y]V5G%W8"]*>GAPG(-?T.@*<ML
ME[`TUT]F&%KD'(MF:7K_GW*,0CV)94M,*YY=[V3698C$\A4_2L9<Q&J2DG`6
M9[H)/@/^XBF:P1%=*NQ\RK)5#@>!E(7J2"F63E6^\X\1WHW/,$,2NC,AM%RP
MY(+EK-"MS_0MI/N:UWFA\83*H7U7%53XLS8Z17I*#9:(OEZ"JTCO[?69_I$/
MN%`;&YUVSFKT.LL325:4'>.IV9E%/RL[%.DIV5DB>IB=F0KSB"^NLQ>T0L'4
M3&2T.CPC73HK=UW;'(E8<#_C$=[9NL'+)%?F]SC]+9M_%5XEWCL)RZUIK++]
M$*C`QZO34T3Q!?$MPV[X(SN!2HY[H+`;<3QH#@%C5,FM@?TME)B1*IZ!D1Y`
M'?5)ER22L=N55@OYU`3O64;J'.M243&_4-)Z=JNNKT1L''.5Z1)<=@?OCKHG
M/N,B8H+$BVW19QE?BJ5MN\N+0M^SV_E#!YL'WGOD[SR)+AB6H9!'?$O&5\V\
MM,MNQ/,A#)"_Q]KT'GN<ODF<S3Y_!X%[CD.(^X[C@HO,RKW0,W.(M\@0,8I[
MV)\BO7`'33&YH7ZK#/4,/;I7PM<IE;Q4@8MAW[]Z?U[)':">+FY'/SW[U#B/
M^J#*/^+`B$>P]\NT3"[:VL7!:SV\)-"O6XS2M79<3X?4#5(XY?.=X3:B%/\;
8AQ,6WLI9>AAYS5$0NJ'Y-_3D536(#P``
`
end
