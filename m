Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSEOJar>; Wed, 15 May 2002 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316359AbSEOJaq>; Wed, 15 May 2002 05:30:46 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40206 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315748AbSEOJap>; Wed, 15 May 2002 05:30:45 -0400
Message-Id: <200205150849.g4F8n6Y12694@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: todd@tekinteractive.com, linux-kernel@vger.kernel.org
Subject: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
Date: Wed, 15 May 2002 11:51:41 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <15577.5431.625191.582701@rtfm.ofc.tekinteractive.com> <15585.10390.825902.226132@rtfm.ofc.tekinteractive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 May 2002 13:09, Todd R. Eigenschink wrote:
> I never saw any reponses to my oops post...but now I've narrowed
> things further, to a point that makes it seem more serious.
...
> Dual P3/500, 2 GB RAM, Intel L440-GXC mainboard.

> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0115ba8>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010087
> eax: c2802db4   ebx: c2002db4   ecx: 00000000   edx: 00000003
> esi: c2802db0   edi: c2802db0   ebp: cd2fdf48   esp: cd2fdf2c
> ds: 0018   es: 0018   ss: 0018
> Process ld-linux.so.2 (pid: 18110, stackpage=cd2fd000)
> Stack: c1095000 c2802db0 00000000 c2802db4 00000000 00000282 00000003
> 00000000 c01295fe c1095000 00001000 c012bef0 00000000 ce03f5c0 ffffffea
> 00001000 e0855de8 00001000 00000000 00001000 00001000 00001000 00004000
> 00000000 Call Trace: [<c01295fe>] [<c012bef0>] [<c0136d57>] [<c010889b>]
> Code: 8b 01 85 45 fc 74 69 31 c0 9c 5e fa f0 fe 0d 80 a9 30 c0 0f
>
> >>EIP; c0115ba8 <__wake_up+40/d0>   <=====
> Trace; c01295fe <unlock_page+62/68>
> Trace; c012bef0 <generic_file_write+578/778>
> Trace; c0136d57 <sys_write+8f/100>
> Trace; c010889b <system_call+33/38>
>
> Code;  c0115ba8 <__wake_up+40/d0>
> 00000000 <_EIP>:
> Code;  c0115ba8 <__wake_up+40/d0>   <=====
>    0:   8b 01                     mov    (%ecx),%eax   <=====
>    2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
>    5:   74 69                     je     70 <_EIP+0x70> c0115c18 <__wake_up+b0/d0>
>    7:   31 c0                     xor    %eax,%eax
>    9:   9c                        pushf
>    a:   5e                        pop    %esi
>    b:   fa                        cli
>    c:   f0 fe 0d 80 a9 30 c0      lock decb 0xc030a980
>   13:   0f 00 00                  sldt   (%eax)

%ecx is a NULL ptr here. It must be in __wake_up_common:

void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr)
{
        if (q) {
                unsigned long flags;
                wq_read_lock_irqsave(&q->lock, flags);
                __wake_up_common(q, mode, nr, 0);
                wq_read_unlock_irqrestore(&q->lock, flags);
        }
}

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

Can you compile kernel/sched.c into asm and look where did it do *NULL?
--
vda
