Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTLaJfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 04:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLaJfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 04:35:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:26802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263861AbTLaJfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 04:35:08 -0500
Date: Wed, 31 Dec 2003 01:35:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: daniel@osdl.org, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.0-test10-mm1] filemap_fdatawait.patch
Message-Id: <20031231013521.79920efd.akpm@osdl.org>
In-Reply-To: <20031231091828.GA4012@in.ibm.com>
References: <3FCD4B66.8090905@us.ibm.com>
	<1070674185.1929.9.camel@ibm-c.pdx.osdl.net>
	<1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	<1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	<20031216180319.6d9670e4.akpm@osdl.org>
	<20031231091828.GA4012@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> It seems like the case Daniel is thinking about is when 
> a process has issued writes to the page cache, and then filemap_fdatawrite
> is called, while these pages are being written back to disk parallely by 
> another thread (not holding i_sem). The filemap_fdatawrite wouldn't see
> pages that are in the process of being written out by the background
> thread so it doesn't mark them for writeback.

If those pages are under writeout then they are clean and
filemap_fdatawrite() has nothing to do.

If, however, those pages were redirtied while under I/O then they are
dirty, on dirty_pages and are under writeout.  In that case
filemap_fdatawrite() must wait for the current write to complete and must
start a new write.

> The following filemap_fdatawait 
> would find these pages on the locked_pages list all right, but if its
> unlucky enough to be in the window that Daniel mentions where PG_dirty 
> is cleared but PG_writeback hasn't yet been set, then the page would
> have move to the clean list without waiting for the actual writeout
> to complete !

If you are referring to this code in mpage_writepage():

		lock_page(page);

		if (wbc->sync_mode != WB_SYNC_NONE)
			wait_on_page_writeback(page);

		if (page->mapping == mapping && !PageWriteback(page) &&
					test_clear_page_dirty(page)) {


then I don't see the race - the page lock synchronises the two threads?


