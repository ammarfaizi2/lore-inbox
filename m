Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131684AbRALQEX>; Fri, 12 Jan 2001 11:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131965AbRALQEO>; Fri, 12 Jan 2001 11:04:14 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15376 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131684AbRALQEK>; Fri, 12 Jan 2001 11:04:10 -0500
Date: Fri, 12 Jan 2001 17:02:34 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010112170234.A2766@athlon.random>
In-Reply-To: <20010112044554.A809@athlon.random> <Pine.LNX.4.10.10101112018220.28973-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10101112018220.28973-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 11, 2001 at 08:26:04PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 08:26:04PM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 12 Jan 2001, Andrea Arcangeli wrote:
> > 
> > Note that there was a precise reason for not implementing it as the TSC disable
> > (infact at first in 2.2.x I was clearing the bigflag in x86_capabilities too).
> > The reason is that the way TSC gets disabled breaks /proc/cpuinfo.
> 
> No.
> 
> It FIXES /proc/cpuinfo.
> 
> Your alternative patch is the thing that breaks.

In 2.2.*, 2.4.0, 2.4.1-pre[12] and 2.4.0ac* `fxsr' and `xmm' in /proc/cpuinfo
means "cpu_has", you changed their meaning in 2.4.1-pre3 to "can_I_use". So now
unless you check the `uname -r` first you don't know anymore what fxsr and xmm
means (if either "cpu_has" or "can_I_use").

This means 2.4.1-pre3 broke /proc/cpuinfo IMHO (while pre2 plus my patch
didn't break anything).

> We _want_ /proc/cpuinfo to reflect the fact that the kernel considers
> FSXR/XMM to not exist. That is true information, and is in fact something
> that install scripts etc can find extremely useful.

The "cpu_has" is true information as well (certainly it's less interesting than
the "can_I_use" but that that's not a good reason for dropping the "cpu_has"
information while breaking the semantics of fxsr/xmm in /proc/cpuinfo).

> In particular, imagine an installation script that wants to install the
> proper optimized version of a library on a machine. How is it supposed to
> know whether it should use the mmx version, the xmm version, or the
> integer version?

Any userspace software that will use `fxsr' and `xmm' information in
/proc/cpuinfo as "can_I_use" will work correctly _only_ in 2.4.1-pre3 and later
kernels (unless it does checks on the kernel revision it's running on first)
and it will break in all 2.2.x, 2.4.0 and 2.4.1-pre[12] (if it's not
checking the kernel revision). This is also a proof of what I said above.

Nobody should ever consider fxsr and xmm as "can_I_use" for backwards
compatibilty reasons with 2.4.0 and 2.2.*.

> This is _exactly_ the kind of thing that /proc/cpuinfo was supposed to be
> able to deal with, and that means that if the kernel doesn't like to use

/proc/cpuinfo shows per-cpu infos, it's always been the "cpu_has" _per-cpu_
info (not the _global_ "can_I_use").

It doesn't make much sense to me to put the "can_I_use" global information in
the per-cpu slots, that's obviously the wrong place for it. We simply need to
add a new entry to /proc (say "/proc/osinfo") to provide the "can_I_use"
informations instead (TSC included).  Breaking /proc/cpuinfo isn't the way to
go IMHO.

> xmm for some reason (ie the user explicitly told it to), then it shouldn't
> show up in /proc/cpuinfo - because on that machine XMM simply does not
> exist as far as user-land is concerned.

So then why does bogomips and and f00f_bug and similar things show up in
/proc/cpuinfo if they aren't useful to user-land either?

/proc/cpuinfo is providing info that isn't just useful for user-land software
agreed, but it's useful for the user to see the details of his hw. That's
always been the case. In 2.2.x and 2.4.0 the user wasn't allowed to use xmm but
he _wanted_ to see "xmm" in the flags field to know the details of his
hardware. That's not an information for userland software but just for the
user.

> Similarly, when we disable TSC, it's also telling user-land that this
> machine does not appear to have a working TSC for some reason. User-land

And IMHO that's wrong too.

> After all, a user can always do a "cpuid" to get to know what the CPU
> itself reports. /proc/cpuinfo is supposed to be a higher-level interface,
> where the buggy bits have been removed or renamed (ie AMD extensions are
> properly renamed and can be easily recognized as such, without each
> user-mode application having to know about the magic meaning of bits in
> "cpuid" on different machines).

cpuid says the "cpu_has" not the "can_I_use" too.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
