Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUG2ORI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUG2ORI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUG2OQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:16:47 -0400
Received: from styx.suse.cz ([82.119.242.94]:30614 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S265051AbUG2OIO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:14 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 43/47] Move Compaq ProLiant DMI handling to i8042.c.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101961806@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101962274@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.50.2, 2004-06-29 11:59:04+02:00, vojtech@suse.cz
  input: Move Compaq ProLiant DMI handling (ServerWorks/OSB workaround)
         to i8042.c.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 i8042-io.h |   31 +++++++++++++++++++++++++++++++
 i8042.c    |   12 ++----------
 2 files changed, 33 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
--- a/drivers/input/serio/i8042-io.h	Thu Jul 29 14:38:43 2004
+++ b/drivers/input/serio/i8042-io.h	Thu Jul 29 14:38:43 2004
@@ -63,6 +63,31 @@
 	return;
 }
 
+#if defined(__i386__)
+
+#include <linux/dmi.h>
+
+static struct dmi_system_id __initdata i8042_dmi_table[] = {
+	{
+		.ident = "Compaq Proliant 8500",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
+		},
+	},
+	{
+		.ident = "Compaq Proliant DL760",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME , "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
+		},
+	},
+	{ }
+};
+#endif
+
 static inline int i8042_platform_init(void)
 {
 /*
@@ -77,6 +102,12 @@
 #if !defined(__i386__) && !defined(__x86_64__)
         i8042_reset = 1;
 #endif
+
+#if defined(__i386__)
+	if (dmi_check_system(i8042_dmi_table))
+		i8042_noloop = 1;
+#endif
+
 	return 0;
 }
 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 29 14:38:43 2004
+++ b/drivers/input/serio/i8042.c	Thu Jul 29 14:38:43 2004
@@ -52,10 +52,9 @@
 module_param_named(dumbkbd, i8042_dumbkbd, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Pretend that controller can only read data from keyboard");
 
-#ifdef __i386__
-extern unsigned int i8042_dmi_noloop;
-#endif
 static unsigned int i8042_noloop;
+module_param_named(noloop, i8042_noloop, bool, 0);
+MODULE_PARM_DESC(dumbkbd, "Disable the AUX Loopback command while probing for the AUX port");
 
 __obsolete_setup("i8042_noaux");
 __obsolete_setup("i8042_nomux");
@@ -966,13 +965,6 @@
 
 	if (i8042_dumbkbd)
 		i8042_kbd_port.write = NULL;
-
-#ifdef __i386__
-	if (i8042_dmi_noloop) {
-		printk(KERN_INFO "i8042.c: AUX LoopBack command disabled by DMI.\n");
-		i8042_noloop = 1;
-	}
-#endif
 
 	if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
 		if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))

