Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWAVRTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWAVRTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 12:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWAVRTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 12:19:11 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:44729 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932271AbWAVRTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 12:19:10 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: fix possible lockup in user interface
Date: Sun, 22 Jan 2006 18:20:15 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601221820.15694.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The appended patch fixes possible system lockup that may result from
calling pm_prepare_console() after processes has been frozen.

Please apply.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/user.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc1-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/kernel/power/user.c	2006-01-21 23:42:32.000000000 +0100
+++ linux-2.6.16-rc1-mm2/kernel/power/user.c	2006-01-22 17:49:07.000000000 +0100
@@ -141,9 +141,14 @@ static int snapshot_ioctl(struct inode *
 			break;
 		sys_sync();
 		down(&pm_sem);
+		pm_prepare_console();
 		disable_nonboot_cpus();
-		if (freeze_processes())
+		if (freeze_processes()) {
+			thaw_processes();
+			enable_nonboot_cpus();
+			pm_restore_console();
 			error = -EBUSY;
+		}
 		up(&pm_sem);
 		if (!error)
 			data->frozen = 1;
@@ -155,6 +160,7 @@ static int snapshot_ioctl(struct inode *
 		down(&pm_sem);
 		thaw_processes();
 		enable_nonboot_cpus();
+		pm_restore_console();
 		up(&pm_sem);
 		data->frozen = 0;
 		break;
@@ -165,7 +171,6 @@ static int snapshot_ioctl(struct inode *
 			break;
 		}
 		down(&pm_sem);
-		pm_prepare_console();
 		/* Free memory before shutting down devices. */
 		error = swsusp_shrink_memory();
 		if (!error) {
@@ -176,7 +181,6 @@ static int snapshot_ioctl(struct inode *
 				device_resume();
 			}
 		}
-		pm_restore_console();
 		up(&pm_sem);
 		if (!error)
 			error = put_user(in_suspend, (unsigned int __user *)arg);
