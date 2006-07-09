Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWGIVVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWGIVVD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWGIVVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:21:01 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17573 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161164AbWGIVVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:21:00 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: john stultz <johnstul@us.ibm.com>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
In-Reply-To: <200607092058.k69KwVxN026427@harpo.it.uu.se>
References: <200607092058.k69KwVxN026427@harpo.it.uu.se>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 14:20:56 -0700
Message-Id: <1152480056.21576.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 22:58 +0200, Mikael Pettersson wrote:
> On Fri, 7 Jul 2006 21:01:26 +0200 (MEST), I wrote:
> >Kernel 2.6.18-rc1 broke resume from APM suspend (to RAM)
> >on my old Dell Latitude CPi laptop. At resume the disk
> >spins up and the screen gets lit, but there is no response
> >to the keyboard, not even sysrq. All other system activity
> >also appears to be halted.
> >
> >I did the obvious test of reverting apm.c to the 2.6.17
> >version and fixing up the fallout from the TIF_POLLING_NRFLAG
> >changes, but it made no difference. So the problem must be
> >somewhere else.
> 
> I've traced the cause of this problem to the i386 time-keeping
> changes in kernel 2.6.17-git11. What happens is that:
> - The kernel autoselects TSC as my clocksource, which is
>   reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
> - Immediately after APM resumes (arch/i386/kernel/apm.c line
>   1231 in 2.6.18-rc1) there is an interrupt from the PIT,
>   which takes us to kernel/timer.c:update_wall_time().
> - update_wall_time() does a clocksource_read() and computes
>   the offset from the previous read. However, the TSC was
>   reset by HW or BIOS during the APM suspend/resume cycle and
>   is now smaller than it was at the prevous read. On my machine,
>   the offset is 0xffffffd598e0a566 at this point, which appears
>   to throw update_wall_time() into a very very long loop.

Huh. It seems you're getting an interrupt before timekeeping_resume()
runs (which resets cycle_last). I'll look over the code and see if I can
sort out why it works w/ ACPI suspend, but not APM, or if the
resume/interrupt-enablement bit is just racy in general.

Thanks for the bug report!
-john


