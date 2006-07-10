Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422723AbWGJRcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422723AbWGJRcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422726AbWGJRcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:32:01 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12432 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422723AbWGJRcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:32:00 -0400
Date: Mon, 10 Jul 2006 09:55:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Message-ID: <20060710075524.GB2174@elf.ucw.cz>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2006-07-10 01:52:35, Mikael Pettersson wrote:
> On Sun, 09 Jul 2006 14:20:56 -0700, john stultz wrote:
> >> I've traced the cause of this problem to the i386 time-keeping
> >> changes in kernel 2.6.17-git11. What happens is that:
> >> - The kernel autoselects TSC as my clocksource, which is
> >>   reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
> >> - Immediately after APM resumes (arch/i386/kernel/apm.c line
> >>   1231 in 2.6.18-rc1) there is an interrupt from the PIT,
> >>   which takes us to kernel/timer.c:update_wall_time().
> >> - update_wall_time() does a clocksource_read() and computes
> >>   the offset from the previous read. However, the TSC was
> >>   reset by HW or BIOS during the APM suspend/resume cycle and
> >>   is now smaller than it was at the prevous read. On my machine,
> >>   the offset is 0xffffffd598e0a566 at this point, which appears
> >>   to throw update_wall_time() into a very very long loop.
> >
> >Huh. It seems you're getting an interrupt before timekeeping_resume()
> >runs (which resets cycle_last). I'll look over the code and see if I can
> >sort out why it works w/ ACPI suspend, but not APM, or if the
> >resume/interrupt-enablement bit is just racy in general.
> 
> I forgot to mention this, but I had a debug printk() in apm.c
> which showed that irqs_disabled() == 0 at the point when APM
> resumes the kernel.

/*
 * These are the actual BIOS calls.  Depending on APM_ZERO_SEGS and
 * apm_info.allow_ints, we are being really paranoid here!  Not only
 * are interrupts disabled, but all the segment registers (except SS)
 * are saved and zeroed this means that if the BIOS tries to reference
 * any data without explicitly loading the segment registers, the
kernel
 * will fault immediately rather than have some unforeseen
circumstances
 * for the rest of the kernel.  And it will be very obvious!  :-)
Doing
 * this depends on CS referring to the same physical memory as DS so
that
 * DS can be zeroed before the call. Unfortunately, we can't do
anything
 * about the stack segment/pointer.  Also, we tell the compiler that
 * everything could change.
 *
 * Also, we KNOW that for the non error case of apm_bios_call, there
 * is no useful data returned in the low order 8 bits of eax.
 */
#define APM_DO_CLI      \
        if (apm_info.allow_ints) \
                local_irq_enable(); \
        else \
                local_irq_disable();

...and I think allow_ints was invented because of thinkpads.. So
AFAICT you can't rely on interrupts being off and you can't rely on
interrupts being on.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
