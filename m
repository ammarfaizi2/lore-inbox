Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265556AbTF2EkZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 00:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265564AbTF2EkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 00:40:25 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:47822 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265556AbTF2EkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 00:40:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Roberto Orenstein <rstein@brturbo.com>,
       pat erley <paterley@drunkencodepoets.com>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Sun, 29 Jun 2003 14:57:40 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306281516.12975.kernel@kolivas.org> <1056840300.1358.12.camel@localhost.localdomain> <200306291132.49068.kernel@kolivas.org>
In-Reply-To: <200306291132.49068.kernel@kolivas.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306291457.40524.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jun 2003 11:32, Con Kolivas wrote:
> On Sun, 29 Jun 2003 08:45, Roberto Orenstein wrote:
> > On Sat, 2003-06-28 at 17:26, pat erley wrote:
> > > I made a small error when I sent Con a piece of magic I wrote up to
> > > help the sleep period.
> > >
> > > what it says right now:
> > >
> > > /kernel/sched.c around line 325
> > >
> > >
> > > sleep_period = (sleep_period *
> > > 	17 * sleep_period / ((17 * sleep_period / (5 * tau) + 2) * 5 * tau));
> > > ----------------------------------------------------------^
> > >
> > > it should be:
> > >
> > > sleep_period = (sleep_period *
> > > 	17 * sleep_period / ((17 * sleep_period / (5 * tau + 2)) * 5 * tau));
> > > --------------------------------------------------------------^
> > >
> > > stupid parenthesis.
> > >
> > > a little background.  what this essentially is is a taylor
> > > approximation of the function ln(66x+1) normalized.  ln(66x+1) happens
> > > to do a great job oas a weighting function on the range of 0 to 1, and
> > > because the input only happens to range from 0 to 1, only 2 terms were
> > > needed to do a 'good enough' job.
> > >
> > > Pat
> >
> > I did your correction and I got a kernel panic(attempting to kill init)
> > on boot. It didn't flushed to disk, so it isn't attached, but it panics
> > at effective_prio+0xcc/0xe0.
> > With objdump I could see it traps a division by 0:
> > cc:       f7 fb                   idiv   %ebx
> >
> > I remember cleary %ebx being 0 on the panic report.
> > And I tracked down and the code is on this else in effective_prio:
> > ----------- sched.c 341-----------------
> > else {
> > 	sleep_period = (sleep_period *
> > 		17 * sleep_period / ((17 * sleep_period / (5 * tau + 2)) * 5 * tau));
> > 	if (!sleep_period)
> > 		return p->static_prio;
> > 	}
> > --------------------------------------
> >
> > I don't have the time now to track this further today, but what happens
> > if sleep_period is too small and tau is too big?
> >  Could this (17 * sleep_period / (5 * tau + 2) give 0 and so a division
> > by 0?
>
> This will give a divide by zero.
>
> I will put together a new patch soon with this correction and appropriate
> logic.

Further inspection of this code shows to me that the current version will do 
the job adequately. The full function Pat put together is a little more 
complicated and unfortunately falls over with integer logic. This one is a 
reasonable enough approximation.

So to summarise, if you still wish to test/use this patch, continue using the 
patch as posted unmodified called:

patch-O1int-0306290223

Con

