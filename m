Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964936AbWEJMKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbWEJMKo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 08:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWEJMKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 08:10:44 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33249 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964936AbWEJMKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 08:10:43 -0400
Date: Wed, 10 May 2006 17:36:58 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: lse-tech@lists.sourceforge.net, akpm@osdl.org
Subject: [PATCH][delayacct] Use portable cputime API in __delayacct_add_tsk()
Message-ID: <20060510120658.GA16239@in.ibm.com>
Reply-To: balbir@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

While testing on ppc64, I found that taskstats could return incorrect data.
The same code worked fine on x86.

	Thanks,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs


Description of the patch
------------------------

tsk->utime and tsk->stime are of type cputime_t. Explicitly converting from
cputime to nanoseconds does not work on all platforms. Use the cputime
API for conversion. This makes the code more portable and returns correct data
on ppc64.

This patch has been tested on x86 and ppc64.

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/delayacct.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/delayacct.c~taskstats-use-cputime-api-for-cpu_run_real_time kernel/delayacct.c
--- linux-2.6.17-rc3/kernel/delayacct.c~taskstats-use-cputime-api-for-cpu_run_real_time	2006-05-10 17:04:22.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/delayacct.c	2006-05-10 17:05:45.000000000 +0530
@@ -112,7 +112,8 @@ int __delayacct_add_tsk(struct taskstats
 	unsigned long t1,t2,t3;
 
 	tmp = (s64)d->cpu_run_real_total;
-	tmp += (u64)(tsk->utime + tsk->stime) * TICK_NSEC;
+	cputime_to_timespec(tsk->utime + tsk->stime, &ts);
+	tmp += timespec_to_ns(&ts);
 	d->cpu_run_real_total = (tmp < (s64)d->cpu_run_real_total) ? 0 : tmp;
 
 	/*
_
