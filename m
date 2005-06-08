Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFHOdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFHOdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 10:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVFHOdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 10:33:04 -0400
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:47077 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S261259AbVFHOcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 10:32:45 -0400
Message-ID: <42A7017A.6080102@stud.feec.vutbr.cz>
Date: Wed, 08 Jun 2005 16:32:26 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu>
In-Reply-To: <20050608112801.GA31084@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the -V0.7.48-00 Real-Time Preemption patch, which can be 
> downloaded from the usual place:

With -V0.7.48-01 I get interestingly long latency traces. For example 
this one is 277 us. This is on i386. I've put the full trace to:
http://www.uamt.feec.vutbr.cz/rizeni/pom/latency_trace-RT-V0.7.48-01.txt

Because of the presence of __wake_up_sync there, I'd guess it has 
something to do with the NEED_RESCHED_DELAYED thing.

Here's an excerpt of it:
preemption latency trace v1.1.4 on 2.6.12-rc6-RT-V0.7.48-01
--------------------------------------------------------------------
  latency: 277 us, #2349/2349, CPU#0 | (M:rt VP:0, KP:1, SP:1 HP:1 #P:1)
     -----------------
     | task: XFree86-5780 (uid:0 nice:-10 policy:0 rt_prio:0)
     -----------------

                  _------=> CPU#
                 / _-----=> irqs-off
                | / _----=> need-resched
                || / _---=> hardirq/softirq
                ||| / _--=> preempt-depth
                |||| /
                |||||     delay
    cmd     pid ||||| time  |   caller
       \   /    |||||   \   |   /
