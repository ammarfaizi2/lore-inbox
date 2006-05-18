Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751155AbWERBjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbWERBjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 21:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWERBjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 21:39:04 -0400
Received: from mail21.syd.optusnet.com.au ([211.29.133.158]:30883 "EHLO
	mail21.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751155AbWERBjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 21:39:02 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 18 May 2006 11:38:25 +1000
User-Agent: KMail/1.9.1
Cc: tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       "Andrew Morton" <akpm@osdl.org>, "Mike Galbraith" <efault@gmx.de>
References: <4t16i2$142pji@orsmga001.jf.intel.com>
In-Reply-To: <4t16i2$142pji@orsmga001.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181138.26399.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 11:10, Chen, Kenneth W wrote:
> Con Kolivas wrote on Wednesday, May 17, 2006 5:35 PM
>
> > What is missing
> > from the comment is to say that it is also designed to stop them at the
> > lowest possible priority that still keeps them in the interactive
> > reinsertion class.
> >
> > Using a constant ceiling value irrespective of nice will not guarantee
> > that tasks fall into the active reinsertion class dependant on their nice
> > value.
>
> If I may ask, how does it work right now?  Ceiling is set at constant value
> irrespective to nice value.  Are you saying current code is broken as well?

In essence, yes. The approximation was too general and vague as you have 
pointed out, and was only close to the correct ceiling or knee for one nice 
value.  I just want to formalise the relationship between the ceiling, nice 
value and INTERACTIVE_SLEEP and make the comment clear enough to be 
understood.

>         ceiling = JIFFIES_TO_NS(MAX_SLEEP_AVG -
>                   DEF_TIMESLICE);
>         if (p->sleep_avg < ceiling)
>                   p->sleep_avg = ceiling;
>
>
> We maybe also misunderstand each other.  I'm not arguing of removing the
> ceiling. Having a ceiling is the right thing to do here.  What I don't like
> is that 2.6.17-rc4 has the ceiling set too high, and your patch also does
> an inversion of the ceiling value w.r.t nice value.  So it's the detail of
> what's the right value for priority boost that I'm uncomfortable with.

We're in fuzzy land where there are no absolutes I'm afraid. The common case 
is obviously nice 0 and anything else is simply respecting the relationship 
between nice and INTERACTIVE_SLEEP. As timeslices get proportionately larger 
the lower the nice value, it becomes increasingly easy to avoid getting to 
the end of a full timeslice thereby avoiding expiration anyway. It also 
doesn't take much sleep from a task to get to best priority from the priority 
knee/ceiling no matter how low it is. Finally the relationship between likely 
preemption with varying nice levels is sort of vaguely maintained. On balance 
it seems satisfactory to me to maintain this relationship.

-- 
-ck
