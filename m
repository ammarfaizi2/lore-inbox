Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUFVBfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUFVBfP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 21:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUFVBfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 21:35:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64958 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S266514AbUFVBfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 21:35:06 -0400
Date: Tue, 22 Jun 2004 03:34:59 +0200 (MEST)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <UTC200406220134.i5M1YxJ20330.aeb@smtp.cwi.nl>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: CAP_DAC_OVERRIDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that CAP_DAC_OVERRIDE is treated inconsistently.
In fs/namei.c:vfs_permission() it allows one to search in
a directory with zero permissions:

        if (!(mask & MAY_EXEC) ||
            (inode->i_mode & S_IXUGO) || S_ISDIR(inode->i_mode))
                if (capable(CAP_DAC_OVERRIDE))
                        return 0;

while in fs/namei.c:exec_permission_lite() it does not.
Maybe the patch below would be appropriate.

Andries

--- /linux/2.6/linux-2.6.6/linux/fs/namei.c     2004-05-28 20:53
+++ ./namei.c   2004-06-22 03:33
@@ -316,7 +316,7 @@
 {
        umode_t mode = inode->i_mode;
 
-       if ((inode->i_op && inode->i_op->permission))
+       if (inode->i_op && inode->i_op->permission)
                return -EAGAIN;
 
        if (current->fsuid == inode->i_uid)
@@ -330,6 +330,9 @@
        if ((inode->i_mode & S_IXUGO) && capable(CAP_DAC_OVERRIDE))
                goto ok;
 
+       if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_OVERRIDE))
+               goto ok;
+
        if (S_ISDIR(inode->i_mode) && capable(CAP_DAC_READ_SEARCH))
                goto ok;
 

[not compiled, not tested, whitespace damaged]
