Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129828AbQL2QO3>; Fri, 29 Dec 2000 11:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130092AbQL2QOT>; Fri, 29 Dec 2000 11:14:19 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:2208 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129828AbQL2QOO>; Fri, 29 Dec 2000 11:14:14 -0500
Date: Fri, 29 Dec 2000 15:46:22 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: "David S. Miller" <davem@redhat.com>
cc: ak@suse.de, torvalds@transmeta.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: test13-pre5
In-Reply-To: <200012282233.OAA01433@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0012291533000.3592-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 28 Dec 2000, David S. Miller wrote:
>    Date: 	Thu, 28 Dec 2000 23:17:22 +0100
>    From: Andi Kleen <ak@suse.de>
> 
>    Would you consider patches for any of these points? 
> 
> To me it seems just as important to make sure struct page is
> a power of 2 in size, with the waitq debugging turned off this
> is true for both 32-bit and 64-bit hosts last time I checked.

  Checking test11 (which I'm running here), even with waitq debugging
turned off, on 32-bit (IA32) the struct page is 68bytes (since
the "age" member was re-introduced a while back).

  For my development testing, I'm running a _heavily_ hacked kernel.  One
of these hacks is to pull the wait_queue_head out of struct page; the
waitq-heads are in a separate allocated area of memory, with a waitq-head
pointer embedded in the page structure (allocated/initialised in
free_area_init_core()).  This gives a page structure of 60bytes, giving me
one free double-word to play with (which I'm using as a pointer to a
release function).

  Infact, there doesn't need to be a waitq-head allocated for each page
structure - they can share; with a performance overhead on a false
wakeup in __wait_on_page().
  Note, for those of us running on 32bit with lots of physical memory, the
available virtual address-space is of major consideration.  Reducing the
size of the page structure is more than just reducing cache misses - it
gives us more virtual to play with...

Mark

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
