Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265438AbTF1WbL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 18:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbTF1WbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 18:31:11 -0400
Received: from smtp1.brturbo.com ([200.199.201.21]:37329 "EHLO
	smtp.brturbo.com") by vger.kernel.org with ESMTP id S265438AbTF1WbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 18:31:09 -0400
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
From: Roberto Orenstein <rstein@brturbo.com>
To: pat erley <paterley@drunkencodepoets.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030628162656.06e7e046.paterley@drunkencodepoets.com>
References: <200306281516.12975.kernel@kolivas.org>
	 <20030628162656.06e7e046.paterley@drunkencodepoets.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056840300.1358.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 19:45:01 -0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-28 at 17:26, pat erley wrote:
> I made a small error when I sent Con a piece of magic I wrote up to help the sleep period.  
> 
> what it says right now:
> 
> /kernel/sched.c around line 325
> 
> 
> sleep_period = (sleep_period *
> 	17 * sleep_period / ((17 * sleep_period / (5 * tau) + 2) * 5 * tau));
> ----------------------------------------------------------^
> 
> it should be:
> 
> sleep_period = (sleep_period *
> 	17 * sleep_period / ((17 * sleep_period / (5 * tau + 2)) * 5 * tau));
> --------------------------------------------------------------^
> 
> stupid parenthesis.
> 
> a little background.  what this essentially is is a taylor approximation of the function ln(66x+1) normalized.  ln(66x+1) happens to do a great job oas a weighting function on the range of 0 to 1, and because the input only happens to range from 0 to 1, only 2 terms were needed to do a 'good enough' job.
> 
> Pat

I did your correction and I got a kernel panic(attempting to kill init)
on boot. It didn't flushed to disk, so it isn't attached, but it panics
at effective_prio+0xcc/0xe0.
With objdump I could see it traps a division by 0: 
cc:       f7 fb                   idiv   %ebx

I remember cleary %ebx being 0 on the panic report.
And I tracked down and the code is on this else in effective_prio:
----------- sched.c 341-----------------
else {
	sleep_period = (sleep_period *
		17 * sleep_period / ((17 * sleep_period / (5 * tau + 2)) * 5 * tau));
	if (!sleep_period)
		return p->static_prio;
	}
--------------------------------------

I don't have the time now to track this further today, but what happens
if sleep_period is too small and tau is too big?
 Could this (17 * sleep_period / (5 * tau + 2) give 0 and so a division
by 0?

abs
Roberto



