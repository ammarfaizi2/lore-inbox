Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWGIVpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWGIVpI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 17:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161171AbWGIVpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 17:45:08 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36798 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161169AbWGIVpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 17:45:06 -0400
Date: Sun, 9 Jul 2006 23:44:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Message-ID: <20060709214439.GC2495@elf.ucw.cz>
References: <200607092058.k69KwVxN026427@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607092058.k69KwVxN026427@harpo.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-07-09 22:58:31, Mikael Pettersson wrote:
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

Step 0: could we get some sanity checks into that loop? I'm pretty
sure we'll face some TSCs going backwards... panic-king the box at
that point is okay, but infinite loop is not...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
