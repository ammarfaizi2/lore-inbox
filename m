Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVCXX7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVCXX7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261280AbVCXX7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:59:35 -0500
Received: from mail0.lsil.com ([147.145.40.20]:4321 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261253AbVCXX4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:56:43 -0500
Message-ID: <91888D455306F94EBD4D168954A9457C01B70560@nacos172.co.lsil.com>
From: "Moore, Eric Dean" <Eric.Moore@lsil.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] - MPT FUSION - SPLITTING SCSI HOST DRIVERS
Date: Thu, 24 Mar 2005 16:56:38 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C530CD.1E536D20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C530CD.1E536D20
Content-Type: text/plain;
	charset="iso-8859-1"

These patches are for the mpt fusion scsi host drivers, which separate
the scsi host drivers into separate bus type kernel modules.  This was
requested
by several people on the linux-scsi@ forum, so our driver can properly
support 
the various transport layers; e.g. SPI, FC, and eventually SAS.  In these
set of patches
the Fiber Channel controllers are moved to a new driver called mptfch.ko.
The current
Parallel SCSI controllers will remain with mptscsih.ko.  Eventually we will
be adding SAS support
in the new modules that will be mptsash.ko.  

Overview of attached patch

(1) mptlinux-3.03.00-1-misc - Kconfig and Makefile changes, for new
separated drivers.

Please apply this patch against the 3.01.20 version of the mpt driver
in http://linux-scsi.bkbits.net:8080/scsi-misc-2.6

Backup of these patches can be found at this ftp:
ftp://ftp.lsil.com/HostAdapterDrivers/linux/Fusion-MPT/2.6-kernel/3.03.00/

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>


------_=_NextPart_000_01C530CD.1E536D20
Content-Type: application/octet-stream;
	name="mptlinux-3.03.00-1-misc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mptlinux-3.03.00-1-misc"

diff -uarN drivers/message/fusion-3.01.20/Kconfig =
drivers/message/fusion/Kconfig=0A=
--- drivers/message/fusion-3.01.20/Kconfig	2005-03-15 =
16:47:34.000000000 -0700=0A=
+++ drivers/message/fusion/Kconfig	2005-03-24 08:36:25.000000000 =
-0700=0A=
@@ -1,9 +1,9 @@=0A=
 =0A=
 menu "Fusion MPT device support"=0A=
 =0A=
-config FUSION_SPI=0A=
-	tristate "Fusion MPT (base + ScsiHost) drivers for SPI"=0A=
-	depends on PCI && SCSI=0A=
+config FUSION=0A=
+	tristate "Fusion MPT (base) drivers"=0A=
+	depends on PCI=0A=
 	---help---=0A=
 	  LSI Logic Fusion(TM) Message Passing Technology (MPT) device =
support=0A=
 	  provides high performance SCSI host initiator, and LAN [1] =
interface=0A=
@@ -14,22 +14,37 @@=0A=
 =0A=
 	  [1] LAN is not supported on parallel SCSI medium.=0A=
 =0A=
+config FUSION_SPI=0A=
+	tristate "Fusion MPT (ScsiHost) drivers for SPI"=0A=
+	depends on FUSION && SCSI=0A=
+	---help---=0A=
+	This is SCSI HOST support for a parallel SCSI host adapters.=0A=
+=0A=
+	List of supported controllers:=0A=
+=0A=
+	LSI53C1020=0A=
+	LSI53C1020A=0A=
+	LSI53C1030=0A=
+	LSI53C1035=0A=
+=0A=
 config FUSION_FC=0A=
-	tristate "Fusion MPT (base + ScsiHost) drivers for FC"=0A=
-	depends on PCI && SCSI=0A=
+	tristate "Fusion MPT (ScsiHost) drivers for FC"=0A=
+	depends on FUSION && SCSI=0A=
 	---help---=0A=
