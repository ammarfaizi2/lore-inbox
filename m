Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753882AbWKFW2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbWKFW2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 17:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbWKFW2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 17:28:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31387 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753875AbWKFW2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 17:28:34 -0500
Message-ID: <454FB710.2030108@redhat.com>
Date: Mon, 06 Nov 2006 16:28:32 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] - catch blocks beyond pagecache limit in __getblk_slow
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=206328

has a nice analysis of what can go wrong when we try to read blocks which
are at extremely high offsets, when our sector_t is 64 bits but our pgoff_t
is only 32.  The cases in question that I've seen are the result of filesystem
corruption.

In short, __getblk_slow() loops until it gets a buffer head.

        for (;;) {
                struct buffer_head * bh;

                bh = __find_get_block(bdev, block, size);
                if (bh)
                        return bh;

                if (!grow_buffers(bdev, block, size))
                        free_more_memory();
        }

When it fails it calls grow_buffers() to create buffers for the block in
question.  But, nothing stops us from going in there with a huge
block offset, and then:

static int
grow_buffers(struct block_device *bdev, sector_t block, int size)
{
        struct page *page;
        pgoff_t index;		/* 32 bits on 32-bit machines */
        int sizebits;

        sizebits = -1;
        do {
                sizebits++;
        } while ((size << sizebits) < PAGE_SIZE);

        index = block >> sizebits;
        block = index << sizebits;
...

has some nasty wrapping, and winds up mapping the wrong block.  Then we try
again.  Lather, rinse, repeat.

It seems that making sure that our block is not past what we can address is
worth doing, something like the patch that follows.

This also addresses the problem mentioned at:
http://kernelfun.blogspot.com/2006/11/mokb-05-11-2006-linux-26x-iso9660.html

notes/questions:

technically it should probably be ((pgoff_t)1 << (sizeof(pgoff_t)*8)) - 1)
instead of ULONG_MAX?  Maybe that'd be a handy macro... MAX_PAGE_INDEX?

Also I think using ffs(size) here is ok, can we ever have block sizes
which are not powers of two?

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.18/fs/buffer.c
===================================================================
--- linux-2.6.18.orig/fs/buffer.c
+++ linux-2.6.18/fs/buffer.c
@@ -1202,6 +1202,14 @@ __getblk_slow(struct block_device *bdev,
 		return NULL;
 	}
 
+	/* Don't try to get a block that we can't reach in the page cache... */
+	if (unlikely(block >> (PAGE_SHIFT - ffs(size)) > ULONG_MAX)) {
+		printk(KERN_ERR "getblk(): block %llu beyond pagecache limit\n",
+					(unsigned long long)block);
+		dump_stack();
+		return NULL;
+	}
+
 	for (;;) {
 		struct buffer_head * bh;
 



