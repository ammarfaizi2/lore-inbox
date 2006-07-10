Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422741AbWGJSTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbWGJSTw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422744AbWGJSTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:19:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1259 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422741AbWGJSTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:19:50 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: john stultz <johnstul@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <20060710180839.GA16503@elf.ucw.cz>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
	 <1152554328.5320.6.camel@localhost.localdomain>
	 <20060710180839.GA16503@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 11:19:48 -0700
Message-Id: <1152555588.5320.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 20:08 +0200, Pavel Machek wrote:
> Hi!
> 
> > > >> I've traced the cause of this problem to the i386 time-keeping
> > > >> changes in kernel 2.6.17-git11. What happens is that:
> > > >> - The kernel autoselects TSC as my clocksource, which is
> > > >>   reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
> > > >> - Immediately after APM resumes (arch/i386/kernel/apm.c line
> > > >>   1231 in 2.6.18-rc1) there is an interrupt from the PIT,
> > > >>   which takes us to kernel/timer.c:update_wall_time().
> > > >> - update_wall_time() does a clocksource_read() and computes
> > > >>   the offset from the previous read. However, the TSC was
> > > >>   reset by HW or BIOS during the APM suspend/resume cycle and
> > > >>   is now smaller than it was at the prevous read. On my machine,
> > > >>   the offset is 0xffffffd598e0a566 at this point, which appears
> > > >>   to throw update_wall_time() into a very very long loop.
> > > >
> > > >Huh. It seems you're getting an interrupt before timekeeping_resume()
> > > >runs (which resets cycle_last). I'll look over the code and see if I can
> > > >sort out why it works w/ ACPI suspend, but not APM, or if the
> > > >resume/interrupt-enablement bit is just racy in general.
> > > 
> > > I forgot to mention this, but I had a debug printk() in apm.c
> > > which showed that irqs_disabled() == 0 at the point when APM
> > > resumes the kernel.
> > 
> > So it seems possible that the timer tick will be enabled before the
> > timekeeping resume code runs. I'm not sure why this isn't seen w/ ACPI
> > suspend/resume, as I think they're using the same
> > sysdev_class .suspend/.resume bits. 
> 
> ACPI actually keeps interrupts disabled, always.
> 
> APM can only keep interrupts disabled on non-IBM machines, presumably
> due to BIOS problems.
> 
> Could we get some sanity check into looping function? If timesource
> goes backwards, at least somehow reporting it would be nice...

Yep, I'm working on a debug patch (similar to the paranoid timekeeping
debugging option in earlier versions of the TOD patch) that will spit
out warnings when we see unusual behavior: large numbers of lost ticks,
timer ticks arriving too early, settimeofday being call, etc.

thanks
-john

