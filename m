Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUBMWg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267260AbUBMWg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:36:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:2732 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267259AbUBMWgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:36:51 -0500
Date: Fri, 13 Feb 2004 14:38:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.3-rc2-mm1] __block_write_full patch
Message-Id: <20040213143836.0a5fdabb.akpm@osdl.org>
In-Reply-To: <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	<1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> Here is my original __block_write_full_page patch which adds
> a wait_on_buffer() to catch the case where i/o might be in flight
> from ll_rw_block().

We don't want to be doing this.

Also, I don't buy the original rationale for the patch.  Sure,
__block_write_full_page() clears PG_writeback.  But that's OK because that
function was also responsible for setting it, and everything is under the
page lock anyway.

My suspicion is that the real problem is that mpage_writepages() moved the
page onto mapping->locked_pages while there is buffer-level I/O in flight
(that's OK).  But PG_writeback is not set because writepage never started
any I/O.  So filemap_fdatawait() never waits for the ext3-initiated
buffer-level I/O.

If so, there are several ways to fix this:

a) Change ext3 so that it appropriately sets and clears page_writeback
   when any of the page's buffers are under writeout (messy).  Or

b) Change filemap_fdatawait() so that it also waits on buffer-level I/O.

   This is tricky because filemap_fdatawait() isn't allowed to assume
   that page->private points at buffer_heads.  Only the address_space
   implementation knows what is at page->private.  So it will need to be
   something like:

	lock_page(page);
	wait_on_page_writeback(page);
	mapping = page->mapping;
	if (mapping) {
		if (mapping->aops->wait_on_private_writeback)
			mapping->aops->wait_on_private_writeback(page);
	}
	unlock_page(page);


	ext3_wait_on_private_writeback(struct page *page)
	{
		for (the buffers)
			wait_on_buffer()
	}

  or

c) Change __block_write_full_page() to move the page back onto
   mapping->dirty_pages if it was WB_SYNC_NONE and we discovered that the
   page had a locked buffer.  This way, a subsequent WB_SYNC_ALL will
   correctly wait on that buffer.

Try c), please?

