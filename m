Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWHYDwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWHYDwk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 23:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422826AbWHYDwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 23:52:40 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:998 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1422825AbWHYDwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 23:52:39 -0400
Date: Fri, 25 Aug 2006 09:23:28 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>, ego@in.ibm.com,
       rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@intel.linux.com, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com, ashok.raj@intel.com
Subject: Re: [RFC][PATCH 4/4] Rename lock_cpu_hotplug/unlock_cpu_hotplug
Message-ID: <20060825035328.GA6322@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20060824103417.GE2395@in.ibm.com> <1156417200.3014.54.camel@laptopd505.fenrus.org> <20060824140342.GI2395@in.ibm.com> <1156429015.3014.68.camel@laptopd505.fenrus.org> <44EDBDDE.7070203@yahoo.com.au> <20060824150026.GA14853@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824150026.GA14853@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 05:00:26PM +0200, Ingo Molnar wrote:
> 
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > It really is just like a reentrant rw semaphore... I don't see the 
> > point of the name change, but I guess we don't like reentrant locks so 
> > calling it something else might go down better with Linus ;)
> 
> what would fit best is a per-cpu scalable (on the read-side) 
> self-reentrant rw mutex. We are doing cpu hotplug locking in things like 
> fork or the slab code, while most boxes will do a CPU hotplug event only 
> once in the kernel's lifetime (during bootup), so a classic global 
> read-write lock is unjustified.

I agree. However, I was not sure if anything else other than for cpu_hotplug,
needs a self-reentrent rwmutex in the kernel. 
Which is why I did not expose the locking(at least the write side of it)
outside. We don't want too many lazy programmers anyway! 

However, even in case of cpu_hotplug, if we want to prevent
a hotplug event in some critical region where we are not going to sleep, 
we may as well use preempt_disable[/enable]. Because __stop_machine_run waits 
for all the tasks in the fast-path to complete before it changes
the online_cpus map, if I am not mistaken.

Only when you want your local online cpu_map to remain intact when 
you wake up from sleep, should you use cpu_hotplug *lock*.

Ingo?

-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
