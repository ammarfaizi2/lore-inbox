Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbVDLBHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbVDLBHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVDLBHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:07:04 -0400
Received: from palrel10.hp.com ([156.153.255.245]:13702 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261998AbVDLBGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:06:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16987.7956.806699.617633@napali.hpl.hp.com>
Date: Mon, 11 Apr 2005 18:06:28 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@davemloft.net>, davidm@hpl.hp.com,
       tony.luck@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: unlocked context-switches
In-Reply-To: <20050410064324.GA24596@elte.hu>
References: <3R6Ir-89Y-23@gated-at.bofh.it>
	<ugoecowjci.fsf@panda.mostang.com>
	<20050409070738.GA5444@elte.hu>
	<16983.33049.962002.335198@napali.hpl.hp.com>
	<20050409155810.593d8f7b.davem@davemloft.net>
	<20050410064324.GA24596@elte.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 10 Apr 2005 08:43:24 +0200, Ingo Molnar <mingo@elte.hu> said:

  Ingo> * David S. Miller <davem@davemloft.net> wrote:

  >> > Yes, of course.  The deadlock was due to context-switching, not
  >> > switch_mm() per se.  Hopefully someone else beats me to
  >> remembering > the details before Monday.

  >> Sparc64 has a deadlock because we hold mm->page_table_lock during
  >> switch_mm().  I bet IA64 did something similar, as I remember it
  >> had a very similar locking issue in this area.

  >> So the deadlock was, we held the runqueue locks over switch_mm(),
  >> switch_mm() spins on mm->page_table_lock, the cpu which does have
  >> mm-> page_table_lock tries to do a wakeup on the first cpu's
  >> mm-> runqueue.
  >> Classic AB-BA deadlock.

  Ingo> yeah, i can see that happening - holding the runqueue lock and
  Ingo> enabling interrupts. (it's basically never safe to enable irqs
  Ingo> with the runqueue lock held.)

  Ingo> the patch drops both the runqueue lock and enables interrupts,
  Ingo> so this particular issue should not trigger.

I had to refresh my memory with a quick Google search that netted [1]
(look for "Disable interrupts during context switch").  Actually, it
wasn't really a deadlock, but rather a livelock, since a CPU got stuck
on an infinite page-not-present loop.

Fundamentally, the issue was that doing the switch_mm() and
switch_to() with interrupts enabled opened a window during which you
could get a call to flush_tlb_mm() (as a result of an IPI).  This, in
turn, could end up activating the wrong MMU-context, since the action
of flush_tlb_mm() depends on the value of current->active_mm.  The
problematic sequence was:

1) schedule() calls switch_mm() which calls activate_context() to
   switch to the new address-space
2) IPI comes in and flush_tlb_mm(mm) gets called
3) "current" still points to old task and if "current->active_mm == mm",
   activate_mm() is called for the old address-space, resetting the
   address-space back to that of the old task

Now, Ingo says that the order is reversed with his patch, i.e.,
switch_mm() happens after switch_to().  That means flush_tlb_mm() may
now see a current->active_mm which hasn't really been activated yet.
That should be OK since it would just mean that we'd do an early (and
duplicate) activate_context().  While it does not give me a warm and
fuzzy feeling to have this inconsistent state be observable by
interrupt-handlers (and, in particular, IPI-handlers), I don't see any
problem with it off hand.

	--david

[1] http://www.gelato.unsw.edu.au/linux-ia64/0307/6109.html
