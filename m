Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUEQOcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUEQOcy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUEQOcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:32:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:55223 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261439AbUEQOcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:32:51 -0400
Date: Mon, 17 May 2004 07:32:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <20040517141427.GD29054@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com>
 <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com>
 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040517141427.GD29054@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 May 2004, Larry McVoy wrote:
>
> On Sun, May 16, 2004 at 10:17:58PM -0700, Linus Torvalds wrote:
> > > Found null start 0x1550b01 end 0x1551000 len 0x4ff line 535587
> > > Found null start 0x2030b01 end 0x2031000 len 0x4ff line 639039
> > > Found null start 0x2330b01 end 0x2331000 len 0x4ff line 663611
> > 
> > The fact that it's always zeroes, and it's an strange number but it always 
> > ends up being page-aligned at the _end_ makes me strongly suspect that we 
> > have one of the "don't write back data past i_size" things wrong.
> 
> Isn't it weird that it is starting at 0xb01 and has the same length at
> three different offsets?  That's a definite pattern and might be a clue.

Note that in the previous case, it was 1352 bytes of NUL (according to the 
subject), now it's 1279. So it's only consistantly the same offset for one 
particular run, and changes between cases.

I agree that it isn't just random, though:

> And note that the weird starting offset plus the length is a page size.

My claim (which may be bogus, but isn't), is that you wrote the file with 
a buffered interface like stdio (or your own buffers), and that the buffer 
size is likely a nice round number like 8kB or something. I think that's 
what stdio uses by default.

And at some point earlier in the process you did an fflush(), or somebody
else had written a header of n*PAGE_SIZE + 0x4ff bytes, or something like
that. Since this was the ChangeSet file, I suspect that the "header" is 
the checkin-comment section at the beginning, and the "second phase" is 
the actual key list thing. You know how you write the ChangeSet file 
better than I do.

So what happens is that for _that_ run of BK, the ChangeSet file will 
first have an i_size that is always at an even page offset (when it is 
writing the first phase, buffered), and then in the second phase i_size 
will always be "fixed offset + n*BUFFER_SIZE".

And in this case the fixed offset happened to be 0x4ff. Last time it was 
something else.

The bug I think triggered only happens when i_size is not on a page 
boundary, so the first phase will never see a zeroed area. And the second 
phase will always see a zeroed area that starts at the same offset.

So this would explain it, except I just noticed that the unlock_page() 
already _is_ way down after we update the i_size. Oh well.

		Linus
