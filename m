Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTKGX6D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTKGWN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:13:26 -0500
Received: from fmr06.intel.com ([134.134.136.7]:14219 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S264423AbTKGPor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:44:47 -0500
Subject: Re: [PATCH] SMP signal latency fix up.
From: Mark Gross <mgross@linux.co.intel.com>
Reply-To: mgross@linux.co.intel.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark Gross <mgross@linux.co.intel.com>, Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0311071039490.20509@earth>
References: <Pine.LNX.4.44.0311061510440.1842-100000@home.osdl.org>
	 <1068169185.1831.9.camel@localhost.localdomain>
	 <1068169363.1831.15.camel@localhost.localdomain>
	 <Pine.LNX.4.56.0311071039490.20509@earth>
Content-Type: text/plain
Organization: TSP
Message-Id: <1068219789.3615.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Nov 2003 07:43:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-11-07 at 01:45, Ingo Molnar wrote:
> On Fri, 6 Nov 2003, Mark Gross wrote:
> 
> >  			}
> > -			success = 1;
> >  		}
> > -#ifdef CONFIG_SMP
> > -	       	else
> > -			if (unlikely(kick) && task_running(rq, p) && (task_cpu(p) != smp_processor_id()))
> > -				smp_send_reschedule(task_cpu(p));
> > -#endif
> > +		success = 1;
> 
> hm, this i believe is incorrect - you've moved the 'success' case outside
> of the 'real wakeup' branch.
> 

Yup, I was confusing myself a bit on the return symantics of
try_to_wake_up, and the relationship with race between changing
task->state and scheduling a task off a cpu (the "array" test while
holding the rq lock.).  

The feeling that this was likely wrong was eating at me all evening and
then it came to me around 8pm when I was driving my son to some thing.  

> to avoid races, we only want to report success if the thread has been
> truly placed on the runqueue by this call. The other case (eg. changing
> TASK_INTERRUPTIBLE to TASK_RUNNING) does not count as a 'wakeup'. Note
> that if the task was in a non-TASK_RUNNING state then we dont have to kick
> the process anyway because it's in kernel-mode and will go through the
> signal return path soon.
> 
> 	Ingo



