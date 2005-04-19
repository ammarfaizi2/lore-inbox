Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVDSBJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVDSBJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 21:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVDSBJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 21:09:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:13031 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261243AbVDSBJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 21:09:10 -0400
Subject: Re: PATCH [PPC64]: dead processes never reaped
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050418193833.GW15596@austin.ibm.com>
References: <20050418193833.GW15596@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 19 Apr 2005 11:07:01 +1000
Message-Id: <1113872821.5516.330.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 14:38 -0500, Linas Vepstas wrote:
> 
> Hi,
> 
> The patch below appears to fix a problem where a number of dead processes
> linger on the system.  On a highly loaded system, dozens of processes 
> were found stuck in do_exit(), calling thier very last schedule(), and
> then being lost forever.  
> 
> Processes that are PF_DEAD are cleaned up *after* the context switch, 
> in a routine called finish_task_switch(task_t *prev). The "prev" gets 
> the  value returned by _switch() in entry.S, but this value comes from 
>   
> __switch_to (struct task_struct *prev, 
>             struct task_struct *new) 
> { 
>    old_thread = &current->thread; ///XXX shouldn't this be prev, not current? 
>    last = _switch(old_thread, new_thread); 
>    return last; 
> } 
>  
> The way I see it, "prev" and "current" are almost always going to be  
> pointing at the same thing; however, if a "need resched" happens,  
> or there's a pre-emept or some-such, then prev and current won't be  
> the same; in which case, finish_task_switch() will end up cleaning  
> up the old current, instead of prev.  This will result in dead processes 
> hanging around, which will never be scheduled again, and will never  
> get a chance to have put_task_struct() called on them.  

Ok, thinking moer about this ... that will need maybe some help from
Ingo so I fully understand where schedule's are allowed ... We are
basically in the middle of the scheduler here, so I wonder how much of
the scheduler itself can be preempted or so ...

Basically, under which circumstances can prev and current be different ?

Ben.


