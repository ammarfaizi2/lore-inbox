Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264300AbTDKGfe (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 02:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264301AbTDKGfe (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 02:35:34 -0400
Received: from zok.SGI.COM ([204.94.215.101]:30856 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264300AbTDKGfc (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 02:35:32 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 kernel/timer.c may incorrectly reenable interrupts
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Apr 2003 16:47:05 +1000
Message-ID: <24294.1050043625@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20 kernel/timer.c

static inline void update_times(void)
{
	unsigned long ticks;

	/*
	 * update_times() is run from the raw timer_bh handler so we
	 * just know that the irqs are locally enabled and so we don't
	 * need to save/restore the flags of the local CPU here. -arca
	 */
	write_lock_irq(&xtime_lock);
	vxtime_lock();

	ticks = jiffies - wall_jiffies;
	if (ticks) {
		wall_jiffies += ticks;
		update_wall_time(ticks);
	}
	vxtime_unlock();
	write_unlock_irq(&xtime_lock);
	calc_load(ticks);
}

I hit one case when the routine was called with interrupts disabled and
it unconditionally enabled them, with nasty side effects.  Code fragment

  local_irq_save();
  local_bh_disable();
  ....
  local_bh_enable();
  local_irq_restore();

local_bh_enable() checks for pending softirqs, finds that there is an
outstanding timer bh and runs it.  do_softirq() -> tasklet_hi_action()
-> bh_action() -> timer_bh() -> update_times() which unconditionally
reenables interrupts.  Then the timer code issued cli(), because
interrupts were incorrectly reenabled it tried to get the global cli
lock and hung.

There is no documentation that defines the required nesting order of
local_irq and local_bh.  Even if the above code fragment is deemed to
be illegal, there are uses of local_bh_enable() all through the kernel,
it will be difficult to prove that none of them are called with
interrupts disabled.  If there is any chance that local_bh_enable() is
called with interrupts off, update_times() is wrong.

