Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965346AbWHOKOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346AbWHOKOb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965358AbWHOKOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:14:31 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:38819 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965346AbWHOKOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:14:31 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][Fix] swsusp: Fix swap_type_of
Date: Tue, 15 Aug 2006 12:18:40 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608151218.41041.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug in mm/swapfile.c#swap_type_of() that makes swsusp only be
able to use the first active swap partition as the resume device.  Fix it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 mm/swapfile.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-mm1/mm/swapfile.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/mm/swapfile.c	2006-08-13 14:54:43.000000000 +0200
+++ linux-2.6.18-rc4-mm1/mm/swapfile.c	2006-08-14 21:09:09.000000000 +0200
@@ -442,11 +442,12 @@ int swap_type_of(dev_t device)
 
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
+
 		if (!device) {
 			spin_unlock(&swap_lock);
 			return i;
 		}
-		inode = swap_info->swap_file->f_dentry->d_inode;
+		inode = swap_info[i].swap_file->f_dentry->d_inode;
 		if (S_ISBLK(inode->i_mode) &&
 		    device == MKDEV(imajor(inode), iminor(inode))) {
 			spin_unlock(&swap_lock);
