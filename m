Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVE2FDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVE2FDV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVE2FCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:02:15 -0400
Received: from smtp836.mail.sc5.yahoo.com ([66.163.171.23]:47450 "HELO
	smtp836.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261242AbVE2FBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:09 -0400
Message-Id: <20050529045847.141124000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:18 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 05/13] i8042: dont read CTR when resuming
Content-Disposition: inline; filename=i8042-dont-read-ctr-when-resuming.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: Only write the CTR in i8042 resume function. Reading it is
       wrong, since it may (will) contain nonsensical data.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |   48 +++++++++++++++++++++++++-------------------
 1 files changed, 28 insertions(+), 20 deletions(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -698,6 +698,26 @@ static void i8042_timer_func(unsigned lo
 	i8042_interrupt(0, NULL, NULL);
 }
 
+static int i8042_ctl_test(void)
+{
+	unsigned char param;
+
+	if (!i8042_reset)
+		return 0;
+
+	if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
+		printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
+		return -1;
+	}
+
+	if (param != I8042_RET_CTL_TEST) {
+		printk(KERN_ERR "i8042.c: i8042 controller selftest failed. (%#x != %#x)\n",
+			 param, I8042_RET_CTL_TEST);
+		return -1;
+	}
+
+	return 0;
+}
 
 /*
  * i8042_controller init initializes the i8042 controller, and,
@@ -719,21 +739,8 @@ static int i8042_controller_init(void)
 		return -1;
 	}
 
-	if (i8042_reset) {
-
-		unsigned char param;
-
-		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
-			printk(KERN_ERR "i8042.c: i8042 controller self test timeout.\n");
-			return -1;
-		}
-
-		if (param != I8042_RET_CTL_TEST) {
-			printk(KERN_ERR "i8042.c: i8042 controller selftest failed. (%#x != %#x)\n",
-				 param, I8042_RET_CTL_TEST);
-			return -1;
-		}
-	}
+	if (i8042_ctl_test())
+		return -1;
 
 /*
  * Save the CTR for restoral on unload / reboot.
@@ -806,9 +813,7 @@ static void i8042_controller_reset(void)
  * Reset the controller if requested.
  */
 
-	if (i8042_reset)
-		if (i8042_command(&param, I8042_CMD_CTL_TEST))
-			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
+	i8042_ctl_test();
 
 /*
  * Disable MUX mode if present.
@@ -920,8 +925,11 @@ static int i8042_resume(struct device *d
 	if (level != RESUME_ENABLE)
 		return 0;
 
-	if (i8042_controller_init()) {
-		printk(KERN_ERR "i8042: resume failed\n");
+	if (i8042_ctl_test())
+		return -1;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		printk(KERN_ERR "i8042: Can't write CTR\n");
 		return -1;
 	}
 

