Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWBOVra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWBOVra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 16:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWBOVra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 16:47:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62875 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750882AbWBOVra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 16:47:30 -0500
Date: Wed, 15 Feb 2006 13:45:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, dsingleton@mvista.com
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
Message-Id: <20060215134556.57cec83a.akpm@osdl.org>
In-Reply-To: <20060215151711.GA31569@elte.hu>
References: <20060215151711.GA31569@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> ...
>
> E.g. in David Singleton's robust-futex-6.patch, there are 3 new syscall 
> variants to sys_futex(): FUTEX_REGISTER, FUTEX_DEREGISTER and 
> FUTEX_RECOVER. The kernel attaches such robust futexes to vmas (via 
> vma->vm_file->f_mapping->robust_head), and at do_exit() time, all vmas 
> are searched to see whether they have a robust_head set.

hm.   What happened if the futex was in anonymous memory (vm_file==NULL)?

> New approach to robust futexes
> ------------------------------
> 
> At the heart of this new approach there is a per-thread private list of 
> robust locks that userspace is holding (maintained by glibc) - which 
> userspace list is registered with the kernel via a new syscall [this 
> registration happens at most once per thread lifetime]. At do_exit() 
> time, the kernel checks this user-space list: are there any robust futex 
> locks to be cleaned up?

Neat.

> 
> ...
> The list is guaranteed to be private and per-thread, so it's lockless. 
>

Why is that guaranteed??  Another thread could be scribbling on it while
the kernel is walking it?

Why use a list and not just a sparse array? (realloc() works..)

>
> There is one race possible though: since adding to and removing from the 
> list is done after the futex is acquired by glibc, there is a few 
> instructions window for the thread (or process) to die there, leaving 
> the futex hung. To protect against this possibility, userspace (glibc) 
> also maintains a simple per-thread 'list_op_pending' field, to allow the 
> kernel to clean up if the thread dies after acquiring the lock, but just 
> before it could have added itself to the list. Glibc sets this 
> list_op_pending field before it tries to acquire the futex, and clears 
> it after the list-add (or list-remove) has finished.

Oh.  I'm surprised that glibc cannot just add the futex to the list prior
to acquiring it, then the exit-time code can work out whether the futex was
really taken-and-contended.  Even if the kernel makes a mistake it either
won't find a futex there or it won't wake anyone up.


I think the patch breaks the build if CONFIG_FUTEX=n?

The patches are misordered - with only the first patch applied, the kernel
won't build.  That's a nasty little landmine for git-bisect users.

Why do we need sys_get_robust_list(other task)?
