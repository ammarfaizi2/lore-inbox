Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWELAEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWELAEN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 20:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWELAEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 20:04:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:26971 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750852AbWELAEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 20:04:12 -0400
Message-Id: <4sur0l$12a3ma@fmsmga001.fm.intel.com>
X-IronPort-AV: i="4.05,117,1146466800"; 
   d="scan'208"; a="35983050:sNHT55328840"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>, <tim.c.chen@linux.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <mingo@elte.hu>
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 11 May 2006 17:04:11 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZzAatbAtx7xdtqR8K9xufWAU8wqwCUsv7A
In-Reply-To: <cone.1147135389.188411.32203.501@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen writes:
> See patch:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e72ff0bb2c163eb13014ba113701bd42dab382fe 

Con Kolivas wrote on Monday, May 08, 2006 5:43 PM
> This patch corrects a bug in the original code which unintentionally dropped 
> the priority of tasks that were idle but were already high priority on other 
> merits. It doesn't further increase the priority.


This got me to take a non-casual look at that particular git commit.  The
first portion of the change log description says perfectly about the intent,
but after studying the code, I have to say that the actual code does not
implement what people say it will do.  In recalc_task_prio(), if a task's
sleep_time is more than INTERACTIVE_SLEEP, it will bump up p->sleep_avg all
the way to near maximum (at MAX_SLEEP_AVG - DEF_TIMESLICE), which according
to my calculation, it will have a priority bonus of 4 (out of max 5).

IOW, for a prolonged sleep, a task will immediately get near maximum priority
boost. Is that what the real intent is?  Seems to be on the contrary to what
the source code comments as well.

I think in the if (sleep_time > INTERACTIVE_SLEEP) block, p->sleep_avg should
be treated similarly like what the "else" block is doing: scale it proportionally
with past sleep time, perhaps not the immediate previously prolonged sleep
because that would for sure bump up priority too fast.  A better method might
be p->sleep_avg *= 2 or something like that.

- Ken
