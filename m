Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267192AbUBNACS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 19:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267204AbUBNACS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 19:02:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:20453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267192AbUBNACM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:02:12 -0500
Subject: Re: [PATCH 2.6.3-rc2-mm1] __block_write_full patch
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040213154815.42e74cb5.akpm@osdl.org>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	 <1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
	 <20040213143836.0a5fdabb.akpm@osdl.org>
	 <1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
	 <20040213154815.42e74cb5.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1076716924.1956.113.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 Feb 2004 16:02:04 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-13 at 15:48, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > My only concern is that a racing mpage_writepages(WB_SYNC_NONE)
> > with a mpage_write_pages(WB_SYNC_ALL) from a filemap_write_and_wait. 
> > Both could be processing the io_pages list, if the
> > mpage_writepages(WB_SYNC_NONE) moves a page that has locked buffers 
> > back to the dirty_pages list, then when the filemap_write_and_wait()
> > calls filemap_fdatawait, it will not wait for the page moved back
> > to the dirty list.
> 
> Yes.  I suspect we simply cannot get this right without insane locking. 
> We're trying to do something here which the writeback code simply does not
> and cannot generally do, namely write and wait upon IO and dirtyings which
> are initiated by other processes.
> 
> The best way to handle *all* this crap is to remove the address_space page
> lists completely and replace all these things with radix tree walks, but I
> never got onto that.  Sad.
> 
> Maybe we could implement some form of per-address_space serialisation which
> permts multiple WB_SYNC_NONE writers, but exclusive WB_SYNC_ALL writers. 
> That's basically an rwsem, but we don't want to block WB_SYNC_NONE
> processes if there's a sync in progress.
> 
> So WB_SYNC_NONE callers would use down_read_trylock() and WB_SYNC_ALL
> callers would use down_write().   That just fixes all this stuff up.
> 

This sounds like an interesting idea.  I'll take a look and see if
I can give it a try.

BTW, the 2.6.3-rc2-mm1 __block_write_full_page() almost already did
your option c) except for the "if (buffer_dirty())".  If the
buffer is in flight buffer_dirty would already be cleared, so
it would not call __set_page_dirty_nobuffers().

                if (wbc->sync_mode != WB_SYNC_NONE) {
                        lock_buffer(bh);
                } else {
                        if (test_set_buffer_locked(bh)) {
                                if (buffer_dirty(bh))
                                        __set_page_dirty_nobuffers(page);
                                continue;
                        }
                }
Thanks,

Daniel


