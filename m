Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131121AbRAJX45>; Wed, 10 Jan 2001 18:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131463AbRAJX4r>; Wed, 10 Jan 2001 18:56:47 -0500
Received: from selene.cps.intel.com ([192.198.165.10]:26128 "EHLO
	selene.cps.intel.com") by vger.kernel.org with ESMTP
	id <S130880AbRAJX4e>; Wed, 10 Jan 2001 18:56:34 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEF6@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'H. Peter Anvin'" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: RE: The latest instance in the A20 farce
Date: Wed, 10 Jan 2001 15:56:07 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa-

I tested this patch on a Pentium dual-proc system (440GX)
and on a Celeron system[1] (810) that lacks floppy, keyboard
controller, maybe some other things.

Linux 2.4.0 boots fine on each of these systems with this
patch applied.  I couldn't tell which method of
enabling A20 was actually successful.
Have you had any other reports on the patch?


[1] I'm not sure if this system qualifies as "legacy free"
or "legacy reduced."  However, for future (how far?)
reference, on legacy-free systems:
[from PDF file at http://www.pcdesguide.org/pc2001/default.htm]

a. The BIOS isn't required to have int. 0x15, AH=0x2401 [Appx. A],
   but that is handled by your patch.
b. The BIOS isn't required to have int. 0x15, AH=0x88 [Appx. A]
   (Ye Olde Traditional memory-size function).
   Hopefully the other memory-size methods will always have
   priority.
c. A20M# is always de-asserted at the processor [Ch. 3, item SYS-0047]

I bring these up because they may have some impact on SYSLINUX,
LILO, etc., and the data structures that they use (like the
memory_size item) and because some of these systems don't
have a "real mode," so loaders can't reliably assume that
they do (unless it's transparent to the loaders)...
and because you know something about SYSLINUX etc.

~Randy
_______________________________________________
|randy.dunlap_at_intel.com        503-677-5408|
|NOTE: Any views presented here are mine alone|
|& may not represent the views of my employer.|
-----------------------------------------------

> From: H. Peter Anvin [mailto:hpa@zytor.com]
> Sent: Wednesday, December 06, 2000 3:55 PM
> 
> Okay, here is yet another A20 patch (against test12-pre6) this time
> for people to try out.  This patch uses the following algorithm for
> enabling A20:
> 
> 1. Try the BIOS call.  If it works, we're cool.
> 2. Try the KBC (using Linus' lowered timeouts.)
> 3. If the KBC doesn't work, or is very slow, flip port 92.
> 
> After 3 it sits into the same infinite loop waiting for A20 to become
> enabled (necessary on for example some Toshiba notebooks which have an
> extremely slow response to A20.)
> 
> The main differences between this patch and test12-pre6:
> 
> - Trying the BIOS first of all.  This should reduce the risk of the
>   BIOS getting confused while doing a suspend.  This also gives even
>   less of an excuse for any nonstandard arrangement -- if you didn't
>   implement the standard KBC *and* you didn't provide the BIOS call,
>   you have a seriously broken piece of hardware.
> 
> - If the KBC responds quickly enough (within about 10000 cycles), we
>   don't ever touch the fast A20 gate.  This is a difference from
>   previous code, where the fast A20 gate was toggled immediately after
>   the KBC, even if the KBC responded instantly.
> 
> - I had to move the A20 code somewhat earlier in setup.S in order for
>   the BIOS to still be available.
> 
> Please try it out and let me know as soon as possible...
> 
> 	-hpa
> 
> 
> --- arch/i386/boot/setup.S.12p6	Wed Dec  6 12:49:07 2000
> +++ arch/i386/boot/setup.S	Wed Dec  6 15:25:01 2000
...
> -- 
> <hpa@transmeta.com> at work, <hpa@zytor.com> in private!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
