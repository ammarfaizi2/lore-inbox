Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319251AbSHNR1F>; Wed, 14 Aug 2002 13:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319254AbSHNR1F>; Wed, 14 Aug 2002 13:27:05 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:17071 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S319251AbSHNR1E>; Wed, 14 Aug 2002 13:27:04 -0400
Message-ID: <20020814173057.18028.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Wed, 14 Aug 2002 19:30:57 +0200
To: Antti Salmela <asalmela@iki.fi>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.4.20-pre1-ac3, SMP (Dual PIII)
References: <20020814145454.A21254@wasala.fi> <1029328630.26226.21.camel@irongate.swansea.linux.org.uk> <20020814161037.A22388@wasala.fi> <1029331629.26227.36.camel@irongate.swansea.linux.org.uk> <20020814185505.A23923@wasala.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020814185505.A23923@wasala.fi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I invested some time analyzing the Ooops and thought I'd share
what I think I found out:

The code where it Oopses is line 451 in context_switch:
    449 static inline task_t * context_switch(task_t *prev, task_t *next)
    450 {
    451         struct mm_struct *mm = next->mm;

0x54 is the offset of task->mm
At this point next is in %esi (%ebx in the earlier Oops posted). The
value of next is calculated by this code in schedule:
    867         idx = sched_find_first_bit(array->bitmap);
    868         queue = array->queue + idx;
    869         next = list_entry(queue->next, task_t, run_list);

At this point idx is in %eax, i.e. it has a value of 0x8c == 140
in both of the Oopsen. Investigating further on the value of next
(0xffffffd6) shows that this value is the result of
      list_entry (0x02, task_t, run_list),
i.e. queue->next == 0x02. Getting back to %eax shows that 140 (== MAX_PRIO
is actually NOT a valid index for array->queue above, i.e. it seems that we
overrun this array by one. Putting a ``BUG_ON(idx >= MAX_PRIO);'' between
lines 867 and 868 above should proof this.

HTH, I have no more time to investigate this now.

      regards    Christian Ehrhardt

------  Oooops preserved for reference --------------------
On Wed, Aug 14, 2002 at 06:55:05PM +0300, Antti Salmela wrote:
> ksymoops 2.4.5 on i686 2.4.19-rc1-ac1.  Options used
>      -V (default)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.19-rc1-ac2 (specified)
>      -m /boot/System.map-2.4.19-rc1-ac2 (specified)
> 
> No modules in ksyms, skipping objects
> Unable to handle kernel NULL pointer dereference at virtual address 0000002a
> c0116f0c
> *pde = 00000000
> Oops: 0000
> CPU:    1
> EIP:    0010:[<c0116f0c>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010003
> eax: 0000008c   ebx: c0327680   ecx: c03276a4   edx: f6760000
> esi: ffffffd6   edi: f676002c   ebp: f6761fa4   esp: f6761f88
> ds: 0018   es: 0018   ss: 0018
> Process distributed-net (pid: 511, stackpage=f6761000)
> Stack: f6760000 00000a00 f676002c 00000001 c011428f f6760000 f6760000 f6761fbc 
>        c0117eef f6760000 000000b5 000b2390 c0327680 bffff934 c01088eb 00000000 
>        00000000 40026004 000000b5 000b2390 bffff934 0000009e c010002b 0000002b 
> Call Trace: [<c011428f>] [<c0117eef>] [<c01088eb>] 
> Code: 8b 7e 54 8b 4a 58 89 4d f4 85 ff 75 37 89 4e 58 f0 ff 41 14 
> 
> 
> >>EIP; c0116f0c <schedule+198/394>   <=====
> 
> >>ebx; c0327680 <runqueues+a00/14000>
> >>ecx; c03276a4 <runqueues+a24/14000>
> >>edx; f6760000 <END_OF_CODE+363b9844/????>
> >>esi; ffffffd6 <END_OF_CODE+3fc5981a/????>
> >>edi; f676002c <END_OF_CODE+363b9870/????>
> >>ebp; f6761fa4 <END_OF_CODE+363bb7e8/????>
> >>esp; f6761f88 <END_OF_CODE+363bb7cc/????>
> 
> Trace; c011428f <smp_apic_timer_interrupt+f3/114>
> Trace; c0117eef <sys_sched_yield+113/11c>
> Trace; c01088eb <system_call+33/38>
> 
> Code;  c0116f0c <schedule+198/394>
> 00000000 <_EIP>:
> Code;  c0116f0c <schedule+198/394>   <=====
>    0:   8b 7e 54                  mov    0x54(%esi),%edi   <=====
> Code;  c0116f0f <schedule+19b/394>
>    3:   8b 4a 58                  mov    0x58(%edx),%ecx
> Code;  c0116f12 <schedule+19e/394>
>    6:   89 4d f4                  mov    %ecx,0xfffffff4(%ebp)
> Code;  c0116f15 <schedule+1a1/394>
>    9:   85 ff                     test   %edi,%edi
> Code;  c0116f17 <schedule+1a3/394>
>    b:   75 37                     jne    44 <_EIP+0x44> c0116f50 <schedule+1dc/394>
> Code;  c0116f19 <schedule+1a5/394>
>    d:   89 4e 58                  mov    %ecx,0x58(%esi)
> Code;  c0116f1c <schedule+1a8/394>
>   10:   f0 ff 41 14               lock incl 0x14(%ecx)
> 
> -- 
> Antti Salmela
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-- 
****************************************************************************
** Christian Ehrhardt  **  e-Mail: ehrhardt@mathematik.uni-ulm.de  *********
****************************************************************************

THAT'S ALL FOLKS!
