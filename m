Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbVGZK5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbVGZK5U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 06:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVGZK5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 06:57:03 -0400
Received: from tim.rpsys.net ([194.106.48.114]:14786 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261747AbVGZK4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 06:56:30 -0400
Subject: Should activate_page()/__set_page_dirty_buffers() use _irqsave
	locking?
From: Richard Purdie <rpurdie@rpsys.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 11:56:24 +0100
Message-Id: <1122375384.7642.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experimenting with oprofile on an arm system without a PMU.
Whenever I enable callgraphing I see a BUG from run_posix_cpu_timers()
due to irqs being enabled when they should be disabled.

Tracing this back shows interrupts are enabled after the arm backtrace
code completes. Further tracing reveals its the call to
check_user_page_readable() (within an interrupt) that is causing the
problem.

check_user_page_readable() can potentially result in calls to
activate_page() (mm/swap.c) and __set_page_dirty_buffers()
(fs/buffer.c). Both functions use *_lock_irq()/*_unlock_irq rather than
the *_lock_irqsave/*_unlock_irqrestore counterparts.

Switching them to use the save/restore locks makes everything work. Is
there a reason for not using these here? Would such a patch be accepted?

Both the arm and i386 backtrace code would seem to be vulnerable to this
problem.

Richard

