Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUG2UV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUG2UV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUG2UV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:21:26 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:60401 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S265224AbUG2UVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:21:05 -0400
Date: Thu, 29 Jul 2004 16:21:00 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Scott Wood <scott@timesys.com>, linux-kernel@vger.kernel.org,
       "La Monte H.P. Yarroll" <piggy@timesys.com>,
       Manas Saksena <manas.saksena@timesys.com>
Subject: Re: [patch] IRQ threads
Message-ID: <20040729202100.GA28507@yoda.timesys>
References: <20040727225040.GA4370@yoda.timesys> <20040728081005.GA20100@elte.hu> <20040728231241.GE6685@yoda.timesys> <20040729193341.GA27057@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729193341.GA27057@elte.hu>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 09:33:41PM +0200, Ingo Molnar wrote:
> 
> * Scott Wood <scott@timesys.com> wrote:
> 
> > > Also, why the enable_irq() change? 
> > 
> > If you mean the do_startup_irq() change, [...]
> 
> i mean the change below - why do irqthreads necessiate it?

The intent is to make enable_irq() robust against calls while the
thread is still running/pending (such as if the thread has lower
priority than the task that calls enable_irq()).  This implies that
the preceding disable was of the _nosync() variety.

I believe we saw drivers/net/8390.c doing this, and it was causing an
interrupt storm because, at the time (this was over a year ago),
actionless irqs (which this IRQ was, because the IRQ was still in
progress) had end() called, unmasking it again.  The IRQ was level
triggered, and thus the handler never got a chance to run.

That wouldn't happen with the current code, because it checks for
THREADPENDING || THREADRUNNING before calling end() in
really_do_IRQ(), so now all the check does is save the wasted time of
one bad interrupt each time it happens.

-Scott
