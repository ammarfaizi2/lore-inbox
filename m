Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285609AbRLRGLV>; Tue, 18 Dec 2001 01:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285605AbRLRGLG>; Tue, 18 Dec 2001 01:11:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62989 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285609AbRLRGKm>; Tue, 18 Dec 2001 01:10:42 -0500
Date: Mon, 17 Dec 2001 22:09:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <20011217205547.C821@holomorphy.com>
Message-ID: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Dec 2001, William Lee Irwin III wrote:
>
>   5:   46490271          XT-PIC  soundblaster
>
> Approximately 4 times more often than the timer interrupt.
> That's not nice...

Yeah.

Well, looking at the issue, the problem is probably not just in the sb
driver: the soundblaster driver shares the output buffer code with a
number of other drivers (there's some horrible "dmabuf.c" code in common).

And yes, the dmabuf code will wake up the writer on every single DMA
complete interrupt. Considering that you seem to have them at least 400
times a second (and probably more, unless you've literally had sound going
since the machine was booted), I think we know why your setup spends time
in the scheduler.

> On Mon, Dec 17, 2001 at 08:27:18PM -0800, Linus Torvalds wrote:
> > Which sound driver are you using, just in case this _is_ the reason?
>
> SoundBlaster 16
> A change of hardware should help verify this.

A number of sound drivers will use the same logic.

You may be able to change this more easily some other way, by using a
larger fragment size for example. That's up to the sw that actually feeds
the sound stream, so it might be your decoder that selects a small
fragment size.

Quite frankly I don't know the sound infrastructure well enough to make
any more intelligent suggestions about other decoders or similar to try,
at this point I just start blathering.

But yes, I bet you'll also see much less impact of this if you were to
switch to more modern hardware.

grep grep grep.. Oh, before you do that, how about changing "min_fragment"
in sb_audio.c from 5 to something bigger like 9 or 10?

That

	audio_devs[devc->dev]->min_fragment = 5;

literally means that your minimum fragment size seems to be a rather
pathetic 32 bytes (which doesn't mean that your sound will be set to that,
but it _might_ be). That sounds totally ridiculous, but maybe I've
misunderstood the code.

Jeff, you've worked on the sb code at some point - does it really do
32-byte sound fragments? Why? That sounds truly insane if I really parsed
that code correctly. That's thousands of separate DMA transfers
and interrupts per second..

Raising that min_fragment thing from 5 to 10 would make the minimum DMA
buffer go from 32 bytes to 1kB, which is a _lot_ more reasonable (what,
at 2*2 bytes per sample and 44kHz would mean that a 1kB DMA buffer empties
in less than 1/100th of a second, but at least it should be < 200 irqs/sec
rather than >400).

		Linus

