Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbVDBHFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVDBHFu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 02:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVDBHFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 02:05:50 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:3977 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261185AbVDBHFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 02:05:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=cqL/haNd+5euvVvr0KOSo94vzpNRQxAofyjrVdZnakh/v7Jr5XYkDMsmC75P2yfqBvxCH1e1pWQ+YHgaGeCTBZWDHkur6cnRRSq2S7LIK7NpzJvdijwi4oqoz92Idq0+zc3eSCGyayIiKln4M283sr/g8O+iNkL33FzXA6B9R4M=
Message-ID: <df35dfeb05040123054c4f4320@mail.gmail.com>
Date: Fri, 1 Apr 2005 23:05:04 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Cleanup locking in sys_reboot() (was Re: [PATCH] Reduce stack usage in sys.c)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <424BB4EA.6080506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <df35dfeb05033023445c386d2d@mail.gmail.com>
	 <424BB4EA.6080506@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 31, 2005 12:29 AM, Jeff Garzik <jgarzik@pobox.com> wrote:
> Your "cleanup lock usage" increases the number of lock_kernel() calls
> quite a bit, which is not really a cleanup but simply bloat.

Yes, just looking at the patch, seem to indicate so. But let's take a
closer look at the original code from a run time perspective :

346          lock_kernel();
347          switch (cmd) {
...
355          case LINUX_REBOOT_CMD_CAD_ON:
356                  C_A_D = 1;
357                  break;
....
421          unlock_kernel();
422          return 0;

Why the lock_kernel() and unlock_kernel()? This happens for another
case as follows:

346          lock_kernel();
347          switch (cmd) {
...
358          case LINUX_REBOOT_CMD_CAD_OFF:
359                  C_A_D = 0;
360                  break;
...
421          unlock_kernel();
422          return 0;

Should'nt we be keeping the lock_kernel() and unlock_kernel() calls to
a minimum?

Again something sloppy happening here:

346          lock_kernel();
347          switch (cmd) {
...
361          case LINUX_REBOOT_CMD_HALT:
362                  notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
...
376                  unlock_kernel();
377                  do_exit(0);
378                  break;
...
421          unlock_kernel();
422          return 0;

The previous author shows deligence in having the "break;" after
"do_exit(0)", but why "unlock_kernel()" twice in the same path? What
if down the road, someone changes do_exit() to do something else and
actually return ?

Same style above, shown for this case as well:

370          case LINUX_REBOOT_CMD_POWER_OFF:

Some other kind of mess:

410          case LINUX_REBOOT_CMD_SW_SUSPEND:
411                  {
412                          int ret = software_suspend();
413                          unlock_kernel();
414                          return ret;
415                  }
... << the switch...case ends at this line
421          unlock_kernel();
422          return 0;

Could'nt we just have a single "unlock_kernel()" above?

Some more:

417          default:
418                  unlock_kernel();
419                  return -EINVAL;
420          }
421          unlock_kernel();
422          return 0;

It would have been nice to have a single "unlock_kernel()" and single
point of exit. Also note that for "default" case, we are doing
lock_kernel() and unlock_kernel() for nothing?

And finally:
346          lock_kernel();
347          switch (cmd) {
...
379          case LINUX_REBOOT_CMD_RESTART2:
380                  if (strncpy_from_user(&buffer[0], arg,
sizeof(buffer) - 1) < 0) {
381                          unlock_kernel();
382                          return -EFAULT;
383                  }

Does the "strncpy_from_user()" really need a lock_kernel()?

My attempt to reduce the stack usage needed to kmalloc buffer and
buffer was being used for the above case (LINUX_REBOOT_CMD_RESTART2)
only. I did not think it was good to have lock_kernel() for the
kmalloc and the subsequent NULL checking of the returned pointer. So I
ended up driving the lock_kernel() and matching unlock_kernel() calls
deeper, IMHO a cleanup. In some cases the unlock_kernel() calls are
provided for sake of completeness, just like the "break;" statements.
You might count the number of "lock_kernel()" to increase in the code,
but actually the patch minimizes the run time calls to
"lock_kernel()".

I assume a call like sys_reboot() is no big deal, but feedback will
always help going forward. I dropped the pick at the stack usage, just
the patch to move the locks around... (cleanup?)

Thanks,
Rayan

Signed-off-by: Yum Rayan <yum.rayan@gmail.com>
--- linux-2.6.12-rc1-mm4.a/kernel/sys.c	2005-03-31 16:51:30.000000000 -0800
+++ linux-2.6.12-rc1-mm4.b/kernel/sys.c	2005-04-01 22:46:53.000000000 -0800
@@ -385,14 +385,15 @@
 	                magic2 != LINUX_REBOOT_MAGIC2C))
 		return -EINVAL;
 
-	lock_kernel();
 	switch (cmd) {
 	case LINUX_REBOOT_CMD_RESTART:
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, NULL);
 		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system.\n");
 		machine_restart(NULL);
+		unlock_kernel();
 		break;
 
 	case LINUX_REBOOT_CMD_CAD_ON:
@@ -404,6 +405,7 @@
 		break;
 
 	case LINUX_REBOOT_CMD_HALT:
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
 		system_state = SYSTEM_HALT;
 		device_shutdown();
@@ -414,6 +416,7 @@
 		break;
 
 	case LINUX_REBOOT_CMD_POWER_OFF:
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
 		system_state = SYSTEM_POWER_OFF;
 		device_shutdown();
@@ -425,22 +428,24 @@
 
 	case LINUX_REBOOT_CMD_RESTART2:
 		if (strncpy_from_user(&buffer[0], arg, sizeof(buffer) - 1) < 0) {
-			unlock_kernel();
 			return -EFAULT;
 		}
 		buffer[sizeof(buffer) - 1] = '\0';
 
+		lock_kernel();
 		notifier_call_chain(&reboot_notifier_list, SYS_RESTART, buffer);
 		system_state = SYSTEM_RESTART;
 		device_shutdown();
 		printk(KERN_EMERG "Restarting system with command '%s'.\n", buffer);
 		machine_restart(buffer);
+		unlock_kernel();
 		break;
 
 #ifdef CONFIG_KEXEC
 	case LINUX_REBOOT_CMD_KEXEC:
 	{
 		struct kimage *image;
+		lock_kernel();
 		image = xchg(&kexec_image, 0);
 		if (!image) {
 			unlock_kernel();
@@ -452,23 +457,24 @@
 		printk(KERN_EMERG "Starting new kernel\n");
 		machine_shutdown();
 		machine_kexec(image);
+		unlock_kernel();
 		break;
 	}
 #endif
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	case LINUX_REBOOT_CMD_SW_SUSPEND:
 		{
-			int ret = software_suspend();
+			int ret;
+			lock_kernel();
+			ret = software_suspend();
 			unlock_kernel();
 			return ret;
 		}
 #endif
 
 	default:
-		unlock_kernel();
 		return -EINVAL;
 	}
-	unlock_kernel();
 	return 0;
 }
