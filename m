Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUFVSLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUFVSLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265047AbUFVSKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:10:45 -0400
Received: from mail.kroah.org ([65.200.24.183]:27061 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265049AbUFVRnQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:16 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261122006@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:52 -0700
Message-Id: <10879261122143@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.111.25, 2004/06/11 17:22:53-07:00, linux@kodeaffe.de

[PATCH] sysfs: fs/sysfs/inode.c: modify parents ctime and mtime on creation

When a node is added to sysfs (e.g. a device plugged in via USB), the
filesystem fails to make this change visible in the parent directory's
ctime/mtime. This is in contrast to removing a device, because in that
case, sysfs makes use of the function simple_unlink from fs/libfs.c which
takes care of that. Instead of using simple_link from fs/libfs.c on
creation, sysfs implements its own mechanism. This patch hooks into the
function sysfs_create and sets the ctime and the mtime of the parent to
CURRENT_TIME.

Signed-off-by: Sebastian Henschel <linux@kodeaffe.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/inode.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)


diff -Nru a/fs/sysfs/inode.c b/fs/sysfs/inode.c
--- a/fs/sysfs/inode.c	Tue Jun 22 09:46:53 2004
+++ b/fs/sysfs/inode.c	Tue Jun 22 09:46:53 2004
@@ -46,8 +46,13 @@
 	struct inode * inode = NULL;
 	if (dentry) {
 		if (!dentry->d_inode) {
-			if ((inode = sysfs_new_inode(mode)))
+			if ((inode = sysfs_new_inode(mode))) {
+				if (dentry->d_parent && dentry->d_parent->d_inode) {
+					struct inode *p_inode = dentry->d_parent->d_inode;
+					p_inode->i_mtime = p_inode->i_ctime = CURRENT_TIME;
+				}
 				goto Proceed;
+			}
 			else 
 				error = -ENOMEM;
 		} else

