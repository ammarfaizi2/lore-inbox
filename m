Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268766AbUJEDTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268766AbUJEDTY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 23:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268771AbUJEDTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 23:19:23 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:63091 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268766AbUJEDSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 23:18:11 -0400
Message-ID: <41621263.2000404@yahoo.com.au>
Date: Tue, 05 Oct 2004 13:17:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: bug in sched.c:task_hot()
References: <200410050237.i952bx620740@unix-os.sc.intel.com>
In-Reply-To: <200410050237.i952bx620740@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chen, Kenneth W wrote:

>Current implementation of task_hot() has a performance bug in it
>that it will cause integer underflow.
>
>Variable "now" (typically passed in as rq->timestamp_last_tick)
>and p->timestamp are all defined as unsigned long long.  However,
>If former is smaller than the latter, integer under flow occurs
>which make the result of subtraction a huge positive number. Then
>it is compared to sd->cache_hot_time and it will wrongly identify
>a cache hot task as cache cold.
>
>This bug causes large amount of incorrect process migration across
>cpus (at stunning 10,000 per second) and we lost cache affinity very
>quickly and almost took double digit performance regression on a db
>transaction processing workload.  Patch to fix the bug.  Diff'ed against
>2.6.9-rc3.
>
>Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
>

This one looks OK (the other may need a bit of rethinking).
What kernel is the regression in relation to, out of interest?

>
>--- linux-2.6.9-rc3/kernel/sched.c.orig	2004-10-04 19:11:21.000000000 -0700
>+++ linux-2.6.9-rc3/kernel/sched.c	2004-10-04 19:19:27.000000000 -0700
>@@ -180,7 +180,8 @@ static unsigned int task_timeslice(task_
> 	else
> 		return SCALE_PRIO(DEF_TIMESLICE, p->static_prio);
> }
>-#define task_hot(p, now, sd) ((now) - (p)->timestamp < (sd)->cache_hot_time)
>+#define task_hot(p, now, sd) ((long long) ((now) - (p)->timestamp)	\
>+				< (long long) (sd)->cache_hot_time)
>
> enum idle_type
> {
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>

