Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266089AbTLaBqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbTLaBp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:45:59 -0500
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:9644 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266089AbTLaBps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:45:48 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Date: Tue, 30 Dec 2003 20:45:35 -0500
User-Agent: KMail/1.5.4
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031230195303.F13556@flint.arm.linux.org.uk> <20031230230028.GA778@ucw.cz>
In-Reply-To: <20031230230028.GA778@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312302045.38501.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 December 2003 06:00 pm, Vojtech Pavlik wrote:
> On Tue, Dec 30, 2003 at 07:53:03PM +0000, Russell King wrote:
> > So it looks like i8042 could do with hooking some power management
> > to disable this timer before suspend and resume it afterwards.
> >
> > Vojtech?
>
> Agreed. There should already be some in -mm kernels, and I'll make sure
> the timer is deleted before suspend. Thanks for finding this.

What about something like the patch below? (Now, I don't suspend my notebook
so it has not been tested, just compiled.)

Dmitry

===================================================================


ChangeSet@1.1518, 2003-12-30 20:37:33-05:00, dtor_core@ameritech.net
  Input: Add suspend methods to restore original controller state
         on suspend as  some BIOS don't like the state we leave
         it in
         Also do not require extra i8042. prefix on module parameters
         if i8042 is compiled into the kernel


 i8042.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 60 insertions(+), 22 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Tue Dec 30 20:41:57 2003
+++ b/drivers/input/serio/i8042.c	Tue Dec 30 20:41:57 2003
@@ -28,6 +28,12 @@
 MODULE_DESCRIPTION("i8042 keyboard and mouse controller driver");
 MODULE_LICENSE("GPL");
 
+/*
+ * Do not add extra 'i8042.' prefix to all parameters if compiled into the kernel
+ */
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX /* empty */
+
 static unsigned int i8042_noaux;
 module_param(i8042_noaux, bool, 0);
 
@@ -746,6 +752,29 @@
 
 
 /*
+ * Reset the controller.
+ */
+void i8042_controller_reset(void)
+{
+	if (i8042_reset) {
+		unsigned char param;
+
+		if (i8042_command(&param, I8042_CMD_CTL_TEST))
+			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
+	}
+
+/*
+ * Restore the original control register setting.
+ */
+
+	i8042_ctr = i8042_initial_ctr;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
+		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
+}
+
+
+/*
  * Here we try to reset everything back to a state in which the BIOS will be
  * able to talk to the hardware when rebooting.
  */
@@ -770,26 +799,20 @@
 		if (i8042_mux_values[i].exists)
 			serio_cleanup(i8042_mux_port + i);
 
-/*
- * Reset the controller.
- */
-
-	if (i8042_reset) {
-		unsigned char param;
+	i8042_controller_reset();
+}
 
-		if (i8042_command(&param, I8042_CMD_CTL_TEST))
-			printk(KERN_ERR "i8042.c: i8042 controller reset timeout.\n");
-	}
 
 /*
- * Restore the original control register setting.
+ * Here we try to restore to the original BIOS settings
  */
 
-	i8042_ctr = i8042_initial_ctr;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
-		printk(KERN_WARNING "i8042.c: Can't restore CTR.\n");
+static int i8042_controller_suspend(void)
+{
+	del_timer_sync(&i8042_timer);
+	i8042_controller_reset();
 
+	return 0;
 }
 
 
@@ -809,7 +832,7 @@
 	if (i8042_mux_present)
 		if (i8042_enable_mux_mode(&i8042_aux_values, NULL) ||
 		    i8042_enable_mux_ports(&i8042_aux_values)) {
-			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't wotk.\n");
+			printk(KERN_WARNING "i8042: failed to resume active multiplexor, mouse won't work.\n");
 		}
 
 /*
@@ -825,6 +848,10 @@
 	for (i = 0; i < 4; i++)
 		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
 			serio_reconnect(i8042_mux_port + i);
+/*
+ * Restart timer (for autorepeats)
+ */ 
+	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
 	return 0;
 }
@@ -851,16 +878,22 @@
 };
 
 /*
- * Resume handler for the new PM scheme (driver model)
+ * Suspend/resume handlers for the new PM scheme (driver model)
  */
+static int i8042_suspend(struct sys_device *dev, u32 state)
+{
+	return i8042_controller_suspend();
+}
+
 static int i8042_resume(struct sys_device *dev)
 {
 	return i8042_controller_resume();
 }
 
 static struct sysdev_class kbc_sysclass = {
-       set_kset_name("i8042"),
-       .resume = i8042_resume,
+	set_kset_name("i8042"),
+	.suspend = i8042_suspend,
+	.resume = i8042_resume,
 };
 
 static struct sys_device device_i8042 = {
@@ -869,12 +902,17 @@
 };
 
 /*
- * Resume handler for the old PM scheme (APM)
+ * Suspend/resume handler for the old PM scheme (APM)
  */
 static int i8042_pm_callback(struct pm_dev *dev, pm_request_t request, void *dummy)
 {
-	if (request == PM_RESUME)
-		return i8042_controller_resume();
+	switch (request) {
+		case PM_SUSPEND:
+			return i8042_controller_suspend();
+
+		case PM_RESUME:
+			return i8042_controller_resume();
+	}
 
 	return 0;
 }
@@ -955,7 +993,7 @@
 		sysdev_class_unregister(&kbc_sysclass);
 	}
 
-	del_timer(&i8042_timer);
+	del_timer_sync(&i8042_timer);
 
 	i8042_controller_cleanup();
 	
