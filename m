Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262534AbTC1OtV>; Fri, 28 Mar 2003 09:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262989AbTC1OtU>; Fri, 28 Mar 2003 09:49:20 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:16127
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262534AbTC1OtT>; Fri, 28 Mar 2003 09:49:19 -0500
Date: Fri, 28 Mar 2003 09:56:36 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mike Galbraith <efault@gmx.de>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       Ed Tomlinson <tomlins@cam.org>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-mm@kvack.org>
Subject: Re: 2.5.66-mm1
In-Reply-To: <5.2.0.9.2.20030328152305.019b3e70@pop.gmx.net>
Message-ID: <Pine.LNX.4.50.0303280942420.2884-100000@montezuma.mastecende.com>
References: <20030327205912.753c6d53.akpm@digeo.com>
 <5.2.0.9.2.20030328152305.019b3e70@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Mar 2003, Mike Galbraith wrote:

> >hm, this is an 'impossible' scenario from the scheduler code POV. Whenever
> >we deactivate a task, we remove it from the runqueue and set p->array to
> >NULL. Whenever we activate a task again, we set p->array to non-NULL. A
> >double-deactivate is not possible. I tried to reproduce it with various
> >scheduler workloads, but didnt succeed.
> >
> >Mike, do you have a backtrace of the crash you saw?
> 
> No, I didn't save it due to "grubby fingerprints".

Hmm i think i may have his this one but i never posted due to being unable 
to reproduce it on a vanilla kernel or the same kernel afterwards (which 
was hacked so i won't vouch for it's cleanliness). I think preempt 
might have bitten him in a bad place (mine is also CONFIG_PREEMPT), is it 
possible that when we did the task_rq_unlock we got preempted and when we 
got back we used the local variable requeue_waker which was set before 
dropping the lock, and therefore might not be valid anymore due to 
scheduler decisions done after dropping the runqueue lock?

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c011b8d9
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c011b8d9>]    Not tainted
EFLAGS: 00010046
EIP is at try_to_wake_up+0x1e9/0x4f0
eax: c055a000   ebx: c04e5aa0   ecx: c0552fc0   edx: c04e5aa0
esi: 00000000   edi: 00000000   ebp: c055bee4   esp: c055beb8
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c055a000 task=c04e5aa0)
Stack: 00000001 c055a000 c0552fc0 00000000 cb1a0000 00000001 00000001 00000002 
       00000000 c04e88e4 00000001 c055bf08 c011d172 c1694700 00000001 00000000 
       c04e88e4 c04e88dc c055a000 00000001 c055bf3c c011d203 c04e88dc 00000001 
Call Trace:
 [<c011d172>] __wake_up_common+0x32/0x60
 [<c011d203>] __wake_up+0x63/0xb0
 [<c0122fb5>] release_console_sem+0x165/0x170
 [<c0122d7b>] printk+0x1eb/0x270
 [<c015e210>] invalidate_bh_lru+0x0/0x60
 [<c015e210>] invalidate_bh_lru+0x0/0x60
 [<c015e210>] invalidate_bh_lru+0x0/0x60
 [<c01163f2>] smp_call_function_interrupt+0x42/0xb0
 [<c015e210>] invalidate_bh_lru+0x0/0x60
 [<c0106eb0>] default_idle+0x0/0x40
 [<c010a41a>] call_function_interrupt+0x1a/0x20
 [<c0106eb0>] default_idle+0x0/0x40
 [<c0106ede>] default_idle+0x2e/0x40
 [<c0106f6a>] cpu_idle+0x3a/0x50
 [<c0105000>] rest_init+0x0/0x80

Code: 8b 06 48 89 06 8b 4a 24 8b 42 20 89 01 89 48 04 8b 4a 18 8d 

0xc011b8d9 is in try_to_wake_up (kernel/sched.c:282).
277     /*
278      * Adding/removing a task to/from a priority array:
279      */
280     static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
281     {
282             array->nr_active--;
283             list_del(&p->run_list);
284             if (list_empty(array->queue + p->prio))
285                     __clear_bit(p->prio, array->bitmap);
286     }

(gdb) list *__wake_up_common+0x32
0xc011d1b2 is in __wake_up_common (kernel/sched.c:1424).
1419            list_for_each_safe(tmp, next, &q->task_list) {
1420                    wait_queue_t *curr;
1421                    unsigned flags;
1422                    curr = list_entry(tmp, wait_queue_t, task_list);
1423                    flags = curr->flags;
1424                    if (curr->func(curr, mode, sync) &&
1425                        (flags & WQ_FLAG_EXCLUSIVE) &&
1426                        !--nr_exclusive)
1427                            break;
1428            }

(gdb) list *__wake_up+0x62
0xc011d242 is in __wake_up (kernel/sched.c:1445).
1440
1441            if (unlikely(!q))
1442                    return;
1443
1444            spin_lock_irqsave(&q->lock, flags);
1445            __wake_up_common(q, mode, nr_exclusive, 0);
1446            spin_unlock_irqrestore(&q->lock, flags);
1447    }
1448
1449    /*


-- 
function.linuxpower.ca
