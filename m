Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTLAAUV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 19:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbTLAAUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 19:20:21 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:41721 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S262161AbTLAAUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 19:20:17 -0500
Date: Sun, 30 Nov 2003 19:18:23 -0500 (EST)
From: Mike Gorse <mgorse@mgorse.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: Oops w/sysfs when closing a disconnected usb serial device
Message-ID: <Pine.LNX.4.58.0311301900110.32493@mgorse.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.6.0-test11, I get a panic if I disconnect a USB serial device with
a fd open on it and then close the fd.  When the device is disconnected,
usb_disconnect calls usb_disable_device, which calls device_del, which
calls kobject_del, which removes the device's sysfs directory.  If a user
space program has the tts device open, then kobject_cleanup and
destroy_serial do not get called until the device is closed, but by then
the kobject_del call to the interface has caused the tty device's sysfs
directory to be nuked from under it.  Eventually sysfs_remove_dir is
called and eventually calls simple_rmdir with a dentry with a NULL
d_inode, causing an oops.  I can make the Oops go away with the following
patch:

--- fs/sysfs/dir.c.orig	2003-11-30 18:59:34.395284712 -0500
+++ fs/sysfs/dir.c	2003-11-30 18:59:50.944768808 -0500
@@ -83,7 +83,7 @@
 	struct dentry * parent = dget(d->d_parent);
 	down(&parent->d_inode->i_sem);
 	d_delete(d);
-	simple_rmdir(parent->d_inode,d);
+	if (d->d_inode) simple_rmdir(parent->d_inode,d);
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));

-- Michael Gorse / AIM:linvortex / http://mgorse.home.dhs.org --
