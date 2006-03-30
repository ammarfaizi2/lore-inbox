Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbWC3PHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbWC3PHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWC3PH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:07:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:35771 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750774AbWC3PH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:07:29 -0500
Message-ID: <442BF42F.8020700@watson.ibm.com>
Date: Thu, 30 Mar 2006 10:07:27 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 1/8] Setup
References: <442B271D.10208@watson.ibm.com>	<442B27DE.3070105@watson.ibm.com> <20060329210333.2994c838.akpm@osdl.org>
In-Reply-To: <20060329210333.2994c838.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>  
>
>>delayacct-setup.patch
>>
>>Initialization code related to collection of per-task "delay"
>>statistics which measure how long it had to wait for cpu,
>>sync block io, swapping etc. The collection of statistics and
>>the interface are in other patches. This patch sets up the data
>>structures and allows the statistics collection to be disabled
>>through a  kernel boot paramater.
>>
>>...
>>
>>+	delayacct	[KNL] Enable per-task delay accounting
>>+
>>    
>>
>
>Why does this boot parameter exist?
>  
>

To allow people who aren't interested in these statistics from paying the
overhead of collecting the stats for each task, the memory consumed by 
per-task
accounting structures that get allocated etc.

>The code is neat-looking.
>  
>
Thanks !

>>--- /dev/null	1970-01-01 00:00:00.000000000 +0000
>>+++ linux-2.6.16/kernel/delayacct.c	2006-03-29 18:12:57.000000000 -0500
>>@@ -0,0 +1,92 @@
>>+/* delayacct.c - per-task delay accounting
>>+ *
>>+ * Copyright (C) Shailabh Nagar, IBM Corp. 2006
>>+ *
>>+ * This program is free software;  you can redistribute it and/or modify
>>+ * it under the terms of the GNU General Public License as published by
>>+ * the Free Software Foundation; either version 2 of the License, or
>>+ * (at your option) any later version.
>>+ *
>>+ * This program is distributed in the hope that it would be useful, but
>>+ * WITHOUT ANY WARRANTY; without even the implied warranty of
>>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
>>+ * the GNU General Public License for more details.
>>+ */
>>+
>>+#include <linux/sched.h>
>>+#include <linux/slab.h>
>>+#include <linux/time.h>
>>+#include <linux/sysctl.h>
>>+#include <linux/delayacct.h>
>>+
>>+int delayacct_on __read_mostly = 0;	/* Delay accounting turned on/off */
>>    
>>
>
>Yes, it should be __read_mostly.  But it shouldn't be initialised to zero.
>  
>
Will fix.

>  
>
>>+void __delayacct_tsk_init(struct task_struct *tsk)
>>+{
>>+	tsk->delays = kmem_cache_alloc(delayacct_cache, SLAB_KERNEL);
>>+	if (tsk->delays) {
>>+		memset(tsk->delays, 0, sizeof(*tsk->delays));
>>+		spin_lock_init(&tsk->delays->lock);
>>+	}
>>+}
>>    
>>
>
>We have kmem_cache_zalloc() now.
>  
>
Will use.

>  
>
>>+void __delayacct_tsk_exit(struct task_struct *tsk)
>>+{
>>+	if (tsk->delays) {
>>+		kmem_cache_free(delayacct_cache, tsk->delays);
>>+		tsk->delays = NULL;
>>+	}
>>+}
>>    
>>
>
>delayacct_tsk_exit() already checked tsk->delays.
>  
>
Oops. Will fix.

>  
>
>>+/*
>>+ * Finish delay accounting for a statistic using
>>+ * its timestamps (@start, @end), accumalator (@total) and @count
>>+ */
>>+
>>+static inline void delayacct_end(struct timespec *start, struct timespec *end,
>>+				u64 *total, u32 *count)
>>+{
>>+	struct timespec ts;
>>+	nsec_t ns;
>>+
>>+	do_posix_clock_monotonic_gettime(end);
>>+	ts.tv_sec = end->tv_sec - start->tv_sec;
>>+	ts.tv_nsec = end->tv_nsec - start->tv_nsec;
>>+	ns = timespec_to_ns(&ts);
>>+	if (ns < 0)
>>+		return;
>>+
>>+	spin_lock(&current->delays->lock);
>>+	*total += ns;
>>+	(*count)++;
>>+	spin_unlock(&current->delays->lock);
>>+}
>>    
>>
>
>It's strange to have a static inline function at the end of a .c file.  I
>guess this gets used in later patches.
>  
>
Yes. It gets called as part of the __delayacct_blkio_end call in a later 
patch.

>It looks rather too big to be inlined.
>  
>
It gets used only once currently so defining it as a separate function 
was more to
aid understanding.

>I'm surprised that we don't already have a timeval_sub() function
>somewhere.
>  
>
There isn't one currently though we'd added a generic function timespec_diff
in an earlier iteration of the patches
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0603.1/1914.html

In the ensuing discussion (under the same thread above), the problem you 
mention
below came up - whether a negative ts.tv_nsec  should be returned as is 
or should the
entire timespec be normalized. The consensus was that a normalized value 
would be
appropriate for a generic function.

However, we didn't want to pay the extra cycles of normalizing the 
return value since our
usage (using timespec_to_ns) wouldn't need it.

So we chose to remove the generic function and use the two line 
subtraction directly.
Especially since we don't really care to use truly negative differences 
(which shouldn't happen
since the timestamps are collected assuming monotonically increasing 
values).

>The code you have there will cause ts.tv_nsec to go negative half the time.
>It looks like timespec_to_ns() will happily fix that up for us, but it's
>all a bit fragile.
>  
>
If you think relying on timespec_to_ns as an "auto" normalizer is flaky, 
we can go back to
introducing a timespec_sub (which is a better name than timespec_diff) 
which returns a normalized
diff and use that.

--Shailabh

