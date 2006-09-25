Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWIYHPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWIYHPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 03:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWIYHPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 03:15:03 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53658 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751002AbWIYHPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 03:15:01 -0400
Date: Mon, 25 Sep 2006 09:13:38 +0200
From: Stefan Seyfried <seife@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Pavel Machek <pavel@suse.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode")
Message-ID: <20060925071338.GD9869@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-rc6-2-seife
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Seyfried <seife@suse.de>

Add an ioctl to the userspace swsusp code that enables the usage of the
pmops->prepare, pmops->enter and pmops->finish methods (the in-kernel
suspend knows these as "platform method"). These are needed on many machines
to (among others) speed up resuming by letting the BIOS skip some steps or
let my hp nx5000 recognise the correct ac_adapter state after resume again.

Signed-off-by: Stefan Seyfried <seife@suse.de>

---
Patch is against 2.6.18. AFAIK little has changed in this area recently, so
it should still apply. I have two machines that are pretty broken without it,
so it is rather urgent for me :-)
Please apply.

diff -rup a/kernel/power/power.h b/kernel/power/power.h
--- a/kernel/power/power.h	2006-09-20 05:42:06.000000000 +0200
+++ b/kernel/power/power.h	2006-09-25 08:42:46.000000000 +0200
@@ -78,7 +78,12 @@ int snapshot_image_loaded(struct snapsho
 #define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
 #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
 #define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
-#define SNAPSHOT_IOC_MAXNR	11
+#define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
+#define SNAPSHOT_IOC_MAXNR	12
+
+#define PMOPS_PREPARE	1
+#define PMOPS_ENTER	2
+#define PMOPS_FINISH	3
 
 /**
  *	The bitmap is used for tracing allocated swap pages
diff -rup a/kernel/power/user.c b/kernel/power/user.c
--- a/kernel/power/user.c	2006-09-20 05:42:06.000000000 +0200
+++ b/kernel/power/user.c	2006-09-12 18:45:34.000000000 +0200
@@ -11,6 +11,7 @@
 
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
+#include <linux/reboot.h>
 #include <linux/string.h>
 #include <linux/device.h>
 #include <linux/miscdevice.h>
@@ -302,6 +303,33 @@ OutS3:
 		up(&pm_sem);
 		break;
 
+	case SNAPSHOT_PMOPS:
+		switch (arg) {
+
+		case PMOPS_PREPARE:
+			if (pm_ops->prepare) {
+				error = pm_ops->prepare(PM_SUSPEND_DISK);
+			}
+			break;
+
+		case PMOPS_ENTER:
+			kernel_shutdown_prepare(SYSTEM_SUSPEND_DISK);
+			error = pm_ops->enter(PM_SUSPEND_DISK);
+			break;
+
+		case PMOPS_FINISH:
+			if (pm_ops && pm_ops->finish) {
+				pm_ops->finish(PM_SUSPEND_DISK);
+			}
+			break;
+
+		default:
+			printk(KERN_ERR "SNAPSHOT_PMOPS: invalid argument %ld\n", arg);
+			error = -EINVAL;
+
+		}
+		break;
+
 	default:
 		error = -ENOTTY;
 
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
