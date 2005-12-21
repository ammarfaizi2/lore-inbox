Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbVLUWtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbVLUWtZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVLUWtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:49:25 -0500
Received: from omta01ps.mx.bigpond.com ([144.140.82.153]:5577 "EHLO
	omta01ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964902AbVLUWtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:49:24 -0500
Message-ID: <43A9DBF2.5080807@bigpond.net.au>
Date: Thu, 22 Dec 2005 09:49:22 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: Fix adverse effects of NFS client on	interactive
 response
References: <43A8EF87.1080108@bigpond.net.au> <1135145341.7910.17.camel@lade.trondhjem.org> <43A8F714.4020406@bigpond.net.au> <20051221161140.GA7950@elte.hu>
In-Reply-To: <20051221161140.GA7950@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Dec 2005 22:49:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Peter Williams <pwil3058@bigpond.net.au> wrote:
> 
> 
>>It's not a theory.  It's a result of observing a -j 16 build with the 
>>sources on an NFS mounted file system with top with and without the 
>>patches and comparing that with the same builds with the sources on a 
>>local file system. [...]
> 
> 
> could you try the build with the scheduler queue from -mm, and set the 
> shell to SCHED_BATCH first? Do you still see interactivity problems 
> after that?

There's no real point in doing such a test as running the build as 
SCHED_BATCH would obviously prevent its tasks from getting any 
interactive bonus.  So I'll concede that is a solution.

However, the problem I see with this solution is that it's pushing the 
onus onto the user and forcing them to decide/remember to run non 
interactive tasks as SCHED_BATCH (and I see the whole point of the 
interactive responsiveness embellishments of the scheduler being to free 
the user of the need to worry about these things).  It's a marginally 
better solution than its complement i.e. marking interactive tasks as 
being such via putting them in a (hypothetical) SCHED_IA class because 
that would clearly have to be a privileged operation unlike setting 
SCHED_BATCH.

This is a case where the PAGG patches would have been useful.  With them 
a mechanism for monitoring exec()s and shifting programs to SCHED_BATCH 
based on what program they had just exec()ed would be possible making 
SCHED_BATCH a better solution to this problem.  If PAGG were 
complimented with a kernel to user space event notification mechanism 
the bulk of this could be accomplished in user space.  The new code SGI 
is proposing as an alternative to PAGG may meet these requirements?

> 
> i'm not sure we want to override the scheduling patterns observed by the 
> kernel, via TASK_NONINTERACTIVE - apart of a few obvious cases.

I thought that this was one of the obvious cases.  I.e. interruptible 
sleeps that clearly aren't interactive.

I interpreted your statement "Right now only pipe_wait() will make use 
of it, because it's a common source of not-so-interactive waits (kernel 
compilation jobs, etc.)." in the original announcement of 
TASK_INTERACTIVE to mean that it was a "work in progresss" and would be 
used more extensively when other places for its application were identified.

BTW I don't think that it should be blindly applied to all file system 
code as I tried that and it resulted in the X server not getting any 
interactive bonus with obvious consequences :-(.  I think that use of 
TASK_NONINTERACTIVE should be done carefully and tested to make sure 
that it has no unexpected scheduling implications (and I think that this 
is such a case).  Provided the TASK_XXX flags are always treated as such 
there should be no changes to the semantics or efficiency (after all, 
it's just an extra bit in an integer constant set at compile time) of 
any other code (than the scheduler's) as a result of its use.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
