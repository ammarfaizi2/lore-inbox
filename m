Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261634AbSIXJ6g>; Tue, 24 Sep 2002 05:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261635AbSIXJ6g>; Tue, 24 Sep 2002 05:58:36 -0400
Received: from dobit2.rug.ac.be ([157.193.42.8]:20940 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S261634AbSIXJ6d>;
	Tue, 24 Sep 2002 05:58:33 -0400
Date: Tue, 24 Sep 2002 12:03:41 +0200 (MEST)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: <linux-kernel@vger.kernel.org>
cc: <Frank.Cornelis@rug.ac.be>
Subject: Oops on umount -a -f
Message-ID: <Pine.GSO.4.31.0209241144260.11353-100000@eduserv.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This Oops has been annoying me for a while now so here's the report after
some disassembling.
Situation: linux 2.4.19 rh7.3 when I poweroff and the system is doing
	umount -a -f

In the file:function fs/file_table.c:fs_may_remount_ro
	struct inode *inode = file->f_dentry->d_inode;
oopses (NULL ptr deref at 00000008) on instruction fs_may_remount_ro+19:
	0xc0138550 <fs_may_remount_ro+16>:      mov    0x8(%edx),%eax
	0xc0138553 <fs_may_remount_ro+19>:      mov    0x8(%eax),%eax
which does the evaluation of
        f_dentry->d_inode
so seems like file->f_dentry can be NULL, which should be checked first.

A quick and dirty patch for this:
--- fs/file_table.c.orig-2.4.19 Tue Sep 24 11:58:17 2002
+++ fs/file_table.c     Tue Sep 24 12:00:34 2002
@@ -170,7 +170,11 @@
        file_list_lock();
        for (p = sb->s_files.next; p != &sb->s_files; p = p->next) {
                struct file *file = list_entry(p, struct file, f_list);
-               struct inode *inode = file->f_dentry->d_inode;
+               struct dentry *dentry = file->f_dentry;
+               struct inode *inode;
+               if (!dentry)
+                 continue;
+               inode = dentry->d_inode;

                /* File with pending delete? */
                if (inode->i_nlink == 0)


'm not on the mailing list anymore, contact me by email.

Greetz,
Frank.

