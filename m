Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318211AbSHPGT1>; Fri, 16 Aug 2002 02:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHPGT1>; Fri, 16 Aug 2002 02:19:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26638 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318211AbSHPGT0>;
	Fri, 16 Aug 2002 02:19:26 -0400
Message-ID: <3D5C9CD7.55287BCB@zip.com.au>
Date: Thu, 15 Aug 2002 23:33:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 kmap_atomic copy_*_user benefits
References: <20020815232126.GR15685@holomorphy.com> <3D5C5F05.7080004@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> William Lee Irwin III wrote:
> > With and without kmap_atomic() -based copy_*_user() patches from akpm.
> > Taken on a 16x/16GB box.
> 
> Have you seen any instability with these things applied?  I seem to be
> getting a fair amount of these BUG()s.  But, I imagine that it could
> be a race uncovered because of the serialization that highmem locks
> caused.
> 
> kernel BUG at softirq.c:229!

I just hit it.  No kmap patches though.

> ...
> 
>  >>EIP; 8011c8dd <tasklet_hi_action+5d/c4>   <=====
> 
>  >>ebx; 80374f54 <bh_task_vec+14/280>
>  >>ecx; 8037e194 <tv1+14/804>
>  >>ebp; 80357560 <__bss_start+0/0>
> 
> Trace; 8011c62a <do_softirq+5a/ac>
> Trace; 801092e1 <do_IRQ+f1/100>
> Trace; 80105334 <poll_idle+0/48>
> Trace; 80107d28 <common_interrupt+18/20>
> Trace; 80105334 <poll_idle+0/48>
> Trace; 8010535d <poll_idle+29/48>
> Trace; 801053b3 <cpu_idle+37/48>

#0  tasklet_hi_action (a=0xc03671a0) at softirq.c:230
#1  0xc011e74d in do_softirq () at softirq.c:89
#2  0xc0112b53 in smp_apic_timer_interrupt (regs=
      {ebx = -1056148556, ecx = 8, edx = 1024, esi = 134587171, edi = -997773344, ebp = -870006964, eax = 0, xds = -870055832, xes = -1072562072, orig_eax = -17, eip = -1072501662, xcs = 96, eflags = 66054, esp = -965588688, xss = 63491})
    at apic.c:1091
#3  0xc0107f7a in apic_timer_interrupt () at stats.c:204
#4  0xc012ee3f in generic_file_write (file=0xcb90d5e0, buf=0x804b340 '\001' <repeats 200 times>..., count=63491, 
    ppos=0xcb90d600) at filemap.c:2085
#5  0xc013e210 in vfs_write (file=0xcb90d5e0, buf=0x804b340 '\001' <repeats 200 times>..., count=63491, pos=0xcb90d600)

(gdb) p t->func
$1 = (void (*)()) 0xc011eb90 <bh_action>
(gdb) p t->data
$2 = 0
(gdb) p bh_base[0]
$3 = (void (*)()) 0xc0121c94 <timer_bh>
