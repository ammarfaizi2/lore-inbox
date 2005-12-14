Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbVLNRk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbVLNRk7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVLNRk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:40:59 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:64895 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932478AbVLNRk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:40:58 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Date: Wed, 14 Dec 2005 09:22:43 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       dpervushin@gmail.com, akpm@osdl.org, basicmark@yahoo.com,
       komal_shah802003@yahoo.com, stephen@streetfiresound.com,
       spi-devel-general@lists.sourceforge.net, Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <20051213191531.GA13751@kroah.com> <43A0230B.1040904@ru.mvista.com>
In-Reply-To: <43A0230B.1040904@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512140922.43877.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 December 2005 5:50 am, Vitaly Wool wrote:
> >>It's way better to just insist that all I/O buffers (in all
> >>generic APIs) be DMA-safe.  AFAICT that's a pretty standard
> >>rule everywhere in Linux.
> >
> >I agree.  
> 
> Well, why then David doesn't insist on that in his own code?
> His synchronous transfer functions

You seem to be referring to one non-generic function that's
documented as OK to pass DMA-unsafe buffers to.  There are
several other synchronous transfer calls that don't make
such guarantees.


> are allocating transfer buffers on  
> stack which is not DMA-safe.

I think the very first version did that, but nothing since
has taken that shortcut.  (Several months now.)  It uses
a buffer that's allocated on the heap.


> Then he starts messing with allocate-or-use-preallocated stuff etc. etc.
> Why isn't he just kmalloc'ing/kfree'ing buffers each time these 
> functions are called 

So that the typical case, with little SPI contention, doesn't
hit the heap?  That's sure what I thought ... though I can't speak
for what other people may think I thought.  You were the one that
wanted to optimize the atypical case to remove a blocking path!


> (as he proposes for upper layer drivers to do)? 

No I didn't.  I actually said that the upper layer drivers should
just not use DMA-unsafe areas for I/O buffers in the first place.
Places like stacks or static data.  Doing that means there's never
a need for a new kmalloc buffer, unless maybe you're marshaling
things into a scratch buffer.


> The thing is that only controller driver is aware whether DMA is needed 
> or not, so it's controller driver that should work it out.

Given the policy that all code avoids DMA-unsafe areas for I/O buffers,
the issue has already been worked out globally.

- Dave
