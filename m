Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279709AbRJYE6j>; Thu, 25 Oct 2001 00:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279708AbRJYE63>; Thu, 25 Oct 2001 00:58:29 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32777 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279709AbRJYE6L>; Thu, 25 Oct 2001 00:58:11 -0400
Date: Wed, 24 Oct 2001 21:57:18 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <Pine.LNX.4.33.0110242117150.9147-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110242140350.9147-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Oct 2001, Linus Torvalds wrote:
>
> On 25 Oct 2001, Zlatko Calusic wrote:
> >
> > Sure. Output of 'vmstat 1' follows:
> >
> >  1  0  0      0 254552   5120 183476   0   0    12    24  178   438 2  37  60
> >  0  1  0      0 137296   5232 297760   0   0     4  5284  195   440 3  43  54
> >  1  0  0      0 126520   5244 308260   0   0     0 10588  215   230 0   3  96
> >  0  2  0      0 117488   5252 317064   0   0     0  8796  176   139 1   3  96
> >  0  2  0      0 107556   5264 326744   0   0     0  9704  174    78 0   3  97
>
> This does not look like a VM issue at all - at this point you're already
> getting only 10MB/s, yet the VM isn't even involved (there's definitely no
> VM pressure here).

I wonder if you're getting screwed by bdflush().. You do have a lot of
context switching going on, and you do have a clear pattern: once the
write-out gets going, you're filling new cached pages at about the same
pace that you're writing them out, which definitely means that the dirty
buffer balancing is nice and active.

So the problem is that you're obviously not actually getting the
throughput you should - it's not the VM, as the page cache grows nicely at
the same rate you're writing.

Try something for me: in fs/buffer.c make "balance_dirty_state()" never
return > 0, ie make the "return 1" be a "return 0" instead.

That will cause us to not wake up bdflush at all, and if you're just on
the "border" of 40% dirty buffer usage you'll have bdflush work in
lock-step with you, alternately writing out buffers and waiting for them.

Quite frankly, just the act of doing the "write_some_buffers()" in
balance_dirty() should cause us to block much better than the synchronous
waiting anyway, because then we will block when the request queue fills
up, not at random points.

Even so, considering that you have such a steady 9-10MB/s, please double-
check that it's not something even simpler and embarrassing, like just
having forgotten to enable auto-DMA in the kernel config ;)

		Linus

