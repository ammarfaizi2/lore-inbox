Return-Path: <linux-kernel-owner+w=401wt.eu-S965168AbWL2Vwl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965168AbWL2Vwl (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 16:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbWL2Vwl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 16:52:41 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:44547 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965168AbWL2Vwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 16:52:40 -0500
Message-ID: <45958E4F.5080105@yahoo.fr>
Date: Fri, 29 Dec 2006 22:53:19 +0100
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] Handle error in sync_sb_inodes()
Content-Type: multipart/mixed;
 boundary="------------040905060903050808040909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040905060903050808040909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Against 2.6.20-rc2, and now the bug fix.

-- 
Guillaume


--------------040905060903050808040909
Content-Type: text/x-patch;
 name="02_sync_sb_inodes_handle_error.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02_sync_sb_inodes_handle_error.diff"

I/O errors could go unnoticed when syncing, for example the following code could
write a file bigger than 10Mib on a 10Mib filesystem. With this patch, msync()
will report the error originally encountered by sync(). Tuning the number of
sync may be needed to reproduce the bug.
make_file.c:

#include <unistd.h>
#include <sys/fcntl.h>
#include <sys/mman.h>
#include <string.h>
#include <stdio.h>

#define NR_SYNC 3 /* Adjust me if needed */
#define SIZE ((10 << 20) + (100 << 10))

int main(void)
{
	int i, fd;
	char *mapping;
	fd = open("mnt/file", O_RDWR | O_CREAT, 0600);
	if (fd < 0) {
		perror("open");
		return 1;
	}

	if (ftruncate(fd, SIZE) < 0) {
		perror("ftruncate");
		return 1;
	}

	mapping = mmap(NULL, SIZE, PROT_WRITE, MAP_SHARED, fd, 0);
	if (mapping == MAP_FAILED) {
		perror("mmap");
		return 1;
	}

	memset(mapping, 0xFF, SIZE);

	for (i = 0; i < NR_SYNC; i++)
		sync();

	if (msync(mapping, SIZE, MS_SYNC) < 0) {
		perror("msync");
		return 1;
	}

	if (close(fd) < 0) {
		perror("close");
		return 1;
	}

	puts("File written successfully => bad!\n");
	return 0;
}

#!/bin/sh

dd if=/dev/zero of=fs.10M bs=10M count=0 seek=1
mkfs.ext2 -qF fs.10M
mkdir mnt
mount fs.10M mnt -o loop
./make_file

Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
---

 fs-writeback.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -r 3859b1144d3a fs/fs-writeback.c
--- a/fs/fs-writeback.c	Sun Dec 24 05:00:03 2006 +0000
+++ b/fs/fs-writeback.c	Fri Dec 29 22:12:42 2006 +0100
@@ -316,6 +316,7 @@ sync_sb_inodes(struct super_block *sb, s
 		struct address_space *mapping = inode->i_mapping;
 		struct backing_dev_info *bdi = mapping->backing_dev_info;
 		long pages_skipped;
+		int ret;
 
 		if (!bdi_cap_writeback_dirty(bdi)) {
 			list_move(&inode->i_list, &sb->s_dirty);
@@ -365,7 +366,8 @@ sync_sb_inodes(struct super_block *sb, s
 		BUG_ON(inode->i_state & I_FREEING);
 		__iget(inode);
 		pages_skipped = wbc->pages_skipped;
-		__writeback_single_inode(inode, wbc);
+		ret = __writeback_single_inode(inode, wbc);
+		mapping_set_error(mapping, ret);
 		if (wbc->sync_mode == WB_SYNC_HOLD) {
 			inode->dirtied_when = jiffies;
 			list_move(&inode->i_list, &sb->s_dirty);

--------------040905060903050808040909--
