Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVIEG7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVIEG7X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 02:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbVIEG7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 02:59:23 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:47280 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932260AbVIEG7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 02:59:22 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 5 Sep 2005 09:58:59 +0300
From: Tony Lindgren <tony@atomide.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905065859.GA5734@atomide.com>
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050904203755.GA25856@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050904203755.GA25856@us.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Aravamudan <nacc@us.ibm.com> [050904 23:38]:
> On 04.09.2005 [21:26:16 +0100], Russell King wrote:
> > On Sun, Sep 04, 2005 at 01:10:54PM -0700, Nishanth Aravamudan wrote:
> > > I've got a few ideas that I think might help push Con's patch coalescing
> > > efforts in an arch-independent fashion.
> > 
> > Note that ARM contains cleanups on top of Tony's original work, on
> > which the x86 version is based.
> > 
> > Basically, Tony submitted his ARM version, we discussed it, fixed up
> > some locking problems and simplified it (it contained multiple
> > structures which weren't necessary, even in multiple timer-based systems).
> 
> Make sense. Thanks for the quick feedback!
> 
> > I'd be really surprised if any architecture couldn't use what ARM has
> > today - in other words, this is the only kernel-side interface:
> > 
> > #ifdef CONFIG_NO_IDLE_HZ
> > 
> > #define DYN_TICK_SKIPPING       (1 << 2)
> > #define DYN_TICK_ENABLED        (1 << 1)
> > #define DYN_TICK_SUITABLE       (1 << 0)
> > 
> > struct dyn_tick_timer {
> >         unsigned int    state;                  /* Current state */
> >         int             (*enable)(void);        /* Enables dynamic tick */
> >         int             (*disable)(void);       /* Disables dynamic tick */
> >         void            (*reprogram)(unsigned long); /* Reprograms the timer */
> >         int             (*handler)(int, void *, struct pt_regs *);
> > };
> > 
> > void timer_dyn_reprogram(void);
> > #else
> > #define timer_dyn_reprogram()   do { } while (0)
> > #endif
> 
> That looks great! So I guess I'm just suggesting moving this from
> include/asm-arch/mach/time.h to arch-independent headers? Perhaps
> timer.h is the best place for now, as it already contains the
> next_timer_interrupt() prototype (which probably should be in the #ifdef
> with timer_dyn_reprogram()).

Yes, the above should be enough on all platforms. I believe x86 still uses
two structs, and should be updated to use the interface above. There are
some extra state flags on x86, but even some of those might be
unnecessary now.

It may not be obvious from the mailing list discussions, but really the
remaining problems are to fix the x86 legacy issues with all the timers,
not with the interface.

Tony
