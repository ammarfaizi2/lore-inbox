Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263409AbTDMJ6O (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 05:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTDMJ6O (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 05:58:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49668 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263409AbTDMJ6N (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 05:58:13 -0400
Date: Sun, 13 Apr 2003 12:09:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: mikpe@csd.uu.se
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au
Subject: Re: APIC is not properly suspending in 2.5.67 on UP
Message-ID: <20030413100959.GA880@atrey.karlin.mff.cuni.cz>
References: <200304130044.h3D0i3lQ029020@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304130044.h3D0i3lQ029020@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >This is needed otherwise APIC thinks it is not active, does not
> >suspend properly, and kills machine.
> 
> This can only happen with UP if the machine boots with local
> APIC enabled and the BIOS announces an MP table.
> 
> If this is the case, then yes apic_pm_activate() needs to be done.
> 
> > Extra whitespace killed (looks
> >ugly). Please apply,
> 
> I think some fixes are needed first:
> - You're calling apic_pm_activate() from setup_local_APIC(), which
>   is before its definition. This will cause a compile warning, and
>   a linkage error if CONFIG_PM=n.

Okay, this needs to be fixed.

> - While calling apic_pm_activate() from setup_local_APIC() sort of
>   works in the UP case, it's wrong since setup_local_APIC() is called
>   for each CPU in SMP, and we must not run the suspend and resume
>   code if there is more than one CPU in the machine.
>   I don't have a good solution for this right now: I don't think
>   cpu_online_map is valid when init_lapi_devicefs() runs, and I
>   don't know how else to check the number of CPUs.
>   Changing the #ifdef CONFIG_PM block to be #if defined(CONFIG_PM)
>   && !defined(CONFIG_SMP) would fix UP kernels, but SMP kernels on
>   UP HW would lose PM. Adding "if (num_online_cpus() > 1) return;"
>   to the suspend & resume procedures is ugly but should work.

That's future work. As soon as I get SMP machine I'll do something
about SMP. (Most probably hot unplugging all but one CPUs before
suspend and hot plugging them all back after resume.) I'd ignore SMP
problems in suspendresume for now: apm just refuses to do it on SMP,
and acpi is broken in more than one way with regard to that.

							Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
