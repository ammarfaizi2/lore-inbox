Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbUCTUNt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 15:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbUCTUNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 15:13:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:916 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263526AbUCTUNs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 15:13:48 -0500
Date: Sat, 20 Mar 2004 12:13:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-Id: <20040320121345.2a80e6a0.akpm@osdl.org>
In-Reply-To: <20040320150621.GO9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random>
	<20040320144022.GC2045@holomorphy.com>
	<20040320150621.GO9009@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Sat, Mar 20, 2004 at 06:40:22AM -0800, William Lee Irwin III wrote:
> > On Sat, Mar 20, 2004 at 02:30:25PM +0100, Andrea Arcangeli wrote:
> > > Anyways returning to the non-ram returned by ->nopage see the below
> > > email exchange with Jens. the bug triggering of course is the
> > > BUG_ON(!pfn_valid(page_to_pfn(new_page))).
> > > If we want to return non-ram, we could, but I believe we should change
> > > the API to return a pfn not a page_t * if we want to.
> > 
> > This would be very helpful for other reasons also. There's a general
> > API issue with drivers that want or need to do this. The one I've
> 
> I'm afraid I'll have to teach ->nopage how to deal with non-ram with
> this page_t API too (changing it to pfn sounds too intrusive in the
> short term), it seems to me that alsa can return non-ram (in the nopage
> callback there's a virt_to_page on some iomm region), and changing alsa
> to use remap_file_pages sounds too intrusive too. 

I had a check in a valid pfn in page_add_rmap() for several weeks before I
actually removed the test.  The debug check never triggered.  But looking
at the code I don't see why not.  Weird.

fyi, we don't need the check in page_referenced() and try_to_unmap()
because do_no_page() does not place pages on the LRU.  It is the ->nopage
implementation which is responsible for that.  Presumably the ALSA driver
was not adding the "page" to the LRU.

I agree that ->nopage implementations should not be doing what that driver
is doing.  ->nopage is defined to return a page*: it's crazy to be
returning someting from there which isn't covered by mem_map[].

I just don't think it's important enough to be able to cope with
non-mem_map[] "memory" in do_no_page(), so I agree that requiring ->mmap()
to synchronously instantiate the pte's and retaining the debug check in
do_no_page() is a good idea.

