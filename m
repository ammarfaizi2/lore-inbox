Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284506AbRLRShe>; Tue, 18 Dec 2001 13:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284500AbRLRSgz>; Tue, 18 Dec 2001 13:36:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59666 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284484AbRLRSgn>; Tue, 18 Dec 2001 13:36:43 -0500
Date: Tue, 18 Dec 2001 10:35:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andreas Dilger <adilger@turbolabs.com>
cc: David Mansfield <david@cobite.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011218105459.X855@lynx.no>
Message-ID: <Pine.LNX.4.33.0112181012540.2998-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Dec 2001, Andreas Dilger wrote:
>
> Yes, esd is an interrupt hog, it seems.  When reading this thread, I
> checked, and sure enough I was getting 190 interrupts/sec on the
> sound card while not playing any sound.  I killed esd (which I don't
> use anyways), and interrupts went to 0/sec when not playing sound.
> Still at 190/sec when using mpg123 on my ymfpci (Yamaha YMF744B DS-1S)
> sound card.

190 interrupts / sec sounds excessive, but not wildly so. The interrupt
per se is not going to be a CPU hog unless the sound card does programmed
IO to fill the data queues, and while that is not unheard of, I don't
think such a card has been made in the last five years.

Obviously getting 190 irq's per second even when not actually _doing_
anything is a total waste of CPU, and is bad form. There may be some
reason why esd does it, most probably for good synchronization between
sound events and to avoid popping when the sound is shut down (many sound
drivers seem to pop a bit on open/close, possibly due to driver bugs, but
possibly because some hard-to-avoid-programmatically hardware glitch when
powering down the logic.

So waiting a while with the driver active may actually be a reasonable
thing to do, although I suspect that after long sequences of silence "esd"
should really shut down for a while (and "long" here is probably on the
order of seconds, not minutes).

What probably _really_ ends up hurting performance is probably not the
interrupt per se (although it is noticeable), but the fact that we wake up
and cause a schedule - which often blows any CPU caches, making the _next_
interrupt also be more expensive than it would possibly need to be.

The code for that (in the case of drivers that use the generic "dmabuf.c"
infrastructure) seems to be in "finish_output_interrupt()", and I suspect
that it could be improved with something like

	dmap = adev->dmap_out;
	lim = dmap->nbufs;
	if (lim < 2) lim = 2;
	if (dmap->qlen <= lim/2) {
		...
	}

around the current unconditional wakeups.

Yeah, yeah, untested, stupid example, the idea being that we only wake up
if we have at least half the frags free now, instead of waking up for
_every_ fragment that free's up.

The above is just as a suggestion for some testing, if somebody actually
feels like trying it out. It probably won't be good as-is, but as a
starting point..

		Linus

