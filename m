Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbSJXOk3>; Thu, 24 Oct 2002 10:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265463AbSJXOk3>; Thu, 24 Oct 2002 10:40:29 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:56850 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S265457AbSJXOk2>; Thu, 24 Oct 2002 10:40:28 -0400
Date: Thu, 24 Oct 2002 15:46:32 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: dipankar@gamebox.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release, version 5 - I think this one's ready
Message-ID: <20021024144632.GC32181@compsoc.man.ac.uk>
References: <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow> <3DB7F574.9030607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB7F574.9030607@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *184jFp-0001Xz-00*O2/KknGX9Mw* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 08:28:20AM -0500, Corey Minyard wrote:

> diff -ur linux.orig/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
> --- linux.orig/arch/i386/kernel/traps.c	Mon Oct 21 13:25:45 2002
> +++ linux/arch/i386/kernel/traps.c	Thu Oct 24 08:11:14 2002

At this point I'd quite like to see :

	mv nmi.c nmi_watchdog.c

and put all this stuff in always-compiled nmi.c.  traps.c is getting
bloated.

>  static void default_do_nmi(struct pt_regs * regs)
>  {
>  	unsigned char reason = inb(0x61);
>   
>  	if (!(reason & 0xc0)) {
> -#if CONFIG_X86_LOCAL_APIC
>  		/*
> -		 * Ok, so this is none of the documented NMI sources,
> -		 * so it must be the NMI watchdog.
> +		 * Check the handler list to see if anyone can handle this
> +		 * nmi.
>  		 */
> -		if (nmi_watchdog) {
> -			nmi_watchdog_tick(regs);
> +		if (call_nmi_handlers(regs))

Now you're using RCU, it's a real pity that we have the inb() first -
if it wasn't for that, there would be no reason at all to have the "fast
path" setting code too (the latter code is ugly, which is one reason I
want to ditch it).

How about adding default_do_nmi as the minimal-priority handler, then
add the watchdog with higher priority above that ? Then oprofile can add
itself on top of those both and return NOTIFY_OK to indicate it should
break out of the loop. As a bonus, you lose the inb() for the watchdog
too.

> +++ linux/include/asm-i386/irq.h	Wed Oct 23 16:47:24 2002

I thought you agreed the stuff should be in asm/nmi.h ?

regards
john
-- 
"This is playing, not work, therefore it's not a waste of time."
	- Zath
