Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUBMXsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 18:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267247AbUBMXrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 18:47:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:34267 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267235AbUBMXq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 18:46:29 -0500
Date: Fri, 13 Feb 2004 15:48:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.3-rc2-mm1] __block_write_full patch
Message-Id: <20040213154815.42e74cb5.akpm@osdl.org>
In-Reply-To: <1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
References: <20040212015710.3b0dee67.akpm@osdl.org>
	<1076707830.1956.46.camel@ibm-c.pdx.osdl.net>
	<20040213143836.0a5fdabb.akpm@osdl.org>
	<1076715039.1956.104.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> My only concern is that a racing mpage_writepages(WB_SYNC_NONE)
> with a mpage_write_pages(WB_SYNC_ALL) from a filemap_write_and_wait. 
> Both could be processing the io_pages list, if the
> mpage_writepages(WB_SYNC_NONE) moves a page that has locked buffers 
> back to the dirty_pages list, then when the filemap_write_and_wait()
> calls filemap_fdatawait, it will not wait for the page moved back
> to the dirty list.

Yes.  I suspect we simply cannot get this right without insane locking. 
We're trying to do something here which the writeback code simply does not
and cannot generally do, namely write and wait upon IO and dirtyings which
are initiated by other processes.

The best way to handle *all* this crap is to remove the address_space page
lists completely and replace all these things with radix tree walks, but I
never got onto that.  Sad.

Maybe we could implement some form of per-address_space serialisation which
permts multiple WB_SYNC_NONE writers, but exclusive WB_SYNC_ALL writers. 
That's basically an rwsem, but we don't want to block WB_SYNC_NONE
processes if there's a sync in progress.

So WB_SYNC_NONE callers would use down_read_trylock() and WB_SYNC_ALL
callers would use down_write().   That just fixes all this stuff up.

