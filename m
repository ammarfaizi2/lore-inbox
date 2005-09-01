Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbVIARBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVIARBw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 13:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVIARBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 13:01:52 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16577 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030244AbVIARBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 13:01:52 -0400
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: ncunningham@cyclades.com, Pavel Machek <pavel@ucw.cz>,
       Meelis Roos <mroos@linux.ee>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: reboot vs poweroff
References: <20050901062406.EBA5613D5B@rhn.tartu-labor>
	<1125557333.12996.76.camel@localhost>
	<Pine.SOC.4.61.0509011030430.3232@math.ut.ee>
	<4316F4E3.4030302@drzeus.cx> <1125578897.4785.23.camel@localhost>
	<m1fysoq0p7.fsf@ebiederm.dsl.xmission.com> <43171C02.30402@drzeus.cx>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 01 Sep 2005 11:00:44 -0600
In-Reply-To: <43171C02.30402@drzeus.cx> (Pierre Ossman's message of "Thu, 01
 Sep 2005 17:19:30 +0200")
Message-ID: <m1aciwpvsz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman <drzeus-list@drzeus.cx> writes:

> Eric W. Biederman wrote:
>
>>Hmm.  Looking at that bug report it specifies 2.6.11.  Does this
>>problem really happen in 2.6.13?
>>
>>  
>>
>
> I first noticed it in 2.6.11. It was fixed sometime during 2.6.13-rc
> only to be killed of again in 2.6.13-rc7. The bugzilla now has a patch
> for 2.6.13 which fixes the problem again.

Thanks.

This is clearly a code path I missed when I was fixing things.

When I made the final acpi change I checked for any other users
of device_suspend and it seems I was blind and missed this one.
Looking again...

The patch in the bug report looks correct.  However it is still
a little incomplete.  In particular the reboot notifier is not
being called, and since not everything has been converted into
using shutdown methods that could lead to some other inconsistent
behavior.

Does anyone have any problems with the patch below?
If not I will send this off to Linus..

Eric


---

 include/linux/reboot.h |    1 +
 kernel/power/disk.c    |    7 ++-----
 kernel/sys.c           |   10 ++++++++++
 3 files changed, 13 insertions(+), 5 deletions(-)

6afa3b66c6b3b135442886b80913e80f10ae886d
diff --git a/include/linux/reboot.h b/include/linux/reboot.h
--- a/include/linux/reboot.h
+++ b/include/linux/reboot.h
@@ -63,6 +63,7 @@ extern void kernel_restart(char *cmd);
 extern void kernel_halt(void);
 extern void kernel_power_off(void);
 extern void kernel_kexec(void);
+extern int kernel_suspend(void);
 
 /*
  * Emergency restart, callable from an interrupt handler.
diff --git a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c
+++ b/kernel/power/disk.c
@@ -17,12 +17,12 @@
 #include <linux/delay.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
+#include <linux/pm.h>
 
 #include "power.h"
 
 
 extern suspend_disk_method_t pm_disk_mode;
-extern struct pm_ops * pm_ops;
 
 extern int swsusp_suspend(void);
 extern int swsusp_write(void);
@@ -49,14 +49,11 @@ dev_t swsusp_resume_device;
 
 static void power_down(suspend_disk_method_t mode)
 {
-	unsigned long flags;
 	int error = 0;
 
-	local_irq_save(flags);
 	switch(mode) {
 	case PM_DISK_PLATFORM:
- 		device_shutdown();
-		error = pm_ops->enter(PM_SUSPEND_DISK);
+		error = kernel_suspend();
 		break;
 	case PM_DISK_SHUTDOWN:
 		kernel_power_off();
diff --git a/kernel/sys.c b/kernel/sys.c
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -28,6 +28,7 @@
 #include <linux/suspend.h>
 #include <linux/tty.h>
 #include <linux/signal.h>
+#include <linux/pm.h>
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
@@ -420,6 +421,15 @@ void kernel_power_off(void)
 }
 EXPORT_SYMBOL_GPL(kernel_power_off);
 
+int kernel_suspend(void)
+{
+	notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
+	system_state = SYSTEM_POWER_OFF;
+	device_shutdown();
+	return pm_ops->enter(PM_SUSPEND_DISK);
+}
+EXPORT_SYMBOL_GPL(kernel_suspend);
+
 /*
  * Reboot system call: for obvious reasons only root may call it,
  * and even root needs to set up some magic numbers in the registers