-	  LSI Logic Fusion(TM) Message Passing Technology (MPT) device =
support=0A=
-	  provides high performance SCSI host initiator, and LAN [1] =
interface=0A=
-	  services to a host system.  The Fusion architecture is capable =
of=0A=
-	  duplexing these protocols on high-speed Fibre Channel=0A=
-	  (up to 2 GHz x 2 ports =3D 4 GHz) and parallel SCSI (up to =
Ultra-320)=0A=
-	  physical medium.=0A=
+	This is SCSI HOST support for a Fiber Channel host adapters.=0A=
 =0A=
-	  [1] LAN is not supported on parallel SCSI medium.=0A=
+	List of supported controllers:=0A=
+=0A=
+	LSIFC909=0A=
+	LSIFC919=0A=
+	LSIFC919X=0A=
+	LSIFC929=0A=
+	LSIFC929X=0A=
+	LSIFC929XL=0A=
 =0A=
 config FUSION_MAX_SGE=0A=
 	int "Maximum number of scatter gather entries"=0A=
-	depends on FUSION_SPI || FUSION_FC=0A=
+	depends on FUSION=0A=
 	default "40"=0A=
 	help=0A=
 	  This option allows you to specify the maximum number of scatter-=0A=
@@ -42,7 +57,7 @@=0A=
 =0A=
 config FUSION_CTL=0A=
 	tristate "Fusion MPT misc device (ioctl) driver"=0A=
-	depends on FUSION_SPI || FUSION_FC=0A=
+	depends on FUSION=0A=
 	---help---=0A=
 	  The Fusion MPT misc device driver provides specialized control=0A=
 	  of MPT adapters via system ioctl calls.  Use of ioctl calls to=0A=
@@ -61,7 +76,7 @@=0A=
 =0A=
 config FUSION_LAN=0A=
 	tristate "Fusion MPT LAN driver"=0A=
-	depends on FUSION_FC && NET_FC=0A=
+	depends on FUSION && NET_FC=0A=
 	---help---=0A=
 	  This module supports LAN IP traffic over Fibre Channel port(s)=0A=
 	  on Fusion MPT compatible hardware (LSIFC9xx chips).=0A=
diff -uarN drivers/message/fusion-3.01.20/Makefile =
drivers/message/fusion/Makefile=0A=
--- drivers/message/fusion-3.01.20/Makefile	2005-03-22 =
10:43:07.000000000 -0700=0A=
+++ drivers/message/fusion/Makefile	2005-03-24 08:22:02.000000000 =
-0700=0A=
@@ -1,20 +1,3 @@=0A=
-#=0A=
-# Makefile for the LSI Logic Fusion MPT (Message Passing Technology) =
drivers.=0A=
-#=0A=
-# Note! If you want to turn on various debug defines for an extended =
period of=0A=
-# time but don't want them lingering around in the Makefile when you =
pass it on=0A=
-# to someone else, use the MPT_CFLAGS env variable (thanks Steve). =
-nromer=0A=
-=0A=
-#=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-{ LSI_LOGIC=0A=
-=0A=
-#  Architecture-specific...=0A=
-#			# intel=0A=
-#EXTRA_CFLAGS +=3D -g=0A=
-#			# sparc64=0A=
-#EXTRA_CFLAGS +=3D -gstabs+=0A=
-=0A=
-EXTRA_CFLAGS +=3D ${MPT_CFLAGS}=0A=
-=0A=
 # Fusion MPT drivers; recognized debug defines...=0A=
 #  MPT general:=0A=
 #EXTRA_CFLAGS +=3D -DMPT_DEBUG_SCSI=0A=
@@ -29,10 +12,10 @@=0A=
 #CFLAGS_mptbase.o +=3D -DMPT_DEBUG_HANDSHAKE=0A=
 #CFLAGS_mptbase.o +=3D -DMPT_DEBUG_IRQ=0A=
 #=0A=
