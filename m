Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262910AbUERT4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUERT4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 15:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUERT4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 15:56:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58895 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262910AbUERT4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 15:56:15 -0400
Date: Tue, 18 May 2004 20:56:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Mark Gross <mgross@linux.jf.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tim Bird <tim.bird@am.sony.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: CE Linux Forum - Specification V1.0 draft
Message-ID: <20040518205608.D30520@flint.arm.linux.org.uk>
Mail-Followup-To: Mark Gross <mgross@linux.jf.intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Tim Bird <tim.bird@am.sony.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <40A90D00.7000005@am.sony.com> <200405171342.49891.mgross@linux.intel.com> <20040518074854.A7348@infradead.org> <200405181232.48226.mgross@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200405181232.48226.mgross@linux.intel.com>; from mgross@linux.jf.intel.com on Tue, May 18, 2004 at 12:32:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2004 at 12:32:48PM -0700, Mark Gross wrote:
> > --- linux-2.4.20.orig/drivers/ide/ide.c	Thu Nov 28 23:53:13 2002
> > +++ celinux-040213/drivers/ide/ide.c	Thu Feb 12 10:25:12 2004
> > @@ -2739,12 +2776,17 @@
> >   */
> >  void ide_delay_50ms (void)
> >  {
> > +#ifdef CONFIG_IDE_PREEMPT
> > +	__set_current_state(TASK_UNINTERRUPTIBLE);
> > +	schedule_timeout(1+HZ/20); /* from 2.5 */
> > +#else /* CONFIG_IDE_PREEMPT */
> >  #ifndef CONFIG_BLK_DEV_IDECS
> >  	mdelay(50);
> >  #else
> >  	__set_current_state(TASK_UNINTERRUPTIBLE);
> >  	schedule_timeout(HZ/20);
> >  #endif /* CONFIG_BLK_DEV_IDECS */
> > +#endif /* CONFIG_IDE_PREEMPT */
> >  }
> >
> > This great piece 'called IDE-preempt' to be buzzword-compliant is (and
> > that's noticeable just from looking at the diff!) so braindead that it's
> > not explainable by incompetence alone.  You'd get your same result by just
> > _disabling_ CONFIG_BLK_DEV_IDECS instead of adding another broken config
> > option (modulo 2.6 adjustments to the sleep time).
> >
> > Every engineer with the slightest clue would first disable that option, or
> > if ide-cs support is actually needed think _why_ it's different instead of
> > just adding a config option to disable it.  Either it's safe to always use
> > the sleeping variant in which case the original ifdef should go away, or
> > it's not in which case your patch is completely broken.
> >
> 
> OK I'll bite, but just because in your blind hostility and haste you've made a 
> mistake ;)

Christoph is actually making a valid point here and I suspect is trying
to point out the lack of thought put into this change.  The things that
_should_ have been considered before making the change are:

1. Why do we use mdelay() here if CONFIG_BLK_DEV_IDECS is defined?

2. Is the reason for this still valid?

3. If it is safe to sleep here even if CONFIG_CLK_DEV_IDECS is set,
   why bother with mdelay() in the first place?

The _correct_ patch is actually:

 void ide_delay_50ms (void)
 {
-#ifndef CONFIG_BLK_DEV_IDECS
-	mdelay(50);
-#else
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/20);
-#endif /* CONFIG_BLK_DEV_IDECS */
 }

since PCMCIA always calls drivers from process context now.




(Unfortunately I can't write upside down, but I'll give the answers to
those three items above.  Look away now if you don't want to read the
answers! 8) )


1. PCMCIA used to call drivers in IRQ context, which made it impossible
   to sleep.

2. No, because PCMCIA always calls drivers in process context now, so
   sleeping is possible.

3. Left as an exercise to the reader. 8)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
