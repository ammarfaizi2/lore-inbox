Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTKBJyy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 04:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbTKBJyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 04:54:54 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:5899 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S261615AbTKBJyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 04:54:51 -0500
Date: Sun, 2 Nov 2003 20:54:41 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at fs/buffer.c:431"
Message-ID: <20031102095441.GA5248@gondor.apana.org.au>
References: <20031029141931.6c4ebdb5.akpm@osdl.org> <E1AGCUJ-00016g-00@gondolin.me.apana.org.au> <20031101233354.1f566c80.akpm@osdl.org> <20031102092723.GA4964@gondor.apana.org.au> <20031102014011.09001c81.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20031102014011.09001c81.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 02, 2003 at 01:40:11AM -0800, Andrew Morton wrote:
> 
> Where are the separated patches?

There are no separate patches.  You can check the README.Debian file
for the details of the changes.

> That's 170k of stuff you're sitting on.  Is there any plan to get it synced
> up?

I submit them as they come in.  The bulk of the size comes from the
making IDE modules work which isn't right yet.

The rest of them which are suitable for general consumption have
been submitted previously.  I will resend them later.

> No, because _something_ has to rub out the wrong-sized buffer_heads.  One
> could add some new function which walks the pagecache and removes the
> buffer_heads from the pages, leaving the pages there.  There doesn't seem a
> lot of point in it though?

Actually grow_dev_page will free the wrong-sized ones.

It seems that the only problem is that we don't check the size in
__find_get_block_slow().  So what about this patch?

The point of all this is to avoid unnecessary reads, and more importantly
preserve the contents of RAM disks when someone calls set_blocksize().

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/fs/buffer.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/buffer.c,v
retrieving revision 1.1.1.15
diff -u -r1.1.1.15 buffer.c
--- kernel-source-2.5/fs/buffer.c	8 Oct 2003 19:24:14 -0000	1.1.1.15
+++ kernel-source-2.5/fs/buffer.c	2 Nov 2003 09:54:07 -0000
@@ -400,7 +400,7 @@
  * private_lock is contended then so is mapping->page_lock).
  */
 static struct buffer_head *
-__find_get_block_slow(struct block_device *bdev, sector_t block, int unused)
+__find_get_block_slow(struct block_device *bdev, sector_t block, int size)
 {
 	struct inode *bd_inode = bdev->bd_inode;
 	struct address_space *bd_mapping = bd_inode->i_mapping;
@@ -419,6 +419,8 @@
 	if (!page_has_buffers(page))
 		goto out_unlock;
 	head = page_buffers(page);
+	if (head->b_size != size)
+		goto out_unlock;
 	bh = head;
 	do {
 		if (bh->b_blocknr == block) {
Index: kernel-source-2.5/fs/block_dev.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/fs/block_dev.c,v
retrieving revision 1.1.1.15
retrieving revision 1.15
diff -u -r1.1.1.15 -r1.15
--- kernel-source-2.5/fs/block_dev.c	8 Oct 2003 19:24:53 -0000	1.1.1.15
+++ kernel-source-2.5/fs/block_dev.c	11 Oct 2003 06:29:24 -0000	1.15
@@ -66,7 +66,7 @@
 	sync_blockdev(bdev);
 	bdev->bd_block_size = size;
 	bdev->bd_inode->i_blkbits = blksize_bits(size);
-	kill_bdev(bdev);
+	invalidate_bdev(bdev, 1);
 	return 0;
 }
 

--ikeVEW9yuYc//A+q--
