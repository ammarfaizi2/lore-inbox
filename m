Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130733AbRBEV3m>; Mon, 5 Feb 2001 16:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRBEV3c>; Mon, 5 Feb 2001 16:29:32 -0500
Received: from chiara.elte.hu ([157.181.150.200]:29961 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130733AbRBEV3T>;
	Mon, 5 Feb 2001 16:29:19 -0500
Date: Mon, 5 Feb 2001 22:28:37 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Steve Lord <lord@sgi.com>, <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
 /notify + callback chains
In-Reply-To: <20010205121921.C1167@redhat.com>
Message-ID: <Pine.LNX.4.30.0102052213470.10520-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 5 Feb 2001, Stephen C. Tweedie wrote:

> And no, the IO success is *not* necessarily sequential from the start
> of the IO: if you are doing IO to raid0, for example, and the IO gets
> striped across two disks, you might find that the first disk gets an
> error so the start of the IO fails but the rest completes.  It's the
> completion code which notifies the caller of what worked and what did
> not.

it's exactly these 'compound' structures i'm vehemently against. I do
think it's a design nightmare. I can picture these monster kiobufs
complicating the whole code for no good reason - we couldnt even get the
bh-list code in block_device.c right - why do you think kiobufs *all
across the kernel* will be any better?

RAID0 is not an issue. Split it up, use separate kiobufs for every
different disk. We need simple constructs - i do not believe why nobody
sees that these big fat monster-trucks of IO workload are *trouble*. They
keep things localized, instead of putting workload components into the
system immediately. We'll have performance bugs nobody has seen before.
bhs have one very nice property: they are simple, modularized. I think
this is like CISC vs. RISC: CISC designs ended up splitting 'fat
instructions' up into RISC-like instructions.

fragmented skbs are a different matter: they are simply a bit more generic
abstractions of 'memory buffer'. Clear goal, clear solution. I do not
think kiobufs have clear goals.

and i do not buy the performance arguments. In 2.4.1 we improved block-IO
performance dramatically by fixing high-load IO scheduling. Write
performance suddenly improved dramatically, there is a 30-40% improvement
in dbench performance. To put in another way: *we needed 5 years to fix a
serious IO-subsystem performance bug*. Block IO was already too complex -
and Alex & Andrea have done a nice job streamlining and cleaning it up for
2.4. We should simplify it further - and optimize the components, instead
of bringing in yet another *big* complication into the API.

and what is the goal of having multi-page kiobufs. To avoid having to do
multiple function calls via a simpler interface? Shouldnt we optimize that
codepath instead?

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
