Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUEEARW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUEEARW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 20:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUEEARW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 20:17:22 -0400
Received: from lexus.itbs.cz ([217.11.254.38]:15438 "EHLO lexus.itbs.cz")
	by vger.kernel.org with ESMTP id S261857AbUEEART (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 20:17:19 -0400
Message-ID: <1083720324.4098428453030@mail.itbs.cz>
Date: Wed,  5 May 2004 03:25:24 +0200
From: Jakub Jermar <jermar@itbs.cz>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] bfs filesystem read past the end of dir
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found out that BFS filesystem will eventually try to read and interpret garbage past the end of 
directory in bfs_add_entry(). If the garbage (interpreted as i-node number) is not set to zero (does it 
have to be?) bfs_add_entry() will consider it a regular directory entry. 

This causes weird things like this:
# touch a
# rm a
# ls
# touch b
# ls
a

My patch detects an attempt to read past the end of directory and explicitly clears the garbage that 
represents i-node number. Thus the correct behaviour is achieved.

Could you take a look at the patch and share your thoughts?

Thanks,
Jakub

diff -Nru linux-2.6.5/fs/bfs/dir.c linux-2.6.5-bfs-patch/fs/bfs/dir.c
--- linux-2.6.5/fs/bfs/dir.c    2004-04-04 05:38:13.000000000 +0200
+++ linux-2.6.5-bfs-patch/fs/bfs/dir.c  2004-05-05 01:28:41.000000000 +0200
@@ -274,7 +274,7 @@
 {
        struct buffer_head * bh;
        struct bfs_dirent * de;
-       int block, sblock, eblock, off;
+       int block, sblock, eblock, off, eoff;
        int i;

        dprintf("name=%s, namelen=%d\n", name, namelen);
@@ -286,12 +286,17 @@

        sblock = BFS_I(dir)->i_sblock;
        eblock = BFS_I(dir)->i_eblock;
+       eoff = dir->i_size % BFS_BSIZE;
        for (block=sblock; block<=eblock; block++) {
                bh = sb_bread(dir->i_sb, block);
                if(!bh)
                        return -ENOSPC;
                for (off=0; off<BFS_BSIZE; off+=BFS_DIRENT_SIZE) {
                        de = (struct bfs_dirent *)(bh->b_data + off);
+                       if (block==eblock && off>=eoff) {
+                               /* Do not read/interpret the garbage in the end of eblock. */
+                               de->ino = 0;
+                       }
                        if (!de->ino) {
                                if ((block-sblock)*BFS_BSIZE + off >= dir->i_size) {
                                        dir->i_size += BFS_DIRENT_SIZE;

