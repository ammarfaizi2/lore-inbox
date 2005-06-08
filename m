Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVFHDxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVFHDxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 23:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVFHDxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 23:53:03 -0400
Received: from smtp821.mail.sc5.yahoo.com ([66.163.171.7]:36025 "HELO
	smtp821.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262089AbVFHDwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 23:52:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Adam Morley <adam.morley@gmail.com>
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Date: Tue, 7 Jun 2005 22:52:39 -0500
User-Agent: KMail/1.8.1
References: <b70d73800506051924546c8931@mail.gmail.com> <200506060125.00489.dtor_core@ameritech.net> <b70d7380050606002834116fea@mail.gmail.com>
In-Reply-To: <b70d7380050606002834116fea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506072252.40120.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 June 2005 02:28, Adam Morley wrote:
> Hi Dimitry,
> 
> On 6/5/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Sunday 05 June 2005 21:24, Adam Morley wrote:
> >  > When I do a mem suspend (echo mem > /sys/power/state), either through
> > > a lid switch ACPI action, or manually echo'ing the parameter, the
> > > mouse doesn't work after un-suspending.  It seems like it is no longer
> > > detected/initialized.  cat'ing the device file doesn't produce output,
> > > and gpm and X don't get mouse inputs.
> > 
> > Could you please try booting 2.6.12-rc5 with "i8042.debug" on the kernel
> > command line; suspend, resume and post your dmesg?
> 
> Sure.  Here it is.  Suspend was done using acpid using a lid action. 
> psmouse was modprobe -r'ed before suspend and modprobe'ed back in
> after resume.
>

We are trying to resume but KBC signals timeout condition every time we
ping AUX port:

> drivers/input/serio/i8042.c: 60 -> i8042 (command) [220701]
> drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220701]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [220703]
> drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220703]
> drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [220725]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [220726]
> drivers/input/serio/i8042.c: ed -> i8042 (parameter) [220726]
> drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [220747]
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [220748]
> drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [220748]
> drivers/input/serio/i8042.c: 60 -> i8042 (command) [220943]
> drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220943]
> drivers/input/serio/i8042.c: d4 -> i8042 (command) [220943]
> drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220943]
> drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [220965]

Could you please try the patch below?

-- 
Dmitry

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
 
