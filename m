Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262779AbVCXLkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262779AbVCXLkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 06:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVCXLkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 06:40:15 -0500
Received: from mx1.elte.hu ([157.181.1.137]:64183 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262785AbVCXLjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 06:39:23 -0500
Date: Thu, 24 Mar 2005 12:39:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050324113912.GA20911@elte.hu>
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

> Here we have more unnecessary schedules.  So the condition to grab a 
> lock should be:
> 
> 1. not owned.
> 2. partially owned, and the owner is not RT.
> 3. partially owned but the owner is RT and so is the grabber, and the
>     grabber's priority is >= the owner's priority.

there's another approach that could solve this problem: let the 
scheduler sort it all out. Esben Nielsen had this suggestion a couple of 
months ago - i didnt follow it because i thought that technique would 
create too many runnable tasks, but maybe that was a mistake. If we do 
the owning of the lock once the wakee hits the CPU we avoid the 'partial 
owner' problem, and we have the scheduler sort out priorities and 
policies.

but i think i like the 'partial owner' (or rather 'owner pending') 
technique a bit better, because it controls concurrency explicitly, and 
it would thus e.g. allow another trick: when a new owner 'steals' a lock 
from another in-flight task, then we could 'unwakeup' that in-flight 
thread which could thus avoid two more context-switches on e.g. SMP 
systems: hitting the CPU and immediately blocking on the lock. (But this 
is a second-phase optimization which needs some core scheduler magic as 
well, i guess i'll be the one to code it up.)

	Ingo
