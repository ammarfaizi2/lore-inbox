Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLRMSP>; Mon, 18 Dec 2000 07:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLRMSG>; Mon, 18 Dec 2000 07:18:06 -0500
Received: from zeus.kernel.org ([209.10.41.242]:11013 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129340AbQLRMRx>;
	Mon, 18 Dec 2000 07:17:53 -0500
Date: Mon, 18 Dec 2000 11:44:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Test12 ll_rw_block error.
Message-ID: <20001218114404.D21351@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10012142208420.1308-100000@penguin.transmeta.com> <Pine.GSO.4.21.0012150150570.11106-100000@weyl.math.psu.edu> <20001215105148.E11931@redhat.com> <3A3C11F2.130DE89E@thebarn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A3C11F2.130DE89E@thebarn.com>; from cattelan@thebarn.com on Sat, Dec 16, 2000 at 07:08:02PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 16, 2000 at 07:08:02PM -0600, Russell Cattelan wrote:
> > There is a very clean way of doing this with address spaces.  It's
> > something I would like to see done properly for 2.5: eliminate all
> > knowledge of buffer_heads from the VM layer.  It would be pretty
> > simple to remove page->buffers completely and replace it with a
> > page->private pointer, owned by whatever address_space controlled the
> > page.  Instead of trying to unmap and flush buffers on the page
> > directly, these operations would become address_space operations.
> 
> Yes this is a lot of what page buf would like to do eventually.
> Have the VM system pressure page_buf for pages which would
> then be able to intelligently call the file system to free up cached pages.
> A big part of getting Delay Alloc to not completely consume all the
> system pages, is being told when it's time to start really allocating disk
> space and push pages out.

Delayed allocation is actually much easier, since it's entirely an
operation on logical page addresses, not physical ones --- by
definition you don't have any buffer_heads yet because you haven't
decided on the disk blocks.  If you're just dealing with pages, not
blocks, then the address_space is the natural way of dealing with it
already.  

Only the full semantics of the flush callback have been missing to
date, and with 2.4.0-test12 even that is mostly solved, since
page_launder will give you the writeback() callbacks you need to flush
things to disk when you start getting memory pressure.  You can even
treat the writepage() as an advisory call.  

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
