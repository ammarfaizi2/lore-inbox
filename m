Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVKJVm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVKJVm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVKJVm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:42:59 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:22437 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932151AbVKJVm6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:42:58 -0500
Subject: Re: IO-APIC problem with 2.6.14-rt9
From: john stultz <johnstul@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20051110210458.GA6097@elte.hu>
References: <20051110200226.GA18780@in.ibm.com>
	 <20051110200205.GA4696@elte.hu> <20051110203000.GB16301@in.ibm.com>
	 <1131654575.27168.685.camel@cog.beaverton.ibm.com>
	 <20051110210458.GA6097@elte.hu>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 13:42:54 -0800
Message-Id: <1131658975.27168.703.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-10 at 22:04 +0100, Ingo Molnar wrote:
> * john stultz <johnstul@us.ibm.com> wrote:
> 
> > > > //#define ARCH_HAS_READ_CURRENT_TIMER  1
> > > > 
> > > > to:
> > > > 
> > > > #define ARCH_HAS_READ_CURRENT_TIMER  1
> > > > 
> > > > ?
> > > 
> > > It works !!  Thanks Ingo for the immediate response
> > 
> > Hrm. Could you post the value for BogoMIPS that you're getting now?
> > 
> > My patches touch the __delay() code, since using the TSC based delay 
> > has just as many, if not more, problems as the loop based delay. So I 
> > want to be careful that my changes are not further causing problems.
> > 
> > Ingo, did you commented out ARCH_HAS_READ_CURRENT_TIMER because of 
> > problems with the new calibration code?
> 
> yes. traces show that the new calibration code results in a bogomips 
> value on Athlon64 CPUs that halve the timeout. I.e. udelay(100) now 
> takes 50 usecs (!). The calibration code seems to assume the number of 
> cycles == number of loops in __delay() - that is not valid.

Yea, that makes sense, because the READ_CURRENT_TIMER calibration is all
TSC based and with my code we use the loop based delay (since the TSC
based one can have a number of problems). So that doesn't mesh well when
the loop/cycle values are not equivalent.

That still leaves open the question why Dinakar is seeing issues w/ the
loop based calibration, but I've got some similar hardware in my lab, so
I can probably work that out.

I'll see if I can't avoid touching the delay code. Its such a sketchy
calibration sensitive code path that I'd really like to see it killed,
but maybe there's something simple that can be done.

Grumble. :( I was hoping to submit my tod code to Andrew tomorrow, but
this might block that. 

thanks
-john




