Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161854AbWKPFtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161854AbWKPFtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 00:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161851AbWKPFtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 00:49:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161840AbWKPFs7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 00:48:59 -0500
Date: Wed, 15 Nov 2006 21:45:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
       Mingming Cao <cmm@us.ibm.com>
Subject: Re: Boot failure with ext2 and initrds
Message-Id: <20061115214534.72e6f2e8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061114184919.GA16020@skynet.ie>
	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	<20061114113120.d4c22b02.akpm@osdl.org>
	<Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	<Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 14:17:01 +0000 (GMT)
Hugh Dickins <hugh@veritas.com> wrote:

> On Tue, 14 Nov 2006, Hugh Dickins wrote:
> > On Tue, 14 Nov 2006, Andrew Morton wrote:
> > > 
> > > The below might help.
> > 
> > Indeed it does (with Martin's E2FSBLK warning fix),
> > seems to be running well on all machines now.
> 
> i386 and ppc64 still doing builds, but after an hour on x86_64,
> an ld got stuck in a loop under ext2_try_to_allocate_with_rsv,
> alternating between ext2_rsv_window_add and rsv_window_remove.
> Send me a patch and I'll try it...
> 
> ext2_try_to_allocate_with_rsv+0x288
> ext2_new_blocks+0x21e
> ext2_get_blocks+0x398
> ext2_get_block+0x46
> __block_prepare_write+0x171
> block_prepare_write+0x39
> ext2_prepare_write+0x2c
> generic_file_buffered_write+0x2b0
> __generic_file_aio_write_nolock+0x4bc
> generic_file_aio_write+0x6d
> do_sync_write+0xf9
> vfs_write+0xc8
> sys_write+0x51

OK, I have a theory.

This must have been the seventeenth damn time I've stared at
find_next_zero_bit() wondering what the damn return value is and wondering
how any even slightly non-sadistic person could write a damn function like
that and not damn well document it.

int find_next_zero_bit(const unsigned long *addr, int size, int offset)

It returns the offset of the first zero bit relative to addr.  

ext3's bitmap_search_next_usable_block() assumed that find_next_zero_bit()
returns the offset of the first zero bit relative to (addr+offset).

The while loop in ext3's bitmap_search_next_usable_block() serendipitously
covered that bug up.

ext2's bitmap_search_next_usable_block() doesn't need that while loop, so
ext3's benign bug became ext2's fatal bug.

So...

--- a/fs/ext2/balloc.c~a
+++ a/fs/ext2/balloc.c
@@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
 	ext2_grpblk_t next;
 
 	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
-	if (next >= maxblocks)
+	if (next >= start + maxblocks)
 		return -1;
 	return next;
 }
_

Anyway, I think that's the bug.  Or a bug, at least.  If so, the cause of
this bug is inadequate code commenting, pure and simple.  And ext3 and ext4
need fixing.

