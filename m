Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268093AbRGVWnP>; Sun, 22 Jul 2001 18:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268094AbRGVWnG>; Sun, 22 Jul 2001 18:43:06 -0400
Received: from juicer13.bigpond.com ([139.134.6.21]:47303 "EHLO
	mailin1.bigpond.com") by vger.kernel.org with ESMTP
	id <S268093AbRGVWmx>; Sun, 22 Jul 2001 18:42:53 -0400
Message-Id: <m15OQ5D-000CDBC@localhost>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrea Arcangeli <andrea@suse.de>, torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: 2.4.7 softirq incorrectness.
Date: Mon, 23 Jul 2001 06:44:10 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This current code is bogus.  Consider:
	spin_lock_irqsave(flags);	
	cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
	spin_unlock_irqrestore(flags);

Oops... softirq not run until the next interrupt.  So, EITHER:

1) make local_irq_restore check for pending softirqs in as we do for
   local_bh_enable(), and get rid of the wakeup_softirqd() in
   cpu_raise_softirq().  ie. all "exits" from in_interrupt == true are
   symmetrical.

*OR*

2) Change the check in cpu_raise_softirq to:
	if (!in_hw_irq_handler(cpu))
		wakeup_softirqd(cpu);

   and implement in_hw_irq_handler() on all platforms.  Then get rid of
   the test in local_bh_enable().

Please pick one approach or the other, and stick with it!  The current
code does half of each, badly. 8(

Thanks,
Rusty.
--
Premature optmztion is rt of all evl. --DK
