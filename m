Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTJJOGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTJJOGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:06:05 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:4268 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S262482AbTJJOFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:05:54 -0400
Date: Fri, 10 Oct 2003 09:05:47 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@dell.com>
X-X-Sender: mdomsch@iguana.domsch.com
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.4] EDD 4-byte MBR disk signature for the boot disk
Message-ID: <Pine.LNX.4.44.0310100903360.2846-100000@iguana.domsch.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For comment. -Matt
-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1182, 2003-10-10 08:50:32-05:00, Matt_Domsch@dell.com
  EDD: read disk80 MBR signature, export through edd module
  
  There are 4 bytes in the MSDOS master boot record, at offset 0x228,
  which may contain a per-system-unique signature.  By writing into this
  signature from a tool that makes real-mode int13 calls a unique
  signature such as "BOOT" for the boot disk (int13 dev 80h), Linux may
  then retrieve this information and use it to compare against disks it
  knows as named /dev/[hs]d[a-z].
  
  This is useful in the case where the BIOS is not EDD3.0 compliant,
  thus doesn't provide the PCI bus/dev/fn and IDE/SCSI location of the
  boot disk, yet you need to know which disk is the boot disk.
  
  This patch retrieves the signature from the disk in setup.S and stores
  it in a space reserved in the empty_zero_page, copies it somewhere
  safe in setup.c, and exports it via
  /proc/bios/edd/int13_disk80/mbr_signature in edd.c.  Code is covered
  under CONFIG_EDD=[ym].


 Documentation/i386/zero-page.txt |    4 +++-
 arch/i386/boot/setup.S           |   21 +++++++++++++++++++++
 arch/i386/kernel/edd.c           |   27 +++++++++++++++++++++++++--
 arch/i386/kernel/i386_ksyms.c    |    1 +
 arch/i386/kernel/setup.c         |    3 +++
 include/asm-i386/edd.h           |    7 ++++++-
 6 files changed, 59 insertions(+), 4 deletions(-)


diff -Nru a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Fri Oct 10 09:01:41 2003
+++ b/Documentation/i386/zero-page.txt	Fri Oct 10 09:01:41 2003
@@ -66,8 +66,10 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
+0x228	4 bytes		DISK80_SIG_BUFFER (setup.S)
 0x2d0 - 0x600		E820MAP
-0x600 - 0x7D4		EDDBUF (setup.S)
+0x600 - 0x800		EDDBUF (setup.S) for disk signature read sector
+0x600 - 0x7d4		EDDBUF (setup.S)
 
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Fri Oct 10 09:01:41 2003
+++ b/arch/i386/boot/setup.S	Fri Oct 10 09:01:41 2003
@@ -49,6 +49,8 @@
  * by Matt Domsch <Matt_Domsch@dell.com> October 2002
  * conformant to T13 Committee www.t13.org
  *   projects 1572D, 1484D, 1386D, 1226DT
+ * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
+ *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
  */
 
 #include <linux/config.h>
@@ -549,6 +551,25 @@
 #endif
 
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
+# Read the first sector of device 80h and store the 4-byte signature
+	movl	$0xFFFFFFFF, %eax
+	movl	%eax, (DISK80_SIG_BUFFER)	# assume failure
+	movb	$READ_SECTORS, %ah
+	movb	$1, %al				# read 1 sector
+	movb	$0x80, %dl			# from device 80
+	movb	$0, %dh				# at head 0
+	movw	$1, %cx				# cylinder 0, sector 0
+	pushw	%es
+	pushw	%ds
+	popw	%es
+	movw	$EDDBUF, %bx
+	int	$0x13
+	jc	disk_sig_done
+	movl	(EDDBUF+MBR_SIG_OFFSET), %eax
+	movl	%eax, (DISK80_SIG_BUFFER)	# store success
+disk_sig_done:
+	popw	%es
+
 # Do the BIOS Enhanced Disk Drive calls
 # This consists of two calls:
 #    int 13h ah=41h "Check Extensions Present"
diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Fri Oct 10 09:01:41 2003
+++ b/arch/i386/kernel/edd.c	Fri Oct 10 09:01:41 2003
@@ -1,7 +1,8 @@
 /*
  * linux/arch/i386/kernel/edd.c
- *  Copyright (C) 2002 Dell Computer Corporation
+ *  Copyright (C) 2002, 2003 Dell, Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
+ *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
  *
  * BIOS Enhanced Disk Drive Services (EDD)
  * conformant to T13 Committee www.t13.org
@@ -27,7 +28,6 @@
 /*
  * TODO:
  * - move edd.[ch] to better locations if/when one is decided
- * - keep current with 2.5 EDD code changes
  */
 
 #include <linux/module.h>
@@ -333,6 +333,18 @@
 }
 
 static int
+edd_show_disk80_sig(char *page, char **start, off_t off, int count, int *eof, void *data)
+{
+	char *p = page;
+	if ( !page || off) {
+		return proc_calc_metrics(page, start, off, count, eof, 0);
+	}
+
+	p += snprintf(p, left, "0x%08x\n", edd_disk80_sig);
+	return proc_calc_metrics(page, start, off, count, eof, (p - page));
+}
+
+static int
 edd_show_extensions(char *page, char **start, off_t off, int count, int *eof, void *data)
 {
 	struct edd_info *info = data;
@@ -491,6 +503,15 @@
 	return 1;
 }
 
+static int
+edd_has_disk80_sig(struct edd_device *edev)
+{
+	struct edd_info *info = edd_dev_get_info(edev);
+	if (!edev || !info)
+		return 0;
+	return info->device == 0x80;
+}
+
 static EDD_DEVICE_ATTR(raw_data, edd_show_raw_data, NULL);
 static EDD_DEVICE_ATTR(version, edd_show_version, NULL);
 static EDD_DEVICE_ATTR(extensions, edd_show_extensions, NULL);
@@ -505,6 +526,7 @@
 		       edd_has_default_sectors_per_track);
 static EDD_DEVICE_ATTR(interface, edd_show_interface,edd_has_edd30);
 static EDD_DEVICE_ATTR(host_bus, edd_show_host_bus, edd_has_edd30);
+static EDD_DEVICE_ATTR(mbr_signature, edd_show_disk80_sig, edd_has_disk80_sig);
 
 static struct edd_attribute *def_attrs[] = {
 	&edd_attr_raw_data,
@@ -517,6 +539,7 @@
 	&edd_attr_default_sectors_per_track,
 	&edd_attr_interface,
 	&edd_attr_host_bus,
+	&edd_attr_mbr_signature,
 	NULL,
 };
 
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Fri Oct 10 09:01:41 2003
+++ b/arch/i386/kernel/i386_ksyms.c	Fri Oct 10 09:01:41 2003
@@ -185,4 +185,5 @@
 #ifdef CONFIG_EDD_MODULE
 EXPORT_SYMBOL(edd);
 EXPORT_SYMBOL(eddnr);
+EXPORT_SYMBOL(edd_disk80_sig);
 #endif
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Fri Oct 10 09:01:41 2003
+++ b/arch/i386/kernel/setup.c	Fri Oct 10 09:01:41 2003
@@ -212,6 +212,7 @@
 #define KERNEL_START (*(unsigned long *) (PARAM+0x214))
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define DISK80_SIGNATURE_BUFFER (*(unsigned int*) (PARAM+DISKSIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))
@@ -721,6 +722,7 @@
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 unsigned char eddnr;
 struct edd_info edd[EDDMAXNR];
+unsigned int edd_disk80_sig;
 /**
  * copy_edd() - Copy the BIOS EDD information
  *              from empty_zero_page into a safe place.
@@ -730,6 +732,7 @@
 {
      eddnr = EDD_NR;
      memcpy(edd, EDD_BUF, sizeof(edd));
+     edd_disk80_sig = DISK80_SIGNATURE_BUFFER;
 }
 #else
 static inline void copy_edd(void) {}
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Fri Oct 10 09:01:41 2003
+++ b/include/asm-i386/edd.h	Fri Oct 10 09:01:41 2003
@@ -1,6 +1,6 @@
 /*
  * linux/include/asm-i386/edd.h
- *  Copyright (C) 2002 Dell Computer Corporation
+ *  Copyright (C) 2002, 2003 Dell, Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * structures and definitions for the int 13h, ax={41,48}h
@@ -41,6 +41,10 @@
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
+#define READ_SECTORS 0x02
+#define MBR_SIG_OFFSET 0x1B8
+#define DISK80_SIG_BUFFER 0x228
+
 #ifndef __ASSEMBLY__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
@@ -167,6 +171,7 @@
 
 extern struct edd_info edd[EDDMAXNR];
 extern unsigned char eddnr;
+extern unsigned int edd_disk80_sig;
 #endif				/*!__ASSEMBLY__ */
 
 #endif				/* _ASM_I386_EDD_H */

