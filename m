Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263361AbUJ2OWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbUJ2OWr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 10:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263344AbUJ2OWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 10:22:47 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:63399 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S263341AbUJ2OTS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:19:18 -0400
Message-Id: <200410291419.i9TEJD75006459@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Fri, 29 Oct 2004 15:48:20 +0200."
             <20041029134820.GA21746@elte.hu> 
Date: Fri, 29 Oct 2004 10:19:12 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.151.88.122] at Fri, 29 Oct 2004 09:19:14 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>after reading some more code i believe the concept is called 'stream' in
>ALSA speak. How many streams did Rui's test utilize? (nine?)

it doesn't matter, actually ...

>if multiple streams were used, then can the handling of one stream delay
>another stream? How are streams prioritized, and are they queued in a
>FIFO or in a LIFO manner? (Also, are such 'streams' directly mapped to
>some hardware concept on the audio card ('channel' or 'voice'?) or am i
>confusing things?)

for our purposes, the number of channels is irrelevant. the audio
interface interrupts when it has and/or needs data. whether that data
covers 2, 9, 26 or 128 channels isn't particularly important. each
channel is handled at the same time. for most stereo devices, the data
for the channels is actually interleaved; for some high end
multichannel devices, each channel uses a separate memory
buffer. either way, its really not central.

\begin{digression}

what may confuse you is the kernel-level ALSA concept of a "stream"
and a "substream". this is not relevant to the issue at hand, but i
may as well explain anyway :)

these are not actually channels at all, but abstractions that ALSA
uses to handle many different audio h/w architectures with a
reasonable level of uniformity. many consumer audio devices these days
have multiple independent audio engines on them. for example, some
cards have analog stereo output, analog surround (so-called "5.1")
output and/or digital S/PDIF output. if they are truly independent
(i.e. they carry different data and can be started and stopped
independently), then ALSA generally represents each device
independently. in the driver architecture, each device is represented
by a "stream" when it is open. audio interfaces with just a single
device has only one stream that can be opened.

in addition, there are a number of audio interfaces that can do h/w
mixing of multiple data flowing into the same device. i have a
consumer card, for example, that can handle 32 different stereo
streams and it mixes them down to a single stereo output. these are
not independent in the sense that they cannot be started/stopped
independently, and so ALSA represents each of these as a
"substream". An audio interface that doesn't do h/w mixing has only a
single substream associated with the stream.

When an application opens an audio interface, it is opening a
substream of a stream. By default, it will get the first (typically
only) substream on the first stream (typically only) of the first
audio interface.  

The term "voice" is a driver-specific one that has been inherited from
the way the makes of certain audio interfaces talk about their hardware.
It corresponds very loosely to ALSA's notion of a substream, but not
precisely. 

\end{digression}

to get back to max_delay .... the important thing here is that
max_delay is measuring the delay between when jackd believes it should
*next* be woken and when it actually is. on the assumption (valid for
rui's test AFAIK) that jackd has gone back to sleep a long time before
the next audio interface interrupt wakes it up, then this delay is
troublesome, because it happens entirely in the kernel.

some things we need to rule out: 

     (a) jackd is not asleep when the next interrupt arrives
               (though this should not cause a delay of 700usecs)
     (b) the audio interface delivered the interrupt on time
     (c) the audio interface doesn't interrupt independently for
               capture and playback. Rui will need to get back
	       to me with details on what type of audio interface
	       he is using for me to comment on this. If its
	       a consumer device with poor support for full
	       duplex operation, then it can happen that
	       capture and playback streams are running out
	       of sync and this can cause some odd timing.

--p
