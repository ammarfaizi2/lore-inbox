Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVG2JIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVG2JIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 05:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVG2JIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 05:08:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52680 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262541AbVG2JII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 05:08:08 -0400
Date: Fri, 29 Jul 2005 11:07:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: Delete scheduler SD_WAKE_AFFINE and SD_WAKE_BALANCE flags
Message-ID: <20050729090742.GA8438@elte.hu>
References: <200507290627.j6T6Rrg06842@unix-os.sc.intel.com> <42E9ED47.1030003@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E9ED47.1030003@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Well, you can easily see suboptimal scheduling decisions on many 
> programs with lots of interprocess communication. For example, tbench 
> on a dual Xeon:
> 
> processes    1               2               3              4
> 
> 2.6.13-rc4:  187, 183, 179   260, 259, 256   340, 320, 349  504, 496, 500
> no wake-bal: 180, 180, 177   254, 254, 253   268, 270, 348  345, 290, 500
> 
> Numbers are MB/s, higher is better.

i cannot see any difference with/without wake-balancing in this 
workload, on a dual Xeon. Could you try the quick hack below and do:

	echo 1 > /proc/sys/kernel/panic # turn on wake-balancing
	echo 0 > /proc/sys/kernel/panic # turn off wake-balancing

does the runtime switching show any effects on the throughput numbers 
tbench is showing? I'm using dbench-3.03. (i only checked the status 
numbers, didnt do full runs)

(did you have SCHED_SMT enabled?)

	Ingo

 kernel/sched.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-prefetch-task/kernel/sched.c
===================================================================
--- linux-prefetch-task.orig/kernel/sched.c
+++ linux-prefetch-task/kernel/sched.c
@@ -1155,6 +1155,8 @@ static int try_to_wake_up(task_t * p, un
 		goto out_activate;
 
 	new_cpu = cpu;
+	if (!panic_timeout)
+		goto out_set_cpu;
 
 	schedstat_inc(rq, ttwu_cnt);
 	if (cpu == this_cpu) {
