Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272856AbRJBMP1>; Tue, 2 Oct 2001 08:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273065AbRJBMPS>; Tue, 2 Oct 2001 08:15:18 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:33292 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S272856AbRJBMPM>;
	Tue, 2 Oct 2001 08:15:12 -0400
Date: Tue, 2 Oct 2001 14:15:38 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, jdthood@yahoo.co.uk
Subject: [PATCH 2.4.10-ac3] move DMI scan before other subsystem init (especially PnP)
Message-ID: <20011002141538.M25153@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch makes the DMI scan routines to be
called before other subsystems get initialized 
(I've done this since PnP initialization is dependent
on DMI variable is_sony_vaio_laptop to be set, for this
subsystem to work).

Since there are other subsystems that may need some
DMI idents in their initializations, and the DMI
routines don't depend on other subsystem, I've put
them at the top of the list, before pci_init, sbus_init
etc. I hope nothing got broken in the process.

The patch includes also some additionnal cleanups
in sonypi/pnp drivers which reference some DMI exported
symbols.

Please review for corectness and apply if all is OK.

Stelian.

diff -uNr --exclude-from=dontdiff linux-2.4.10-ac3.orig/arch/i386/kernel/dmi_scan.c linux-2.4.10-ac3/arch/i386/kernel/dmi_scan.c
--- linux-2.4.10-ac3.orig/arch/i386/kernel/dmi_scan.c	Tue Oct  2 13:16:25 2001
+++ linux-2.4.10-ac3/arch/i386/kernel/dmi_scan.c	Tue Oct  2 12:53:33 2001
@@ -9,6 +9,7 @@
 #include <linux/pm.h>
 #include <linux/keyboard.h>
 #include <asm/keyboard.h>
+#include <asm/system.h>
 
 unsigned long dmi_broken;
 
@@ -687,12 +688,10 @@
 	}
 }
 
-static int __init dmi_scan_machine(void)
+int __init dmi_scan_machine(void)
 {
 	int err = dmi_iterate(dmi_decode);
 	if(err == 0)
 		dmi_check_blacklist();
 	return err;
 }
-
-module_init(dmi_scan_machine);
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac3.orig/arch/i386/kernel/i386_ksyms.c linux-2.4.10-ac3/arch/i386/kernel/i386_ksyms.c
--- linux-2.4.10-ac3.orig/arch/i386/kernel/i386_ksyms.c	Tue Oct  2 13:16:25 2001
+++ linux-2.4.10-ac3/arch/i386/kernel/i386_ksyms.c	Tue Oct  2 12:54:23 2001
@@ -29,6 +29,7 @@
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/page.h>
+#include <asm/system.h>
 
 extern void dump_thread(struct pt_regs *, struct user *);
 extern spinlock_t rtc_lock;
@@ -171,6 +172,5 @@
 EXPORT_SYMBOL(do_BUG);
 #endif
 
-extern int is_sony_vaio_laptop;
 EXPORT_SYMBOL(is_sony_vaio_laptop);
 
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac3.orig/drivers/char/sonypi.c linux-2.4.10-ac3/drivers/char/sonypi.c
--- linux-2.4.10-ac3.orig/drivers/char/sonypi.c	Tue Sep 18 07:52:35 2001
+++ linux-2.4.10-ac3/drivers/char/sonypi.c	Tue Oct  2 12:55:44 2001
@@ -39,6 +39,7 @@
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/system.h>
 
 #include "sonypi.h"
 #include <linux/sonypi.h>
@@ -48,7 +49,6 @@
 static int verbose; /* = 0 */
 static int fnkeyinit; /* = 0 */
 static int camera; /* = 0 */
-extern int is_sony_vaio_laptop; /* set in DMI table parse routines */
 
 /* Inits the queue */
 static inline void sonypi_initq(void) {
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac3.orig/drivers/pnp/pnp_bios.c linux-2.4.10-ac3/drivers/pnp/pnp_bios.c
--- linux-2.4.10-ac3.orig/drivers/pnp/pnp_bios.c	Tue Oct  2 13:17:06 2001
+++ linux-2.4.10-ac3/drivers/pnp/pnp_bios.c	Tue Oct  2 12:56:08 2001
@@ -44,12 +44,11 @@
 #include <linux/kmod.h>
 #include <linux/completion.h>
 #include <linux/spinlock.h>
+#include <asm/system.h>
 
 /* PnP bios signature: "$PnP" */
 #define PNP_SIGNATURE   (('$' << 0) + ('P' << 8) + ('n' << 16) + ('P' << 24))
 
-extern int is_sony_vaio_laptop;
-
 static void pnpbios_build_devlist(void);
 
 /*
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac3.orig/include/asm-i386/system.h linux-2.4.10-ac3/include/asm-i386/system.h
--- linux-2.4.10-ac3.orig/include/asm-i386/system.h	Tue Oct  2 13:17:47 2001
+++ linux-2.4.10-ac3/include/asm-i386/system.h	Tue Oct  2 12:58:40 2001
@@ -3,6 +3,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <asm/segment.h>
 #include <linux/bitops.h> /* for LOCK_PREFIX */
 
@@ -349,7 +350,10 @@
 void disable_hlt(void);
 void enable_hlt(void);
 
+int __init dmi_scan_machine(void);
 extern unsigned long dmi_broken;
+extern int is_sony_vaio_laptop;
+
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002
 
diff -uNr --exclude-from=dontdiff linux-2.4.10-ac3.orig/init/main.c linux-2.4.10-ac3/init/main.c
--- linux-2.4.10-ac3.orig/init/main.c	Tue Oct  2 13:17:54 2001
+++ linux-2.4.10-ac3/init/main.c	Tue Oct  2 12:58:01 2001
@@ -30,6 +30,7 @@
 
 #include <asm/io.h>
 #include <asm/bugs.h>
+#include <asm/system.h>
 
 #if defined(CONFIG_ARCH_S390)
 #include <asm/s390mach.h>
@@ -785,6 +786,10 @@
 	s390_init_machine_check();
 #endif
 
+#if defined(CONFIG_X86)
+	dmi_scan_machine();
+#endif
+
 #ifdef CONFIG_GSC
 	/*
 	 * GSC must initialise before PCI. On may HPPA boxes the PCI
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
