Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262295AbVBVMNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262295AbVBVMNi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVBVMMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:12:17 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:55246 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262286AbVBVMLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:11:30 -0500
Date: Tue, 22 Feb 2005 13:11:29 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch 2/6] Bind Mount Extensions 0.06
Message-ID: <20050222121129.GC3682@mail.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



;
; Bind Mount Extensions
;
; This part adds the required checks for touch_atime() to allow
; for vfsmount based NOATIME and NODIRATIME
; autofs4 update_atime is the only exception (ignored on purpose)
;
; Copyright (C) 2003-2005 Herbert Pötzl <herbert@13thfloor.at>
;
; Changelog:
;
;   0.01  - broken out part from bme0.05
;
; this patch is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public License
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
;
; this patch is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;

diff -NurpP --minimal linux-2.6.11-rc4-bme0.06-bm0.01/include/linux/fs.h linux-2.6.11-rc4-bme0.06-bm0.01-at0.01/include/linux/fs.h
--- linux-2.6.11-rc4-bme0.06-bm0.01/include/linux/fs.h	2005-02-19 06:31:24 +0100
+++ linux-2.6.11-rc4-bme0.06-bm0.01-at0.01/include/linux/fs.h	2005-02-19 06:31:36 +0100
@@ -1038,8 +1038,16 @@ static inline void mark_inode_dirty_sync
 
 static inline void touch_atime(struct vfsmount *mnt, struct dentry *dentry)
 {
-	/* per-mountpoint checks will go here */
-	update_atime(dentry->d_inode);
+	struct inode *inode = dentry->d_inode;
+
+	if (MNT_IS_NOATIME(mnt))
+		return;
+	if (S_ISDIR(inode->i_mode) && MNT_IS_NODIRATIME(mnt))
+		return;
+	if (IS_RDONLY(inode) || MNT_IS_RDONLY(mnt))
+		return;
+
+	update_atime(inode);
 }
 
 static inline void file_accessed(struct file *file)
