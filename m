Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292763AbSCEBIO>; Mon, 4 Mar 2002 20:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293103AbSCEBIF>; Mon, 4 Mar 2002 20:08:05 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32101 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292763AbSCEBHp>; Mon, 4 Mar 2002 20:07:45 -0500
Date: Tue, 5 Mar 2002 02:05:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305020546.W20606@dualathlon.random>
In-Reply-To: <20020305005215.U20606@dualathlon.random> <Pine.LNX.4.44L.0203042056110.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203042056110.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 09:01:31PM -0300, Rik van Riel wrote:
> This could be expressed as:
> 
> "node A"  HIGHMEM A -> HIGHMEM B -> NORMAL -> DMA
> "node B"  HIGHMEM B -> HIGHMEM A -> NORMAL -> DMA

Highmem? Let's assume you speak about "normal" and "dma" only of course.

And that's not always the right zonelist layout. If an allocation asks for
ram from a certain node, like during the ram bindings, we should use the
current layout of the numa zonelist. If node A is the preferred, than we
should allocate from node A first, other logics (see the point-of-view
watermarks in my tree) will make sure you fallback into node B if we
risk to be unbalanced across the zones. However, the layout you mentioned
above is sometime the right layout, for example for allocations with no
"preference" on the node to allocate from, your layout would make
perfect sense. But at the moment we miss an API to choose if the node
allocation should be strict or not.

Said that, see below to see how to implement the zonelist layout you
suggested on top of the current vm (regardless if it's the best generic
layout or not).

>
> How would you express this situation in classzone ?

Check my tree in the 20_numa-mm-1 patch, to implement your above layout,
you need to make a 10 line change to build_zonelistss so that it fills
the zonelist array with normal B before dma (and other way around for
the normal classzone zonelist on the node B).

The memory balancing in my tree will just do the right thing after that,
check the memclass based on zone_idx (that was needed for the old numa
too infact).

In short it fits beautifully into it.

> So why would kswapd not go mad _with_ classzone ?

because nobody asks for GFP_DMA and nobody cares about the state of the
DMA classzone. And if somebody does it is right that kswapd has to try
to make some progress, but if nobody asks there's no good reason to
waste CPU.

the scsi pool being allocated from DMA is not a problem, that never
happens at runtime. if it happens before production kswapd will stop in
a few seconds after a failed try.

> I bet the workaround for that problem has very little
> to do with classzones...

that is not a workaround, the memory balancing knows what classzone it
has to work on and so it doesn't fall into a senseless trap of trying to
free a classzone that nobody cares about.

My current VM code is very advanced about knowing every detail, it's not
a guess "let's look at which zones have plenty of memory".  Just like it
supports NUMA layouts like the above you mentioned just fine (even if
you want to add highmem or any other zones you want). Note that this is
all unrelated to rmap, we can just put rmap on top of my VM bits without
any problem, that's completly orthogonal with the other bits.

Andrea
