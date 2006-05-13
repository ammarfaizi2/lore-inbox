Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932429AbWEMNHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbWEMNHI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 09:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWEMNHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 09:07:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:45465 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932429AbWEMNHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 09:07:07 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, kernel@kolivas.org,
       tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060513052730.389ea002.akpm@osdl.org>
References: <cone.1147135389.188411.32203.501@kolivas.org>
	 <4sur0l$12a3ma@fmsmga001.fm.intel.com>
	 <20060513052730.389ea002.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 13 May 2006 15:07:17 +0200
Message-Id: <1147525637.9829.28.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 05:27 -0700, Andrew Morton wrote:
> (Catching up on lkml)
> 
> On Thu, 11 May 2006 17:04:11 -0700
> "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
> 
> > Tim Chen writes:
> > > See patch:
> > > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e72ff0bb2c163eb13014ba113701bd42dab382fe 
> > 
> > Con Kolivas wrote on Monday, May 08, 2006 5:43 PM
> > > This patch corrects a bug in the original code which unintentionally dropped 
> > > the priority of tasks that were idle but were already high priority on other 
> > > merits. It doesn't further increase the priority.
> > 
> > 
> > This got me to take a non-casual look at that particular git commit.  The
> > first portion of the change log description says perfectly about the intent,
> > but after studying the code, I have to say that the actual code does not
> > implement what people say it will do.  In recalc_task_prio(), if a task's
> > sleep_time is more than INTERACTIVE_SLEEP, it will bump up p->sleep_avg all
> > the way to near maximum (at MAX_SLEEP_AVG - DEF_TIMESLICE), which according
> > to my calculation, it will have a priority bonus of 4 (out of max 5).
> > 
> > IOW, for a prolonged sleep, a task will immediately get near maximum priority
> > boost. Is that what the real intent is?  Seems to be on the contrary to what
> > the source code comments as well.
> > 
> > I think in the if (sleep_time > INTERACTIVE_SLEEP) block, p->sleep_avg should
> > be treated similarly like what the "else" block is doing: scale it proportionally
> > with past sleep time, perhaps not the immediate previously prolonged sleep
> > because that would for sure bump up priority too fast.  A better method might
> > be p->sleep_avg *= 2 or something like that.
> > 
> 
> That seems to be a pretty significant discovery.  Is anything happening
> with it?

When I tried to fix that, I ran into resistance.

	-Mike

