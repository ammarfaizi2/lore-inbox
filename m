Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUATWIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbUATWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:07:39 -0500
Received: from linux.us.dell.com ([143.166.224.162]:10453 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S265840AbUATWF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:05:58 -0500
Date: Tue, 20 Jan 2004 16:05:34 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] EDD disksig patch for 2.6.1
Message-ID: <20040120160534.A13220@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sent this patch before the holidays, had no feedback on it
specifically.  The same functional code is in 2.4.x mainline now.  I'm
still working on the follow-on patches for symlinks for IDE and SCSI
devices in sysfs, but those are separate from the disksig patch.  For
Andrew, patch is appended, linux-2.6.1-edd1-disksig.patch.  Please
consider for -mm and/or mainline.

Linus, please do a

	bk pull http://mdomsch.bkbits.net/linux-2.5-edd-for-linus

This will update the following files:

 Documentation/i386/zero-page.txt |    4 +++-
 arch/i386/boot/setup.S           |   21 +++++++++++++++++++++
 arch/i386/kernel/edd.c           |   22 +++++++++++++++++++++-
 arch/i386/kernel/i386_ksyms.c    |    6 ------
 arch/i386/kernel/setup.c         |    7 +++++++
 include/asm-i386/edd.h           |    6 +++++-
 include/asm-i386/setup.h         |    1 +
 7 files changed, 58 insertions, 9 deletions

through these ChangeSets:

<Matt_Domsch@dell.com> (04/01/20 1.1505)
   EDD: read disk80 MBR signature, export through edd module
   
   There are 4 bytes in the MSDOS master boot record, at offset 0x1b8,
   which may contain a per-system-unique signature.  By first writing a
   unique signature to each disk in the system, then rebooting, and then
   reading the MBR to get the signature for the boot disk (int13 dev
   80h), userspace may use it to compare against disks it knows as named
   /dev/[hs]d[a-z], and thus determine which disk is the BIOS boot disk,
   thus where the /boot, / and boot loaders should be placed.
     
   This is useful in the case where the BIOS is not EDD3.0 compliant,
   thus doesn't provide the PCI bus/dev/fn and IDE/SCSI location of the
   boot disk, yet you need to know which disk is the boot disk.  It's
   most useful in OS installers.
      
   This patch retrieves the signature from the disk in setup.S, stores it
   in a space reserved in the empty_zero_page, copies it somewhere safe
   in setup.c, and exports it via
   /sys/firmware/edd/int13_disk80/mbr_signature in edd.c.  Code is
   covered under CONFIG_EDD=[ym].


-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1505, 2004-01-20 15:45:36-06:00, Matt_Domsch@dell.com
  EDD: read disk80 MBR signature, export through edd module
  
  There are 4 bytes in the MSDOS master boot record, at offset 0x1b8,
  which may contain a per-system-unique signature.  By first writing a
  unique signature to each disk in the system, then rebooting, and then
  reading the MBR to get the signature for the boot disk (int13 dev
  80h), userspace may use it to compare against disks it knows as named
  /dev/[hs]d[a-z], and thus determine which disk is the BIOS boot disk,
  thus where the /boot, / and boot loaders should be placed.
    
  This is useful in the case where the BIOS is not EDD3.0 compliant,
  thus doesn't provide the PCI bus/dev/fn and IDE/SCSI location of the
  boot disk, yet you need to know which disk is the boot disk.  It's
  most useful in OS installers.
     
  This patch retrieves the signature from the disk in setup.S, stores it
  in a space reserved in the empty_zero_page, copies it somewhere safe
  in setup.c, and exports it via
  /sys/firmware/edd/int13_disk80/mbr_signature in edd.c.  Code is
  covered under CONFIG_EDD=[ym].


 Documentation/i386/zero-page.txt |    4 +++-
 arch/i386/boot/setup.S           |   21 +++++++++++++++++++++
 arch/i386/kernel/edd.c           |   22 +++++++++++++++++++++-
 arch/i386/kernel/i386_ksyms.c    |    6 ------
 arch/i386/kernel/setup.c         |    7 +++++++
 include/asm-i386/edd.h           |    6 +++++-
 include/asm-i386/setup.h         |    1 +
 7 files changed, 58 insertions, 9 deletions


