Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbSJMAyp>; Sat, 12 Oct 2002 20:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261395AbSJMAyp>; Sat, 12 Oct 2002 20:54:45 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:38390 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261392AbSJMAyo>;
	Sat, 12 Oct 2002 20:54:44 -0400
Message-ID: <3DA8C585.1030600@us.ibm.com>
Date: Sat, 12 Oct 2002 17:59:49 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Structure clobbering causes timer oopses
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It put some extrace checks in timer_t, including a tripwire at the 
beginning and end, just in case the timer was just trampled by 
something.  It was.

I added begin, and end:
> struct timer_list {
>+        unsigned int begin;
>         struct list_head entry;
>         unsigned long expires;
> 
>         void (*function)(unsigned long);
>         unsigned long data;
> 
>         struct tvec_t_base_s *base;
>+        unsigned int end;
> };

> static inline void init_timer(struct timer_list * timer)
> {
>+        timer->begin = TIMER_BEG_MAGIC;
>+        timer->end = TIMER_END_MAGIC;
>         timer->base = NULL;
> }

then this beast:
(yeah, yeah, it ain't pretty, but it worked)
> #define CHECK_TIMER(timer) do {\
>                 if (((timer)->begin!=TIMER_BEG_MAGIC) || \
>                     ((timer)->end!=TIMER_END_MAGIC)) {\
>                         printk("timer magic check failed %s:%s():%d\n",
 >                __stringify(KBUILD_BASENAME),__FUNCTION__,__LINE__);\
>                         printk("begin: 0x%x end:0x%x\n", (timer)->begin, 
 >                         (timer)->end);\
>                         dump_stack();\
>                 }} while (0)


Just before a crash, I got:

timer magic check failed timer:__run_timers():351
begin: 0xc035fbc8 end:0xc035fbe8
Call Trace:
  [<c0120d53>] run_timer_tasklet+0xf7/0x188
  [<c011d945>] tasklet_hi_action+0x85/0xe0
  [<c011d64a>] do_softirq+0x5a/0xac
  [<c01117ed>] smp_apic_timer_interrupt+0x111/0x118
  [<c0105334>] poll_idle+0x0/0x48
  [<c0107a7a>] apic_timer_interrupt+0x1a/0x20
  [<c0105334>] poll_idle+0x0/0x48
  [<c010535d>] poll_idle+0x29/0x48
  [<c01053b3>] cpu_idle+0x37/0x48
  [<c011898d>] printk+0x125/0x140


Then, the full crash:

general protection fault: fbe0

CPU:    4
EIP:    0060:[<c035fbe9>]    Not tainted
EFLAGS: 00010287
EIP is at tvec_bases+0x169/0x20400
eax: d18deac0   ebx: c035dbcc   ecx: c035fbe0   edx: c0363f70
esi: c035fbd8   edi: c0363b00   ebp: 00000001   esp: f77c7f1c
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=f77c6000 task=f77c5060)
Stack: c0120d9b c035fbe0 cb1101c8 00000000 f77c6000 c011d945 00000000
        00000001 c035f960 fffffffe 00000080 c03443e4 c03443e4 c011d64a
        c035f960 00000010 00000004 00000000 00000000 00000046 c01117ed
        f77c6000 c0105334 00000000
Call Trace:
  [<c0120d9b>] run_timer_tasklet+0x13f/0x188
  [<c011d945>] tasklet_hi_action+0x85/0xe0
  [<c011d64a>] do_softirq+0x5a/0xac
  [<c01117ed>] smp_apic_timer_interrupt+0x111/0x118
  [<c0105334>] poll_idle+0x0/0x483
  [<c0107a7a>] apic_timer_interrupt+0x1a/0x20
  [<c0105334>] poll_idle+0x0/0x48
  [<c010535d>] poll_idle+0x29/0x48
  [<c01053b3>] cpu_idle+0x37/0x48
  [<c011898d>] printk+0x125/0x140


APIC error on CPU4: 08(08)
APIC error on CPU4: 08(08)
APIC error on CPU4: 08(08)
APIC error on CPU4: 08(08)
...

Notice that the junk that got put in begin, end, and function, are 
fairly close values, like something was trying to fill out an array.

Can anyone think of clever ways to figure out what is doing the 
trampling?

BTW, I found lots of users who aren't using init_timer().  Should I 
publicly humiliate them?
-- 
Dave Hansen
haveblue@us.ibm.com

