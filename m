Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWENQFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWENQFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWENQFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:05:34 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:48519 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751482AbWENQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:05:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Mon, 15 May 2006 02:03:13 +1000
User-Agent: KMail/1.9.1
Cc: tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
References: <4sur0l$12a3ma@fmsmga001.fm.intel.com>
In-Reply-To: <4sur0l$12a3ma@fmsmga001.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605150203.13633.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 May 2006 10:04, Chen, Kenneth W wrote:
> Tim Chen writes:
> > See patch:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=co
> >mmit;h=e72ff0bb2c163eb13014ba113701bd42dab382fe
>
> Con Kolivas wrote on Monday, May 08, 2006 5:43 PM
>
> > This patch corrects a bug in the original code which unintentionally
> > dropped the priority of tasks that were idle but were already high
> > priority on other merits. It doesn't further increase the priority.
>
> This got me to take a non-casual look at that particular git commit.  The
> first portion of the change log description says perfectly about the
> intent, but after studying the code, I have to say that the actual code
> does not implement what people say it will do.  In recalc_task_prio(), if a
> task's sleep_time is more than INTERACTIVE_SLEEP, it will bump up
> p->sleep_avg all the way to near maximum (at MAX_SLEEP_AVG -
> DEF_TIMESLICE), which according to my calculation, it will have a priority
> bonus of 4 (out of max 5).
>
> IOW, for a prolonged sleep, a task will immediately get near maximum
> priority boost. Is that what the real intent is?  Seems to be on the
> contrary to what the source code comments as well.
>
> I think in the if (sleep_time > INTERACTIVE_SLEEP) block, p->sleep_avg
> should be treated similarly like what the "else" block is doing: scale it
> proportionally with past sleep time, perhaps not the immediate previously
> prolonged sleep because that would for sure bump up priority too fast.  A
> better method might be p->sleep_avg *= 2 or something like that.

There would be no difference if the priority boost is done lower. The if and 
else blocks both end up equating to the same amount of priority boost, with 
the former having a ceiling on it, so yes it is the intent. You'll see that 
the amount of sleep required to jump from lowest priority to MAX_SLEEP_AVG - 
DEF_TIMESLICE is INTERACTIVE_SLEEP.

-ck
