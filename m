Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264830AbTLWAbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264829AbTLWA3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:29:52 -0500
Received: from mail.kroah.org ([65.200.24.183]:32941 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264830AbTLWA3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:29:23 -0500
Date: Mon, 22 Dec 2003 16:24:39 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] fix sysfs oops  [1/4]
Message-ID: <20031223002439.GB4805@kroah.com>
References: <20031223002126.GA4805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223002126.GA4805@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes an oops when a kobject is unregistered before it's child is.
The usb-serial devices show this bug very easily (yank out a device
while its port is opened...)

Patch was originally written by Mike Gorse <mgorse@mgorse.dhs.org>


diff -Nru a/fs/sysfs/dir.c b/fs/sysfs/dir.c
--- a/fs/sysfs/dir.c	Mon Dec 22 16:02:07 2003
+++ b/fs/sysfs/dir.c	Mon Dec 22 16:02:07 2003
@@ -83,7 +83,8 @@
 	struct dentry * parent = dget(d->d_parent);
 	down(&parent->d_inode->i_sem);
 	d_delete(d);
-	simple_rmdir(parent->d_inode,d);
+	if (d->d_inode)
+		simple_rmdir(parent->d_inode,d);
 
 	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
 		 atomic_read(&d->d_count));
