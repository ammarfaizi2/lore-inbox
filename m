Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267548AbSLLXT5>; Thu, 12 Dec 2002 18:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbSLLXT5>; Thu, 12 Dec 2002 18:19:57 -0500
Received: from mg02.austin.ibm.com ([192.35.232.12]:32416 "EHLO
	mg02.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S267548AbSLLXTq>; Thu, 12 Dec 2002 18:19:46 -0500
Subject: [PATCH] BIN_TO_BCD consolidation
From: Hollis Blanchard <hollis@austin.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-sLaD/4bv4Gb+0ZjkfScY"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 17:32:36 -0600
Message-Id: <1039735956.3538.116.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sLaD/4bv4Gb+0ZjkfScY
Content-Type: multipart/mixed; boundary="=-pirxAKtDlNSPVjCNtTRh"


--=-pirxAKtDlNSPVjCNtTRh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

All I wanted to do was "secal =3D BIN_TO_BCD(secs % 60)" ...

Has anyone else noticed the number of BCD_TO_BIN / BIN_TO_BCD
definitions?
	egrep -lr -e "define (BCD_TO_BIN|BIN_TO_BCD)" linux/

Definitions are all over (in arch C files, arch includes, generic
includes, even a SCSI C file). They're all identical. They're almost all
wrapped with #ifndef to keep from clobbering each other.

My biggest problem is that they make an assignment:
	#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
This makes it impossible to write code like
	secal =3D BIN_TO_BCD(secs % 60);
because 'secs % 60' is not an lvalue.

The following patch moves all those definitions into include/linux/bcd.h
and defines BIN2BCD which doesn't make an assignment. I don't care what
it's called if that offends anyone; I just want to be able to do it. I'd
like to see BIN_TO_BCD deprecated, but maybe that's just me.

I tried to catch everything; I apologize if I missed an instance or two.
Obviously I couldn't test it all, but it builds on PPC. Comments?

-Hollis
--=20
PowerPC Linux
IBM Linux Technology Center

 arch/alpha/kernel/time.c              |    1 +
 arch/arm/kernel/time.c                |    8 --------
 arch/cris/drivers/ds1302.c            |    1 +
 arch/cris/kernel/time.c               |    1 +
 arch/i386/kernel/time.c               |    1 +
 arch/m68k/atari/time.c                |    1 +
 arch/m68k/sun3x/time.c                |    4 +---
 arch/mips/ddb5xxx/common/rtc_ds1386.c |    7 +------
 arch/mips/dec/time.c                  |    1 +
 arch/mips/kernel/old-time.c           |    1 +
 arch/mips64/sgi-ip27/ip27-rtc.c       |    1 +
 arch/mips64/sgi-ip27/ip27-timer.c     |    1 +
 arch/ppc/iSeries/mf.c                 |    1 +
 arch/ppc/platforms/chrp_time.c        |    1 +
 arch/ppc/platforms/gemini_setup.c     |    1 +
 arch/ppc/platforms/prep_time.c        |    1 +
 arch/ppc/syslib/todc_time.c           |    1 +
 arch/ppc64/kernel/mf.c                |    1 +
 arch/ppc64/kernel/rtc.c               |    1 +
 arch/sh/kernel/rtc.c                  |    9 +--------
 arch/sparc64/kernel/time.c            |    9 +--------
 arch/x86_64/kernel/time.c             |    1 +
 drivers/acorn/char/pcf8583.c          |    1 +
 drivers/acpi/sleep.c                  |    1 +
 drivers/char/rtc.c                    |    1 +
 drivers/scsi/sr_vendor.c              |    3 +--
 drivers/sgi/char/ds1286.c             |    1 +
 include/asm-arm/arch-ebsa285/time.h   |    1 +
 include/asm-cris/rtc.h                |    5 -----
 include/asm-generic/rtc.h             |    1 +
 include/asm-mips/ds1286.h             |   11 -----------
 include/asm-mips64/ds1286.h           |   11 -----------
 include/asm-mips64/m48t35.h           |    8 --------
 include/asm-ppc/m48t35.h              |    9 ---------
 include/asm-ppc/mk48t59.h             |    8 --------
 include/asm-ppc/nvram.h               |    8 --------
 include/asm-ppc/todc.h                |    8 --------
 include/asm-ppc64/nvram.h             |    8 --------
 include/linux/bcd.h                   |   20 ++++++++++++++++++++
 include/linux/mc146818rtc.h           |   11 -----------
 40 files changed, 48 insertions(+), 122 deletions(-)

--=-pirxAKtDlNSPVjCNtTRh
Content-Disposition: attachment; filename=bcd-consolidate.diff
Content-Type: text/plain; name=bcd-consolidate.diff; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.744   -> 1.745 =20
#	include/asm-ppc/m48t35.h	1.5     -> 1.6   =20
#	drivers/acpi/sleep.c	1.8     -> 1.9   =20
#	arch/ppc/platforms/chrp_time.c	1.7     -> 1.8   =20
#	include/asm-cris/rtc.h	1.2     -> 1.3   =20
#	include/asm-ppc/mk48t59.h	1.4     -> 1.5   =20
#	drivers/sgi/char/ds1286.c	1.6     -> 1.7   =20
#	arch/mips64/sgi-ip27/ip27-timer.c	1.3     -> 1.4   =20
#	  drivers/char/rtc.c	1.18    -> 1.19  =20
#	include/asm-ppc64/nvram.h	1.2     -> 1.3   =20
#	include/asm-generic/rtc.h	1.1     -> 1.2   =20
#	arch/ppc/iSeries/mf.c	1.2     -> 1.3   =20
#	arch/mips64/sgi-ip27/ip27-rtc.c	1.5     -> 1.6   =20
#	drivers/scsi/sr_vendor.c	1.10    -> 1.11  =20
#	arch/i386/kernel/time.c	1.22    -> 1.23  =20
#	arch/ppc/platforms/prep_time.c	1.7     -> 1.8   =20
#	arch/sparc64/kernel/time.c	1.18    -> 1.19  =20
#	include/asm-mips64/m48t35.h	1.1     -> 1.2   =20
#	arch/ppc/platforms/gemini_setup.c	1.12    -> 1.13  =20
#	arch/alpha/kernel/time.c	1.11    -> 1.12  =20
#	arch/cris/kernel/time.c	1.6     -> 1.7   =20
#	arch/ppc64/kernel/rtc.c	1.3     -> 1.4   =20
#	include/asm-mips/ds1286.h	1.1     -> 1.2   =20
#	arch/m68k/sun3x/time.c	1.4     -> 1.5   =20
#	include/asm-mips64/ds1286.h	1.2     -> 1.3   =20
#	arch/x86_64/kernel/time.c	1.5     -> 1.6   =20
#	arch/arm/kernel/time.c	1.11    -> 1.12  =20
#	arch/mips/kernel/old-time.c	1.3     -> 1.4   =20
#	arch/ppc64/kernel/mf.c	1.3     -> 1.4   =20
#	include/asm-ppc/todc.h	1.1     -> 1.2   =20
#	arch/ppc/syslib/todc_time.c	1.4     -> 1.5   =20
#	arch/m68k/atari/time.c	1.3     -> 1.4   =20
#	arch/mips/dec/time.c	1.2     -> 1.3   =20
#	arch/mips/ddb5xxx/common/rtc_ds1386.c	1.1     -> 1.2   =20
#	include/linux/mc146818rtc.h	1.2     -> 1.3   =20
#	arch/sh/kernel/rtc.c	1.5     -> 1.6   =20
#	arch/cris/drivers/ds1302.c	1.4     -> 1.5   =20
#	drivers/acorn/char/pcf8583.c	1.5     -> 1.6   =20
#	include/asm-ppc/nvram.h	1.4     -> 1.5   =20
#	include/asm-arm/arch-ebsa285/time.h	1.5     -> 1.6   =20
#	               (new)	        -> 1.1     include/linux/bcd.h
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/12	hollis@granite.austin.ibm.com	1.745
# consolidate all the BCD_TO_BIN / BIN_TO_BCD definitions into bcd.h
# --------------------------------------------
#
diff -Nru a/arch/alpha/kernel/time.c b/arch/alpha/kernel/time.c
--- a/arch/alpha/kernel/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/alpha/kernel/time.c	Thu Dec 12 17:29:52 2002
@@ -37,6 +37,7 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
=20
 #include <asm/uaccess.h>
 #include <asm/io.h>
diff -Nru a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
--- a/arch/arm/kernel/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/arm/kernel/time.c	Thu Dec 12 17:29:52 2002
@@ -47,14 +47,6 @@
 /* change this if you have some constant time drift */
 #define USECS_PER_JIFFY	(1000000/HZ)
=20
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 static int dummy_set_rtc(void)
 {
 	return 0;
diff -Nru a/arch/cris/drivers/ds1302.c b/arch/cris/drivers/ds1302.c
--- a/arch/cris/drivers/ds1302.c	Thu Dec 12 17:29:52 2002
+++ b/arch/cris/drivers/ds1302.c	Thu Dec 12 17:29:52 2002
@@ -97,6 +97,7 @@
 #include <linux/module.h>
 #include <linux/miscdevice.h>
 #include <linux/delay.h>
+#include <linux/bcd.h>
=20
 #include <asm/uaccess.h>
 #include <asm/system.h>
diff -Nru a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
--- a/arch/cris/kernel/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/cris/kernel/time.c	Thu Dec 12 17:29:52 2002
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/delay.h>
+#include <linux/bcd.h>
=20
 #include <asm/segment.h>
 #include <asm/io.h>
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/i386/kernel/time.c	Thu Dec 12 17:29:52 2002
@@ -43,6 +43,7 @@
 #include <linux/smp.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/bcd.h>
=20
 #include <asm/io.h>
 #include <asm/smp.h>
diff -Nru a/arch/m68k/atari/time.c b/arch/m68k/atari/time.c
--- a/arch/m68k/atari/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/m68k/atari/time.c	Thu Dec 12 17:29:52 2002
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
=20
 #include <asm/rtc.h>
=20
diff -Nru a/arch/m68k/sun3x/time.c b/arch/m68k/sun3x/time.c
--- a/arch/m68k/sun3x/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/m68k/sun3x/time.c	Thu Dec 12 17:29:52 2002
@@ -11,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
=20
 #include <asm/irq.h>
 #include <asm/io.h>
@@ -35,9 +36,6 @@
 #define C_READ    0x40
 #define C_SIGN    0x20
 #define C_CALIB   0x1f
-
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-#define BIN_TO_BCD(val) (((val/10) << 4) | (val % 10))
=20
 int sun3x_hwclk(int set, struct rtc_time *t)
 {
diff -Nru a/arch/mips/ddb5xxx/common/rtc_ds1386.c b/arch/mips/ddb5xxx/commo=
n/rtc_ds1386.c
--- a/arch/mips/ddb5xxx/common/rtc_ds1386.c	Thu Dec 12 17:29:52 2002
+++ b/arch/mips/ddb5xxx/common/rtc_ds1386.c	Thu Dec 12 17:29:52 2002
@@ -20,6 +20,7 @@
=20
 #include <linux/types.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
=20
 #include <asm/time.h>
 #include <asm/addrspace.h>
@@ -27,12 +28,6 @@
 #include <asm/ddb5xxx/debug.h>
=20
 #define	EPOCH		2000
-
-#undef BCD_TO_BIN
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-
-#undef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
=20
 #define	READ_RTC(x)	*(volatile unsigned char*)(rtc_base+x)
 #define	WRITE_RTC(x, y)	*(volatile unsigned char*)(rtc_base+x) =3D y
diff -Nru a/arch/mips/dec/time.c b/arch/mips/dec/time.c
--- a/arch/mips/dec/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/mips/dec/time.c	Thu Dec 12 17:29:52 2002
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/bcd.h>
=20
 #include <asm/cpu.h>
 #include <asm/bootinfo.h>
diff -Nru a/arch/mips/kernel/old-time.c b/arch/mips/kernel/old-time.c
--- a/arch/mips/kernel/old-time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/mips/kernel/old-time.c	Thu Dec 12 17:29:52 2002
@@ -16,6 +16,7 @@
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
+#include <linux/bcd.h>
=20
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
diff -Nru a/arch/mips64/sgi-ip27/ip27-rtc.c b/arch/mips64/sgi-ip27/ip27-rtc=
.c
--- a/arch/mips64/sgi-ip27/ip27-rtc.c	Thu Dec 12 17:29:52 2002
+++ b/arch/mips64/sgi-ip27/ip27-rtc.c	Thu Dec 12 17:29:52 2002
@@ -35,6 +35,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/bcd.h>
=20
 #include <asm/m48t35.h>
 #include <asm/sn/ioc3.h>
diff -Nru a/arch/mips64/sgi-ip27/ip27-timer.c b/arch/mips64/sgi-ip27/ip27-t=
imer.c
--- a/arch/mips64/sgi-ip27/ip27-timer.c	Thu Dec 12 17:29:52 2002
+++ b/arch/mips64/sgi-ip27/ip27-timer.c	Thu Dec 12 17:29:52 2002
@@ -11,6 +11,7 @@
 #include <linux/param.h>
 #include <linux/timex.h>
 #include <linux/mm.h>	=09
+#include <linux/bcd.h>	=09
=20
 #include <asm/pgtable.h>
 #include <asm/sgialib.h>
diff -Nru a/arch/ppc/iSeries/mf.c b/arch/ppc/iSeries/mf.c
--- a/arch/ppc/iSeries/mf.c	Thu Dec 12 17:29:52 2002
+++ b/arch/ppc/iSeries/mf.c	Thu Dec 12 17:29:52 2002
@@ -40,6 +40,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/uaccess.h>
 #include <linux/pci.h>
+#include <linux/bcd.h>
=20
=20
 /*
diff -Nru a/arch/ppc/platforms/chrp_time.c b/arch/ppc/platforms/chrp_time.c
--- a/arch/ppc/platforms/chrp_time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/ppc/platforms/chrp_time.c	Thu Dec 12 17:29:52 2002
@@ -20,6 +20,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mc146818rtc.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
=20
 #include <asm/segment.h>
 #include <asm/io.h>
diff -Nru a/arch/ppc/platforms/gemini_setup.c b/arch/ppc/platforms/gemini_s=
etup.c
--- a/arch/ppc/platforms/gemini_setup.c	Thu Dec 12 17:29:52 2002
+++ b/arch/ppc/platforms/gemini_setup.c	Thu Dec 12 17:29:52 2002
@@ -24,6 +24,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/bcd.h>
=20
 #include <asm/system.h>
 #include <asm/pgtable.h>
diff -Nru a/arch/ppc/platforms/prep_time.c b/arch/ppc/platforms/prep_time.c
--- a/arch/ppc/platforms/prep_time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/ppc/platforms/prep_time.c	Thu Dec 12 17:29:52 2002
@@ -19,6 +19,7 @@
 #include <linux/timex.h>
 #include <linux/kernel_stat.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
=20
 #include <asm/sections.h>
 #include <asm/segment.h>
diff -Nru a/arch/ppc/syslib/todc_time.c b/arch/ppc/syslib/todc_time.c
--- a/arch/ppc/syslib/todc_time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/ppc/syslib/todc_time.c	Thu Dec 12 17:29:52 2002
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/bcd.h>
=20
 #include <asm/machdep.h>
 #include <asm/io.h>
diff -Nru a/arch/ppc64/kernel/mf.c b/arch/ppc64/kernel/mf.c
--- a/arch/ppc64/kernel/mf.c	Thu Dec 12 17:29:52 2002
+++ b/arch/ppc64/kernel/mf.c	Thu Dec 12 17:29:52 2002
@@ -40,6 +40,7 @@
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/uaccess.h>
 #include <linux/pci.h>
+#include <linux/bcd.h>
=20
 extern struct pci_dev * iSeries_vio_dev;
=20
diff -Nru a/arch/ppc64/kernel/rtc.c b/arch/ppc64/kernel/rtc.c
--- a/arch/ppc64/kernel/rtc.c	Thu Dec 12 17:29:52 2002
+++ b/arch/ppc64/kernel/rtc.c	Thu Dec 12 17:29:52 2002
@@ -32,6 +32,7 @@
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/spinlock.h>
+#include <linux/bcd.h>
=20
 #include <asm/io.h>
 #include <asm/uaccess.h>
diff -Nru a/arch/sh/kernel/rtc.c b/arch/sh/kernel/rtc.c
--- a/arch/sh/kernel/rtc.c	Thu Dec 12 17:29:52 2002
+++ b/arch/sh/kernel/rtc.c	Thu Dec 12 17:29:52 2002
@@ -9,17 +9,10 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/bcd.h>
=20
 #include <asm/io.h>
 #include <asm/rtc.h>
-
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
=20
 void sh_rtc_gettimeofday(struct timeval *tv)
 {
diff -Nru a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
--- a/arch/sparc64/kernel/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/sparc64/kernel/time.c	Thu Dec 12 17:29:52 2002
@@ -23,6 +23,7 @@
 #include <linux/mc146818rtc.h>
 #include <linux/delay.h>
 #include <linux/profile.h>
+#include <linux/bcd.h>
=20
 #include <asm/oplib.h>
 #include <asm/mostek.h>
@@ -329,14 +330,6 @@
=20
 	return (data1 =3D=3D data2);	/* Was the write blocked? */
 }
-
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) (((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((((val)/10)<<4) + (val)%10)
-#endif
=20
 /* Probe for the real time clock chip. */
 static void __init set_system_time(void)
diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Thu Dec 12 17:29:52 2002
+++ b/arch/x86_64/kernel/time.c	Thu Dec 12 17:29:52 2002
@@ -21,6 +21,7 @@
 #include <linux/ioport.h>
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/bcd.h>
 #include <asm/vsyscall.h>
 #include <asm/timex.h>
=20
diff -Nru a/drivers/acorn/char/pcf8583.c b/drivers/acorn/char/pcf8583.c
--- a/drivers/acorn/char/pcf8583.c	Thu Dec 12 17:29:52 2002
+++ b/drivers/acorn/char/pcf8583.c	Thu Dec 12 17:29:52 2002
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/mc146818rtc.h>
 #include <linux/init.h>
+#include <linux/bcd.h>
=20
 #include "pcf8583.h"
=20
diff -Nru a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
--- a/drivers/acpi/sleep.c	Thu Dec 12 17:29:52 2002
+++ b/drivers/acpi/sleep.c	Thu Dec 12 17:29:52 2002
@@ -16,6 +16,7 @@
 #include <linux/device.h>
 #include <linux/suspend.h>
 #include <linux/seq_file.h>
+#include <linux/bcd.h>
=20
 #include <asm/uaccess.h>
 #include <asm/acpi.h>
diff -Nru a/drivers/char/rtc.c b/drivers/char/rtc.c
--- a/drivers/char/rtc.c	Thu Dec 12 17:29:52 2002
+++ b/drivers/char/rtc.c	Thu Dec 12 17:29:52 2002
@@ -72,6 +72,7 @@
 #include <linux/spinlock.h>
 #include <linux/sysctl.h>
 #include <linux/wait.h>
+#include <linux/bcd.h>
=20
 #include <asm/current.h>
 #include <asm/uaccess.h>
diff -Nru a/drivers/scsi/sr_vendor.c b/drivers/scsi/sr_vendor.c
--- a/drivers/scsi/sr_vendor.c	Thu Dec 12 17:29:52 2002
+++ b/drivers/scsi/sr_vendor.c	Thu Dec 12 17:29:52 2002
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/errno.h>
 #include <linux/string.h>
+#include <linux/bcd.h>
=20
 #include <linux/blk.h>
 #include "scsi.h"
@@ -150,8 +151,6 @@
=20
 /* This function gets called after a media change. Checks if the CD is
    multisession, asks for offset etc. */
-
-#define BCD_TO_BIN(x)    ((((int)x & 0xf0) >> 4)*10 + ((int)x & 0x0f))
=20
 int sr_cd_check(struct cdrom_device_info *cdi)
 {
diff -Nru a/drivers/sgi/char/ds1286.c b/drivers/sgi/char/ds1286.c
--- a/drivers/sgi/char/ds1286.c	Thu Dec 12 17:29:52 2002
+++ b/drivers/sgi/char/ds1286.c	Thu Dec 12 17:29:52 2002
@@ -36,6 +36,7 @@
 #include <linux/poll.h>
 #include <linux/rtc.h>
 #include <linux/spinlock.h>
+#include <linux/bcd.h>
=20
 #include <asm/ds1286.h>
 #include <asm/io.h>
diff -Nru a/include/asm-arm/arch-ebsa285/time.h b/include/asm-arm/arch-ebsa=
285/time.h
--- a/include/asm-arm/arch-ebsa285/time.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-arm/arch-ebsa285/time.h	Thu Dec 12 17:29:52 2002
@@ -18,6 +18,7 @@
 #define RTC_ALWAYS_BCD		0
=20
 #include <linux/mc146818rtc.h>
+#include <linux/bcd.h>
=20
 #include <asm/hardware/dec21285.h>
 #include <asm/leds.h>
diff -Nru a/include/asm-cris/rtc.h b/include/asm-cris/rtc.h
--- a/include/asm-cris/rtc.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-cris/rtc.h	Thu Dec 12 17:29:52 2002
@@ -39,11 +39,6 @@
 #define RTC_INIT() (-1)
 #endif
=20
-/* conversions to and from the stupid RTC internal format */
-
-#define BCD_TO_BIN(x) x =3D (((x & 0xf0) >> 3) * 5 + (x & 0xf))
-#define BIN_TO_BCD(x) x =3D (x % 10) | ((x / 10) << 4)=20
-
 /*
  * The struct used to pass data via the following ioctl. Similar to the
  * struct tm in <time.h>, but it needs to be here so that the kernel=20
diff -Nru a/include/asm-generic/rtc.h b/include/asm-generic/rtc.h
--- a/include/asm-generic/rtc.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-generic/rtc.h	Thu Dec 12 17:29:52 2002
@@ -16,6 +16,7 @@
=20
 #include <linux/mc146818rtc.h>
 #include <linux/rtc.h>
+#include <linux/bcd.h>
=20
 #define RTC_PIE 0x40		/* periodic interrupt enable */
 #define RTC_AIE 0x20		/* alarm interrupt enable */
diff -Nru a/include/asm-mips/ds1286.h b/include/asm-mips/ds1286.h
--- a/include/asm-mips/ds1286.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-mips/ds1286.h	Thu Dec 12 17:29:52 2002
@@ -57,15 +57,4 @@
 #define RTC_IPSW		0x40
 #define RTC_TE			0x80
=20
-/*
- * Conversion between binary and BCD.
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _ASM_DS1286_h */
diff -Nru a/include/asm-mips64/ds1286.h b/include/asm-mips64/ds1286.h
--- a/include/asm-mips64/ds1286.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-mips64/ds1286.h	Thu Dec 12 17:29:52 2002
@@ -56,15 +56,4 @@
 #define RTC_IPSW		0x40
 #define RTC_TE			0x80
=20
-/*
- * Conversion between binary and BCD.
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _ASM_DS1286_h */
diff -Nru a/include/asm-mips64/m48t35.h b/include/asm-mips64/m48t35.h
--- a/include/asm-mips64/m48t35.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-mips64/m48t35.h	Thu Dec 12 17:29:52 2002
@@ -21,12 +21,4 @@
 #define M48T35_RTC_STOPPED  0x80
 #define M48T35_RTC_READ     0x40
=20
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(x)   ((x)=3D((x)&15) + ((x)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(x)   ((x)=3D(((x)/10)<<4) + (x)%10)
-#endif
-
 #endif
diff -Nru a/include/asm-ppc/m48t35.h b/include/asm-ppc/m48t35.h
--- a/include/asm-ppc/m48t35.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-ppc/m48t35.h	Thu Dec 12 17:29:52 2002
@@ -74,13 +74,4 @@
 #define M48T35_RTC_READ     0x40
=20
=20
-/* read/write conversions */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(x)   ((x)=3D((x)&15) + ((x)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(x)   ((x)=3D(((x)/10)<<4) + (x)%10)
-#endif
-
 #endif
diff -Nru a/include/asm-ppc/mk48t59.h b/include/asm-ppc/mk48t59.h
--- a/include/asm-ppc/mk48t59.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-ppc/mk48t59.h	Thu Dec 12 17:29:52 2002
@@ -24,12 +24,4 @@
 #define MK48T59_RTC_CONTROLB		0x1FF9
 #define MK48T59_RTC_CB_STOP		0x80
=20
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _PPC_MK48T59_H */
diff -Nru a/include/asm-ppc/nvram.h b/include/asm-ppc/nvram.h
--- a/include/asm-ppc/nvram.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-ppc/nvram.h	Thu Dec 12 17:29:52 2002
@@ -23,14 +23,6 @@
 #define MOTO_RTC_CONTROLA            0x1FF8
 #define MOTO_RTC_CONTROLB            0x1FF9
=20
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 /* PowerMac specific nvram stuffs */
=20
 enum {
diff -Nru a/include/asm-ppc/todc.h b/include/asm-ppc/todc.h
--- a/include/asm-ppc/todc.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-ppc/todc.h	Thu Dec 12 17:29:52 2002
@@ -355,14 +355,6 @@
 	todc_info->flags         =3D clock_type ##_FLAGS;			\
 }
=20
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 extern todc_info_t *todc_info;
=20
 unsigned char todc_direct_read_val(int addr);
diff -Nru a/include/asm-ppc64/nvram.h b/include/asm-ppc64/nvram.h
--- a/include/asm-ppc64/nvram.h	Thu Dec 12 17:29:52 2002
+++ b/include/asm-ppc64/nvram.h	Thu Dec 12 17:29:52 2002
@@ -28,12 +28,4 @@
 #define MOTO_RTC_CONTROLA       0x1FF8
 #define MOTO_RTC_CONTROLB       0x1FF9
=20
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _PPC64_NVRAM_H */
diff -Nru a/include/linux/bcd.h b/include/linux/bcd.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/bcd.h	Thu Dec 12 17:29:52 2002
@@ -0,0 +1,20 @@
+/* Permission is hereby granted to copy, modify and redistribute this code
+ * in terms of the GNU Library General Public License, Version 2 or later,
+ * at your option.
+ */
+
+/* macros to translate to/from binary and binary-coded decimal (frequently
+ * found in RTC chips).
+ */
+
+#ifndef _BCD_H
+#define _BCD_H
+
+#define BCD2BIN(val)	(((val) & 0x0f) + ((val)>>4)*10)
+#define BIN2BCD(val)	((((val)/10)<<4) + (val)%10)
+
+/* backwards compat */
+#define BCD_TO_BIN(val) ((val)=3DBCD2BIN(val))
+#define BIN_TO_BCD(val) ((val)=3DBIN2BCD(val))
+
+#endif /* _BCD_H */
diff -Nru a/include/linux/mc146818rtc.h b/include/linux/mc146818rtc.h
--- a/include/linux/mc146818rtc.h	Thu Dec 12 17:29:52 2002
+++ b/include/linux/mc146818rtc.h	Thu Dec 12 17:29:52 2002
@@ -87,15 +87,4 @@
 # define RTC_VRT 0x80		/* valid RAM and time */
 /**********************************************************************/
=20
-/* example: !(CMOS_READ(RTC_CONTROL) & RTC_DM_BINARY)=20
- * determines if the following two #defines are needed
- */
-#ifndef BCD_TO_BIN
-#define BCD_TO_BIN(val) ((val)=3D((val)&15) + ((val)>>4)*10)
-#endif
-
-#ifndef BIN_TO_BCD
-#define BIN_TO_BCD(val) ((val)=3D(((val)/10)<<4) + (val)%10)
-#endif
-
 #endif /* _MC146818RTC_H */

--=-pirxAKtDlNSPVjCNtTRh--

--=-sLaD/4bv4Gb+0ZjkfScY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9+RyT4KXmU2P6AeoRAlNaAJ0YhaNgbDA2Za4ereQSCOdQYZ9TqQCbBBVC
mZ8a2BZGwzGpGqkgh0QxLfg=
=91RZ
-----END PGP SIGNATURE-----

--=-sLaD/4bv4Gb+0ZjkfScY--

