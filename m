Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288159AbSAXO5Y>; Thu, 24 Jan 2002 09:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288274AbSAXO5O>; Thu, 24 Jan 2002 09:57:14 -0500
Received: from [195.66.192.167] ([195.66.192.167]:8458 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288159AbSAXO45>; Thu, 24 Jan 2002 09:56:57 -0500
Message-Id: <200201241454.g0OEsIE11368@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Ken <koehlekr@ucrwcu.rwc.uc.edu>, linux-kernel@vger.kernel.org,
        bugs@linux-ide.org
Subject: Re: 2.4.17 multiple Oops and file corruption on I845 MB
Date: Thu, 24 Jan 2002 16:54:19 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C4EE4C8.6FF3B2AF@ucrwcu.rwc.uc.edu>
In-Reply-To: <3C4EE4C8.6FF3B2AF@ucrwcu.rwc.uc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm... what about de-inlining __wake_up_common? It is called in several places,

kernel/sched.c
==============
static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
                                     int nr_exclusive, const int sync)
{
        struct list_head *tmp;
        struct task_struct *p;

        CHECK_MAGIC_WQHEAD(q);
        WQ_CHECK_LIST_HEAD(&q->task_list);

        list_for_each(tmp,&q->task_list) {
                unsigned int state;
                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);

                CHECK_MAGIC(curr->__magic);
                p = curr->task;
                state = p->state;
                if (state & mode) {
                        WQ_NOTE_WAKER(curr);
                        if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
                                break;
                }
        }
}

void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr)
{
        if (q) {
                unsigned long flags;
                wq_read_lock_irqsave(&q->lock, flags);
====>           __wake_up_common(q, mode, nr, 0);
                wq_read_unlock_irqrestore(&q->lock, flags);
        }
}

void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr)
{
        if (q) {
                unsigned long flags;
                wq_read_lock_irqsave(&q->lock, flags);
====>           __wake_up_common(q, mode, nr, 1);
                wq_read_unlock_irqrestore(&q->lock, flags);
        }
}

void complete(struct completion *x)
{
        unsigned long flags;

        spin_lock_irqsave(&x->wait.lock, flags);
        x->done++;
====>   __wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, 0);
        spin_unlock_irqrestore(&x->wait.lock, flags);
}


> Jan 22 16:52:57 ken kernel: Unable to handle kernel paging request at
> virtual address fffffffc
> Jan 22 16:52:57 ken kernel: c010ebc2
> Jan 22 16:52:57 ken kernel: *pde = 00001063
> Jan 22 16:52:57 ken kernel: Oops: 0000
> Jan 22 16:52:57 ken kernel: CPU:    0
> Jan 22 16:52:57 ken kernel: EIP:    0010:[__wake_up+34/160]    Not
> tainted
> Jan 22 16:52:57 ken kernel: EIP:    0010:[<c010ebc2>]    Not tainted
> Using defaults from ksymoops -t elf32-i386
> Jan 22 16:52:57 ken kernel: EFLAGS: 00010013
> Jan 22 16:52:57 ken kernel: eax: d34900cc   ebx: 00000000   ecx:
> 00000001   edx: 00000003
> Jan 22 16:52:57 ken kernel: esi: 00000000   edi: 00000001   ebp:
> d1caded4   esp: d1cadebc
> Jan 22 16:52:57 ken kernel: ds: 0018   es: 0018   ss: 0018
> Jan 22 16:52:58 ken kernel: Process sync (pid: 738, stackpage=d1cad000)
> Jan 22 16:52:58 ken kernel: Stack: 00000282 00000003 d34900c8 d3490080
> 00000000 00002bf5 00000001 c012cb67
> Jan 22 16:52:58 ken kernel:        d1cadee8 00000014 00000000 d34cee00
> d34cee80 d34cef00 d34cef80 d34af100
> Jan 22 16:52:58 ken kernel:        d34af180 d34af200 d34af280 d34af300
> d34af380 d34af400 d34af480 d34af500
> Jan 22 16:52:58 ken kernel: Call Trace: [write_some_buffers+183/240]
> [write_unlocked_buffers+22/64] [sync_buffers+20/64] [fsync_dev+14/48]
> [sys_sync+7/16]
> Jan 22 16:52:58 ken kernel: Call Trace: [<c012cb67>] [<c012cbb6>]
> [<c012ccb4>] [<c012cd6e>] [<c012cda7>]
> Jan 22 16:52:58 ken kernel:    [<c0106ceb>]
> Jan 22 16:52:58 ken kernel: Code: 8b 4b fc 8b 01 85 45 ec 74 4e 31 c0 9c
> 5e fa c7 01 00 00 00
>
> >>EIP; c010ebc2 <__wake_up+22/a0>   <=====
>
> Trace; c012cb67 <write_some_buffers+b7/f0>
> Trace; c012cbb6 <write_unlocked_buffers+16/40>
> Trace; c012ccb4 <sync_buffers+14/40>
> Trace; c012cd6e <fsync_dev+e/30>
> Trace; c012cda7 <sys_sync+7/10>
> Trace; c0106ceb <system_call+33/38>
> Code;  c010ebc2 <__wake_up+22/a0>
> 00000000 <_EIP>:
> Code;  c010ebc2 <__wake_up+22/a0>   <=====
>    0:   8b 4b fc                  mov    0xfffffffc(%ebx),%ecx   <=====
> Code;  c010ebc5 <__wake_up+25/a0>
>    3:   8b 01                     mov    (%ecx),%eax
> Code;  c010ebc7 <__wake_up+27/a0>
>    5:   85 45 ec                  test   %eax,0xffffffec(%ebp)
> Code;  c010ebca <__wake_up+2a/a0>
>    8:   74 4e                     je     58 <_EIP+0x58> c010ec1a
> <__wake_up+7a/a0>
> Code;  c010ebcc <__wake_up+2c/a0>
>    a:   31 c0                     xor    %eax,%eax
> Code;  c010ebce <__wake_up+2e/a0>
>    c:   9c                        pushf
> Code;  c010ebcf <__wake_up+2f/a0>
>    d:   5e                        pop    %esi
> Code;  c010ebd0 <__wake_up+30/a0>
>    e:   fa                        cli
> Code;  c010ebd1 <__wake_up+31/a0>
>    f:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
