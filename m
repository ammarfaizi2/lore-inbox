Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262176AbSJFUmg>; Sun, 6 Oct 2002 16:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262182AbSJFUmg>; Sun, 6 Oct 2002 16:42:36 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3201 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262176AbSJFUmf>;
	Sun, 6 Oct 2002 16:42:35 -0400
Message-ID: <3DA0A144.8070301@us.ibm.com>
Date: Sun, 06 Oct 2002 13:47:00 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.5.40-mm2
References: <3DA0854E.CF9080D7@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>   Ingo said that his 2.4-based per-cpu-pages patch was beneficial to
>   specweb, but nobody has tested these patches with specweb.  Hint.

cc'ing Ingo, because I think this might be related to the timer bh 
removal.

2.5.40 doesn't last very long under Specweb.  It always dies out with 
one of these oopses after a little while:

CPU:    3
EIP:    0060:[<801204a9>]    Not tainted
EFLAGS: 00010006
EIP is at run_timer_tasklet+0xcd/0x13c
eax: 00000000   ebx: 802657a8   ecx: e3c640a0   edx: 00000000
esi: e3c642c0   edi: 8039cae0   ebp: 00000246   esp: 8c3d9f20
ds: 0068   es: 0068   ss: 0068
Process swapper (pid: 0, threadinfo=8c3d8000 task=8c3dc760)
Stack: 8c093188 00000000 8c3d8000 00000001 8011d2e5 00000000 00000001 
80399960
        fffffffe 00000060 8037e324 8037e324 8011cfea 80399960 0000000c 
00000003
        00000000 00000000 00000046 801111dd 8c3d8000 80105334 00000000 
80107a8a
Call Trace:
  [<8011d2e5>] tasklet_hi_action+0x85/0xe0
  [<8011cfea>] do_softirq+0x5a/0xac
  [<801111dd>] smp_apic_timer_interrupt+0x111/0x118
  [<80105334>] poll_idle+0x0/0x48
  [<80107a8a>] apic_timer_interrupt+0x1a/0x20
  [<80105334>] poll_idle+0x0/0x48
  [<8010535d>] poll_idle+0x29/0x48
  [<801053b3>] cpu_idle+0x37/0x48
  [<801183ad>] printk+0x125/0x140

Code: 89 50 04 89 02 c7 06 00 00 00 00 c7 46 04 00 00 00 00 c7 46

I'll get a properly decoded one later.  I think I just wrote over my 
old vmlinux.  But, it looks to me like this is somewhere inside 
__run_timers() at kernel/timer.c :329, which looks something like this:
                         list_del(&timer->entry);
                         timer->base = NULL;
#if CONFIG_SMP
                         base->running_timer = timer;
#endif

kgdb kills this machine when kjournald is starting up.  Time to try 
kdb.  I _really_ hate this POS hardware.

-- 
Dave Hansen
haveblue@us.ibm.com

