Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964896AbWHHOE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWHHOE6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHHOE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:04:58 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:16342 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932595AbWHHOE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:04:57 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: Suspend on Dell D420
Date: Tue, 8 Aug 2006 16:04:00 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>
References: <20060804162300.GA26148@uio.no> <200608051108.01180.rjw@sisk.pl> <20060806115043.GA30671@uio.no>
In-Reply-To: <20060806115043.GA30671@uio.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608081604.00665.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 August 2006 13:50, Steinar H. Gunderson wrote:
> On Sat, Aug 05, 2006 at 11:08:00AM +0200, Rafael J. Wysocki wrote:
> >> No idea whether it's related. FWIW, resume didn't work with maxcpus=1 on boot
> >> either, so I'm not really sure how related it is.
> > Hm, could you please try it with a non-SMP kernel?
> 
> Compiling straight 2.6.17 with CONFIG_SMP=n suspends and resumes just fine.

Sorry for the delay, there have been some problems with -rc3-mm2 recently.

Please apply the appended patch to the SMP kernel and try the following:

(1)
# echo testproc > /sys/power/disk
# echo disk > /sys/power/state

This should turn off the non-boot CPU, freeze all processes, wait for 5
seconds and thaw the processes and the CPU.

(2)
# echo test > /sys/power/disk
# echo disk > /sys/power/state

This should turn off the non-boot CPU, freeze all processes, shrink
memory, suspend all devices, wait for 5 seconds, resume the devices etc.
IOW it does everything that's needed for a suspend except for actually
suspending.

I think (1) will work and (2) will not, but let's see. :-)

Greetings,
Rafael


---
Add some tools for testing the suspend code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/pm.h  |    4 +++-
 kernel/power/disk.c |   35 +++++++++++++++++++++++++++--------
 2 files changed, 30 insertions(+), 9 deletions(-)

Index: linux-2.6.18-rc2-mm1/include/linux/pm.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/include/linux/pm.h	2006-07-28 08:36:24.000000000 +0200
+++ linux-2.6.18-rc2-mm1/include/linux/pm.h	2006-08-07 09:07:12.000000000 +0200
@@ -116,7 +116,9 @@ typedef int __bitwise suspend_disk_metho
 #define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
 #define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
 #define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
-#define	PM_DISK_MAX		((__force suspend_disk_method_t) 5)
+#define	PM_DISK_TEST		((__force suspend_disk_method_t) 5)
+#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
+#define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
Index: linux-2.6.18-rc2-mm1/kernel/power/disk.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/kernel/power/disk.c	2006-07-30 16:55:17.000000000 +0200
+++ linux-2.6.18-rc2-mm1/kernel/power/disk.c	2006-08-07 09:37:01.000000000 +0200
@@ -83,6 +83,12 @@ static int prepare_processes(void)
 		goto thaw;
 	}
 
+	if (pm_disk_mode == PM_DISK_TESTPROC) {
+		printk("swsusp debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		goto thaw;
+	}
+
 	/* Free memory before shutting down devices. */
 	if (!(error = swsusp_shrink_memory()))
 		return 0;
@@ -119,11 +125,19 @@ int pm_suspend_disk(void)
 	if (error)
 		return error;
 
+	if (pm_disk_mode == PM_DISK_TESTPROC)
+		goto Thaw;
+
 	error = device_suspend(PMSG_FREEZE);
 	if (error) {
 		printk("Some devices failed to suspend\n");
-		unprepare_processes();
-		return error;
+		goto Thaw;
+	}
+
+	if (pm_disk_mode == PM_DISK_TEST) {
+		printk("swsusp debug: Waiting for 5 seconds.\n");
+		mdelay(5000);
+		goto Done;
 	}
 
 	pr_debug("PM: snapshotting memory.\n");
@@ -139,15 +153,16 @@ int pm_suspend_disk(void)
 			power_down(pm_disk_mode);
 		else {
 			swsusp_free();
-			unprepare_processes();
-			return error;
+			goto Thaw;
 		}
-	} else
+	} else {
 		pr_debug("PM: Image restored successfully.\n");
+	}
 
 	swsusp_free();
  Done:
 	device_resume();
+ Thaw:
 	unprepare_processes();
 	return error;
 }
@@ -241,6 +256,8 @@ static const char * const pm_disk_modes[
 	[PM_DISK_PLATFORM]	= "platform",
 	[PM_DISK_SHUTDOWN]	= "shutdown",
 	[PM_DISK_REBOOT]	= "reboot",
+	[PM_DISK_TEST]		= "test",
+	[PM_DISK_TESTPROC]	= "testproc",
 };
 
 /**
@@ -295,17 +312,19 @@ static ssize_t disk_store(struct subsyst
 		}
 	}
 	if (mode) {
-		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT)
+		if (mode == PM_DISK_SHUTDOWN || mode == PM_DISK_REBOOT ||
+		     mode == PM_DISK_TEST || mode == PM_DISK_TESTPROC) {
 			pm_disk_mode = mode;
-		else {
+		} else {
 			if (pm_ops && pm_ops->enter &&
 			    (mode == pm_ops->pm_disk_mode))
 				pm_disk_mode = mode;
 			else
 				error = -EINVAL;
 		}
-	} else
+	} else {
 		error = -EINVAL;
+	}
 
 	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
 		 pm_disk_modes[mode]);
