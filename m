Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291675AbSBHRpe>; Fri, 8 Feb 2002 12:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291676AbSBHRpZ>; Fri, 8 Feb 2002 12:45:25 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48019 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291675AbSBHRpL>; Fri, 8 Feb 2002 12:45:11 -0500
Date: Fri, 8 Feb 2002 17:46:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        "David S. Miller" <davem@redhat.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
In-Reply-To: <3C630D5D.CD66795@zip.com.au>
Message-ID: <Pine.LNX.4.21.0202081649120.1497-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Feb 2002, Andrew Morton wrote:
> 
> OK, I agree the weird case won't trigger the bug.   So I think we
> agree that we need to run with Hugh's BUG check and do nothing else.

Thank you, Andrew and Andrea, for exploring and exploding those myths.
I've checked back on the BUG which Ben submitted his 1st Jan patch for,
and it was actually a PageLRU(page) in rmqueue, not in __free_pages_ok,
so his patch would not have solved it.

But I cannot yet agree that Marcelo should take my interrupt BUG patch.
I've also checked back on the BUG which I submitted my 15th Nov patch
for (making unmap_kiobuf use page_cache_release instead of put_page),
and Gerd Knorr's report (extracts below) implies that his bttv driver
was calling unmap_kiobuf at interrupt time.  Is that right, Gerd?

If that's so, then my proposed in_interrupt check before lru_cache_del
will just give him a BUG again (and my 15th Nov patch was mistaken to
encourage him to unmap at interrupt time).  Now maybe Gerd's code is
wrong anyway: a quick look suggests it may also vfree there, which
would be wrong at interrupt time.  But whether his code is right or
wrong, unmap_kiobuf used to be safe at interrupt time and now is not
(in some rare circumstances): are we right to have made that change?

Ben, you probably have an AIO opinion here.  Is there a circumstance
in which AIO can unpin a user page at interrupt time, after the
calling task has (exited or) unmapped the page?

Hugh

Subject: [PATCH] Re: kiobuf / vm bug
On Thu, 15 Nov 2001, Gerd Knorr wrote:
> 
> I think I have found a kiobuf-related bug in the VM of recent linux
> kernels.  2.4.13 is fine, 2.4.14-pre1 doesn't boot my machine,
> 2.4.14-pre2 + newer kernels are broken.
> 
> /me runs a kernel with a few v4l-related patches and my current 0.8.x
> bttv version (available from http://bytesex.org/patches/ +
> http://bytesex.org/bttv/).
> 
> With this kernel I can trigger the following BUG():
> ksymoops 2.4.3 on i686 2.4.15-pre4.  Options used
> kernel BUG at page_alloc.c:84!
> >>EIP; c0129e5a <__free_pages_ok+aa/29c>   <=====
> Trace; c012a6f2 <__free_pages+1a/1c>
> Trace; c0121120 <unmap_kiobuf+34/48>
> 
> The Oops seems to be triggered by the following actions:
> 
> (1) the application maps /dev/video0.  bttv 0.8.x simply returns some
>     shared anonymous memory to as mapping.
> (2) the application asks the driver to capture a frame.  bttv will lock
>     down the anonymous memory using kiobufs for I/O and prepare
>     everything for DMA xfer.
> (3) The applications exits for some reason, i.e. the anonymous memory
>     will be unmapped while the DMA transfer is active and the pages are
>     locked down for I/O.
> (4) The DMA xfer is done and bttv's irq handler cleans up everything.
>     This includes calling unlock_kiovec+unmap_kiobuf for the locked
>     pages.  The unmap_kiobuf call at this point triggeres the Oops
>     listed above ...

