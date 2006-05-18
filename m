Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWERXen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWERXen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWERXen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:34:43 -0400
Received: from mga03.intel.com ([143.182.124.21]:44937 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751045AbWERXem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:34:42 -0400
Message-Id: <4t153d$14p68g@azsmga001.ch.intel.com>
X-IronPort-AV: i="4.05,143,1146466800"; 
   d="scan'208"; a="38574352:sNHT1151766399"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Con Kolivas'" <kernel@kolivas.org>, "Mike Galbraith" <efault@gmx.de>
Cc: <tim.c.chen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
       <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Subject: RE: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 18 May 2006 16:34:39 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZ6P0Qi6Fn7PLXdSiCeH7Qyo7JTxgAkfbrQ
In-Reply-To: <200605181552.19868.kernel@kolivas.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote on Wednesday, May 17, 2006 10:52 PM
> The relationship between INTERACTIVE_SLEEP and the ceiling is not perfect
> and not explicit enough. The sleep boost is not supposed to be any larger
> than without this code and the comment is not clear enough about what exactly
> it does, just the reason it does it.
> 
> There is a ceiling to the priority beyond which tasks that only ever sleep
> for very long periods cannot surpass.
> 
> Opportunity to micro-optimise and re-use the ceiling variable.
> 
> --- linux-2.6.17-rc4-mm1.orig/kernel/sched.c	2006-05-17 15:57:49.000000000 +1000
> +++ linux-2.6.17-rc4-mm1/kernel/sched.c	2006-05-18 15:48:47.000000000 +1000
> @@ -925,12 +924,12 @@ static int recalc_task_prio(task_t *p, u
>  			 * are likely to be waiting on I/O
>  			 */
>  			if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
> -				if (p->sleep_avg >= INTERACTIVE_SLEEP(p))
> +				if (p->sleep_avg >= ceiling)
>  					sleep_time = 0;
>  				else if (p->sleep_avg + sleep_time >=
> -						INTERACTIVE_SLEEP(p)) {
> -					p->sleep_avg = INTERACTIVE_SLEEP(p);
> -					sleep_time = 0;
> +					 ceiling) {
> +						p->sleep_avg = ceiling;
> +						sleep_time = 0;


Watch for white space damage, last two lines has one extra tab on the indentation.


By the way, there is all kinds of non-linear behavior with priority boost
adjustment:

        if (p->sleep_type == SLEEP_NONINTERACTIVE && p->mm) {
                if (p->sleep_avg >= ceiling)
                        sleep_time = 0;
                else if (p->sleep_avg + sleep_time >= ceiling) {
                        p->sleep_avg = ceiling;
                        sleep_time = 0;
                }
        }

For large p->sleep_avg, kernel don't clamp it to ceiling, yet clamp small
incremental sleep.  This all seems very fragile.

- Ken
