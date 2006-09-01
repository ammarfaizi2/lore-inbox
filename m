Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWIAQM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWIAQM7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWIAQM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:12:59 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:65223 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932203AbWIAQM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:12:57 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Fri, 1 Sep 2006 17:12:43 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: sct@redhat.com, akpm@osdl.org,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
In-Reply-To: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.64.0609011652420.24650@hermes-2.csi.cam.ac.uk>
References: <1157125829.30578.6.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 1 Sep 2006, Badari Pulavarty wrote:
> 
> I have been running into following bug while running fsx
> tests on 1k (ext3) filesystem all the time. 
> 
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at fs/buffer.c:2791
> invalid opcode: 0000 [1] SMP
> 
> Its complaining about BUG_ON(!buffer_mapped(bh)).
> 
> It was hard to track it down, needed lots of debug - but here 
> is the problem & fix.  Since the fix is in __set_page_buffer_dirty()
> code - I am wondering how it would effect others :(

This will breaks NTFS and probably a lot of other file systems I would 
think.

For example all buffer based file systems in their writepage 
implementations will create buffers if none are present and those will not 
be mapped.  If for whatever reason writepage now breaks out before mapping 
the buffers (e.g. because the buffers do not need to be written or due to 
an error) you are left with a page containing unmapped buffers.

Then a page dirty comes in caused by a mmapped write for example.

__set_page_dirty_bufferes() runs by default and with your patch does not 
set the unmapped buffers dirty thus they never get written out and you 
have data corruption.

It is the caller of submit_bh() that is doing the stupidity of submitting 
unmapped buffers for i/o or even the caller of the caller, etc...  
Somewhere up in that chain buffers should have been mapped before being 
submitted for i/o otherwise it is a BUG() (as correctly identified by 
submit_bh()).

Perhaps the real fix is not to have ext3 use ll_rw_block() and instead 
make it use submit_bh() directly and only submit buffers inside the file 
size and/or make it map buffers before calling ll_rw_block() and if they 
are outside the file size just clean them without submitting them...

Best regards,

	Anton

> With this fix fsx tests ran for more than 16 hours (and still
> running).
> 
> Please let me know, what you think.
> 
> Thanks,
> Badari 
> 
> Patch to fix: Kernel BUG at fs/buffer.c:2791
> on 1k (2k) filesystems while running fsx.
> 
> journal_commit_transaction collects lots of dirty buffer from
> and does a single ll_rw_block() to write them out. ll_rw_block()
> locks the buffer and checks to see if they are dirty and submits
> them for IO.
> 
> In the mean while, journal_unmap_buffers() as part of
> truncate can unmap the buffer and throw it away. Since its
> a 1k (2k) filesystem - each page (4k) will have more than
> one buffer_head attached to the page and and we can't free 
> up buffer_heads attached to the page (if we are not
> invalidating the whole page).
> 
> Now, any call to set_page_dirty() (like msync_interval)
> could end up setting all the buffer heads attached to
> this page again dirty, including the ones those got
> cleaned up :(
> 
> If ll_rw_block() runs now and sees the dirty bit it does
> submit_bh() on those buffer_heads and triggers the assert.
> 
> Fix is to check if the buffer is mapped before setting its
> dirty bit in __set_page_dirty_buffers().
> 
> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> ---
>  fs/buffer.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.18-rc5/fs/buffer.c
> ===================================================================
> --- linux-2.6.18-rc5.orig/fs/buffer.c	2006-09-01 08:20:51.000000000 -0700
> +++ linux-2.6.18-rc5/fs/buffer.c	2006-09-01 08:41:01.000000000 -0700
> @@ -846,7 +846,13 @@ int __set_page_dirty_buffers(struct page
>  		struct buffer_head *bh = head;
>  
>  		do {
> -			set_buffer_dirty(bh);
> +			/*
> +			 * Its possible that, not all buffers attached to
> +			 * this page are mapped (cleaned up by truncate).
> +			 * If so, skip them.
> +			 */
> +			if (buffer_mapped(bh))
> +				set_buffer_dirty(bh);
>  			bh = bh->b_this_page;
>  		} while (bh != head);
>  	}

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
