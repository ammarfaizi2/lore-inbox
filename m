Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTKGWmY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTKGW0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:26:12 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6888 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264005AbTKGJqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:46:06 -0500
Date: Fri, 7 Nov 2003 10:45:59 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Mark Gross <mgross@linux.co.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SMP signal latency fix up.
In-Reply-To: <1068169363.1831.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.56.0311071039490.20509@earth>
References: <Pine.LNX.4.44.0311061510440.1842-100000@home.osdl.org> 
 <1068169185.1831.9.camel@localhost.localdomain> <1068169363.1831.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Nov 2003, Mark Gross wrote:

>  			}
> -			success = 1;
>  		}
> -#ifdef CONFIG_SMP
> -	       	else
> -			if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> -				smp_send_reschedule(task_cpu(p));
> -#endif
> +		success = 1;

hm, this i believe is incorrect - you've moved the 'success' case outside
of the 'real wakeup' branch.

to avoid races, we only want to report success if the thread has been
truly placed on the runqueue by this call. The other case (eg. changing
TASK_INTERRUPTIBLE to TASK_RUNNING) does not count as a 'wakeup'. Note
that if the task was in a non-TASK_RUNNING state then we dont have to kick
the process anyway because it's in kernel-mode and will go through the
signal return path soon.

	Ingo
