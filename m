Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbTJ2WTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 17:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTJ2WTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 17:19:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:36804 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261626AbTJ2WTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 17:19:13 -0500
Date: Wed, 29 Oct 2003 14:19:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org, lkml-031028@amos.mailshell.com
Subject: Re: 2.6.0test9 Reiserfs boot time "buffer layer error at
 fs/buffer.c:431"
Message-Id: <20031029141931.6c4ebdb5.akpm@osdl.org>
In-Reply-To: <200310292149.h9TLnsNq024151@car.linuxhacker.ru>
References: <20031028154920.1905.qmail@mailshell.com>
	<20031028141329.13443875.akpm@osdl.org>
	<20031029174419.5776.qmail@mailshell.com>
	<20031029123107.338796a4.akpm@osdl.org>
	<200310292149.h9TLnsNq024151@car.linuxhacker.ru>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin <green@linuxhacker.ru> wrote:
>
> Hello!
> 
> Andrew Morton <akpm@osdl.org> wrote:
> >> Here are the results (output of dmesg) from booting a kernel with this
> >> patch:
> >> set_blocksize: size=4096
> >> buffer layer error at fs/buffer.c:431
> AM> hm, that didn't tell us much :(
> AM> Could you add Oleg's patch as well?
> 
> Actually it will say that device's block size is 4096 (confirming
> last set_blocksize was at least partially succesful),

Assuming that the printk is for the correct filesystem, yes.

> but what
> it does not tell us is how those buffers have survived after blocksize
> was changed and all buffers were invalidated.

Well reiserfs shouldn't be doing this:

    bh = sb_bread (s, offset / s->s_blocksize);
    ...
    sb_set_blocksize (s, sb_blocksize(rs));
    brelse (bh);

but still, truncate_inode_pages() should be removing all those pages
unconditionally.


> (These buffers are there because reiserfs first reads that offset (in bytes)
> with whatever current blocksize is, except they should have been invalidated of
> course).
> Even if invalidate_bdev() -> invalidate_inode_pages() have not cleaned
> everything, truncate_inode_pages() should have done this.

yup.

> So probably this page means do_invalidate_page() ... -> try_to_free_buffers()
> have failed for whatever reason.

See the pinned buffer, above.

> We did not write there yet, so this is not PageWriteback case.
> But if the read is still going on, I guess we won't free the page/buffers?
> Or am I missing some wait_on_buffer()?
> But anyway that might explains buffers being still in page, but not such
> a page present in a mapping. (except if we have not pickup this page from a list
> of free pages not looking that it still have stale buffers)

Yes, the page should have been removed from the mapping.


Amos, could you add this as well?

 25-akpm/mm/truncate.c |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN mm/truncate.c~truncate_inode_pages-check mm/truncate.c
--- 25/mm/truncate.c~truncate_inode_pages-check	Wed Oct 29 14:13:43 2003
+++ 25-akpm/mm/truncate.c	Wed Oct 29 14:15:06 2003
@@ -174,6 +174,14 @@ void truncate_inode_pages(struct address
 		}
 		pagevec_release(&pvec);
 	}
+
+	if (lstart == 0) {
+		WARN_ON(mapping->nrpages);
+		WARN_ON(!list_empty(&mapping->clean_pages));
+		WARN_ON(!list_empty(&mapping->dirty_pages));
+		WARN_ON(!list_empty(&mapping->locked_pages));
+		WARN_ON(!list_empty(&mapping->io_pages));
+	}
 }
 
 EXPORT_SYMBOL(truncate_inode_pages);

_

