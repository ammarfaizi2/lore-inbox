Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946053AbWBORfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946053AbWBORfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946054AbWBORff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:35:35 -0500
Received: from mail.suse.de ([195.135.220.2]:40874 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946053AbWBORff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:35:35 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
References: <20060215151711.GA31569@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 15 Feb 2006 18:35:13 +0100
In-Reply-To: <20060215151711.GA31569@elte.hu>
Message-ID: <p73lkwc5xv2.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:


> In practice, when e.g. yum is kill -9-ed (or segfaults), a system reboot 
> is needed to release that futex based lock. This is one of the leading 
> bugreports against yum.

Reboot?  That object is stored somewhere in user space, isn't it? 
And wherever it is that object can be removed, can't it?

e.g. if you have it in a shared memory object you could just
add some code to always kill everybody who has the shared memory
mapped.

I wrote code like this some time ago when I was experimenting
with a new machine check handler. It looked for all processes
mapping some memory when the CPU reported it corrupted and killed them.

e.g. you could add a new VMA flag that says "when one user
of this dies unexpectedly by a signal kill all" 

That would solve the problem too, wouldn't it? 

It might not be highly available, but people who want that
can just use the plain old sysv in kernel locks. In theory
you could make it in fact highly available by catching the signal
in the other process and then doing the lock cleanup from there.

Of course it won't help if the lock is stored on disk,
but that's not in any way different from any other existing disk
based lock file.
 
> Ulrich Drepper has implemented the necessary glibc support for this new 
> mechanism, which fully enables robust mutexes. (Ulrich plans to commit 
> these changes to glibc-HEAD later today.)

And what happens if the patch is rejected? I don't really think you
can force patches in this way ("do it or I break glibc")

I think it really needs proper discussion first before it's merged
anywhere. And glibc should be the slave of the kernel on this,
not the other way round.


> The patch adds two new syscalls: one to register the userspace list, and 
> one to query the registered list pointer:
> 
>  asmlinkage long
>  sys_set_robust_list(struct robust_list_head __user *head,
>                      size_t len);
> 
>  asmlinkage long
>  sys_get_robust_list(int pid, struct robust_list_head __user **head_ptr,
>                      size_t __user *len_ptr);

What happens when the list gets corrupted? Does the kernel go
into an endless loop? Kernel going through arbitary user structures
like this seems very risky to me. There are ways to do
list walking with cycle detection, but they still have quite
bad worst case detection times.

Or when parts of these mappings are remote on NFS and the server is down
etc - then  the kernel could potentially block a long time in exit.

-Andi