-#  For mptscsih:=0A=
-#CFLAGS_mptscsih.o +=3D -DMPT_DEBUG_SCANDV=0A=
-#CFLAGS_mptscsih.o +=3D -DMPT_DEBUG_RESET=0A=
-#CFLAGS_mptscsih.o +=3D -DMPT_DEBUG_NEH=0A=
+#  For mptscsi:=0A=
+#CFLAGS_mptscsi.o +=3D -DMPT_DEBUG_SCANDV=0A=
+#CFLAGS_mptscsi.o +=3D -DMPT_DEBUG_RESET=0A=
+#CFLAGS_mptscsi.o +=3D -DMPT_DEBUG_NEH=0A=
 #=0A=
 #  For mptctl:=0A=
 #CFLAGS_mptctl.o +=3D -DMPT_DEBUG_IOCTL=0A=
@@ -46,7 +29,11 @@=0A=
 ##mptscsih-objs	:=3D scsihost.o scsiherr.o=0A=
 =0A=
 =
#=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-} LSI_LOGIC=0A=
+mptscsih-objs :=3D mpt_core.o mptscsi.o=0A=
+mptfch-objs :=3D mpt_core.o mptfc.o=0A=
 =0A=
-obj-$(CONFIG_FUSION)		+=3D mptbase.o mptscsih.o=0A=
+obj-$(CONFIG_FUSION)		+=3D mptbase.o=0A=
+obj-$(CONFIG_FUSION_SPI)	+=3D mptscsih.o=0A=
+obj-$(CONFIG_FUSION_FC)		+=3D mptfch.o=0A=
 obj-$(CONFIG_FUSION_CTL)	+=3D mptctl.o=0A=