diff -Nru a/Documentation/i386/zero-page.txt b/Documentation/i386/zero-page.txt
--- a/Documentation/i386/zero-page.txt	Tue Jan 20 15:49:42 2004
+++ b/Documentation/i386/zero-page.txt	Tue Jan 20 15:49:42 2004
@@ -72,8 +72,10 @@
 0x21c	unsigned long	INITRD_SIZE, size in bytes of ramdisk image
 0x220	4 bytes		(setup.S)
 0x224	unsigned short	setup.S heap end pointer
+0x2cc	4 bytes		DISK80_SIG_BUFFER (setup.S)
 0x2d0 - 0x600		E820MAP
-0x600 - 0x7D4		EDDBUF (setup.S)
+0x600 - 0x7ff		EDDBUF (setup.S) for disk signature read sector
+0x600 - 0x7d3		EDDBUF (setup.S) for edd data
 
 0x800	string, 2K max	COMMAND_LINE, the kernel commandline as
 			copied using CL_OFFSET.
diff -Nru a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S	Tue Jan 20 15:49:42 2004
+++ b/arch/i386/boot/setup.S	Tue Jan 20 15:49:42 2004
@@ -49,6 +49,8 @@
  * by Matt Domsch <Matt_Domsch@dell.com> October 2002
  * conformant to T13 Committee www.t13.org
  *   projects 1572D, 1484D, 1386D, 1226DT
+ * disk signature read by Matt Domsch <Matt_Domsch@dell.com>
+ *	and Andrew Wilks <Andrew_Wilks@dell.com> September 2003
  */
 
 #include <linux/config.h>
@@ -578,6 +580,25 @@
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
--- a/arch/i386/kernel/edd.c	Tue Jan 20 15:49:42 2004
+++ b/arch/i386/kernel/edd.c	Tue Jan 20 15:49:42 2004
@@ -2,6 +2,7 @@
  * linux/arch/i386/kernel/edd.c
  *  Copyright (C) 2002, 2003 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
+ *  disk80 signature by Matt Domsch, Andrew Wilks, and Sandeep K. Shandilya
  *
  * BIOS Enhanced Disk Drive Services (EDD)
  * conformant to T13 Committee www.t13.org
@@ -59,7 +60,7 @@
 MODULE_DESCRIPTION("sysfs interface to BIOS EDD information");
 MODULE_LICENSE("GPL");
 
-#define EDD_VERSION "0.10 2003-Oct-11"
+#define EDD_VERSION "0.11 2003-Dec-17"
 #define EDD_DEVICE_NAME_SIZE 16
 #define REPORT_URL "http://domsch.com/linux/edd30/results.html"
 
@@ -260,6 +261,14 @@
 }
 
 static ssize_t
+edd_show_disk80_sig(struct edd_device *edev, char *buf)
+{
+	char *p = buf;
+	p += snprintf(p, left, "0x%08x\n", edd_disk80_sig);
+	return (p - buf);
+}
+
+static ssize_t
 edd_show_extensions(struct edd_device *edev, char *buf)
 {
 	struct edd_info *info = edd_dev_get_info(edev);
@@ -429,6 +438,15 @@
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
 static EDD_DEVICE_ATTR(raw_data, 0444, edd_show_raw_data, NULL);
 static EDD_DEVICE_ATTR(version, 0444, edd_show_version, NULL);
 static EDD_DEVICE_ATTR(extensions, 0444, edd_show_extensions, NULL);
@@ -443,6 +461,7 @@
 		       edd_has_default_sectors_per_track);
 static EDD_DEVICE_ATTR(interface, 0444, edd_show_interface, edd_has_edd30);
 static EDD_DEVICE_ATTR(host_bus, 0444, edd_show_host_bus, edd_has_edd30);
