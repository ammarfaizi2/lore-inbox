Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWESBKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWESBKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWESBKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:10:44 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:53124 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932158AbWESBKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:10:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Fri, 19 May 2006 11:10:19 +1000
User-Agent: KMail/1.9.1
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
References: <4t16i2$142pji@orsmga001.jf.intel.com> <1147935878.7481.20.camel@homer> <1147957143.7632.8.camel@homer>
In-Reply-To: <1147957143.7632.8.camel@homer>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605191110.19607.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 22:59, Mike Galbraith wrote:
> On Thu, 2006-05-18 at 09:04 +0200, Mike Galbraith wrote:
> > OK, after some brief testing, I think this is a step in the right
> > direct, but there is another problem.  In the case where the queue isn't
> > empty, the stated intent is utterly defeated by the on runqueue bonus.
>
> The overly verbose one liner below could serve as a minimal ~fix.
>
> Prevent the on-runqueue bonus logic from defeating the idle sleep logic.
>
> Signed-off-by: Mike Galbraith <efault@gmx.de>
>
> --- linux-2.6.17-rc4-mm1/kernel/sched.c.org	2006-05-18 08:38:13.000000000
> +0200 +++ linux-2.6.17-rc4-mm1/kernel/sched.c	2006-05-18 14:47:09.000000000
> +0200 @@ -917,6 +917,16 @@ static int recalc_task_prio(task_t *p, u
>  			 * with one single large enough sleep.
>  			 */
>  			p->sleep_avg = ceiling;
> +			/*
> +			 * Using INTERACTIVE_SLEEP() as a ceiling places a
> +			 * nice(0) task 1ms sleep away from promotion, and
> +			 * gives it 700ms to round-robin with no chance of
> +			 * being demoted.  This is more than generous, so
> +			 * mark this sleep as non-interactive to prevent the
> +			 * on-runqueue bonus logic from intervening should
> +			 * this task not receive cpu immediately.
> +			 */
> +			p->sleep_type = SLEEP_NONINTERACTIVE;
>  		} else {
>  			/*
>  			 * Tasks waking from uninterruptible sleep are

Yes I like it. It's consistent with the intent and lacking from the current 
design.

Ok I'll wrap this and Ken's patches all together and ask for them to be pushed 
upstream. I'd go so far as to say they are mostly obvious comment and 
bugfixes for the code that is already going into 2.6.17 and we should short 
circuit them to mainline if it's ok with Ingo and Akpm.

-- 
-ck
