Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270304AbUJUHio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270304AbUJUHio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270293AbUJUHi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:38:27 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:52891 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270401AbUJUHaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:14 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/7] Input: i8042 remove reboot notifier
Date: Thu, 21 Oct 2004 02:29:31 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210228.03038.dtor_core@ameritech.net> <200410210228.57067.dtor_core@ameritech.net>
In-Reply-To: <200410210228.57067.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210229.33358.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1969, 2004-10-20 00:53:53-05:00, dtor_core@ameritech.net
  Input: i8042 - get rid of reboot notifier as suspend method
         should do the job.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |   33 +++++----------------------------
 1 files changed, 5 insertions(+), 28 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-10-21 02:14:01 -05:00
+++ b/drivers/input/serio/i8042.c	2004-10-21 02:14:01 -05:00
@@ -16,10 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/config.h>
-#include <linux/reboot.h>
 #include <linux/init.h>
-#include <linux/sysdev.h>
-#include <linux/pm.h>
 #include <linux/serio.h>
 #include <linux/err.h>
 
@@ -825,27 +822,6 @@
 
 
 /*
- * We need to reset the 8042 back to original mode on system shutdown,
- * because otherwise BIOSes will be confused.
- */
-
-static int i8042_notify_sys(struct notifier_block *this, unsigned long code,
-        		    void *unused)
-{
-        if (code == SYS_DOWN || code == SYS_HALT)
-        	i8042_controller_cleanup();
-        return NOTIFY_DONE;
-}
-
-static struct notifier_block i8042_notifier =
-{
-        i8042_notify_sys,
-        NULL,
-        0
-};
-
-
-/*
  * Here we try to restore the original BIOS settings
  */
 
@@ -904,6 +880,11 @@
 
 }
 
+/*
+ * We need to reset the 8042 back to original mode on system shutdown,
+ * because otherwise BIOSes will be confused.
+ */
+
 static void i8042_shutdown(struct device *dev)
 {
 	i8042_controller_cleanup();
@@ -1031,16 +1012,12 @@
 
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
-	register_reboot_notifier(&i8042_notifier);
-
 	return 0;
 }
 
 void __exit i8042_exit(void)
 {
 	int i;
-
-	unregister_reboot_notifier(&i8042_notifier);
 
 	i8042_controller_cleanup();
 
