Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWCRQFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWCRQFy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWCRQFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:05:54 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:16347 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932125AbWCRQFy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:05:54 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: -mm: PM=y, VT=n doesn't compile
Date: Sat, 18 Mar 2006 17:04:44 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@suse.cz>,
       linux-kernel@vger.kernel.org
References: <20060317171814.GO3914@stusta.de>
In-Reply-To: <20060317171814.GO3914@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603181704.44873.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 17 March 2006 18:18, Adrian Bunk wrote:
> swsusp-pm-refuse-to-suspend-devices-if-wrong-console-is-active.patch
> causes the following compile error with CONFIG_PM=y, CONFIG_VT=n:
> 
> <--  snip  -->
> 
> ...
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `device_suspend': undefined reference to `fg_console'
> drivers/built-in.o: In function `device_suspend': undefined reference to `vc_cons'
> make: *** [.tmp_vmlinux1] Error 1
> 
> <--  snip  -->

Sorry, I overlooked your message yesterday.  [Actually Andrew turned my
attention to it by dropping the patch from -mm. ;-)]

Fixed version of the patch is appended.

Greetings,
Rafael

---
From: "Rafael J. Wysocki" <rjw@sisk.pl>

1) Remove the console-switching code from the suspend part of the swsusp
   userland interface and let the userland tools switch the console.

2) It is unsafe to suspend devices if the hardware is controlled by X. 
   Add an extra check to prevent this from happening.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/suspend.c |   17 +++++++++++++++++
 kernel/power/user.c          |    3 ---
 2 files changed, 17 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/drivers/base/power/suspend.c
+++ linux-2.6.16-rc6-mm2/drivers/base/power/suspend.c
@@ -8,6 +8,9 @@
  *
  */
 
+#include <linux/vt_kern.h>
+#include <linux/kbd_kern.h>
+#include <linux/console.h>
 #include <linux/device.h>
 #include <linux/kallsyms.h>
 #include <linux/pm.h>
@@ -65,6 +68,17 @@ int suspend_device(struct device * dev, 
 	return error;
 }
 
+#ifdef CONFIG_VT
+static inline int is_suspend_console_safe(void)
+{
+	/* It is unsafe to suspend devices while X has control of the
+	 * hardware. Make sure we are running on a kernel-controlled console.
+	 */
+	return vc_cons[fg_console].d->vc_mode == KD_TEXT;
+}
+#else
+#define is_suspend_console_safe()	1
+#endif
 
 /**
  *	device_suspend - Save state and stop all devices in system.
@@ -85,6 +99,9 @@ int device_suspend(pm_message_t state)
 {
 	int error = 0;
 
+	if (!is_suspend_console_safe())
+		return -EINVAL;
+
 	down(&dpm_sem);
 	down(&dpm_list_sem);
 	while (!list_empty(&dpm_active) && error == 0) {
Index: linux-2.6.16-rc6-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/user.c
+++ linux-2.6.16-rc6-mm2/kernel/power/user.c
@@ -138,12 +138,10 @@ static int snapshot_ioctl(struct inode *
 		if (data->frozen)
 			break;
 		down(&pm_sem);
-		pm_prepare_console();
 		disable_nonboot_cpus();
 		if (freeze_processes()) {
 			thaw_processes();
 			enable_nonboot_cpus();
-			pm_restore_console();
 			error = -EBUSY;
 		}
 		up(&pm_sem);
@@ -157,7 +155,6 @@ static int snapshot_ioctl(struct inode *
 		down(&pm_sem);
 		thaw_processes();
 		enable_nonboot_cpus();
-		pm_restore_console();
 		up(&pm_sem);
 		data->frozen = 0;
 		break;
