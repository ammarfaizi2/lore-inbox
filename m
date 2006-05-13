Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWEMMak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWEMMak (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWEMMaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:30:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932405AbWEMMaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:30:39 -0400
Date: Sat, 13 May 2006 05:27:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: kernel@kolivas.org, tim.c.chen@linux.intel.com,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Message-Id: <20060513052730.389ea002.akpm@osdl.org>
In-Reply-To: <4sur0l$12a3ma@fmsmga001.fm.intel.com>
References: <cone.1147135389.188411.32203.501@kolivas.org>
	<4sur0l$12a3ma@fmsmga001.fm.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Catching up on lkml)

On Thu, 11 May 2006 17:04:11 -0700
"Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> Tim Chen writes:
> > See patch:
> > http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e72ff0bb2c163eb13014ba113701bd42dab382fe 
> 
> Con Kolivas wrote on Monday, May 08, 2006 5:43 PM
> > This patch corrects a bug in the original code which unintentionally dropped 
> > the priority of tasks that were idle but were already high priority on other 
> > merits. It doesn't further increase the priority.
> 
> 
> This got me to take a non-casual look at that particular git commit.  The
> first portion of the change log description says perfectly about the intent,
> but after studying the code, I have to say that the actual code does not
> implement what people say it will do.  In recalc_task_prio(), if a task's
> sleep_time is more than INTERACTIVE_SLEEP, it will bump up p->sleep_avg all
> the way to near maximum (at MAX_SLEEP_AVG - DEF_TIMESLICE), which according
> to my calculation, it will have a priority bonus of 4 (out of max 5).
> 
> IOW, for a prolonged sleep, a task will immediately get near maximum priority
> boost. Is that what the real intent is?  Seems to be on the contrary to what
> the source code comments as well.
> 
> I think in the if (sleep_time > INTERACTIVE_SLEEP) block, p->sleep_avg should
> be treated similarly like what the "else" block is doing: scale it proportionally
> with past sleep time, perhaps not the immediate previously prolonged sleep
> because that would for sure bump up priority too fast.  A better method might
> be p->sleep_avg *= 2 or something like that.
> 

That seems to be a pretty significant discovery.  Is anything happening
with it?
