Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVLLILP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVLLILP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVLLILP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:11:15 -0500
Received: from [194.90.237.34] ([194.90.237.34]:64139 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP
	id S1751128AbVLLILO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:11:14 -0500
Date: Mon, 12 Dec 2005 10:14:15 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051212081415.GT14936@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <439D224A.7080007@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439D224A.7080007@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> >>>If that works, I can mostly do things directly,
> >>>although I'm still stuck with the problem of an app performing
> >>>a fork + write into the same page while I'm doing DMA there.
> >>>
> >>>I am currently solving this by doing a second get_user_pages after
> >>>DMA is done and comparing the page lists, but this, of course,
> >>>needs a task context ...
> >>>
> >>
> >>Usually we don't care about these kinds of races happening. So long
> >>as it doesn't oops the kernel or hang the hardware, it is up to
> >>userspace not to do stuff like that.
> > 
> > 
> > Note that I am, even, not necessarily talking about full pages
> > here: an application could be writing to one part of a page
> > while hardware DMAs another part of it.
> > So the app is not necessarily buggy.
> > 
> 
> Sorry, I might have misunderstdood: what's the race? And how does
> a second get_user_pages solve it?

Here's what I have in mind:

A multithreaded app calls recvmsg(2), (or io_submit with receive request),
passing in a buffer that is not page aligned.
This does get_user_pages on some page and blocks waiting for DMA to complete.

Another thread calls fork(2), marking the page for copy on write.
After fork, it writes (even 1 byte) into one of the pages that were passed
to recvmsg, possibly even outside the buffer passed to recvmsg.
This triggers a page copy in the parent process.

Any data that the device DMA's into this page after this point is not
seen by the application, since it goes into the original page,
while a copy is now mapped into the parent's memory.

-- 
MST
