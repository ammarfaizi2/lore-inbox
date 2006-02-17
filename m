Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWBQF5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWBQF5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 00:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWBQF5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 00:57:46 -0500
Received: from ozlabs.org ([203.10.76.45]:43666 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932214AbWBQF5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 00:57:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17397.25985.646489.878694@cargo.ozlabs.ibm.com>
Date: Fri, 17 Feb 2006 16:56:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: linux-kernel@vger.kernel.org
Subject: why do we have wall_jiffies?
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel/timer.c we currently have jiffies_64, of which jiffies is
the least-significant long-sized piece, and wall_jiffies.  The code
that updates them looks like this (from kernel/timer.c):

static inline void update_times(void)
{
	unsigned long ticks;

	ticks = jiffies - wall_jiffies;
	if (ticks) {
		wall_jiffies += ticks;
		update_wall_time(ticks);
	}
	calc_load(ticks);
}
  
/*
 * The 64-bit jiffies value is not atomic - you MUST NOT read it
 * without sampling the sequence number in xtime_lock.
 * jiffies is defined in the linker script...
 */

void do_timer(struct pt_regs *regs)
{
	jiffies_64++;
	update_times();
	softlockup_tick(regs);
}

In other places there is code that uses (jiffies - wall_jiffies).
However I can't see any way that jiffies and wall_jiffies could ever
be different (except for a few nanoseconds while executing the code
above).  I also can't see any way that `ticks' could ever be anything
other than 1.

Is the wall_jiffies stuff just a leftover from days when we used to do
timekeeping from a softirq?  Or am I missing something fundamental?

Thanks,
Paul.
