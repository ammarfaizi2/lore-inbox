Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310261AbSCBCJW>; Fri, 1 Mar 2002 21:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310260AbSCBCJN>; Fri, 1 Mar 2002 21:09:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12888 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310261AbSCBCJA>; Fri, 1 Mar 2002 21:09:00 -0500
Date: Sat, 2 Mar 2002 03:06:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020302030615.G4431@inspiron.random>
In-Reply-To: <20020301013056.GD2711@matchmail.com> <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 10:26:48PM -0500, Bill Davidsen wrote:
> rather than patches. But there are a lot more small machines (which I feel
> are better served by rmap) than large. I would like to leave the jury out

I think there's quite some confusion going on from the rmap users, let's
clarify the facts.

The rmap design in the VM is all about decreasing the complexity of
swap_out on the huge boxes (so it's all about saving CPU), by slowing
down a big lots of fast common paths like page faults and by paying with
some memory too. See the lmbench numbers posted by Randy after applying
rmap to see what I mean.

On a very lowmem machine the rmap design shouldn't really make a sensible
difference, the smaller the amount of mapped VM, the less rmap can make
differences, period.

So I wouldn't really worry about the low mem machines. I guess what
makes the difference for you (the responsiveness part) are things like
read-latency2 included at least in some variant of the rmap patch, but
they're completly orthogonal to the VM (they're included in the rmap
patch just incidentally, the rmap patch isn't just about the rmap
design, it's lots of other stuff too, please don't mistake this for a
blame, I would prefer if it would be kept separated so people wouldn't
be confused thinking rmap gives the responsiveness on the lowmem boxes,
but I'm also not perfect sometime at maintaining patches, see vm-28, it
does more than just one thing, even if they're at least all vm related
things).

Note that I'm listening to the rmap design too, and Rik's implementation
should be better than the last one I seen last year from Dave, but I
really am not going to slow down page faults and other paths just to
save CPU during heavy swapout in 2.4, all my machines are mostly idle
during heavy swapout/pageout anyways.

For 2.5 it would be easy to integrate just the rmap design from Rik's
patch on top of my vm-28, as far as the design is concerned that's
orthogonal with all the other changes I'm doing, but the very visible
lmbench slowdowns for lots of the important common paths didn't made it
appealing to me yet (first somebody has to show me the total wastage of
cpu during swapout with my current patch applied, I mean the last column
on the right of vmstat).

So in short you may want to try 2.4.19pre1 + vm-28 + read-latency2 (or
even more simply 2.4.19pre1aa1 + read-latency2) and see if it makes the
system as responsive as rmap for you on the lowmem boxes. let us know if
it helps, thanks!

IMHO vm-28 should be somehow included into mainline ASAP (before 2.4.19
is released), then again IMHO we can forget about the 2.4 VM and it will
be definitely finished.

Andrea