+static EDD_DEVICE_ATTR(mbr_signature, 0444, edd_show_disk80_sig, edd_has_disk80_sig);
 
 
 /* These are default attributes that are added for every edd
@@ -464,6 +483,7 @@
 	&edd_attr_default_sectors_per_track,
 	&edd_attr_interface,
 	&edd_attr_host_bus,
+	&edd_attr_mbr_signature,
 	NULL,
 };
 
diff -Nru a/arch/i386/kernel/i386_ksyms.c b/arch/i386/kernel/i386_ksyms.c
--- a/arch/i386/kernel/i386_ksyms.c	Tue Jan 20 15:49:42 2004
+++ b/arch/i386/kernel/i386_ksyms.c	Tue Jan 20 15:49:42 2004
@@ -32,7 +32,6 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/nmi.h>
-#include <asm/edd.h>
 #include <asm/ist.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
@@ -201,11 +200,6 @@
 EXPORT_SYMBOL(kmap_atomic);
 EXPORT_SYMBOL(kunmap_atomic);
 EXPORT_SYMBOL(kmap_atomic_to_page);
-#endif
-
-#ifdef CONFIG_EDD_MODULE
-EXPORT_SYMBOL(edd);
-EXPORT_SYMBOL(eddnr);
 #endif
 
 #if defined(CONFIG_X86_SPEEDSTEP_SMI) || defined(CONFIG_X86_SPEEDSTEP_SMI_MODULE)
diff -Nru a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c	Tue Jan 20 15:49:42 2004
+++ b/arch/i386/kernel/setup.c	Tue Jan 20 15:49:42 2004
@@ -447,6 +447,12 @@
 #if defined(CONFIG_EDD) || defined(CONFIG_EDD_MODULE)
 unsigned char eddnr;
 struct edd_info edd[EDDMAXNR];
+unsigned int edd_disk80_sig;
+#ifdef CONFIG_EDD_MODULE
+EXPORT_SYMBOL(eddnr);
+EXPORT_SYMBOL(edd);
+EXPORT_SYMBOL(edd_disk80_sig);
+#endif
 /**
  * copy_edd() - Copy the BIOS EDD information
  *              from empty_zero_page into a safe place.
@@ -456,6 +462,7 @@
 {
      eddnr = EDD_NR;
      memcpy(edd, EDD_BUF, sizeof(edd));
+     edd_disk80_sig = DISK80_SIGNATURE;
 }
 #else
 #define copy_edd() do {} while (0)
diff -Nru a/include/asm-i386/edd.h b/include/asm-i386/edd.h
--- a/include/asm-i386/edd.h	Tue Jan 20 15:49:42 2004
+++ b/include/asm-i386/edd.h	Tue Jan 20 15:49:42 2004
@@ -1,6 +1,6 @@
 /*
  * linux/include/asm-i386/edd.h
- *  Copyright (C) 2002 Dell Inc.
+ *  Copyright (C) 2002, 2003 Dell Inc.
  *  by Matt Domsch <Matt_Domsch@dell.com>
  *
  * structures and definitions for the int 13h, ax={41,48}h
@@ -41,6 +41,9 @@
 #define EDDMAGIC1 0x55AA
 #define EDDMAGIC2 0xAA55
 
+#define READ_SECTORS 0x02
+#define MBR_SIG_OFFSET 0x1B8
+#define DISK80_SIG_BUFFER 0x2cc
 #ifndef __ASSEMBLY__
 
 #define EDD_EXT_FIXED_DISK_ACCESS           (1 << 0)
@@ -167,6 +170,7 @@
 
 extern struct edd_info edd[EDDMAXNR];
 extern unsigned char eddnr;
+extern unsigned int edd_disk80_sig;
 #endif				/*!__ASSEMBLY__ */
 
 #endif				/* _ASM_I386_EDD_H */
diff -Nru a/include/asm-i386/setup.h b/include/asm-i386/setup.h
--- a/include/asm-i386/setup.h	Tue Jan 20 15:49:42 2004
+++ b/include/asm-i386/setup.h	Tue Jan 20 15:49:42 2004
@@ -44,6 +44,7 @@
 #define INITRD_START (*(unsigned long *) (PARAM+0x218))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
 #define EDID_INFO   (*(struct edid_info *) (PARAM+0x440))
+#define DISK80_SIGNATURE (*(unsigned int*) (PARAM+DISK80_SIG_BUFFER))
 #define EDD_NR     (*(unsigned char *) (PARAM+EDDNR))
 #define EDD_BUF     ((struct edd_info *) (PARAM+EDDBUF))
 #define COMMAND_LINE ((char *) (PARAM+2048))

===================================================================


This BitKeeper patch contains the following changesets:
1.1505
## Wrapped with gzip_uu ##


