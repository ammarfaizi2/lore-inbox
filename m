Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWFBGtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWFBGtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWFBGtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:49:25 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:38535 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1751221AbWFBGtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:49:24 -0400
Subject: [Patch] Lockdep: add parent-child annotations to usbfs
From: Arjan van de Ven <arjan@linux.intel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Jun 2006 08:49:09 +0200
Message-Id: <1149230949.3117.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In usbfs's fs_remove_file() function, the aim is to remove a file or
directory from usbfs. This is done by first taking the i_mutex of the
parent directory of this file/dir via
  mutex_lock(&parent->d_inode->i_mutex);
and then to call either usbfs_rmdir() for a directory or usbfs_unlink() 
for a file. Both these functions then take the i_mutex for the
to-be-removed object themselves:
  mutex_lock(&inode->i_mutex);

This is a classical parent->child locking order relationship that the
VFS uses all over the place; the VFS locking rule is "you need to take
the parent first". This patch annotates the usbfs code to make this
explicit and thus informs the lockdep code that those two locks indeed
have this relationship.

The rules for unlink that we already use in the VFS for unlink are to
use I_MUTEX_PARENT for the parent directory, and a normal mutex for the
file itself; this patch follows that convention.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 drivers/usb/core/inode.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc5-mm1.5/drivers/usb/core/inode.c
===================================================================
--- linux-2.6.17-rc5-mm1.5.orig/drivers/usb/core/inode.c
+++ linux-2.6.17-rc5-mm1.5/drivers/usb/core/inode.c

@@ -528,7 +528,7 @@ static void fs_remove_file (struct dentr
 	if (!parent || !parent->d_inode)
 		return;
 
-	mutex_lock(&parent->d_inode->i_mutex);
+	mutex_lock_nested(&parent->d_inode->i_mutex, I_MUTEX_PARENT);
 	if (usbfs_positive(dentry)) {
 		if (dentry->d_inode) {
 			if (S_ISDIR(dentry->d_inode->i_mode))

