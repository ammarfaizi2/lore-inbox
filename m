Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932070AbWCSLVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWCSLVL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 06:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWCSLUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 06:20:49 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:45022 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932070AbWCSLUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 06:20:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 3/3] swsusp: add s2ram ioctl to userland interface
Date: Sun, 19 Mar 2006 12:16:22 +0100
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200603191158.26275.rjw@sisk.pl>
In-Reply-To: <200603191158.26275.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603191216.23428.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Tettamanti <kronos.it@gmail.com>

Add the SNAPSHOT_S2RAM ioctl to the snapshot device.

This ioctl allows a userland application to make the system (previously
frozen with the SNAPSHOT_FREE ioctl) enter the S3 state without freezing
processes and disabling nonboot CPUs for the second time.

This will allow us to implement the suspend-to-disk-and-RAM (STDR)
functionality in the userland suspend tools.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/main.c  |    2 +-
 kernel/power/power.h |    4 +++-
 kernel/power/user.c  |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc6-mm2/kernel/power/main.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/main.c
+++ linux-2.6.16-rc6-mm2/kernel/power/main.c
@@ -103,7 +103,7 @@ static int suspend_prepare(suspend_state
 }
 
 
-static int suspend_enter(suspend_state_t state)
+int suspend_enter(suspend_state_t state)
 {
 	int error = 0;
 	unsigned long flags;
Index: linux-2.6.16-rc6-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/power.h
+++ linux-2.6.16-rc6-mm2/kernel/power/power.h
@@ -77,7 +77,8 @@ int snapshot_image_loaded(struct snapsho
 #define SNAPSHOT_GET_SWAP_PAGE		_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
 #define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
 #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
-#define SNAPSHOT_IOC_MAXNR	10
+#define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
+#define SNAPSHOT_IOC_MAXNR	11
 
 /**
  *	The bitmap is used for tracing allocated swap pages
@@ -112,3 +113,4 @@ extern int swsusp_resume(void);
 extern int swsusp_read(void);
 extern int swsusp_write(void);
 extern void swsusp_close(void);
+extern int suspend_enter(suspend_state_t state);
Index: linux-2.6.16-rc6-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc6-mm2.orig/kernel/power/user.c
+++ linux-2.6.16-rc6-mm2/kernel/power/user.c
@@ -265,6 +265,42 @@ static int snapshot_ioctl(struct inode *
 		}
 		break;
 
+	case SNAPSHOT_S2RAM:
+		if (!data->frozen) {
+			error = -EPERM;
+			break;
+		}
+
+		if (down_trylock(&pm_sem)) {
+			error = -EBUSY;
+			break;
+		}
+
+		if (pm_ops->prepare) {
+			error = pm_ops->prepare(PM_SUSPEND_MEM);
+			if (error)
+				goto OutS3;
+		}
+
+		/* Put devices to sleep */
+		error = device_suspend(PMSG_SUSPEND);
+		if (error) {
+			printk(KERN_ERR "Failed to suspend some devices.\n");
+		} else {
+			/* Enter S3, system is already frozen */
+			suspend_enter(PM_SUSPEND_MEM);
+
+			/* Wake up devices */
+			device_resume();
+		}
+
+		if (pm_ops->finish)
+			pm_ops->finish(PM_SUSPEND_MEM);
+
+OutS3:
+		up(&pm_sem);
+		break;
+
 	default:
 		error = -ENOTTY;
 
