Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268232AbUHXTvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268232AbUHXTvv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267314AbUHXTvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:51:50 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:14788 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S268232AbUHXTv0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:51:26 -0400
Date: Tue, 24 Aug 2004 15:51:22 -0400
To: mingo@elte.hu
Cc: manas.saksena@timesys.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] PPC/PPC64 port of voluntary preempt patch
Message-ID: <20040824195122.GA9949@yoda.timesys>
References: <20040823221816.GA31671@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040823221816.GA31671@yoda.timesys>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 06:18:16PM -0400, Scott Wood wrote:
> I have attached a port of the voluntary preempt patch to PPC and
> PPC64.  The patch is against P7, but it applies against P8 as well.
> 
> I've tested it on a dual G5 Mac, both in uniprocessor and SMP.
> 
> Some notes on changes to the generic part of the patch/existing
> generic code:

Another thing that I forgot to mention is that I have some doubts as
to the current generic_synchronize_irq() implementation.  Given that
IRQs are now preemptible, a higher priority RT thread calling
synchronize_irq can't just spin waiting for the IRQ to complete, as
it never will (and it wouldn't be a great idea for non-RT tasks
either).  I see that a do_hardirq() call was added, presumably to
hurry completion of the interrupt, but is that really safe?  It looks
like that could end up re-entering handlers, and you'd still have a
partially executed handler after synchronize_irq() finishes (causing
not only an extra end() call, but possibly code being executed after
it's been unloaded, and other synchronization violations).

If I'm missing something, please let me know, but I don't see a good
way to implement it without blocking for the IRQ thread's completion
(such as with the per-IRQ waitqueues in M5).

-Scott
