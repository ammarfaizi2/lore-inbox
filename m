Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUG2Ssl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUG2Ssl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbUG2Ooo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:44:44 -0400
Received: from styx.suse.cz ([82.119.242.94]:10390 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264815AbUG2OIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:09 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 10/47] Disable the AUX LoopBack command in i8042.c on Compaq ProLiant
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101943643@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <1091110194629@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.85.1, 2004-06-02 13:44:20+02:00, vojtech@suse.cz
  input: Disable the AUX LoopBack command in i8042.c on Compaq ProLiant
         8-way Xeon ProFusion systems, as it causes crashes and reboots
         on these machines. DMI data is used for determining if the
         workaround should be enabled.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 arch/i386/kernel/dmi_scan.c |   31 +++++++++++++++++++++++++++++++
 drivers/input/serio/i8042.c |   14 +++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

===================================================================

diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Thu Jul 29 14:41:45 2004
+++ b/arch/i386/kernel/dmi_scan.c	Thu Jul 29 14:41:45 2004
@@ -15,6 +15,9 @@
 unsigned long dmi_broken;
 EXPORT_SYMBOL(dmi_broken);
 
+unsigned int i8042_dmi_noloop = 0;
+EXPORT_SYMBOL(i8042_dmi_noloop);
+
 int is_sony_vaio_laptop;
 int is_unsafe_smbus;
 int es7000_plat = 0;
@@ -401,6 +404,17 @@
 }
 
 /*
+ * Several HP Proliant (and maybe other OSB4/ProFusion) systems
+ * shouldn't use the AUX LoopBack command, or they crash or reboot.
+ */
+
+static __init int set_8042_noloop(struct dmi_blacklist *d)
+{
+	i8042_dmi_noloop = 1;
+	return 0;
+}
+
+/*
  * This bios swaps the APM minute reporting bytes over (Many sony laptops
  * have this problem).
  */
@@ -874,6 +888,23 @@
 			MATCH(DMI_BIOS_VERSION, "3A71"),
 			NO_MATCH, NO_MATCH,
 			} },
+
+	/*      
+	 * Several HP Proliant (and maybe other OSB4/ProFusion) systems
+	 * can't use i8042 in mux mode, or they crash or reboot.
+	 */                     
+
+	{ set_8042_noloop, "Compaq Proliant 8500", {
+			MATCH(DMI_SYS_VENDOR, "Compaq"),
+			MATCH(DMI_PRODUCT_NAME , "ProLiant"),
+			MATCH(DMI_PRODUCT_VERSION, "8500"),
+			NO_MATCH }},
+
+	{ set_8042_noloop, "Compaq Proliant DL760", {
+			MATCH(DMI_SYS_VENDOR, "Compaq"),
+			MATCH(DMI_PRODUCT_NAME , "ProLiant"),
+			MATCH(DMI_PRODUCT_VERSION, "DL760"),
+			NO_MATCH }},
 
 #ifdef	CONFIG_ACPI_BOOT
 	/*
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 29 14:41:45 2004
+++ b/drivers/input/serio/i8042.c	Thu Jul 29 14:41:45 2004
@@ -1,7 +1,7 @@
 /*
  *  i8042 keyboard and mouse controller driver for Linux
  *
- *  Copyright (c) 1999-2002 Vojtech Pavlik
+ *  Copyright (c) 1999-2004 Vojtech Pavlik
  */
 
 /*
@@ -52,6 +52,8 @@
 module_param_named(dumbkbd, i8042_dumbkbd, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
+static unsigned int i8042_noloop;
+
 __obsolete_setup("i8042_noaux");
 __obsolete_setup("i8042_nomux");
 __obsolete_setup("i8042_unlock");
@@ -154,6 +156,9 @@
 	unsigned long flags;
 	int retval = 0, i = 0;
 
+	if (i8042_noloop && command == I8042_CMD_AUX_LOOP)
+		return -1;
+
 	spin_lock_irqsave(&i8042_lock, flags);
 
 	retval = i8042_wait_write();
@@ -954,6 +959,13 @@
 
 	if (i8042_dumbkbd)
 		i8042_kbd_port.write = NULL;
+
+#ifdef __i386__
+	if (i8042_dmi_noloop) {
+		printk(KERN_INFO "i8042.c: AUX LoopBack command disabled by DMI.\n");
+		i8042_noloop = 1;
+	}
+#endif
 
 	if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
 		if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))

