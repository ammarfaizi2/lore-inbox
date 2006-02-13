Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWBMOdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWBMOdm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 09:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWBMOdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 09:33:42 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:32390 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932232AbWBMOdl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 09:33:41 -0500
Date: Mon, 13 Feb 2006 20:03:45 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Balbir Singh <balbir.singh@in.ibm.com>
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
Message-ID: <20060213143345.GA12279@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060209061142.2164.35994.sendpatchset@debian> <20060209061147.2164.4528.sendpatchset@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209061147.2164.4528.sendpatchset@debian>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 03:11:47PM +0900, KUROSAWA Takahiro wrote:
> This patch adds CPU resource controller.  It enables us to control
> CPU time percentage of tasks grouped by the cpu_rc structure.
> It controls time_slice of tasks based on the feedback of difference
> between the target value and the current usage in order to control
> the percentage of the CPU usage to the target value.

I noticed some anomalies in guarantees that were provided to different classes.
Basically I had created two classes CA (10% guarantee) and CB (90% guarantee) 
and run few tasks on a 4-cpu system as below:

Case 1:

	CPU0	CPU1	CPU2	CPU3
	============================

	TA1	TA2	TA3	TA4
	TB1	TB2	TB3	TB4

Case 2:
	
	CPU0	CPU1	CPU2	CPU3
	============================

	TA1	TA2	TA3	TA4
	               		TB4

TA* tasks belong to CA and TB* belong to CB. All are CPU hungry tasks. Also 
each task is bound to the respective CPU indicated.

In both above cases, I found that CPU time was *equally* shared between the two 
classes (whereas I expected them to be shared in 1:9 ratio).

> +void cpu_rc_collect_hunger(task_t *tsk)
> +{

[snip]

> +	if (CPU_RC_GUAR_SCALE * tsk->last_slice	/ (wait + tsk->last_slice)
> +			< cr->guarantee / cr->rcd->numcpus)
					^^^^^^^^^^^^^^^^^^
					
Debugging it a bit indicated that the division of cr->guarantee by 
cr->rcd->numcpus in cpu_rc_collect_hunger doesn't seem to be required (since 
LHS is not on global scale and also the class's tasks may not be running
on other CPUs as in case 2). Removing the division rectified CPU sharing 
anomaly I had found.

Let me know what you think of this fix!


--- kernel/cpu_rc.c.org	2006-02-11 08:44:38.000000000 +0530
+++ kernel/cpu_rc.c	2006-02-13 18:34:30.000000000 +0530
@@ -204,7 +204,7 @@ void cpu_rc_collect_hunger(task_t *tsk)
 
 	wait = jiffies - tsk->last_activated;
 	if (CPU_RC_GUAR_SCALE * tsk->last_slice	/ (wait + tsk->last_slice)
-			< cr->guarantee / cr->rcd->numcpus)
+			< cr->guarantee)
 		cr->stat[cpu].maybe_hungry++;
 
 	tsk->last_activated = 0;



-- 
Regards,
vatsa
