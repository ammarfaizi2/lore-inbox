Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267167AbUBMXaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUBMXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:30:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:64721 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267167AbUBMXao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:30:44 -0500
Subject: Re: [PATCH 2.6.3-rc2-mm1] __block_write_full patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040213143836.0a5fdabb.akpm@osdl.org>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	 <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
	 <20040213143836.0a5fdabb.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Feb 2004 15:30:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-13 at 14:38, Andrew Morton wrote:

> My suspicion is that the real problem is that mpage_writepages() moved the
> page onto mapping->locked_pages while there is buffer-level I/O in flight
> (that's OK).  But PG_writeback is not set because writepage never started
> any I/O.  So filemap_fdatawait() never waits for the ext3-initiated
> buffer-level I/O.


kjournald was calling ll_rw_block() with a bunch of bh's and
PG_writeback was not set.

A subsequent __block_write_full_page()  with the
page locked, sees that none of the bh(s) for that page
are dirty.  PG_PageWriteback would be set, unlock_page()
and then see no buffers to submit, so clear PG_Page_Writeback
(but buffer i/o still in flight).  filemap_fdatawait() has
nothing to wait for.

I think we agree.

> 
> If so, there are several ways to fix this:

> c) Change __block_write_full_page() to move the page back onto
>    mapping->dirty_pages if it was WB_SYNC_NONE and we discovered that the
>    page had a locked buffer.  This way, a subsequent WB_SYNC_ALL will
>    correctly wait on that buffer.
> 
> Try c), please?

No problem.  I will code this up and give it a try.

My only concern is that a racing mpage_writepages(WB_SYNC_NONE)
with a mpage_write_pages(WB_SYNC_ALL) from a filemap_write_and_wait. 
Both could be processing the io_pages list, if the
mpage_writepages(WB_SYNC_NONE) moves a page that has locked buffers 
back to the dirty_pages list, then when the filemap_write_and_wait()
calls filemap_fdatawait, it will not wait for the page moved back
to the dirty list.

I'll code up the change and run my tests and let you know what happens.

Thanks,

Daniel


