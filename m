Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVCXKqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVCXKqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 05:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbVCXKqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 05:46:09 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47019 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262627AbVCXKqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 05:46:02 -0500
Date: Thu, 24 Mar 2005 11:45:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324104554.GB20359@elte.hu>
References: <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050324052854.GA1298@us.ibm.com> <20050324053456.GA14494@elte.hu> <Pine.LNX.4.58.0503240310490.18714@localhost.localdomain> <Pine.LNX.4.58.0503240341280.18714@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503240341280.18714@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I also see this with non rt tasks causing a burst of schedules.
> 
> 1. Process A runs and grabs lock L. then finishes its time slice.
> 2. Process B runs and tries to grab Lock L.
> 3. Process A runs and releases lock L.
> 4. __up_mutex gives process B lock L.
> 5. Process A tries to grab lock L.
> 6. Process B runs and releases lock L.
> 7. __up_mutex gives lock L to process A.
> 8. Process B tries to grab lock L again.
> 9. Process A runs...
> 
> Here we have more unnecessary schedules.  So the condition to grab a lock
> should be:
> 
> 1. not owned.
> 2. partially owned, and the owner is not RT.
> 3. partially owned but the owner is RT and so is the grabber, and the
>     grabber's priority is >= the owner's priority.

yeah, sounds good - but i'd not make any distinction between RT and 
non-RT tasks - just make the rule #3 distinction based on ->prio. In 
particular on UP a task should only run when its higher prio, so if a 
lock is 'partially owned' then the priority rule should always be true.  
(On SMP it's a bit more complex, there the priority rule could make a 
real difference.)

	Ingo
