Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266878AbUHZDRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266878AbUHZDRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 23:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHZDRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 23:17:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7629 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266878AbUHZDR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 23:17:28 -0400
Subject: Re: [patch] PPC/PPC64 port of voluntary preempt patch
From: Lee Revell <rlrevell@joe-job.com>
To: Scott Wood <scott@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, manas.saksena@timesys.com,
       linux-kernel <linux-kernel@vger.kernel.org>, nando@ccrma.stanford.edu
In-Reply-To: <20040824195122.GA9949@yoda.timesys>
References: <20040823221816.GA31671@yoda.timesys>
	 <20040824195122.GA9949@yoda.timesys>
Content-Type: text/plain
Message-Id: <1093490252.5678.56.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 23:17:32 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 15:51, Scott Wood wrote:
> On Mon, Aug 23, 2004 at 06:18:16PM -0400, Scott Wood wrote:
> > I have attached a port of the voluntary preempt patch to PPC and
> > PPC64.  The patch is against P7, but it applies against P8 as well.
> > 
> > I've tested it on a dual G5 Mac, both in uniprocessor and SMP.
> > 
> > Some notes on changes to the generic part of the patch/existing
> > generic code:
> 
> Another thing that I forgot to mention is that I have some doubts as
> to the current generic_synchronize_irq() implementation.  Given that
> IRQs are now preemptible, a higher priority RT thread calling
> synchronize_irq can't just spin waiting for the IRQ to complete, as
> it never will (and it wouldn't be a great idea for non-RT tasks
> either).  I see that a do_hardirq() call was added, presumably to
> hurry completion of the interrupt, but is that really safe?  It looks
> like that could end up re-entering handlers, and you'd still have a
> partially executed handler after synchronize_irq() finishes (causing
> not only an extra end() call, but possibly code being executed after
> it's been unloaded, and other synchronization violations).
> 
> If I'm missing something, please let me know, but I don't see a good
> way to implement it without blocking for the IRQ thread's completion
> (such as with the per-IRQ waitqueues in M5).

I think Scott may be on to something.  There are several reports that P9
does not work on SMP machines at all - it either doesn't boot, locks up
the first time there is heavy IRQ activity (starting KDE), or locks up
as soon as the first RT process is run.  This is exactly the behavior
that would be expected if Scott is correct.  See this thread:

http://ccrma-mail.stanford.edu/pipermail/planetccrma/2004-August/005899.html

Does anyone have P9 working on SMP?  Fernando, can you see if M5 works
on SMP?  If this works it would seem that the preemptible IRQs are the
problem.

Lee


