Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRCAUYq>; Thu, 1 Mar 2001 15:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129876AbRCAUYh>; Thu, 1 Mar 2001 15:24:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30672 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129865AbRCAUYR>;
	Thu, 1 Mar 2001 15:24:17 -0500
Date: Thu, 1 Mar 2001 15:24:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] Re: fat problem in 2.4.2
In-Reply-To: <200103012005.MAA08328@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0103011508320.11577-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Mar 2001, Linus Torvalds wrote:

> In article <Pine.GSO.4.21.0103011345110.11577-100000@weyl.math.psu.edu>,
> Alexander Viro  <viro@math.psu.edu> wrote:
> >
> >Alan, fix is really quite simple. Especially if you have vmtruncate()
> >returning int (ac1 used to do it, I didn't check later ones). Actually
> >just a generic_cont_expand() done on expanding path in vmtruncate()
> >will be enough - it should be OK for all cases, including normal
> >filesystems. <grabbing -ac7>
> >
> >OK, any brave soul to test that? All I can promise that it builds.
> 
> This looks like it would create a dummy block even for non-broken
> filesystems (ie truncating a file to be larger on ext2 would create a
> block, no?). While that would work, it would also waste disk-space.

<checking> yeah... Frankly, I'd just do
--- buffer.c	Thu Mar  1 15:16:34 2001
+++ buffer.c.old	Thu Mar  1 15:17:55 2001
@@ -1571,6 +1571,9 @@
 	struct buffer_head *bh, *head, *wait[2], **wait_bh=wait;
 	char *kaddr = kmap(page);
 
+	if (from >= to)
+		goto done;
+
 	blocksize = inode->i_sb->s_blocksize;
 	if (!page->buffers)
 		create_empty_buffers(page, inode->i_dev, blocksize);
@@ -1626,6 +1629,7 @@
 		if (!buffer_uptodate(*wait_bh))
 			goto out;
 	}
+done:
 	return 0;
 out:
 	bh = head;
@@ -1648,6 +1652,9 @@
 	unsigned blocksize;
 	struct buffer_head *bh, *head;
 
+	if (from >= to)
+		goto done;
+
 	blocksize = inode->i_sb->s_blocksize;
 
 	for(bh = head = page->buffers, block_start = 0;
@@ -1677,6 +1684,7 @@
 	 */
 	if (!partial)
 		SetPageUptodate(page);
+done:
 	return 0;
 }
 
- obviously correct, avoids disk waste and since we do it in __block...
everything keeps working (block_... versions are obviously OK, cont_...
also does the right thing).

Dunno. I like the idea of expanding truncate() being the same as
lseek() + empty write(). After all, that's what it is.

Comments?
						Cheers,
							Al

