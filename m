Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965190AbWGJSJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965190AbWGJSJM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWGJSJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:09:12 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52445 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S965190AbWGJSJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:09:11 -0400
Date: Mon, 10 Jul 2006 20:08:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: john stultz <johnstul@us.ibm.com>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Message-ID: <20060710180839.GA16503@elf.ucw.cz>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se> <1152554328.5320.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152554328.5320.6.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >> I've traced the cause of this problem to the i386 time-keeping
> > >> changes in kernel 2.6.17-git11. What happens is that:
> > >> - The kernel autoselects TSC as my clocksource, which is
> > >>   reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
> > >> - Immediately after APM resumes (arch/i386/kernel/apm.c line
> > >>   1231 in 2.6.18-rc1) there is an interrupt from the PIT,
> > >>   which takes us to kernel/timer.c:update_wall_time().
> > >> - update_wall_time() does a clocksource_read() and computes
> > >>   the offset from the previous read. However, the TSC was
> > >>   reset by HW or BIOS during the APM suspend/resume cycle and
> > >>   is now smaller than it was at the prevous read. On my machine,
> > >>   the offset is 0xffffffd598e0a566 at this point, which appears
> > >>   to throw update_wall_time() into a very very long loop.
> > >
> > >Huh. It seems you're getting an interrupt before timekeeping_resume()
> > >runs (which resets cycle_last). I'll look over the code and see if I can
> > >sort out why it works w/ ACPI suspend, but not APM, or if the
> > >resume/interrupt-enablement bit is just racy in general.
> > 
> > I forgot to mention this, but I had a debug printk() in apm.c
> > which showed that irqs_disabled() == 0 at the point when APM
> > resumes the kernel.
> 
> So it seems possible that the timer tick will be enabled before the
> timekeeping resume code runs. I'm not sure why this isn't seen w/ ACPI
> suspend/resume, as I think they're using the same
> sysdev_class .suspend/.resume bits. 

ACPI actually keeps interrupts disabled, always.

APM can only keep interrupts disabled on non-IBM machines, presumably
due to BIOS problems.

Could we get some sanity check into looping function? If timesource
goes backwards, at least somehow reporting it would be nice...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
