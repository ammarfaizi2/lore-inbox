Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129675AbRALE1Y>; Thu, 11 Jan 2001 23:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132608AbRALE1P>; Thu, 11 Jan 2001 23:27:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:44302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129675AbRALE1H>; Thu, 11 Jan 2001 23:27:07 -0500
Date: Thu, 11 Jan 2001 20:26:04 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
In-Reply-To: <20010112044554.A809@athlon.random>
Message-ID: <Pine.LNX.4.10.10101112018220.28973-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Jan 2001, Andrea Arcangeli wrote:
> 
> Note that there was a precise reason for not implementing it as the TSC disable
> (infact at first in 2.2.x I was clearing the bigflag in x86_capabilities too).
> The reason is that the way TSC gets disabled breaks /proc/cpuinfo.

No.

It FIXES /proc/cpuinfo.

Your alternative patch is the thing that breaks.

We _want_ /proc/cpuinfo to reflect the fact that the kernel considers
FSXR/XMM to not exist. That is true information, and is in fact something
that install scripts etc can find extremely useful.

In particular, imagine an installation script that wants to install the
proper optimized version of a library on a machine. How is it supposed to
know whether it should use the mmx version, the xmm version, or the
integer version?

This is _exactly_ the kind of thing that /proc/cpuinfo was supposed to be
able to deal with, and that means that if the kernel doesn't like to use
xmm for some reason (ie the user explicitly told it to), then it shouldn't
show up in /proc/cpuinfo - because on that machine XMM simply does not
exist as far as user-land is concerned.

Similarly, when we disable TSC, it's also telling user-land that this
machine does not appear to have a working TSC for some reason. User-land
applications may also care about the fact that TSC seems to skip time if
the machine is idle etc (which was apparently the problem with some broken
Cyrix chips).

After all, a user can always do a "cpuid" to get to know what the CPU
itself reports. /proc/cpuinfo is supposed to be a higher-level interface,
where the buggy bits have been removed or renamed (ie AMD extensions are
properly renamed and can be easily recognized as such, without each
user-mode application having to know about the magic meaning of bits in
"cpuid" on different machines).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
