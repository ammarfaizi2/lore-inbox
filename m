Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269808AbUH0BZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269808AbUH0BZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 21:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269805AbUH0BYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 21:24:45 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:48002 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S269936AbUH0BTg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 21:19:36 -0400
Subject: Re: [patch] PPC/PPC64 port of voluntary preempt patch
From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       manas.saksena@timesys.com, linux-kernel <linux-kernel@vger.kernel.org>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <1093490252.5678.56.camel@krustophenia.net>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824195122.GA9949@yoda.timesys>
	 <1093490252.5678.56.camel@krustophenia.net>
Content-Type: text/plain
Organization: 
Message-Id: <1093569534.22682.222.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Aug 2004 18:18:54 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 20:17, Lee Revell wrote:
> On Tue, 2004-08-24 at 15:51, Scott Wood wrote:
> > On Mon, Aug 23, 2004 at 06:18:16PM -0400, Scott Wood wrote:
> > > I have attached a port of the voluntary preempt patch to PPC and
> > > PPC64.  The patch is against P7, but it applies against P8 as well.
> > > I've tested it on a dual G5 Mac, both in uniprocessor and SMP.
> > > Some notes on changes to the generic part of the patch/existing
> > > generic code:
> > 
> > Another thing that I forgot to mention is that I have some doubts as
> > to the current generic_synchronize_irq() implementation.  Given that
> > IRQs are now preemptible, a higher priority RT thread calling
> > synchronize_irq can't just spin waiting for the IRQ to complete, as
> > it never will (and it wouldn't be a great idea for non-RT tasks
> > either).  I see that a do_hardirq() call was added, presumably to
> > hurry completion of the interrupt, but is that really safe?  It looks
> > like that could end up re-entering handlers, and you'd still have a
> > partially executed handler after synchronize_irq() finishes (causing
> > not only an extra end() call, but possibly code being executed after
> > it's been unloaded, and other synchronization violations).
> > 
> > If I'm missing something, please let me know, but I don't see a good
> > way to implement it without blocking for the IRQ thread's completion
> > (such as with the per-IRQ waitqueues in M5).
> 
> I think Scott may be on to something.  There are several reports that P9
> does not work on SMP machines at all - it either doesn't boot, locks up
> the first time there is heavy IRQ activity (starting KDE), or locks up
> as soon as the first RT process is run.  This is exactly the behavior
> that would be expected if Scott is correct.  See this thread:
> 
> http://ccrma-mail.stanford.edu/pipermail/planetccrma/2004-August/005899.html
> 
> Does anyone have P9 working on SMP?  Fernando, can you see if M5 works
> on SMP?  If this works it would seem that the preemptible IRQs are the
> problem.

Sorry, I could not get SMP 2.6.8.1 + voluntary M5 to boot on my dual
Athlon test system. Again problems with interrupts but worse than P9,
this time acpi=off or pci=noacpi did not help (I can boot single user,
but the machine hang in the network startup - or if I disable that,
later on X startup). I saw two messages, one "irq 9: nobody cared!" and
then "Disabling IRQ # 9" (that's the one for the network card). On a
different boot:
  Badness in free_irq at  .... irq.c
free_irq
load_balance_new_idle
floppy_release_irq_and_dma
set_dor
motor_off_callback
...

So I could not get to the point where I could test jack and SCHED_FIFO
processes. 

-- Fernando


