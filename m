Return-Path: <linux-kernel-owner+w=401wt.eu-S1754931AbXABV06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754931AbXABV06 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754932AbXABV06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:26:58 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33551 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753701AbXABV05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:26:57 -0500
Date: Tue, 2 Jan 2007 13:26:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] Handle error in sync_sb_inodes()
Message-Id: <20070102132645.264d2b89.akpm@osdl.org>
In-Reply-To: <45958E4F.5080105@yahoo.fr>
References: <45958E4F.5080105@yahoo.fr>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I/O errors could go unnoticed when syncing, for example the following code could
> write a file bigger than 10Mib on a 10Mib filesystem. With this patch, msync()
> will report the error originally encountered by sync(). Tuning the number of
> sync may be needed to reproduce the bug.
> make_file.c:
> 
> #include <unistd.h>
> #include <sys/fcntl.h>
> #include <sys/mman.h>
> #include <string.h>
> #include <stdio.h>
> 
> #define NR_SYNC 3 /* Adjust me if needed */
> #define SIZE ((10 << 20) + (100 << 10))
> 
> int main(void)
> {
> 	int i, fd;
> 	char *mapping;
> 	fd = open("mnt/file", O_RDWR | O_CREAT, 0600);
> 	if (fd < 0) {
> 		perror("open");
> 		return 1;
> 	}
> 
> 	if (ftruncate(fd, SIZE) < 0) {
> 		perror("ftruncate");
> 		return 1;
> 	}
> 
> 	mapping = mmap(NULL, SIZE, PROT_WRITE, MAP_SHARED, fd, 0);
> 	if (mapping == MAP_FAILED) {
> 		perror("mmap");
> 		return 1;
> 	}
> 
> 	memset(mapping, 0xFF, SIZE);
> 
> 	for (i = 0; i < NR_SYNC; i++)
> 		sync();
> 
> 	if (msync(mapping, SIZE, MS_SYNC) < 0) {
> 		perror("msync");
> 		return 1;
> 	}
> 
> 	if (close(fd) < 0) {
> 		perror("close");
> 		return 1;
> 	}
> 
> 	puts("File written successfully => bad!\n");
> 	return 0;
> }
> 
> #!/bin/sh
> 
> dd if=/dev/zero of=fs.10M bs=10M count=0 seek=1
> mkfs.ext2 -qF fs.10M
> mkdir mnt
> mount fs.10M mnt -o loop
> ./make_file
> 
> Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
> ---
> 
>  fs-writeback.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff -r 3859b1144d3a fs/fs-writeback.c
> --- a/fs/fs-writeback.c	Sun Dec 24 05:00:03 2006 +0000
> +++ b/fs/fs-writeback.c	Fri Dec 29 22:12:42 2006 +0100
> @@ -316,6 +316,7 @@ sync_sb_inodes(struct super_block *sb, s
>  		struct address_space *mapping = inode->i_mapping;
>  		struct backing_dev_info *bdi = mapping->backing_dev_info;
>  		long pages_skipped;
> +		int ret;
>  
>  		if (!bdi_cap_writeback_dirty(bdi)) {
>  			list_move(&inode->i_list, &sb->s_dirty);
> @@ -365,7 +366,8 @@ sync_sb_inodes(struct super_block *sb, s
>  		BUG_ON(inode->i_state & I_FREEING);
>  		__iget(inode);
>  		pages_skipped = wbc->pages_skipped;
> -		__writeback_single_inode(inode, wbc);
> +		ret = __writeback_single_inode(inode, wbc);
> +		mapping_set_error(mapping, ret);
>  		if (wbc->sync_mode == WB_SYNC_HOLD) {
>  			inode->dirtied_when = jiffies;
>  			list_move(&inode->i_list, &sb->s_dirty);

This change is somewhat contrary to the way in which we've been handling
these issues thus far.

What the kernel does is to set the address_space error bits at the
lowest-level where the error is detected for the sync operation to later
detect.  Whereas your change adopts the more conventional
propagate-it-back-then-handle-it model.

The implication from your change is that there's some piece of code
somewhere which is forgetting to propagate an error into the address_space
at the appropriate time.  And that looks to be the code at "recover:" in
__block_write_full_page().

So perhaps a more consistent fix here is to teach __block_write_full_page()
to propagate that error, I think?  Something like:

--- a/fs/buffer.c~a
+++ a/fs/buffer.c
@@ -1739,6 +1739,7 @@ recover:
 		}
 	} while ((bh = bh->b_this_page) != head);
 	SetPageError(page);
+	mapping_set_error(page->mapping, err);
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
 	unlock_page(page);
_

