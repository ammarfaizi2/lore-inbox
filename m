Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261928AbSJISSx>; Wed, 9 Oct 2002 14:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261935AbSJISSx>; Wed, 9 Oct 2002 14:18:53 -0400
Received: from mg03.austin.ibm.com ([192.35.232.20]:35303 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S261928AbSJISSt> convert rfc822-to-8bit; Wed, 9 Oct 2002 14:18:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Erich Focht <efocht@ess.nec.de>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [PATCH] pooling NUMA scheduler with initial load balancing
Date: Wed, 9 Oct 2002 13:13:21 -0500
X-Mailer: KMail [version 1.4]
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
References: <200210091826.20759.efocht@ess.nec.de> <1548227964.1034159598@[10.10.2.3]> <200210091258.08379.habanero@us.ibm.com>
In-Reply-To: <200210091258.08379.habanero@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210091313.21197.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 October 2002 12:58 pm, Andrew Theurer wrote:
> > I'm testing on 2.5.41-mm1 ... your patches still apply clean. That
> > has a whole bunch of nice NUMA mods, you might want to try that
> > instead? All the changes in there will end up in mainline real soon
> > anyway ;-)
> >
> > One minor warning:
> >
> > arch/i386/kernel/smpboot.c: In function `smp_cpus_done':
> > arch/i386/kernel/smpboot.c:1199: warning: implicit declaration of
> > function `bld_pools'
> >
> > And the same panic:
> >
> > Starting migration thread for cpu 3
> > Bringing up 4
> > CPU>dividNOWrro!
>
> I got the same thing on 2.5.40-mm1.  It looks like it may be a a divide by
> zero in calc_pool_load.  I am attempting to boot a band-aid version right
> now.  OK, got a little further:
>
A little more detail:
Code: f7 f3 3b 45 e4 7e 06 89 45 e4 89 7d ec 8b 45 d8 8b 00 39 f0 
EFLAGS: 00010046
eax: 00000001   ebx: 00000000   ecx: 00000003   edx: 00000000
esi: c02c98c4   edi: c39c5880   ebp: f0199ee8   esp: f0199ec0
ds: 0068   es: 0068   ss: 0068
Stack: c39c58a0 c02c94c8 c02c993c 00000000 c02c94c4 00000000 0000007d c02c94a0 
       00000001 00000003 f0199f1c c0117bec c02c94a0 00000003 00000003 00000001 
       00000000 c01135d1 f01a3f10 00000000 00000003 f01c1740 c02cb4e0 f0199f44 
Call Trace: [<c0117bec>] [<c01135d1>] [<c0117eed>] [<c0122587>] [<c0105420>] 
[<c0125e60>] [<c0113ca7>] [<c0105420>] [<c010818e>] [<c
0105420>] [<c0105420>] [<c010544a>] [<c01054ea>] [<c011cf50>]
Code: f7 f3 3b 45 e4 7e 06 89 45 e4 89 7d ec 8b 45 d8 8b 00 39 f0 
Using defaults from ksymoops -t elf32-i386 -a i386


>>esi; c02c98c4 <runqueues+424/15800>
>>edi; c39c5880 <END_OF_CODE+36419c4/????>
>>ebp; f0199ee8 <END_OF_CODE+2fe1602c/????>
>>esp; f0199ec0 <END_OF_CODE+2fe16004/????>

Trace; c0117bec <load_balance+8c/140>
Trace; c01135d1 <smp_call_function_interrupt+41/90>
Trace; c0117eed <scheduler_tick+24d/390>
Trace; c0122587 <tasklet_hi_action+77/c0>
Trace; c0105420 <default_idle+0/50>
Trace; c0125e60 <update_process_times+40/50>
Trace; c0113ca7 <smp_apic_timer_interrupt+117/120>
Trace; c0105420 <default_idle+0/50>
Trace; c010818e <apic_timer_interrupt+1a/20>
Trace; c0105420 <default_idle+0/50>
Trace; c0105420 <default_idle+0/50>
Trace; c010544a <default_idle+2a/50>
Trace; c01054ea <cpu_idle+3a/50>
Trace; c011cf50 <printk+140/180>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f7 f3                     div    %ebx
Code;  00000002 Before first symbol
   2:   3b 45 e4                  cmp    0xffffffe4(%ebp),%eax
Code;  00000005 Before first symbol
   5:   7e 06                     jle    d <_EIP+0xd> 0000000d Before first 
symbol
Code;  00000007 Before first symbol
   7:   89 45 e4                  mov    %eax,0xffffffe4(%ebp)
Code;  0000000a Before first symbol
   a:   89 7d ec                  mov    %edi,0xffffffec(%ebp)
Code;  0000000d Before first symbol
   d:   8b 45 d8                  mov    0xffffffd8(%ebp),%eax
Code;  00000010 Before first symbol
  10:   8b 00                     mov    (%eax),%eax
Code;  00000012 Before first symbol
  12:   39 f0                     cmp    %esi,%eax




