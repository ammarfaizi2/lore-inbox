Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267936AbUJHDG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267936AbUJHDG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 23:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUJGS0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:26:54 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:44779 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267700AbUJGSYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:24:04 -0400
Subject: [patch 1/2] uml: fix fd leak with HostFs
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 07 Oct 2004 20:22:54 +0200
Message-Id: <20041007182254.B3A8A49BA@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2.4 we used force_delete() to make sure inode were not cached, and we then
close the host file when the inode is cleared; when porting to 2.6 the
"force_delete" thing was dropped, and this patch adds a fix for this (by
setting drop_inode = generic_delete_inode).

Search for drop_inode in the 2.6 Documentation/filesystems/vfs.txt for info
about this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -puN fs/hostfs/hostfs_kern.c~uml-HostFs-2.6-fd_leak fs/hostfs/hostfs_kern.c
--- linux-2.6.9-current/fs/hostfs/hostfs_kern.c~uml-HostFs-2.6-fd_leak	2004-10-07 17:38:01.075378432 +0200
+++ linux-2.6.9-current-paolo/fs/hostfs/hostfs_kern.c	2004-10-07 20:21:52.868718656 +0200
@@ -290,7 +290,6 @@ static void hostfs_delete_inode(struct i
 {
 	if(HOSTFS_I(inode)->fd != -1) {
 		close_file(&HOSTFS_I(inode)->fd);
-		printk("Closing host fd in .delete_inode\n");
 		HOSTFS_I(inode)->fd = -1;
 	}
 	clear_inode(inode);
@@ -301,9 +300,11 @@ static void hostfs_destroy_inode(struct 
 	if(HOSTFS_I(inode)->host_filename)
 		kfree(HOSTFS_I(inode)->host_filename);
 
+	/*XXX: This should not happen, probably. The check is here for
+	 * additional safety.*/
 	if(HOSTFS_I(inode)->fd != -1) {
 		close_file(&HOSTFS_I(inode)->fd);
-		printk("Closing host fd in .destroy_inode\n");
+		printk(KERN_DEBUG "Closing host fd in .destroy_inode\n");
 	}
 
 	kfree(HOSTFS_I(inode));
_
