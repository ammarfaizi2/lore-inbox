Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbTHTXUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 19:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbTHTXUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 19:20:49 -0400
Received: from havoc.gtf.org ([63.247.75.124]:13712 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262342AbTHTXUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 19:20:46 -0400
Date: Wed, 20 Aug 2003 19:20:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, andrew.grover@intel.com, len.brown@intel.com
Subject: [patch] remove mount_root_failed_msg()
Message-ID: <20030820232045.GA25921@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one snuck in... 

* debugging message for ACPI

* Intel guys removed it from their 2.4 tree (at my request)

* it's point-in-time specific (message becomes nearly useless after
  ACPI bug fixes)

* b/c of the point-in-time issue, it's IMO much more appropriate for a
  vendor kernel (where the message, I agree, may be helpful)

* can potentially mislead users to the correct cause of root mount failure

* overall, I disagree with adding messages like this.  The number one
  bug report, by far, for networking drivers is ACPI-related (no
  interrupts delivered).  You don't see me adding "boot with acpi=off"
  messages to the net subsystem.



===== arch/i386/kernel/dmi_scan.c 1.41 vs edited =====
--- 1.41/arch/i386/kernel/dmi_scan.c	Tue Aug 19 16:01:09 2003
+++ edited/arch/i386/kernel/dmi_scan.c	Wed Aug 20 19:10:10 2003
@@ -1116,27 +1116,3 @@
 }
 
 EXPORT_SYMBOL(is_unsafe_smbus);
-
-#ifdef CONFIG_MOUNT_ROOT_FAILED_MSG
-/*
- * mount_root_failed_msg()
- *
- * Called from mount_block_root() upon failure to mount root.
- * architecture dependent to give different platforms
- * the opportunity to print different handy messages
- * On x86 this lives here b/c it dumps out some DMI info.
- */
-
-void
-mount_root_failed_msg(void)
-{
-#ifdef	CONFIG_ACPI_BOOT
-	printk ("Try booting with pci=noacpi, acpi=ht, "
-		"or acpi=off on the command line.\n");
-	printk ("If one helps, please report the following lines:\n");
-
-	dmi_dump_system();
-#endif
-}
-#endif	/* CONFIG_MOUNT_ROOT_FAILED_MSG */
-
===== arch/i386/defconfig 1.100 vs edited =====
--- 1.100/arch/i386/defconfig	Mon Aug 18 23:46:20 2003
+++ edited/arch/i386/defconfig	Wed Aug 20 19:10:15 2003
@@ -228,7 +228,6 @@
 # CONFIG_BLK_DEV_RAM is not set
 # CONFIG_BLK_DEV_INITRD is not set
 CONFIG_LBD=y
-CONFIG_MOUNT_ROOT_FAILED_MSG=y
 
 #
 # ATA/ATAPI/MFM/RLL support
===== init/do_mounts.h 1.6 vs edited =====
--- 1.6/init/do_mounts.h	Tue Aug 12 22:44:58 2003
+++ edited/init/do_mounts.h	Wed Aug 20 19:10:24 2003
@@ -80,13 +80,3 @@
 
 #endif
 
-#ifdef CONFIG_MOUNT_ROOT_FAILED_MSG
-
-void mount_root_failed_msg(void);
-
-#else
-
-static inline void mount_root_failed_msg(void) {}
-
-#endif
-
===== init/do_mounts.c 1.54 vs edited =====
--- 1.54/init/do_mounts.c	Fri Aug 15 03:52:20 2003
+++ edited/init/do_mounts.c	Wed Aug 20 19:10:38 2003
@@ -286,8 +286,6 @@
 				root_device_name, b);
 		printk("Please append a correct \"root=\" boot option\n");
 
-		mount_root_failed_msg();	/* architecture dependent */
-
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
 	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
===== arch/i386/Kconfig 1.71 vs edited =====
--- 1.71/arch/i386/Kconfig	Mon Aug 18 22:46:23 2003
+++ edited/arch/i386/Kconfig	Wed Aug 20 19:16:36 2003
@@ -1204,10 +1204,6 @@
 
 source "drivers/block/Kconfig"
 
-config MOUNT_ROOT_FAILED_MSG
-	bool
-	default y
-
 source "drivers/ide/Kconfig"
 
 source "drivers/scsi/Kconfig"
