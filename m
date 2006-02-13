Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030312AbWBMXzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030312AbWBMXzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWBMXzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:55:31 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:64964 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030312AbWBMXza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:55:30 -0500
Date: Tue, 14 Feb 2006 08:55:29 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: vatsa@in.ibm.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       balbir.singh@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
In-Reply-To: <20060213143345.GA12279@in.ibm.com>
References: <20060209061142.2164.35994.sendpatchset@debian>
	<20060209061147.2164.4528.sendpatchset@debian>
	<20060213143345.GA12279@in.ibm.com>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060213235529.CB13674035@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006 20:03:45 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> > +void cpu_rc_collect_hunger(task_t *tsk)
> > +{
> 
> [snip]
> 
> > +	if (CPU_RC_GUAR_SCALE * tsk->last_slice	/ (wait + tsk->last_slice)
> > +			< cr->guarantee / cr->rcd->numcpus)
> 					^^^^^^^^^^^^^^^^^^
> 					
> Debugging it a bit indicated that the division of cr->guarantee by 
> cr->rcd->numcpus in cpu_rc_collect_hunger doesn't seem to be required (since 
> LHS is not on global scale and also the class's tasks may not be running
> on other CPUs as in case 2). Removing the division rectified CPU sharing 
> anomaly I had found.
> 
> Let me know what you think of this fix!

Ah, you are right.  LHS is on per-cpu scale.
I'll apply your patch.

> --- kernel/cpu_rc.c.org	2006-02-11 08:44:38.000000000 +0530
> +++ kernel/cpu_rc.c	2006-02-13 18:34:30.000000000 +0530
> @@ -204,7 +204,7 @@ void cpu_rc_collect_hunger(task_t *tsk)
>  
>  	wait = jiffies - tsk->last_activated;
>  	if (CPU_RC_GUAR_SCALE * tsk->last_slice	/ (wait + tsk->last_slice)
> -			< cr->guarantee / cr->rcd->numcpus)
> +			< cr->guarantee)
>  		cr->stat[cpu].maybe_hungry++;
>  
>  	tsk->last_activated = 0;

Thanks,

-- 
KUROSAWA, Takahiro