-obj-$(CONFIG_FUSION_LAN)	+=3D mptlan.o=0A=
+obj-$(CONFIG_FUSION_LAN)	+=3D mptlan.o=0A=
\ No newline at end of file=0A=
diff -uarN drivers/message/fusion-3.01.20/mptbase.c =
drivers/message/fusion/mptbase.c=0A=
--- drivers/message/fusion-3.01.20/mptbase.c	2005-03-24 =
09:27:32.000000000 -0700=0A=
+++ drivers/message/fusion/mptbase.c	2005-03-24 09:25:18.000000000 =
-0700=0A=
@@ -1,55 +1,14 @@=0A=
 /*=0A=
  *  linux/drivers/message/fusion/mptbase.c=0A=
- *      High performance SCSI + LAN / Fibre Channel device drivers.=0A=
  *      This is the Fusion MPT base driver which supports multiple=0A=
  *      (SCSI + LAN) specialized protocol drivers.=0A=
- *      For use with PCI chip/adapter(s):=0A=
- *          LSIFC9xx/LSI409xx Fibre Channel=0A=
+ *      For use with LSI Logic PCI chip/adapter(s)=0A=
  *      running LSI Logic Fusion MPT (Message Passing Technology) =
firmware.=0A=
  *=0A=
- *  Credits:=0A=
- *      There are lots of people not mentioned below that deserve =
credit=0A=
- *      and thanks but won't get it here - sorry in advance that =
you=0A=
- *      got overlooked.=0A=
- *=0A=
- *      This driver would not exist if not for Alan Cox's =
development=0A=
- *      of the linux i2o driver.=0A=
- *=0A=
- *      A special thanks to Noah Romer (LSI Logic) for tons of work=0A=
- *      and tough debugging on the LAN driver, especially early =
on;-)=0A=
- *      And to Roger Hickerson (LSI Logic) for tirelessly =
supporting=0A=
- *      this driver project.=0A=
- *=0A=
- *      A special thanks to Pamela Delaney (LSI Logic) for tons of =
work=0A=
- *      and countless enhancements while adding support for the =
1030=0A=
- *      chip family.  Pam has been instrumental in the development =
of=0A=
- *      of the 2.xx.xx series fusion drivers, and her contributions =
are=0A=
- *      far too numerous to hope to list in one place.=0A=
- *=0A=
- *      All manner of help from Stephen Shirron (LSI Logic):=0A=
- *      low-level FC analysis, debug + various fixes in FCxx =
firmware,=0A=
- *      initial port to alpha platform, various driver code =
optimizations,=0A=
- *      being a faithful sounding board on all sorts of issues & =
ideas,=0A=
- *      etc.=0A=
- *=0A=
- *      A huge debt of gratitude is owed to David S. Miller (DaveM)=0A=
- *      for fixing much of the stupid and broken stuff in the early=0A=
- *      driver while porting to sparc64 platform.  THANK YOU!=0A=
- *=0A=
- *      Special thanks goes to the I2O LAN driver people at the=0A=
- *      University of Helsinki, who, unbeknownst to them, provided=0A=
- *      the inspiration and initial structure for this driver.=0A=
- *=0A=
- *      A really huge debt of gratitude is owed to Eddie C. Dost=0A=
- *      for gobs of hard work fixing and optimizing LAN code.=0A=
- *      THANK YOU!=0A=
- *=0A=
- *  Copyright (c) 1999-2004 LSI Logic Corporation=0A=
- *  Originally By: Steven J. Ralston=0A=
- *  (mailto:sjralston1@netscape.net)=0A=
+ *  Copyright (c) 1999-2005 LSI Logic Corporation=0A=
  *  (mailto:mpt_linux_developer@lsil.com)=0A=
  *=0A=
- *  $Id: mptbase.c,v 1.126 2002/12/16 15:28:45 pdelaney Exp $=0A=
+ *  $Id: mptbase.c,v 1.130 2003/05/07 14:08:30 Exp $=0A=
  */=0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 /*=0A=
@@ -738,6 +697,12 @@=0A=
 	/* call per pci device probe entry point */=0A=
 	list_for_each_entry(ioc, &ioc_list, list) {=0A=
 		if(dd_cbfunc->probe) {=0A=
+			if((cb_idx =3D=3D MPTFC_DRIVER) && (ioc->bus_type !=3D FC))=0A=
+				continue;=0A=
+			if((cb_idx =3D=3D MPTSCSIH_DRIVER) && (ioc->bus_type !=3D SCSI))=0A=
+				continue;=0A=
+			if((cb_idx =3D=3D MPTSAS_DRIVER) && (ioc->bus_type !=3D SAS))=0A=
+				continue;=0A=
 			error =3D dd_cbfunc->probe(ioc->pcidev,=0A=
 			  ioc->pcidev->driver->id_table);=0A=
 			if(error !=3D 0)=0A=
@@ -5130,14 +5095,14 @@=0A=
 procmpt_version_read(char *buf, char **start, off_t offset, int =
request, int *eof, void *data)=0A=
 {=0A=
 	int	 ii;=0A=
-	int	 scsi, lan, ctl, targ, dmp;=0A=
+	int	 scsi, fc, sas, lan, ctl, targ, dmp;=0A=
 	char	*drvname;=0A=
 	int	 len;=0A=
 =0A=
 	len =3D sprintf(buf, "%s-%s\n", "mptlinux", =
MPT_LINUX_VERSION_COMMON);=0A=
 	len +=3D sprintf(buf+len, "  Fusion MPT base driver\n");=0A=
 =0A=
-	scsi =3D lan =3D ctl =3D targ =3D dmp =3D 0;=0A=
+	scsi =3D fc =3D sas =3D lan =3D ctl =3D targ =3D dmp =3D 0;=0A=
 	for (ii=3DMPT_MAX_PROTOCOL_DRIVERS-1; ii; ii--) {=0A=
 		drvname =3D NULL;=0A=
 		if (MptCallbacks[ii]) {=0A=
@@ -5145,6 +5110,12 @@=0A=
 			case MPTSCSIH_DRIVER:=0A=
 				if (!scsi++) drvname =3D "SCSI host";=0A=
 				break;=0A=
+			case MPTFC_DRIVER:=0A=
+				if (!fc++) drvname =3D "FC host";=0A=
+				break;=0A=
+			case MPTSAS_DRIVER:=0A=
+				if (!sas++) drvname =3D "SAS host";=0A=
+				break;=0A=
 			case MPTLAN_DRIVER:=0A=
 				if (!lan++) drvname =3D "LAN";=0A=
 				break;=0A=
diff -uarN drivers/message/fusion-3.01.20/mptbase.h =
drivers/message/fusion/mptbase.h=0A=
--- drivers/message/fusion-3.01.20/mptbase.h	2005-03-22 =
10:44:24.000000000 -0700=0A=
+++ drivers/message/fusion/mptbase.h	2005-03-24 09:34:42.000000000 =
-0700=0A=
@@ -5,15 +5,10 @@=0A=
  *          LSIFC9xx/LSI409xx Fibre Channel=0A=
  *      running LSI Logic Fusion MPT (Message Passing Technology) =
firmware.=0A=
  *=0A=
- *  Credits:=0A=
- *     (see mptbase.c)=0A=
- *=0A=
- *  Copyright (c) 1999-2004 LSI Logic Corporation=0A=
- *  Originally By: Steven J. Ralston=0A=
- *  (mailto:sjralston1@netscape.net)=0A=
+ *  Copyright (c) 1999-2005 LSI Logic Corporation=0A=
  *  (mailto:mpt_linux_developer@lsil.com)=0A=
  *=0A=
- *  $Id: mptbase.h,v 1.144 2003/01/28 21:31:56 pdelaney Exp $=0A=
+ *  $Id: mptbase.h,v 1.149 2003/05/07 14:08:31 Exp $=0A=
  */=0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 /*=0A=
@@ -83,8 +78,8 @@=0A=
 #define COPYRIGHT	"Copyright (c) 1999-2004 " MODULEAUTHOR=0A=
 #endif=0A=
 =0A=
-#define MPT_LINUX_VERSION_COMMON	"3.01.20"=0A=
-#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-3.01.20"=0A=
+#define MPT_LINUX_VERSION_COMMON	"3.03.00"=0A=
+#define MPT_LINUX_PACKAGE_NAME		"@(#)mptlinux-3.03.00"=0A=
 #define WHAT_MAGIC_STRING		"@" "(" "#" ")"=0A=
 =0A=
 #define show_mptmod_ver(s,ver)  \=0A=
@@ -95,7 +90,7 @@=0A=
  *  Fusion MPT(linux) driver configurable stuff...=0A=
  */=0A=
 #define MPT_MAX_ADAPTERS		18=0A=
-#define MPT_MAX_PROTOCOL_DRIVERS	16=0A=
+#define MPT_MAX_PROTOCOL_DRIVERS	32=0A=
 #define MPT_MAX_BUS			1	/* Do not change */=0A=
 #define MPT_MAX_FC_DEVICES		255=0A=
 #define MPT_MAX_SCSI_DEVICES		16=0A=
@@ -203,7 +198,9 @@=0A=
 typedef enum {=0A=
 	MPTBASE_DRIVER,		/* MPT base class */=0A=
 	MPTCTL_DRIVER,		/* MPT ioctl class */=0A=
-	MPTSCSIH_DRIVER,	/* MPT SCSI host (initiator) class */=0A=
+	MPTSCSIH_DRIVER,	/* MPT SCSI host class */=0A=
+	MPTFC_DRIVER,		/* MPT FC host class */=0A=
+	MPTSAS_DRIVER,		/* MPT SAS host class */=0A=
 	MPTLAN_DRIVER,		/* MPT LAN class */=0A=
 	MPTSTM_DRIVER,		/* MPT SCSI target mode class */=0A=
 	MPTUNKNOWN_DRIVER=0A=
@@ -483,6 +480,8 @@=0A=
 	u8		 forceDv;		/* 1 to force DV scheduling */=0A=
 	u8		 noQas;			/* Disable QAS for this adapter */=0A=
 	u8		 Saf_Te;		/* 1 to force all Processors as SAF-TE if Inquiry data =
length is too short to check for SAF-TE */=0A=
+	u8		 mpt_dv;		/* command line option: enhanced=3D1, basic=3D0 */=0A=
+	u8		 mpt_pq_filter;=0A=
 	u8		 rsvd[1];=0A=
 } ScsiCfgData;=0A=
 =0A=
@@ -576,6 +575,9 @@=0A=
 	u8			 reload_fw;	/* Force a FW Reload on next reset */=0A=
 	u8			 NBShiftFactor;  /* NB Shift Factor based on Block Size (Facts)  =
*/     =0A=
 	u8			 pad1[4];=0A=
+	int			 DoneCtx;=0A=
+	int			 TaskCtx;=0A=
+	int			 InternalCtx;=0A=
 	struct list_head	 list; =0A=
 	struct net_device	*netdev;=0A=
 } MPT_ADAPTER;=0A=
@@ -898,6 +900,10 @@=0A=
 	unsigned long		  soft_resets;		/* fw/external bus resets count */=0A=
 	unsigned long		  timeouts;		/* cmd timeouts */=0A=
 	ushort			  sel_timeout[MPT_MAX_FC_DEVICES];=0A=
+	char 			  *info_kbuf;=0A=
+	wait_queue_head_t	 scandv_waitq;=0A=
+	int			 scandv_wait_done;=0A=
+	long			 last_queue_full;=0A=
 } MPT_SCSI_HOST;=0A=
 =0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
diff -uarN drivers/message/fusion-3.01.20/mptctl.c =
drivers/message/fusion/mptctl.c=0A=
--- drivers/message/fusion-3.01.20/mptctl.c	2005-03-22 =
10:43:07.000000000 -0700=0A=
+++ drivers/message/fusion/mptctl.c	2005-03-22 16:01:30.000000000 =
-0700=0A=
@@ -1,40 +1,13 @@=0A=
 /*=0A=
  *  linux/drivers/message/fusion/mptctl.c=0A=
- *      Fusion MPT misc device (ioctl) driver.=0A=
- *      For use with PCI chip/adapter(s):=0A=
- *          LSIFC9xx/LSI409xx Fibre Channel=0A=
+ *      mpt Ioctl driver.=0A=
+ *      For use with LSI Logic PCI chip/adapters=0A=
  *      running LSI Logic Fusion MPT (Message Passing Technology) =
firmware.=0A=
  *=0A=
- *  Credits:=0A=
- *      This driver would not exist if not for Alan Cox's =
development=0A=
- *      of the linux i2o driver.=0A=
- *=0A=
- *      A special thanks to Pamela Delaney (LSI Logic) for tons of =
work=0A=
- *      and countless enhancements while adding support for the =
1030=0A=
- *      chip family.  Pam has been instrumental in the development =
of=0A=
- *      of the 2.xx.xx series fusion drivers, and her contributions =
are=0A=
- *      far too numerous to hope to list in one place.=0A=
- *=0A=
- *      A huge debt of gratitude is owed to David S. Miller (DaveM)=0A=
- *      for fixing much of the stupid and broken stuff in the early=0A=
- *      driver while porting to sparc64 platform.  THANK YOU!=0A=
- *=0A=
- *      A big THANKS to Eddie C. Dost for fixing the ioctl path=0A=
- *      and most importantly f/w download on sparc64 platform!=0A=
- *      (plus Eddie's other helpful hints and insights)=0A=
- *=0A=
- *      Thanks to Arnaldo Carvalho de Melo for finding and patching=0A=
- *      a potential memory leak in mptctl_do_fw_download(),=0A=
- *      and for some kmalloc insight:-)=0A=
- *=0A=
- *      (see also mptbase.c)=0A=
- *=0A=
- *  Copyright (c) 1999-2004 LSI Logic Corporation=0A=
- *  Originally By: Steven J. Ralston, Noah Romer=0A=
- *  (mailto:sjralston1@netscape.net)=0A=
+ *  Copyright (c) 1999-2005 LSI Logic Corporation=0A=
  *  (mailto:mpt_linux_developer@lsil.com)=0A=
  *=0A=
- *  $Id: mptctl.c,v 1.63 2002/12/03 21:26:33 pdelaney Exp $=0A=
+ *  $Id: mptctl.c,v 1.66 2003/05/07 14:08:32 Exp $=0A=
  */=0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 /*=0A=
diff -uarN drivers/message/fusion-3.01.20/mptctl.h =
drivers/message/fusion/mptctl.h=0A=
--- drivers/message/fusion-3.01.20/mptctl.h	2005-03-22 =
10:43:07.000000000 -0700=0A=
+++ drivers/message/fusion/mptctl.h	2005-03-22 16:01:49.000000000 =
-0700=0A=
@@ -5,22 +5,10 @@=0A=
  *          LSIFC9xx/LSI409xx Fibre Channel=0A=
  *      running LSI Logic Fusion MPT (Message Passing Technology) =
firmware.=0A=
  *=0A=
- *  Credits:=0A=
- *      This driver would not exist if not for Alan Cox's =
development=0A=
- *      of the linux i2o driver.=0A=
- *=0A=
- *      A huge debt of gratitude is owed to David S. Miller (DaveM)=0A=
- *      for fixing much of the stupid and broken stuff in the early=0A=
- *      driver while porting to sparc64 platform.  THANK YOU!=0A=
- *=0A=
- *      (see also mptbase.c)=0A=
- *=0A=
- *  Copyright (c) 1999-2004 LSI Logic Corporation=0A=
- *  Originally By: Steven J. Ralston=0A=
- *  (mailto:sjralston1@netscape.net)=0A=
+ *  Copyright (c) 1999-2005 LSI Logic Corporation=0A=
  *  (mailto:mpt_linux_developer@lsil.com)=0A=
  *=0A=
- *  $Id: mptctl.h,v 1.13 2002/12/03 21:26:33 pdelaney Exp $=0A=
+ *  $Id: mptctl.h,v 1.14 2003/03/18 22:49:51 Exp $=0A=
  */=0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 /*=0A=
diff -uarN drivers/message/fusion-3.01.20/mptlan.c =
drivers/message/fusion/mptlan.c=0A=
--- drivers/message/fusion-3.01.20/mptlan.c	2005-03-22 =
10:43:07.000000000 -0700=0A=
+++ drivers/message/fusion/mptlan.c	2005-03-22 16:02:29.000000000 =
-0700=0A=
@@ -1,33 +1,12 @@=0A=
 /*=0A=
  *  linux/drivers/message/fusion/mptlan.c=0A=
  *      IP Over Fibre Channel device driver.=0A=
- *      For use with PCI chip/adapter(s):=0A=
- *          LSIFC9xx/LSI409xx Fibre Channel=0A=
+ *      For use with LSI Logic Fibre Channel PCI chip/adapters=0A=
  *      running LSI Logic Fusion MPT (Message Passing Technology) =
firmware.=0A=
  *=0A=
- *  Credits:=0A=
- *      This driver would not exist if not for Alan Cox's =
development=0A=
- *      of the linux i2o driver.=0A=
+ *  Copyright (c) 2000-2005 LSI Logic Corporation=0A=
  *=0A=
- *      Special thanks goes to the I2O LAN driver people at the=0A=
- *      University of Helsinki, who, unbeknownst to them, provided=0A=
- *      the inspiration and initial structure for this driver.=0A=
- *=0A=
- *      A huge debt of gratitude is owed to David S. Miller (DaveM)=0A=
- *      for fixing much of the stupid and broken stuff in the early=0A=
- *      driver while porting to sparc64 platform.  THANK YOU!=0A=
- *=0A=
- *      A really huge debt of gratitude is owed to Eddie C. Dost=0A=
- *      for gobs of hard work fixing and optimizing LAN code.=0A=
- *      THANK YOU!=0A=
- *=0A=
- *      (see also mptbase.c)=0A=
- *=0A=
- *  Copyright (c) 2000-2004 LSI Logic Corporation=0A=
- *  Originally By: Noah Romer=0A=
- *  (mailto:mpt_linux_developer@lsil.com)=0A=
- *=0A=
- *  $Id: mptlan.c,v 1.53 2002/10/17 20:15:58 pdelaney Exp $=0A=
+ *  $Id: mptlan.c,v 1.55 2003/05/07 14:08:32 Exp $=0A=
  */=0A=
 =
/*=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D*/=0A=
 /*=0A=

------_=_NextPart_000_01C530CD.1E536D20--
