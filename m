Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUCPV4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUCPV4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:56:19 -0500
Received: from ns.suse.de ([195.135.220.2]:63958 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261430AbUCPV4R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:56:17 -0500
Subject: Re: 2.6.4-mm2
From: Chris Mason <mason@suse.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <1079461971.23783.5.camel@ibm-c.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1079474312.4186.927.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 16:58:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-16 at 13:32, Daniel McNeil wrote:
> Andrew,
> 
> I re-ran six copies of the direct_read_under test on an 8-proc
> machine last night.  All six tests saw uninitialized data.

It is possible to trigger mpage_writepages twice at the same time,
right?  Say once from sync_sb_inodes and once from filemap_fdatawrite? 
I'm assuming Daniel is hitting the same bug he reported before, a race
between ll_rw_block from ext3 data=ordered and sychronous writeback from
fsync or O_DIRECT.

Picture one proc in mpage_writepages with wbc->sync_mode ==
WBC_SYNC_NONE, and a second proc with sync_mod = WBC_SYNC_ALL.  The file
in question has one dirty page and that one page is being written by
kjournald in a data=ordered flush.

The sync none proc gets to a page with a locked buffer being written by
ll_rw_block.  It locks the page, calls test_clear_page_dirty, and then
calls writepage.

The sync all proc now calls pagevec_lookup_tag(PAGECACHE_TAG_DIRTY), no
pages are returned, so it returns.

The sync none proc gets to the buffer_locked check in
__block_write_full_page and properly retags the page with
PAGECACHE_TAG_DIRTY, but it's too late.  The sync all proc has already
skipped the page.

That's my theory anyway...

-chris

