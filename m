Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316860AbSFQJbg>; Mon, 17 Jun 2002 05:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316861AbSFQJbf>; Mon, 17 Jun 2002 05:31:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37640 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316860AbSFQJbe>;
	Mon, 17 Jun 2002 05:31:34 -0400
Message-ID: <3D0DAD69.5C667D63@zip.com.au>
Date: Mon, 17 Jun 2002 02:35:37 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 4/19] stack space reduction (remove MAX_BUF_PER_PAGE)
References: <3D0D86F0.5016809@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ..
> +               do {
> +                       if (buffer_async_read(bh))
> +                               submit_bh(READ, bh);
> +               } while ((bh = bh->b_this_page) != head);

That's a bug.  We cannot touch bh->b_this_page after submitting
the buffer because the I/O could complete synchronously and the
page can come unlocked and the buffers can be stripped by the VM.
The buffer at `bh' could be dead memory.

This can happen on SMP with PIO-mode IDE disks.

We cannot fix this with the usual

	do {
		next = bh->b_this_page;
		if (something)
			submit_bh(bh);
	} while ((bh = next) != head);

approach because the final buffer on the page could be unlocked,
clean and uptodate.

Pinning one of the buffers while we walk the ring will keep
try_to_free_buffers() away.   Here is an incremental patch.



--- 2.5.22/fs/ntfs/aops.c~ntfs-race-fix	Mon Jun 17 01:50:32 2002
+++ 2.5.22-akpm/fs/ntfs/aops.c	Mon Jun 17 02:24:00 2002
@@ -220,10 +220,12 @@ handle_zblock:
 		} while ((bh = bh->b_this_page) != head);
 
 		/* Finally, start i/o on the buffers. */
+		get_bh(head);	/* Pin the buffers while we walk the ring */
 		do {
 			if (buffer_async_read(bh))
 				submit_bh(READ, bh);
 		} while ((bh = bh->b_this_page) != head);
+		put_bh(head);
 		return 0;
 	}
 	/* No i/o was scheduled on any of the buffers. */
@@ -510,10 +512,12 @@ handle_zblock:
 		} while ((bh = bh->b_this_page) != head);
 
 		/* Finally, start i/o on the buffers. */
+		get_bh(head);	/* Pin the buffers while we walk the ring */
 		do {
 			if (buffer_async_read(bh))
 				submit_bh(READ, bh);
 		} while ((bh = bh->b_this_page) != head);
+		put_bh(head);
 		return 0;
 	}
 	/* No i/o was scheduled on any of the buffers. */
@@ -774,10 +778,12 @@ handle_zblock:
 		} while ((bh = bh->b_this_page) != head);
 
 		/* Finally, start i/o on the buffers. */
+		get_bh(head);	/* Pin the buffers while we walk the ring */
 		do {
 			if (buffer_async_read(bh))
 				submit_bh(READ, bh);
 		} while ((bh = bh->b_this_page) != head);
+		put_bh(head);
 		return 0;
 	}
 	/* No i/o was scheduled on any of the buffers. */
--- 2.5.22/fs/buffer.c~ntfs-race-fix	Mon Jun 17 01:55:55 2002
+++ 2.5.22-akpm/fs/buffer.c	Mon Jun 17 02:24:33 2002
@@ -2024,7 +2024,12 @@ int block_read_full_page(struct page *pa
 	 * Stage 3: start the IO.  Check for uptodateness
 	 * inside the buffer lock in case another process reading
 	 * the underlying blockdev brought it uptodate (the sct fix).
+	 *
+	 * Bump the refcount of one buffer while walking the ring so
+	 * that the VM cannot release the buffers while we're looking at
+	 * ->b_this_page.
 	 */
+	get_bh(head);
 	do {
 		if (buffer_async_read(bh)) {
 			if (buffer_uptodate(bh))
@@ -2033,6 +2038,7 @@ int block_read_full_page(struct page *pa
 				submit_bh(READ, bh);
 		}
 	} while ((bh = bh->b_this_page) != head);
+	put_bh(head);
 	return 0;
 }
 

-