M'XL( ':B#4   [59:U?;2!+];/V*FC"S8Q(_NO4V,^0$L)GUR0,.)K.[)\GQ
M:4LMK$$/CUH&G/7^]ZUNR48V$(,3''#L?EQ5W[Y57=7LP$?!L[W:>Y;GPVX:
M"V^L[< _4Y'OU7P>12TOC;'A+$VQH3U.8]Z.?36L/;IL<]]O1V$RO6GJ+:N)
MWYI!FC5EB]!PUBG+O3%<\4SLU6C+6+;DLPG?JYWU_OCX[N!,T_;WX6C,D@L^
MX#GL[VMYFEVQR!=O6#Z.TJ259RP1,<^9-&:^'#K7"='QGT4=@UCVG-K$=.8>
M]2EE)N4^T4W7-F_1I/&M5/A1*\TN5F%,0O'=,3J6.;<LLT.U+M 6M8@%Q&P3
MVM8)4&O/M/8,NTGL/4*@0MB;!5&?2FJ^P"L'FD0[A!^[E"/-@UZWNP<99S[X
MH;ATT9##,Q#A1<+R:<8;P&\F:99#/L[2Z<48<$\@3OUIQ'$N_IR/><:!X:\)
MHUG.!80)#N;P?M ]&4#,1,XS&.%VXT.\-/,;P')(@T#@WI ;.G(;B'(]#G$;
M8S8#+TURAA ,)CQKBAE.CYO3)/Q[RF^M:@$<SB (,Y'#=1;F87(!#&'6QR%=
MP!DBRZ4M#"LP&_)S@C9)TW ^FI7XJ@UQ)!T24ZT#Z4"8"YX7LY?8J$S5HM:F
M'E /DYP:X/,KQ'#)>+<!4W0&,6$>5XO#;Q#F$@YW:R))8Q>X6%',%[+O,DFO
M!3 !"8NYCSAMA&M_&HLO_B?6_/IE8>=4X'.0VCA,>$E?L4BAC#KL(_E+RR3%
M:LJUVBTYH"T[&]!6<&I@E#(?C04Q3J<1MG&81&BXW\+)4&PU@N,/KB*81@LZ
M/29X!5<]& <EB(C2,EI$K34*69(OS?!3+I)?<YADZ57H%Q-/C_HPF@JUW"!1
M9O6[O?;@:-!'TSR6AVF"NI%C$>9V:3##G9FE4T@X]R6UDL%[&%G.0/'T\U\%
M@L08E2JKD8;C7K H0AJ*52^7/5%Q)N-Y%O(K+M:ED*6Q:EKH#,4]G;0&#1#H
ML-(G<@12JB[$@&T\NT)[2Q)Y/,EGPZ\\2X<3=H%>YZ634,T#@5&FH%>P@!<P
M!;Q7:*%P4#7V*I1>T$:%M]$YXFM4F JI2I?#PK_;\2@;WIJ.:#BBY2$K1REN
M12B)\5*,L6C=-$%%P-')A^/^'T/<S?U/L_A+2WL+-B4VT4YOPZS6?.)+TP@C
MVNL- 8UE>"Z$AFLKN;9+6BO1S<3_YI3:&&=MXKMTQ'3=<;D3Z,&W(^HWH%7P
MUJEI&M;<(D['03/OPZI 7/(LX5%;,:FLHX1T=$(-M(M:NF/..[;=<8+ &3'?
M"!SF/=JZ=>BJ=;I!7.,)))98\O/P4LQB45J[Y)+.+<>UW;F+IGHCEQG,LHR1
M;CS5VO4G5(TVS([UE)TO(4O-K]MK.@8E<T8)'FN.20/J>;IC/=7>"GC55*I;
MAKG1U&[J36..QY8,406L].2F].16?I.OF&PX<\LT##IW1Z3#W5''T'V/XFF\
MP>3'/&35=$P^'A)NF'C1U.=M)N*F@I+J&J\+UW!=W9US?S2R*',8Z7BN23?9
M^3!TU3I<K]W92.P=K&*;QM7LIF.:<^(XIHV:-:B!G)H!]\S WZ2!;X&OR-76
M,0+(G/)^GY0)Y@^/#D]%1!] BRUB2X\P=5,O\LT.$*--];;\8.]9^IYI/B[;
MU"DTZ?.EFPR3R(<.*7ZU?D9IQZ ['=NA%$^>(N2=0#.[5C]XDIP^L#-;G$E]
M$Z@&+V&1"]^>DZ.9X@P*SAIPD/@9OX9_A=&E*,[A ;YQ/H&W+1@@,7X8S9C6
MM75$[*OW'9\',EM#"H9_]LX&_9,/\(*T* 6Y@\TN]YK4>:'U=1SM:KB$(:9B
MU^6Q+>FHBSR;>KD\L"5/(282+SE^P'1AS#)X.9H&N]I_M5KQ;0+[F% %OVFU
M";S:!Y%,,J0XJ$\:$/$ <[\7Y.87XMY\3EXT"LCE@W9Q$N8ZTRR!^@2:$@:;
M_J=]UH0,0!X($7[EPQSY,BAT%JT(K\P>,_$(JY6IE;XP"5)XJ=[W%X.'F':K
MCKJ:@6:% =1_DE]@/H>?9->N5EL82V[MECW-U^7ST'G)C4N*)?1-T\+=*&V6
MF]'M_=D_Z@T/SL_/ZBO*:V"U9IH%.VM[432NKA3MZYNVC>"U?\A>U$LV7 54
M@>3^&/E@(/F>:/U41 R@ND%="]>-B%892)QMXXCU[&%$9=PKGEK4LM+50GE6
MBI7P41P\:^'C?CJV"!]=0SJ[4<:0HW0RR\*+<0[UHUWIXWI#>3ITD2CH)UY+
M^@\8R\!PUCOH#@>]H_.3LP$*ENC+'BQ"AP/,P4^.CP>]<UDW'[K+SFY_\!8%
M*/L//QX?]\ZP7_<\K4_M#IK";[!,3#"7EQ2IDB-?<_??E"HW91B;;U)^3"*D
ML<M)_&9QK_)I\<A'IT"T0Z5P]3F*F=A*O]:V^C6>7;]%):B6)-25@KQ@\5F.
ME:(*C:CH5047B=V:@C=1L\U1Z,BS4"FI5E[MU&IWI58O"Z==K>O(R-?'=QVG
MV4AN$X6(64VMAJO%X;=CU4*5YZZYK> ><EV=[AL/3%_PM)::58NYS8K]GOI2
M\]D5_^L-ULECEF] P[ J [5AZ3;*TM%-)4O=_)[\[+FO XOKM6)'BAN.,M:.
M5;JC;C;4Y879E.J ^_.UHH!^,%^K$K6-2"U,GF2PO4],JRD;_'X?IZ]Q<DTN
MIYK/P>_%MZ'Z=CL6!GR2\WC$,Q7'\>EX\-".O,Z6SY-<K)"6!E F((\@K1:G
M5U'M9W)S7+X:\ MG-V6[_-B ^AW_VZWM !,"G1\"%D8+H%'MY^IA@E!LO.B@
M\EM4P]=.P1-=N%TY0*9*.,:/U)!BYQ?+6(Z1 \8%",MA+'&*SNOB"=Y-T>G-
MHE#=(N&,DA8<-YF*\34N2BP_^O)C.BD;"YS"[Q%LA#3@L25-HX96^\NKR?V6
M1]?03Y,%=_5B_*O5PW+WT3P6FR.FGL>%T%:>L%<Q[O/]Q6#URN,I@6?K.QF-
M>3%_XZ%U7AY>*=C6*-N,C+4B<8EN&7@"F[KA6,41N76.AX':?LY0A/NF:J;%
M7R)P):,TPJ)+=: OQ?+6M[S!68D]Q4W3IEJQRL]6.9^L)KHZ,<&Z7QFE:5N(
MXDEW7@_F3=^"-3"=($2F2YVYC<5<<3 A\K9J>-Z_4\F,J??OTY.S\^'@/^\/
M3][)VAO;5O-9>7L^6TN:Y$7>)B4L-+3%.62:';"U;^;8.V& "7OE-GWX_J3[
M\5U/6UD0%KI^DF$E>:?UOK;5XG.')WX8H#&6*TL0^5HC9K]2+'PX./]XUOOM
M_HJTO S;K-GONZ-[4+/?@JUJUJ"T3*;<;17[O*F45.<ZYQ S+TM70Y6Z9=Q4
MEY8D;"50NW(#=<>@^LMZ5;LO=Z%^>G!V\/[5W8-R]_8/\=Z8>Y>8>^Q;NJ%W
-@H!H_P=*^R/E_A\     
 
