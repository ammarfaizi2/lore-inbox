Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265932AbUACJHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 04:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbUACJFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 04:05:48 -0500
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:41873 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265939AbUACJEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 04:04:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 4/7] atkbd option parsing
Date: Sat, 3 Jan 2004 04:01:34 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200401030350.43437.dtor_core@ameritech.net> <200401030357.44852.dtor_core@ameritech.net> <200401030400.55755.dtor_core@ameritech.net>
In-Reply-To: <200401030400.55755.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401030401.35798.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1574, 2004-01-03 02:45:27-05:00, dtor_core@ameritech.net
  Input: converted atkbd to the new style of option parsing.
         If compiled as a module new option names are:
         set, softrepeat, reset.
         If built into the kernel options must be prepended
         with "atkbd." prefix, like "atkbd.softrepeat"


 Documentation/kernel-parameters.txt |    7 +++---
 drivers/input/keyboard/atkbd.c      |   40 ++++++++----------------------------
 2 files changed, 13 insertions(+), 34 deletions(-)


===================================================================



diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Sat Jan  3 03:09:00 2004
+++ b/Documentation/kernel-parameters.txt	Sat Jan  3 03:09:00 2004
@@ -153,10 +153,11 @@
 
 	atascsi=	[HW,SCSI] Atari SCSI
 
-	atkbd_set=	[HW] Select keyboard code set
+	atkbd.set=	[HW] Select keyboard code set
 			Format: <int>
-
-	atkbd_reset	[HW] Reset keyboard during initialization
+	atkbd.softrepeat=
+			[HW] Use software keyboard repeat
+	atkbd.reset=	[HW] Reset keyboard during initialization
 
 	autotest	[IA64]
 
diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Sat Jan  3 03:09:00 2004
+++ b/drivers/input/keyboard/atkbd.c	Sat Jan  3 03:09:00 2004
@@ -19,6 +19,7 @@
 
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -29,18 +30,23 @@
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
-MODULE_PARM(atkbd_set, "1i");
-MODULE_PARM(atkbd_reset, "1i");
-MODULE_PARM(atkbd_softrepeat, "1i");
 MODULE_LICENSE("GPL");
 
 static int atkbd_set = 2;
+module_param_named(set, atkbd_set, int, 0);
+MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3, 4)");
+
 #if defined(__i386__) || defined (__x86_64__)
 static int atkbd_reset;
 #else
 static int atkbd_reset = 1;
 #endif
+module_param_named(reset, atkbd_reset, bool, 0);
+MODULE_PARM_DESC(reset, "Reset keyboard during initialization");
+
 static int atkbd_softrepeat;
+module_param_named(softrepeat, atkbd_softrepeat, bool, 0);
+MODULE_PARM_DESC(softrepeat, "Use software keyboard repeat");
 
 /*
  * Scancode to keycode tables. These are just the default setting, and
@@ -759,34 +765,6 @@
 	.disconnect =	atkbd_disconnect,
 	.cleanup =	atkbd_cleanup,
 };
-
-#ifndef MODULE
-static int __init atkbd_setup_set(char *str)
-{
-        int ints[4];
-        str = get_options(str, ARRAY_SIZE(ints), ints);
-        if (ints[0] > 0) atkbd_set = ints[1];
-        return 1;
-}
-static int __init atkbd_setup_reset(char *str)
-{
-        int ints[4];
-        str = get_options(str, ARRAY_SIZE(ints), ints);
-        if (ints[0] > 0) atkbd_reset = ints[1];
-        return 1;
-}
-static int __init atkbd_setup_softrepeat(char *str)
-{
-        int ints[4];
-        str = get_options(str, ARRAY_SIZE(ints), ints);
-        if (ints[0] > 0) atkbd_softrepeat = ints[1];
-        return 1;
-}
-
-__setup("atkbd_set=", atkbd_setup_set);
-__setup("atkbd_reset", atkbd_setup_reset);
-__setup("atkbd_softrepeat=", atkbd_setup_softrepeat);
-#endif
 
 int __init atkbd_init(void)
 {
