Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTE1ARv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 20:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264459AbTE1ARv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 20:17:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5297 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264456AbTE1ARu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 20:17:50 -0400
Date: Wed, 28 May 2003 01:31:05 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] procfs bug exposed by cdev changes
Message-ID: <20030528003105.GD27916@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	fs/inode.c assumes that any ->delete_inode() will call clear_inode().
procfs instance doesn't.  It had passed unpunished for a while; cdev changes
combined with ALSA creating character devices in procfs made it fatal.

	Patch follows.  It had fixed ALSA-triggered memory corruption here -
what happens in vanilla 2.5.70 is that clear_inode() is not called when
procfs character device inodes are freed.  That leaves a freed inode on
a cyclic list, with obvious unpleasantness following when we try to traverse
it (e.g. when unregistering a device).

	Please, apply.  Folks who'd seen oopsen/memory corruption after
ALSA access - please, check if that fixes all problems.

--- C70/fs/proc/inode.c	Mon May 26 22:21:40 2003
+++ C70-current/fs/proc/inode.c	Tue May 27 20:07:01 2003
@@ -61,8 +61,6 @@
 	struct proc_dir_entry *de;
 	struct task_struct *tsk;
 
-	inode->i_state = I_CLEAR;
-
 	/* Let go of any associated process */
 	tsk = PROC_I(inode)->task;
 	if (tsk)
@@ -75,6 +73,7 @@
 			module_put(de->owner);
 		de_put(de);
 	}
+	clear_inode(inode);
 }
 
 struct vfsmount *proc_mnt;
