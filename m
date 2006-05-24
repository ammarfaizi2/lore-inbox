Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932560AbWEXEYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbWEXEYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 00:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbWEXEYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 00:24:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:5505 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932560AbWEXEYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 00:24:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=WYeGZdfG/FrEFzpodI32qh7ZSYy63s95o8WWbPivyiGkNHaQOAMaXndt9E7o+ZwCYKWJk+Uu4A2/HAgvaOeqlsinIy8Htj34Dm/xWjSoRTWspOp4Z39oZ5k4n8Zfn0dijA14WHs86O5kN2logjGVAq2QiU9+Hz0mwobrO8xmI+g=
Message-ID: <4473E11C.6050305@gmail.com>
Date: Wed, 24 May 2006 00:29:16 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: zippel@linux-m68k.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] affs: possible null pointer dereference in affs_rename()
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If affs_bread() fails, the exit path calls mark_buffer_dirty_inode()
with a NULL argument.

Coverity CID: 312.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index d4c2d63..a42143c 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -416,10 +416,9 @@ affs_rename(struct inode *old_dir, struc
 			return retval;
 	}
 
-	retval = -EIO;
 	bh = affs_bread(sb, old_dentry->d_inode->i_ino);
 	if (!bh)
-		goto done;
+		return -EIO;
 
 	/* Remove header from its parent directory. */
 	affs_lock_dir(old_dir);


