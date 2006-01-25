Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbWAYWkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWAYWkm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 17:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWAYWk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 17:40:27 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:35535 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932197AbWAYWk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 17:40:26 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: userland interface fixes
Date: Wed, 25 Jan 2006 23:41:36 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601252341.37361.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch contains some minor fixes of the swsusp userland interface:
1) use atomic_add_unless() instead of atomic_dec_and_test()/atomic_inc(),
2) remove a (unnecessary) memory barrier,
3) drop (unnecessary) access_ok() (actually the page will get released when
	the device is closed, so we don't need to worry if put_user() fails).

Please consider for applying.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/user.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

Index: linux-2.6.16-rc1-mm3/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc1-mm3.orig/kernel/power/user.c	2006-01-25 21:21:13.000000000 +0100
+++ linux-2.6.16-rc1-mm3/kernel/power/user.c	2006-01-25 21:53:52.000000000 +0100
@@ -40,10 +40,8 @@ static int snapshot_open(struct inode *i
 {
 	struct snapshot_data *data;
 
-	if (!atomic_dec_and_test(&device_available)) {
-		atomic_inc(&device_available);
+	if (!atomic_add_unless(&device_available, -1, 0))
 		return -EBUSY;
-	}
 
 	if ((filp->f_flags & O_ACCMODE) == O_RDWR)
 		return -ENOSYS;
@@ -198,7 +196,6 @@ static int snapshot_ioctl(struct inode *
 		pm_prepare_console();
 		error = device_suspend(PMSG_FREEZE);
 		if (!error) {
-			mb();
 			error = swsusp_resume();
 			device_resume();
 		}
@@ -223,10 +220,6 @@ static int snapshot_ioctl(struct inode *
 		break;
 
 	case SNAPSHOT_GET_SWAP_PAGE:
-		if (!access_ok(VERIFY_WRITE, (unsigned long __user *)arg, _IOC_SIZE(cmd))) {
-			error = -EINVAL;
-			break;
-		}
 		if (data->swap < 0 || data->swap >= MAX_SWAPFILES) {
 			error = -ENODEV;
 			break;
@@ -241,7 +234,7 @@ static int snapshot_ioctl(struct inode *
 		offset = alloc_swap_page(data->swap, data->bitmap);
 		if (offset) {
 			offset <<= PAGE_SHIFT;
-			__put_user(offset, (loff_t __user *)arg);
+			error = put_user(offset, (loff_t __user *)arg);
 		} else {
 			error = -ENOSPC;
 		}

