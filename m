Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293711AbSCFRYm>; Wed, 6 Mar 2002 12:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293714AbSCFRYd>; Wed, 6 Mar 2002 12:24:33 -0500
Received: from renoir.op.net ([207.29.195.4]:46610 "EHLO renoir.op.net")
	by vger.kernel.org with ESMTP id <S293711AbSCFRY1>;
	Wed, 6 Mar 2002 12:24:27 -0500
Message-Id: <200203061724.MAA26665@renoir.op.net>
To: Jaroslav Kysela <perex@suse.cz>
cc: Ulrich Zadow <ulrich.zadow@ARTCOM.DE>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Alsa-devel] Timer? 
In-Reply-To: Your message of "Wed, 06 Mar 2002 17:57:54 +0100."
             <Pine.LNX.4.33.0203061741300.2187-100000@pnote.perex-int.cz> 
Date: Wed, 06 Mar 2002 12:20:57 -0500
From: Paul Davis <pbd@Op.Net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You're right. But it would be really nice to have a continuous timer 
>source in some resolution (microseconds?) available for all platforms
>to satisfy synchronization requirements. 

its often called "UST" (Unadjusted System Time). Its part of the POSIX
CLOCK_MONOTONIC specification. this is supported (apparently) as part
of glibc. i don't know what kind of kernel support is offered; it
almost certainly isn't of the resolution that UST has under IRIX or
BeOS (where it appears to be based on a cycle counter).

>It's not probably required exactly for this example where timing from one
>audio target is sufficient, but I can imagine several applications
>synchronized together. 

jaroslav, as you know, this has been the subject of much discussion on
alsa-devel; the presence of a UST source doesn't permit
multi-application synchronization in and of itself. you have to have
a scheme that uses either:

  a) synchronous client execution (the JACK/CoreAudio model)
  b) timestamped buffers with client-side drift correction (the dmSDK/OpenML
		 model)

UST is useful for (b), but its not necessary for (a). the kernel
provides no specific support for (a) or (b).

			As far as I know, Linux has not a continous timer.
>I am ready to work on this issue. It is very simple to create an interface
>with one ioctl returning struct timeval with the absolute timer value
>measured from system boot on i386 using rdtsc instruction.
>
>Perhaps, I'm trying to reinvent wheel, so please, let me know, if someone 
>solved this issue.

i think this is reinventing the wheel. however, AFAIK, at this time,
its not *reimplementing* the wheel, since Linux doesn't appear to
offer this facility at this time. Having CLOCK_MONOTONIC properly
supported by the cycle counter would be good.

But notice: this also does not provide proper synchronization, since
it actually *adds* a clock source. Without it, you've the clock
attached to each hardware i/o device (audio, video, MIDI). With it,
those clocks continue to exist, but you add the UST one. Its
incredibly unlikely that the UST source will run in sync with any of
the others, and so now you have to do client-side drift correction for
*every* stream type.

If instead, you just pick one of the existing stream clocks
(e.g. audio) and sync to that, you reduce the number of instances of
drift correction that have to be done.

as a result, i'm ambivalent about its use for synchronization. it
would be nice, however, to use a UST source for other things.

--p
