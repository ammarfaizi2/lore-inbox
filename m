Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTJGILh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 04:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTJGILh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 04:11:37 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:6171 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261879AbTJGILf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 04:11:35 -0400
Date: Tue, 7 Oct 2003 04:11:26 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Peter Waechtler <pwaechtler@mac.com>
Cc: Jamie Lokier <jamie@shareable.org>, Ulrich Drepper <drepper@redhat.com>,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>,
       linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: POSIX message queues
Message-ID: <20031007041126.C26086@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1448383.1065513016965.JavaMail.pwaechtler@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1448383.1065513016965.JavaMail.pwaechtler@mac.com>; from pwaechtler@mac.com on Tue, Oct 07, 2003 at 09:50:16AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 09:50:16AM +0200, Peter Waechtler wrote:
>  
> On Sunday, October 05, 2003, at 08:32PM, Jakub Jelinek <jakub@redhat.com> wrote:
> 
> >> Speaking of librt - I should not have to link in pthreads and the
> >> run-time overhead associated with it (locking stdio etc.) just so I
> >> can use shm_open().  Any chance of fixing this?
> >
> >That overhead is mostly gone in current glibcs (when using NPTL):
> >a) e.g. locking is done unconditionally even when libpthread is not present
> >   (it is just lock cmpxchgl, inlined)
> 
> 
> a "lock cmpxchg" is > 100 cycles (according to a recent Linux Journal article
> from Paul McKenney: 107ns on 700MHz PentiumIII)

Here is exactly what it does on IA-32/i686+:

# define lll_lock(futex) \
  (void) ({ int ignore1, ignore2;                                             \
            __asm __volatile ("cmpl $0, %%gs:%P6\n\t"                         \
                              "je,pt 0f\n\t"                                  \
                              "lock\n"                                        \
                              "0:\tcmpxchgl %1, %2\n\t"                       \
                              "jnz _L_mutex_lock_%=\n\t"                      \
                              ".subsection 1\n\t"                             \
                              ".type _L_mutex_lock_%=,@function\n"            \
                              "_L_mutex_lock_%=:\n\t"                         \
                              "leal %2, %%ecx\n\t"                            \
                              "call __lll_mutex_lock_wait\n\t"                \
                              "jmp 1f\n\t"                                    \
                              ".size _L_mutex_lock_%=,.-_L_mutex_lock_%=\n"   \
                              ".previous\n"                                   \
                              "1:"                                            \
                              : "=a" (ignore1), "=c" (ignore2), "=m" (futex)  \
                              : "0" (0), "1" (1), "m" (futex),                \
                                "i" (offsetof (tcbhead_t, multiple_threads))  \
                              : "memory"); })

> you suggested naming the syscall number symbols NR_mq_open instead of
> NR_sys_mq_open. In the stub I want to overload some syscalls (e.g. mq_open)
> but others not (e.g. mq_timedsend).
> 
> How to deal with that?

The syscall is still mq_open, isn't it? So it should be __NR_mq_open.
You simply put the ones where you want to implement them directly in the kernel
into syscalls.list (and add sysdeps/generic/mq_*.c stubs; also, mq_{timed,}{receive,send}
are cancellation points according to POSIX 2003, so they need to be marked as such).
Where you need to do some handling before/after the syscall in userland, you simply write
mq_open.c etc. and use INLINE_SYSCALL (or INTERNAL_SYSCALL) in it.

	Jakub
