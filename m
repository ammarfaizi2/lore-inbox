Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284156AbRLRQTq>; Tue, 18 Dec 2001 11:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284177AbRLRQTh>; Tue, 18 Dec 2001 11:19:37 -0500
Received: from maila.telia.com ([194.22.194.231]:29927 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S284176AbRLRQTV>;
	Tue, 18 Dec 2001 11:19:21 -0500
Message-Id: <200112181619.fBIGJBv13914@maila.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Linus Torvalds <torvalds@transmeta.com>,
        William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Scheduler ( was: Just a second ) ...
Date: Tue, 18 Dec 2001 17:16:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-audio-dev@music.columbia.edu,
        Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112172153410.2416-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This might be of interest on linux-audio-dev too...

On Tuesday den 18 December 2001 07.09, Linus Torvalds wrote:
> On Mon, 17 Dec 2001, William Lee Irwin III wrote:
> >   5:   46490271          XT-PIC  soundblaster
> >
> > Approximately 4 times more often than the timer interrupt.
> > That's not nice...
>
> Yeah.
>
> Well, looking at the issue, the problem is probably not just in the sb
> driver: the soundblaster driver shares the output buffer code with a
> number of other drivers (there's some horrible "dmabuf.c" code in common).
>
> And yes, the dmabuf code will wake up the writer on every single DMA
> complete interrupt. Considering that you seem to have them at least 400
> times a second (and probably more, unless you've literally had sound going
> since the machine was booted), I think we know why your setup spends time
> in the scheduler.
>
> > On Mon, Dec 17, 2001 at 08:27:18PM -0800, Linus Torvalds wrote:
> > > Which sound driver are you using, just in case this _is_ the reason?
> >
> > SoundBlaster 16
> > A change of hardware should help verify this.
>
> A number of sound drivers will use the same logic.
>
> You may be able to change this more easily some other way, by using a
> larger fragment size for example. That's up to the sw that actually feeds
> the sound stream, so it might be your decoder that selects a small
> fragment size.
>
> Quite frankly I don't know the sound infrastructure well enough to make
> any more intelligent suggestions about other decoders or similar to try,
> at this point I just start blathering.
>
> But yes, I bet you'll also see much less impact of this if you were to
> switch to more modern hardware.
>
> grep grep grep.. Oh, before you do that, how about changing "min_fragment"
> in sb_audio.c from 5 to something bigger like 9 or 10?
>
> That
>
> 	audio_devs[devc->dev]->min_fragment = 5;
>
> literally means that your minimum fragment size seems to be a rather
> pathetic 32 bytes (which doesn't mean that your sound will be set to that,
> but it _might_ be). That sounds totally ridiculous, but maybe I've
> misunderstood the code.

I think it really is 32 samples, yes that is little - but too small?
It depends on the used sample frequency...

Paul Davis wrote this on linux-audio-dev 2001-12-05
"in doing lots of testing on JACK, i've noticed that although the
trident driver now works (there were some patches from jaroslav and
myself), in general i still get xruns with the lowest possible latency
setting for that card (1.3msec per interrupt, 2.6msec buffer). with
the same settings on my hammerfall, i don't get xruns, even with
substantial system load."

>
> Jeff, you've worked on the sb code at some point - does it really do
> 32-byte sound fragments? Why? That sounds truly insane if I really parsed
> that code correctly. That's thousands of separate DMA transfers
> and interrupts per second..
>

Lets see: we have >1 GHz CPU and interrupts at >1000 Hz
 => 1 Mcycle / interrupt - is that insane?

If the hardware can support it? Why not let it? It is really up to the 
applications/user to decide...

> Raising that min_fragment thing from 5 to 10 would make the minimum DMA
> buffer go from 32 bytes to 1kB, which is a _lot_ more reasonable (what,
> at 2*2 bytes per sample and 44kHz would mean that a 1kB DMA buffer empties
> in less than 1/100th of a second, but at least it should be < 200 irqs/sec
> rather than >400).
>

Yes, it is probably more reasonable - but if the soundcard can support it?
(I have a vision of lots of linux-audio-dev folks pulling out their new 
soundcard and replacing it with their since long forgotten SB16...)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