===================================================================


This BitKeeper patch contains the following changesets:
1.1182
## Wrapped with gzip_uu ##


M'XL( ,6[AC\  [U9^7?:2!+^&?T5E7AF%QP.M6Z<<5YL@V=Y2<9^QMGC)7F\
M1FHLC76P:H$AR_[O6]T2(+ 3;!(OMHF.ZCJ^_KJZJG, 'SE+CRH?:)8-.DG$
M75\Y@+\E/#NJ>"P,FVX2X8.K),$'+3^)6"ORI%AK>-MBGM<*@W@R:VA-HX%W
M#2_@MSRX47#,)<U<'Z8LY4<5TM173[+YF!U5KKJ_?WQ_<J4HQ\=PYM/XAO59
M!L?'2I:D4QIZ_"W-_#")FUE*8QZQC I7%BO1A::J&OZ8Q-95TUH02S7LA4L\
M0JA!F*=JAF,92D13EX7)VS"Y27C3C7'@A@J=J&I;(X9*S(5!+*(K'2!-0AP-
M5+U%5/P%U3DRU2-=:ZCFD:I"":JW2X@^%:!\@5<6-%3E%'YN&&>*"]U.YPA2
M1CT0(#OHR.D5(-8QS28IJP.;C9,T@\Q/D\F-#S@;$"7>)&0X%G^O?98RH/AG
MP'">,0Y!C,(,/O0[%WV(*,]8"D.<:#3B)JE7!YI!,AIQG!=UIFE.';7<^0%.
M843GX"9Q1E$%A3%+&WR.PZ/&) [^/6%KKYH IW.X2X,LB&_08):@R8"CHI4(
MC-(D0BU9DH3X$FU&]!:]PTC#!@; Q#"B@TO#D*-<;F)# Y^@3Y3#R].+B^N7
M,$I2&9B,16 %U5R%QZ;@J'ZM#N\%:448J =%8[26I0&;,ND>6D0=$<V"!..+
M/9AP] *A33#J:"PPI#<8.\_5HWR&>F[CY(X+-V(:,0]::*WUR>=?O$^T\?5+
M<SD+0CT7&D>3<#D%+D4#=W*"Q.UI#R<$A6+T'V==;ZK2;AC0.*M+CR<<O(3Q
M^*\9C--D&GCYP,NS'@PG7)H>Y:[W.MU6_ZS?@S!Q\X"2D9!%-2M\ZC#'.9XG
M$X@9>HYABEB*N98 HC,;B):C&<M5O00P%]R:7?$HUQ,#TFDR;O:E<QQ7"1-L
M0' EE?B8N@QU84Z:HB<%/"P:9_/!5Y8F@S&]0:J[R3@0!,Z 8T:2P E"T!%;
M6W#KTD2^*J3L-* HU4+ W-8P2+A,7Y(9@WQ%M:)A.EB[CJI0HNDBB<\D#SD:
MQGS&/%0SB3U<+F<7?YSW?A_@)!U_FD<XR>_ P!7;5B[724UI//&C*"I5E3<[
M4@@F-K\5Z([5$K/2*F MY1,#_UD08IG&PE(]APRIIMD.LT?:Z/LY[#NJ,5WB
MCVZJ6GNAHFH-W7RLKEN6QBQL24BE+DR\.FF;FD$6FJ.99&&H>MOV+,VB]I!9
MKK6_ZK*;MF-:3T"ST"6N![=\'O%<Y1I4LC!MQW(6CCT:N4.'ZM0T]:&F/]7;
M;0MEIRW#MIVG.UTP?]M?PT;="TI4W%%L@XR(ZVJV^51_2\HW\%5U0]_I:B=Q
M)Q'#'4.DH%RM6,\-L9Z;V2S;<%FW%Z:AZV3A#-4V<X9M7?-<@AOA#I<?8Z3L
MNM$FCV!P$+OAQ&,MRJ.&U"EHYF\R6%L0M:V2A6T9%M/(B'J4&,3;M="^H[KL
MIJ,;ABR4'F:\J)J>;Q'^!-4:WNJ(M"BM9%VEMEO$!*)A.75D.H^KJS03&MKS
M%59%]60T1&VT65J)C>,;VP:;;N\:RCE@.>F8-L&]0*:>"VBD=_(74_OE-^9P
MCTVBHP-1>N(+#L4.-9ZGP8V?0?6L!B+XNOC6H8-0UJ$7NTVE9Q3"10&YCG X
ME_!##G\=3F(O97?PCR"\Y?D^VL<OQL;PK@E]Q-@+PCE%%U3I@RXF4\% !MQ/
M[HK=5&!2=7V:PF&Q:\OK0Y[1-*N+RG(@Z\NZ*/!P9YU@<2,O#UF"#Z=)X,&A
M1S-:4_ZC5 I%< Q"V6NE$HR@"B_$#2P60D\-4*R"=<@DC455Y ZP9'0'D2A,
M7%[-?5@;KR]-2FMJ#57^5_FL5,;PZAAX/$[1E5%U7(>0C5#JI3K[575FG^.7
M=5$5E&(4(_>T6AU#0\930R7".A>YRQ4HX&2U=6B7GPBS/N5E>'F63MPL=XA-
M ZR=#AE>2,1*[T0]"X?R^W@I/+AAF7Q1E2,*1%^(&P'H"_&JM@9474<IWC3>
M%/8P*ZDS1\W=[YFJC80H?,9U->AT_]X[ZPY.KJ^OJAOK)$=QBR[YP\T8T;.>
M2=JHMO(7\19IF@XV5<G<^' NW9T;?R2]_P35^D)OMVWCQW(C]ISD^5*CQT9!
MC.6VZ*M$_UFT<GE#)3B /=5FQMQ(@OGVM94%'X;F_Y0%=3"4@SPJN.J>= ;]
M[MGUQ54?F:QJJS<8T:"/Q?W%^7F_>XWOR*FS>MGI]=\A/\7[TX_GY]VKO$46
M:X!8@JQLANUTC&V" $6V,ME6WG@M:;NK9ME])/)S2JL=5'Y4:55:+P8N&%.2
M6M^7U/JSDKKH,5>'(<M#@Z<06Y:/6\3>!=0>%.]9#A)*\JM2N%NIW"=@M>C3
M:DK'EMLR?FLXS$*H&S))JY4*QH[B:UD9MVS-U\6 /&/BS$7D2\-MS[@_?*LJ
M+;>+NXG[(QWLHZO2>QWL1E5*2$Y2LC=+-?+,YWW%N=2#A:F8O&W";E!4MNC?
M+$#+V.S#2Y,@P3#M/L2?S8H2?GL(QC<XN"**RW*Y";_E=P-YMY:%/AMG+!JR
M5&9TM([F25L<3@M[8NV.@I1G!7/%,5=I%:].FZ1@ >9Z65>B9!I6?E%GY\6G
M#K\R.BN>BTLLUNXMN5KE "CGN-YA1(-PJ6A8^:6\JZ JZB]?$'$75O!SD.-$
MEBNM$!#K%&6\4(K(T[-5&"L9(>#G2F@&OM"3O[S++;BS_*4[#P-Y3H4C"EA0
M;CSA_AT&Q5>7GKA,QL7#7$^^U%'9$&% D@G7B*Y4_G0K8K[%#C;PDGB)7367
M?[6Y:]8>C6,^.7SBNHQS9</"4<FYSP_WP>6SE*<DGKT/>Y[:%=\[["FE(4O3
M="LO )U]T]#S9J&B.=ZL7\2I>I %- R^YD>UQ0%1;2,#Y2=9NWK@,CS[9"+B
MB+ZC^\_+BZOK0?]?'TXOWE?O=6D/,J=P>@_2/.FP[4&^[#ICPS]#DQPTM*)%
ML*T?**>>D2$N%M[;_)#):^OL?H,;XN!P%S,*1/8A!1I"4MROV/\XN?YXU5V5
M38?5<I%^6(/JY<G5R8=78D I1]6PH-)$G_'=DKYGZYKH1<1G"X[C;[GP>OV_
8I:[/W%O<4(ZIY^B,.9KR/_S>8GZA'0  

