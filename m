Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267254AbUGNAIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267254AbUGNAIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267257AbUGNAIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:08:37 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:27381 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267254AbUGNAIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:08:13 -0400
Date: Wed, 14 Jul 2004 02:08:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill drive_info
Message-ID: <20040714000810.GA7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of drive_info in 2.6 seems to be drivers/ide/legacy/hd.c .

What about the patch below to kill drive_info?

Please double-check this patch, all I checked was a test of compilation
on i386.

diffstat output:
 arch/cris/kernel/setup.c         |    1 -
 arch/i386/kernel/i386_ksyms.c    |    5 -----
 arch/i386/kernel/setup.c         |    2 --
 arch/ia64/dig/setup.c            |   10 ----------
 arch/ia64/sn/kernel/setup.c      |   14 --------------
 arch/ppc/platforms/pmac_setup.c  |    2 --
 arch/sh64/kernel/sh_ksyms.c      |    8 --------
 arch/x86_64/kernel/setup.c       |    2 --
 arch/x86_64/kernel/x8664_ksyms.c |    5 -----
 drivers/ide/legacy/hd.c          |    7 +++++--
 10 files changed, 5 insertions(+), 51 deletions(-)


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/arch/x86_64/kernel/setup.c.old	2004-07-14 01:18:28.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/x86_64/kernel/setup.c	2004-07-14 01:19:45.000000000 +0200
@@ -85,7 +85,6 @@
 /*
  * Setup options
  */
-struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
 struct sys_desc_table_struct {
 	unsigned short length;
@@ -429,7 +428,6 @@
 	unsigned long kernel_end;
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
- 	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
 	aux_device_present = AUX_DEVICE_INFO;
--- linux-2.6.7-mm7-full/arch/x86_64/kernel/x8664_ksyms.c.old	2004-07-14 01:20:15.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/x86_64/kernel/x8664_ksyms.c	2004-07-14 01:20:25.000000000 +0200
@@ -41,11 +41,6 @@
 extern void __read_lock_failed(rwlock_t *rw);
 #endif
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
-extern struct drive_info_struct drive_info;
-EXPORT_SYMBOL(drive_info);
-#endif
-
 extern unsigned long get_cmos_time(void);
 
 /* platform dependent support */
--- linux-2.6.7-mm7-full/arch/i386/kernel/i386_ksyms.c.old	2004-07-14 01:22:27.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/i386/kernel/i386_ksyms.c	2004-07-14 01:22:39.000000000 +0200
@@ -51,11 +51,6 @@
 extern void FASTCALL( __read_lock_failed(rwlock_t *rw));
 #endif
 
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
-extern struct drive_info_struct drive_info;
-EXPORT_SYMBOL(drive_info);
-#endif
-
 extern unsigned long cpu_khz;
 extern unsigned long get_cmos_time(void);
 
--- linux-2.6.7-mm7-full/arch/ia64/sn/kernel/setup.c.old	2004-07-14 01:23:27.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/ia64/sn/kernel/setup.c	2004-07-14 01:24:19.000000000 +0200
@@ -109,20 +109,6 @@
 };
 
 /*
- * This is here so we can use the CMOS detection in ide-probe.c to
- * determine what drives are present.  In theory, we don't need this
- * as the auto-detection could be done via ide-probe.c:do_probe() but
- * in practice that would be much slower, which is painful when
- * running in the simulator.  Note that passing zeroes in DRIVE_INFO
- * is sufficient (the IDE driver will autodetect the drive geometry).
- */
-#ifdef CONFIG_IA64_GENERIC
-extern char drive_info[4*16];
-#else
-char drive_info[4*16];
-#endif
-
-/*
  * This routine can only be used during init, since
  * smp_boot_data is an init data structure.
  * We have to use smp_boot_data.cpu_phys_id to find
--- linux-2.6.7-mm7-full/arch/ia64/dig/setup.c.old	2004-07-14 01:24:45.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/ia64/dig/setup.c	2004-07-14 01:25:02.000000000 +0200
@@ -25,16 +25,6 @@
 #include <asm/machvec.h>
 #include <asm/system.h>
 
-/*
- * This is here so we can use the CMOS detection in ide-probe.c to
- * determine what drives are present.  In theory, we don't need this
- * as the auto-detection could be done via ide-probe.c:do_probe() but
- * in practice that would be much slower, which is painful when
- * running in the simulator.  Note that passing zeroes in DRIVE_INFO
- * is sufficient (the IDE driver will autodetect the drive geometry).
- */
-char drive_info[4*16];
-
 void __init
 dig_setup (char **cmdline_p)
 {
--- linux-2.6.7-mm7-full/arch/ppc/platforms/pmac_setup.c.old	2004-07-14 01:25:51.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/ppc/platforms/pmac_setup.c	2004-07-14 01:25:57.000000000 +0200
@@ -95,8 +95,6 @@
 
 struct device_node *memory_node;
 
-unsigned char drive_info;
-
 int ppc_override_l2cr = 0;
 int ppc_override_l2cr_value;
 int has_l2cache = 0;
--- linux-2.6.7-mm7-full/arch/cris/kernel/setup.c.old	2004-07-14 01:26:26.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/cris/kernel/setup.c	2004-07-14 01:26:42.000000000 +0200
@@ -23,7 +23,6 @@
 /*
  * Setup options
  */
-struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
 
 unsigned char aux_device_present;
--- linux-2.6.7-mm7-full/arch/sh64/kernel/sh_ksyms.c.old	2004-07-14 01:27:07.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/sh64/kernel/sh_ksyms.c	2004-07-14 01:27:16.000000000 +0200
@@ -32,14 +32,6 @@
 extern void dump_thread(struct pt_regs *, struct user *);
 extern int dump_fpu(struct pt_regs *, elf_fpregset_t *);
 
-#if 0
-/* Not yet - there's no declaration of drive_info anywhere. */
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_HD) || defined(CONFIG_BLK_DEV_IDE_MODULE) || defined(CONFIG_BLK_DEV_HD_MODULE)
-extern struct drive_info_struct drive_info;
-EXPORT_SYMBOL(drive_info);
-#endif
-#endif
-
 /* platform dependent support */
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
--- linux-2.6.7-mm7-full/drivers/ide/legacy/hd.c.old	2004-07-14 01:29:42.000000000 +0200
+++ linux-2.6.7-mm7-full/drivers/ide/legacy/hd.c	2004-07-14 01:53:21.000000000 +0200
@@ -47,6 +47,10 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
+#ifdef __i386__
+#include <asm/setup.h>
+#endif
+
 #ifdef __arm__
 #undef  HD_IRQ
 #endif
@@ -726,8 +730,7 @@
 
 #ifdef __i386__
 	if (!NR_HD) {
-		extern struct drive_info drive_info;
-		unsigned char *BIOS = (unsigned char *) &drive_info;
+		unsigned char *BIOS = &boot_params[0x80];
 		unsigned long flags;
 		int cmos_disks;
 
--- linux-2.6.7-mm7-full/arch/i386/kernel/setup.c.old	2004-07-14 01:28:56.000000000 +0200
+++ linux-2.6.7-mm7-full/arch/i386/kernel/setup.c	2004-07-14 01:59:25.000000000 +0200
@@ -102,7 +102,6 @@
 /*
  * Setup options
  */
-struct drive_info_struct { char dummy[32]; } drive_info;
 struct screen_info screen_info;
 struct apm_info apm_info;
 struct sys_desc_table_struct {
@@ -1288,7 +1287,6 @@
 #endif
 
  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
- 	drive_info = DRIVE_INFO;
  	screen_info = SCREEN_INFO;
 	edid_info = EDID_INFO;
 	apm_info.bios = APM_BIOS_INFO;