mozilla--6007  0Dnh2    0us!: <697a6f6d> (<2d616c6c>)
mozilla--6007  0Dnh2    0us : __trace_start_sched_wakeup (try_to_wake_up)
mozilla--6007  0....    0us : _spin_unlock_irqrestore (__wake_up_sync)
mozilla--6007  0....    0us : up_mutex (__wake_up_sync)
mozilla--6007  0....    0us : __up_mutex (up_mutex)
mozilla--6007  0....    0us : _read_unlock (sock_wfree)
mozilla--6007  0....    0us : up_read_mutex (sock_wfree)
mozilla--6007  0....    1us : up_write_mutex (sock_wfree)
mozilla--6007  0....    1us : __up_mutex (up_write_mutex)
mozilla--6007  0....    1us : kfree_skbmem (unix_stream_recvmsg)
mozilla--6007  0....    1us : skb_release_data (kfree_skbmem)
mozilla--6007  0....    1us : kfree (kfree_skbmem)
mozilla--6007  0....    1us : __local_save_flags (kfree)
mozilla--6007  0....    1us : _spin_lock (kfree)
mozilla--6007  0....    2us : __spin_lock (_spin_lock)
mozilla--6007  0....    2us : __might_sleep (__spin_lock)
mozilla--6007  0....    2us : irqs_disabled (__might_sleep)
mozilla--6007  0....    2us : _down_mutex (__spin_lock)
mozilla--6007  0....    2us : __down_mutex (__spin_lock)
mozilla--6007  0...1    2us : grab_lock (__down_mutex)
mozilla--6007  0...1    2us : __down_mutex <mozilla--6007> (7d 0)
mozilla--6007  0....    2us : _spin_unlock (kfree)
mozilla--6007  0....    2us : up_mutex (kfree)
mozilla--6007  0....    3us : __up_mutex (up_mutex)
mozilla--6007  0....    3us : kmem_cache_free (kfree_skbmem)
mozilla--6007  0....    3us : __local_save_flags (kmem_cache_free)
mozilla--6007  0....    3us : _spin_lock (kmem_cache_free)
mozilla--6007  0....    3us : __spin_lock (_spin_lock)
mozilla--6007  0....    3us : __might_sleep (__spin_lock)
mozilla--6007  0....    3us : irqs_disabled (__might_sleep)
mozilla--6007  0....    3us : _down_mutex (__spin_lock)
mozilla--6007  0....    3us : __down_mutex (__spin_lock)
mozilla--6007  0...1    4us : grab_lock (__down_mutex)
mozilla--6007  0...1    4us : __down_mutex <mozilla--6007> (7d 0)
mozilla--6007  0....    4us : _spin_unlock (kmem_cache_free)
mozilla--6007  0....    4us : up_mutex (kmem_cache_free)
mozilla--6007  0....    4us : __up_mutex (up_mutex)
mozilla--6007  0....    4us : skb_dequeue (unix_stream_recvmsg)
mozilla--6007  0....    4us : _spin_lock_irqsave (skb_dequeue)
mozilla--6007  0....    4us : __spin_lock (_spin_lock_irqsave)
mozilla--6007  0....    5us : __might_sleep (__spin_lock)
mozilla--6007  0....    5us : irqs_disabled (__might_sleep)
mozilla--6007  0....    5us : _down_mutex (__spin_lock)
mozilla--6007  0....    5us : __down_mutex (__spin_lock)
mozilla--6007  0...1    5us : grab_lock (__down_mutex)
mozilla--6007  0...1    5us : __down_mutex <mozilla--6007> (7d 0)
mozilla--6007  0....    5us : __local_save_flags (_spin_lock_irqsave)
mozilla--6007  0....    5us : _spin_unlock_irqrestore (skb_dequeue)
.
.
.
mozilla--6007  0....  268us : __wake_up_common (__wake_up_sync)
mozilla--6007  0....  268us : default_wake_function (__wake_up_common)
mozilla--6007  0....  268us : try_to_wake_up (__wake_up_common)
mozilla--6007  0....  268us : _spin_unlock_irqrestore (__wake_up_sync)
mozilla--6007  0....  268us : up_mutex (__wake_up_sync)
mozilla--6007  0....  269us : __up_mutex (up_mutex)
mozilla--6007  0....  269us : _read_unlock (sock_wfree)
mozilla--6007  0....  269us : up_read_mutex (sock_wfree)
mozilla--6007  0....  269us : up_write_mutex (sock_wfree)
mozilla--6007  0....  269us : __up_mutex (up_write_mutex)
mozilla--6007  0....  269us : kfree_skbmem (unix_stream_recvmsg)
mozilla--6007  0....  269us : skb_release_data (kfree_skbmem)
mozilla--6007  0....  269us : kfree (kfree_skbmem)
mozilla--6007  0....  270us : __local_save_flags (kfree)
mozilla--6007  0....  270us : _spin_lock (kfree)
mozilla--6007  0....  270us : __spin_lock (_spin_lock)
mozilla--6007  0....  270us : __might_sleep (__spin_lock)
mozilla--6007  0....  270us : irqs_disabled (__might_sleep)
mozilla--6007  0....  270us : _down_mutex (__spin_lock)
mozilla--6007  0....  270us : __down_mutex (__spin_lock)
mozilla--6007  0...1  270us : grab_lock (__down_mutex)
mozilla--6007  0...1  270us : __down_mutex <mozilla--6007> (7d 0)
mozilla--6007  0....  270us : _spin_unlock (kfree)
mozilla--6007  0....  271us : up_mutex (kfree)
mozilla--6007  0....  271us : __up_mutex (up_mutex)
mozilla--6007  0....  271us : kmem_cache_free (kfree_skbmem)
mozilla--6007  0....  271us : __local_save_flags (kmem_cache_free)
mozilla--6007  0....  271us : _spin_lock (kmem_cache_free)
mozilla--6007  0....  271us : __spin_lock (_spin_lock)
mozilla--6007  0....  271us : __might_sleep (__spin_lock)
mozilla--6007  0....  271us : irqs_disabled (__might_sleep)
mozilla--6007  0....  271us : _down_mutex (__spin_lock)
mozilla--6007  0....  271us : __down_mutex (__spin_lock)
mozilla--6007  0...1  272us : grab_lock (__down_mutex)
mozilla--6007  0...1  272us : __down_mutex <mozilla--6007> (7d 0)
mozilla--6007  0....  272us : _spin_unlock (kmem_cache_free)
mozilla--6007  0....  272us : up_mutex (kmem_cache_free)
mozilla--6007  0....  272us : __up_mutex (up_mutex)
mozilla--6007  0....  272us : rt_up (unix_stream_recvmsg)
mozilla--6007  0...1  272us : __up_mutex (rt_up)
mozilla--6007  0....  273us : dnotify_parent (vfs_read)
mozilla--6007  0....  273us : _spin_lock (dnotify_parent)
mozilla--6007  0....  273us : __spin_lock (_spin_lock)
mozilla--6007  0....  273us : __might_sleep (__spin_lock)
mozilla--6007  0....  273us : irqs_disabled (__might_sleep)
mozilla--6007  0....  273us : _down_mutex (__spin_lock)
mozilla--6007  0....  273us : __down_mutex (__spin_lock)
mozilla--6007  0...1  273us : grab_lock (__down_mutex)
mozilla--6007  0...1  274us : __down_mutex <mozilla--6007> (7d 0)
mozilla--6007  0....  274us : _spin_unlock (vfs_read)
mozilla--6007  0....  274us : up_mutex (vfs_read)
mozilla--6007  0....  274us : __up_mutex (up_mutex)
mozilla--6007  0....  274us : fput (sys_read)
mozilla--6007  0Dnh.  274us : __schedule (work_resched)
mozilla--6007  0Dnh.  275us : profile_hit (__schedule)
mozilla--6007  0Dnh1  275us : sched_clock (__schedule)
mozilla--6007  0Dnh1  275us : local_irq_disable (__schedule)
    <...>-5780  0dnh2  276us : __switch_to (__schedule)
    <...>-5780  0dnh2  276us : __schedule <mozilla--6007> (7d 73)
    <...>-5780  0dnh1  276us : trace_stop_sched_switched (__schedule)
    <...>-5780  0dnh1  276us : trace_stop_sched_switched <<...>-5780> (73 0)
    <...>-5780  0dnh1  277us : trace_stop_sched_switched (__schedule)


