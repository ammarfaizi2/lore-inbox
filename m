Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVLLIw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVLLIw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 03:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVLLIw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 03:52:29 -0500
Received: from [194.90.237.34] ([194.90.237.34]:3233 "EHLO mtlex01.yok.mtl.com")
	by vger.kernel.org with ESMTP id S1750732AbVLLIw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 03:52:29 -0500
Date: Mon, 12 Dec 2005 10:55:32 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: set_page_dirty vs set_page_dirty_lock
Message-ID: <20051212085532.GW14936@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <439D3592.70100@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439D3592.70100@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Piggin <nickpiggin@yahoo.com.au>:
> OK, yeah if a thread in the parent process writes into the buffer, then
> yes this would leave the copy in the parent AFAIKS.
> 
> But this is going to do similar weird stuff when racing with
> copy_to_user
> with ethernet recvmsg, is it not? (and direct-io and probably others).

FWIW, I think that copy_to_user will work correctly since it keeps the mmap
semaphore for the duration of the copy.
Direct-io might have the same problem.

> As such, I don't think it would be something you in particular need to
> worry about.
> 
> I guess to solve it, we could either retain mmap_sem for the duration to
> prevent fork,

Since this is the receive side, the DMA can take an indefinite
time to arrive. Isnt this a problem if we keep the mmap_sem?

> or try to do something tricky with page_count to determine
> if we need to do a copy in fork() rather than a COW.

I'm actually reasonably happy with the trick that I'm using:
performing a second get_user_pages after DMA and comparing
the page lists.
However, doing this every time on the off chance that a
page was made COW forces me into task context, every time.

-- 
MST
