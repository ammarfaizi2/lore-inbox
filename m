Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261340AbUL2HeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261340AbUL2HeC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 02:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbUL2HeB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:34:01 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:11695 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261376AbUL2HdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:24 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/16] i8042 panicblink cleanup
Date: Wed, 29 Dec 2004 02:19:21 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net>
In-Reply-To: <200412290217.36282.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290219.23638.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1957.1.28, 2004-11-12 01:23:12-05:00, dtor_core@ameritech.net
  Input: i8042 - move panicblink with the rest of module paremeters,
         add proper entry to kernel-parameters.txt
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 Documentation/kernel-parameters.txt |    3 +++
 drivers/input/serio/i8042.c         |   35 ++++++++++++++++++++++-------------
 2 files changed, 25 insertions(+), 13 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	2004-12-29 01:46:13 -05:00
+++ b/Documentation/kernel-parameters.txt	2004-12-29 01:46:13 -05:00
@@ -486,6 +486,9 @@
 	i8042.noaux	[HW] Don't check for auxiliary (== mouse) port
 	i8042.nomux	[HW] Don't check presence of an active multiplexing
 			     controller
+	i8042.panicblink=
+			[HW] Frequency with which keyboard LEDs should blink
+			     when kernel panics (default is 0.5 sec)
 	i8042.reset	[HW] Reset the controller during init and cleanup
 	i8042.unlock	[HW] Unlock (ignore) the keylock
 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-12-29 01:46:13 -05:00
+++ b/drivers/input/serio/i8042.c	2004-12-29 01:46:13 -05:00
@@ -54,6 +54,10 @@
 module_param_named(noloop, i8042_noloop, bool, 0);
 MODULE_PARM_DESC(dumbkbd, "Disable the AUX Loopback command while probing for the AUX port");
 
+static unsigned int i8042_blink_frequency = 500;
+module_param_named(panicblink, i8042_blink_frequency, uint, 0600);
+MODULE_PARM_DESC(panicblink, "Frequency with which keyboard LEDs should blink when kernel panics");
+
 #ifdef CONFIG_ACPI
 static int i8042_noacpi;
 module_param_named(noacpi, i8042_noacpi, bool, 0);
@@ -821,25 +825,29 @@
 }
 
 
-static int blink_frequency = 500;
-module_param_named(panicblink, blink_frequency, int, 0600);
-
-/* Catch the case when the kbd interrupt is off */
-#define DELAY do { mdelay(1); if (++delay > 10) return delay; } while(0)
-
-/* Tell the user who may be running in X and not see the console that we have
-   panic'ed. This is to distingush panics from "real" lockups.  */
+/*
+ * i8042_panic_blink() will flash the keyboard LEDs and is called when
+ * kernel panics. Flashing LEDs is useful for users running X who may
+ * not see the console and will help distingushing panics from "real"
+ * lockups.
+ */
 static long i8042_panic_blink(long count)
 {
 	long delay = 0;
 	static long last_blink;
 	static char led;
-	/* Roughly 1/2s frequency. KDB uses about 1s. Make sure it is
-	   different. */
-	if (!blink_frequency)
+
+	/*
+	 * We expect frequency to be about 1/2s. KDB uses about 1s.
+	 * Make sure they are different.
+	 */
+	if (!i8042_blink_frequency)
 		return 0;
-	if (count - last_blink < blink_frequency)
+	if (count - last_blink < i8042_blink_frequency)
 		return 0;
+
+	/* Ensures that we will not get stuck here if kbd interrupt is off */
+#define DELAY do { mdelay(1); if (++delay > 10) return delay; } while(0)
 	led ^= 0x01 | 0x04;
 	while (i8042_read_status() & I8042_STR_IBF)
 		DELAY;
@@ -850,11 +858,12 @@
 	DELAY;
 	i8042_write_data(led);
 	DELAY;
+#undef DELAY
+
 	last_blink = count;
 	return delay;
 }
 
-#undef DELAY
 
 /*
  * Here we try to restore the original BIOS settings
