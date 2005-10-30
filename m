Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbVJ3BFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbVJ3BFk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 21:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932760AbVJ3BFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 21:05:40 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:61911 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932751AbVJ3BFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 21:05:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=kucJdnN2b9S7VvVM0HVZs5nsoJHoEowUGobZSmr+WWBzMXJ7IBecCeOpos3h0fJZwm7A0vM6OfCAdyGLDPQcSoBO+2Y9nQVkaqR1qxKpydxdKHQhgivGinJCU0WWzEuqOCOFMOVBCj8lTcF5Pi9OnML+GkgKNV7L4Y1tFG8o/s8=
Date: Sun, 30 Oct 2005 04:18:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Sergey S. Kostyliov" <rathamahata@php4.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] befs: use strlcpy()
Message-ID: <20051030011817.GA32602@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
	Looks like second strncpy() can fill symlink buffer without
	NUL-termination which would cause bad things later, though I
	may be wrong.

 fs/befs/btree.c    |    3 +--
 fs/befs/linuxvfs.c |    4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -503,10 +503,9 @@ befs_btree_read(struct super_block *sb, 
 		goto error_alloc;
 	};
 
-	strncpy(keybuf, keystart, keylen);
+	strlcpy(keybuf, keystart, keylen);
 	*value = fs64_to_cpu(sb, valarray[cur_key]);
 	*keysize = keylen;
-	keybuf[keylen] = '\0';
 
 	befs_debug(sb, "Read [%Lu,%d]: Key \"%.*s\", Value %Lu", node_off,
 		   cur_key, keylen, keybuf, *value);
--- linux-vanilla/fs/befs/linuxvfs.c
+++ linux-strlcpy/fs/befs/linuxvfs.c
@@ -381,8 +381,8 @@ befs_read_inode(struct inode *inode)
 	if (S_ISLNK(inode->i_mode) && !(befs_ino->i_flags & BEFS_LONG_SYMLINK)){
 		inode->i_size = 0;
 		inode->i_blocks = befs_sb->block_size / VFS_BLOCK_SIZE;
-		strncpy(befs_ino->i_data.symlink, raw_inode->data.symlink,
-			BEFS_SYMLINK_LEN);
+		strlcpy(befs_ino->i_data.symlink, raw_inode->data.symlink,
+			sizeof(befs_ino->i_data.symlink));
 	} else {
 		int num_blks;
 

