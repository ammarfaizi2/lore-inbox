Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317297AbSFLL6h>; Wed, 12 Jun 2002 07:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSFLL6g>; Wed, 12 Jun 2002 07:58:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41424 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317297AbSFLL6f>;
	Wed, 12 Jun 2002 07:58:35 -0400
Date: Wed, 12 Jun 2002 04:54:14 -0700 (PDT)
Message-Id: <20020612.045414.105100110.davem@redhat.com>
To: mingo@elte.hu
Cc: kravetz@us.ibm.com, rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: Scheduler Bug (set_cpus_allowed)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0206102130060.29999-100000@elte.hu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Mon, 10 Jun 2002 22:02:28 +0200 (CEST)
   
   David, would it be possible to somehow not recurse back into the scheduler
   code (like wakeup) from within the port-specific switch_to() code?

It's a locking problem more than anything else.  It's not that
we call back into it, it's that we hold locks in switch_mm.

To recap, from the changeset 1.369.49.1:

  Fix scheduler deadlock on some platforms.
  
  Some platforms need to grab mm->page_table_lock during switch_mm().
  On the other hand code like swap_out() in mm/vmscan.c needs to hold
  mm->page_table_lock during wakeups which needs to grab the runqueue
  lock.  This creates a conflict and the resolution chosen here is to
  not hold the runqueue lock during context_switch().
  
  The implementation is specifically a "frozen" state implemented as a
  spinlock, which is held around the context_switch() call.  This allows
  the runqueue lock to be dropped during this time yet prevent another cpu
  from running the "not switched away from yet" task.

So if you're going to delete the frozen code, please replace it with
something that handles the above.

There is nothing weird about holding page_table_lock during
switch_mm, I can imagine many other ports doing it especially those
with TLB pids which want to optimize SMP tlb/cache flushes.

I think changing vmscan.c to not call wakeup is the wrong way to
go about this.  I thought about doing that originally, but it looks
to be 100 times more difficult to implement (and verify) than the
scheduler side fix.
