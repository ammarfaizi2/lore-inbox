Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136903AbRAHGEe>; Mon, 8 Jan 2001 01:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136929AbRAHGEY>; Mon, 8 Jan 2001 01:04:24 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:49932 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136903AbRAHGEH>; Mon, 8 Jan 2001 01:04:07 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Subtle MM bug
Date: 7 Jan 2001 22:04:04 -0800
Organization: Transmeta Corporation
Message-ID: <93bl8k$sb3$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0101072014300.17414-100000@mf1.private> <20010108064225.B29026@gruyere.muc.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010108064225.B29026@gruyere.muc.suse.de>,
Andi Kleen  <ak@suse.de> wrote:
>On Sun, Jan 07, 2001 at 09:29:29PM -0800, Wayne Whitney wrote:
>> The application is some mathematics computations (modular symbols) using a
>> package called MAGMA;  at times this requires very large matrices.  The
>> RSS can get up to 870MB; for some reason a MAGMA process under linux
>> thinks it has run out of memory at 870MB, regardless of the actual
>> memory/swap in the machine.  MAGMA is single-threaded.
>
>I think it's caused by the way malloc maps its memory. 
>Newer glibc should work a bit better by falling back to mmap even for smaller
>allocations (older does it only for very big ones) 

That doesn't resolve the "2.4.x behaves badly" thing, though.

I've seen that one myself, and it seems to be simply due to the fact
that we're usually so good at gettign memory from page_launder() that we
never bother to try to swap stuff out. And when we _do_ start swapping
stuff out it just moves to the dirty list, and page_launder() will take
care of it.

So far so good. The problem appears to be that we don't swap stuff out
smoothly: we start doing the VM scanning, but when we get enough dirty
pages, we'll let it be, and go back to page_launder() again. Which means
that we don't walk theough the whole VM space, we just do some "spot
cleaning".

		Linus 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
