Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbVLLGcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbVLLGcV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 01:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbVLLGcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 01:32:21 -0500
Received: from [194.90.237.34] ([194.90.237.34]:7264 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1751158AbVLLGcU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 01:32:20 -0500
Date: Mon, 12 Dec 2005 08:35:21 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051212063521.GB24168@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <439CEE50.2060803@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439CEE50.2060803@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> > It seems that I can do
> > 
> > 	if (TestSetPageLocked(page))
> > 		schedule_work()
> > 
> > and in this way, avoid the schedule_work overhead for the common case
> > where the page isnt locked.
> > Right?
> > 
> 
> I think you can do that - provided you ensure the page mapping hasn't
> disappeared after locking it.

Ugh. I dont really know how to do that.
Isnt this sufficient?

if (TestSetPageLocked(page))
	schedule_work(...)
set_page_dirty(page)
unlock_page(page)

Thats all there seems to be set_page_dirty_lock does if it is called when
PG_Locked bit is clear.

> However, I think you should try to the simplest way first.

Thanks, Nick, thats what I have now, this already works for me here
https://openib.org/svn/gen2/trunk/src/linux-kernel/infiniband/ulp/sdp/sdp_iocb.c
I'm looking at ways to improve performance, though.

> > If that works, I can mostly do things directly,
> > although I'm still stuck with the problem of an app performing
> > a fork + write into the same page while I'm doing DMA there.
> > 
> > I am currently solving this by doing a second get_user_pages after
> > DMA is done and comparing the page lists, but this, of course,
> > needs a task context ...
> > 
> 
> Usually we don't care about these kinds of races happening. So long
> as it doesn't oops the kernel or hang the hardware, it is up to
> userspace not to do stuff like that.

Note that I am, even, not necessarily talking about full pages
here: an application could be writing to one part of a page
while hardware DMAs another part of it.
So the app is not necessarily buggy.

It seems to me people really dont want to change their applications.
They just want to load a library and have it go faster.
Given that I'm implementing a socket protocol, we are talking about
an awful lot of applications that currently work fine on top of TCP.

-- 
MST
