Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312261AbSCYCah>; Sun, 24 Mar 2002 21:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312259AbSCYCaV>; Sun, 24 Mar 2002 21:30:21 -0500
Received: from zero.tech9.net ([209.61.188.187]:26899 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S312257AbSCYC3g>;
	Sun, 24 Mar 2002 21:29:36 -0500
Subject: Re: preempt-related hangs
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <3C9E8767.4F57CB0A@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 24 Mar 2002 21:30:26 -0500
Message-Id: <1017023430.13141.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-03-24 at 21:11, Andrew Morton wrote:

> OK, this patch fixed it.  I don't know why.

Eh, odd.  That effectively disables kernel preemption around
set_cpus_allowed, but preemption is already disabled by the task_rq_lock
call.  Note, however, preemption is enabled by the task_rq_unlock and
thus wake_up_process is called with preemption enabled.

With your patch, preemption is now disabled across the call, and
subsequently the task_rq_unlock in try_to_wake_up will never call
preempt_schedule and your lock does not happen.

The actual problem may be elsewhere, and this just hides it.  This is
pretty clear, since we would get a similar effect just wrapping
wake_up_process in preempt_disable.  But, oh, try_to_wake_up disables
preempt, too ... hrm.

Hm, what if try_to_wake_up wakes up a process and then preemptively
schedules into it and it wants to acquire the req.sem semaphore, but
cannot, as it is still taken by set_cpus_allowed?  The semaphore seems
to just be used in the migration code.

So we have init spinning on softirq threads to come up and then we have
a deadlock on req.sem from set_cpus_allowed and into the migration
thread?

Bleh ... Ingo?

	Robert Love


