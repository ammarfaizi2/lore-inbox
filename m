Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVDCFyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVDCFyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 00:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVDCFyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 00:54:40 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:12494 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261420AbVDCFyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 00:54:20 -0500
Date: Sat, 2 Apr 2005 21:53:32 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050402215332.79ff56cc.pj@engr.sgi.com>
In-Reply-To: <20050402145351.GA11601@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just so as no else wastes time repeating the little bit I've done so
far, and so I don't waste time figuring out what is already known,
here's what I have so far, trying out Ingo's "sched: auto-tune migration
costs" on ia64 SN2:

To get it to compile against 2.6.12-rc1-mm4, I did thus:

      1. Manually edited "include/asm-x86_64/topology.h" to
         remove .cache_hot_time (patch failed due to conflicts
         with nearby changes to add some *_idx terms).
      2. Moved the 394 line block of new code in kernel/sched.c
         to _before_ the large  #ifdef ARCH_HAS_SCHED_DOMAIN,
         #else, #endif block.  The ia64 arch (only) defines
         ARCH_HAS_SCHED_DOMAIN, so was being denied use of Ingo's
         code when it was buried in the '#else-#endif' side of
         this large conditional block.
      3. Add "#include <linux/vmalloc.h>" to kernel/sched.c
      4. Don't print cpu_khz in the cost matrix header, as cpu_khz
         is only in a few arch's (x86_64, ppc, i386, arm).

Note that (2) was just a superficial fix - it compiles, but the result
could easily be insanely stupid and I'd have no clue.  I need to
read the code some more.

Booting on an 8 CPU ia64 SN2, the console output got far enough to show:

============================ begin ============================
Brought up 8 CPUs
softlockup thread 7 started up.
Total of 8 processors activated (15548.60 BogoMIPS).
---------------------
migration cost matrix (max_cache_size: 33554432):
---------------------
          [00]    [01]    [02]    [03]    [04]    [05]    [06]    [07]
[00]:     -
============================= end =============================

Then it hung for 5 or 10 minutes, and then it blurted out a panic and
died. I'll quote the whole panic, including backtrace, in case someone
happens to see something obvious.

But I'm not asking anyone to think about this yet, unless it amuses
them.  I can usefully occupy myself reading the code and adding printk's
for a while.

Note the first 3 chars of the panic message "4.5".  This looks like it
might be the [00]-[01] entry of Ingo's table, flushed out when the
newlines of the panic came through.

============================ begin ============================
4.5(0)<1>Unable to handle kernel paging request at virtual address 0000000000010008
swapper[1]: Oops 8813272891392 [1]
Modules linked in:

Pid: 1, CPU 0, comm:              swapper
psr : 0000101008026018 ifs : 8000000000000288 ip  : [<a0000001000d9a30>]    Not tainted
ip is at queue_work+0xb0/0x1a0
unat: 0000000000000000 pfs : 0000000000000288 rsc : 0000000000000003
rnat: a000000100ab2a50 bsps: 0000000000100000 pr  : 5a66666956996a65
ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000d99b0 b6  : a000000100003320 b7  : a000000100490200
f6  : 1003e0000000000009ff7 f7  : 1003e000418d3645db265
f8  : 1003e000000003b8186ed f9  : 1003e0000000000005f3b
f10 : 1003e0000000000001000 f11 : 1003e0000000000000040
r1  : a000000100c9de60 r2  : 0000000000000000 r3  : 0000000000000001
r8  : 0000000000000000 r9  : 0000000000000000 r10 : a000000100969c50
r11 : 0000000000000004 r12 : e00001b03a8d7910 r13 : e00001b03a8d0000
r14 : 0000000000000000 r15 : 0000000000010008 r16 : e00001b03a8d0dc0
r17 : 0000000000010008 r18 : 0000000000000103 r19 : a000000100c32048
r20 : a000000100c32018 r21 : a000000100aa92c8 r22 : e000003003005d90
r23 : e000003003005da8 r24 : a000000100cf2098 r25 : e000003003005db0
r26 : a000000100ab4bf4 r27 : e000003003005d81 r28 : 000000010004b001
r29 : 0000000000000000 r30 : 000000010004b000 r31 : a000000100c32010

Call Trace:
 [<a000000100010460>] show_stack+0x80/0xa0
                                sp=e00001b03a8d74d0 bsp=e00001b03a8d1620
 [<a000000100010d40>] show_regs+0x860/0x880
                                sp=e00001b03a8d76a0 bsp=e00001b03a8d15b8
 [<a000000100036390>] die+0x170/0x200
                                sp=e00001b03a8d76b0 bsp=e00001b03a8d1580
 [<a00000010005bb20>] ia64_do_page_fault+0x200/0xa40
                                sp=e00001b03a8d76b0 bsp=e00001b03a8d1520
 [<a00000010000b2c0>] ia64_leave_kernel+0x0/0x290
                                sp=e00001b03a8d7740 bsp=e00001b03a8d1520
 [<a0000001000d9a30>] queue_work+0xb0/0x1a0
                                sp=e00001b03a8d7910 bsp=e00001b03a8d14e0
 [<a0000001000db0d0>] schedule_work+0x30/0x60
                                sp=e00001b03a8d7910 bsp=e00001b03a8d14c8
 [<a000000100490230>] blank_screen_t+0x30/0x60
                                sp=e00001b03a8d7910 bsp=e00001b03a8d14b8
 [<a0000001000c8130>] run_timer_softirq+0x2d0/0x4a0
                                sp=e00001b03a8d7910 bsp=e00001b03a8d1410
 [<a0000001000bb920>] __do_softirq+0x220/0x260
                                sp=e00001b03a8d7930 bsp=e00001b03a8d1378
 [<a0000001000bb9e0>] do_softirq+0x80/0xe0
                                sp=e00001b03a8d7930 bsp=e00001b03a8d1320
 [<a0000001000bbc50>] irq_exit+0x90/0xc0
                                sp=e00001b03a8d7930 bsp=e00001b03a8d1310
 [<a00000010000f4b0>] ia64_handle_irq+0x110/0x140
                                sp=e00001b03a8d7930 bsp=e00001b03a8d12d8
 [<a00000010000b2c0>] ia64_leave_kernel+0x0/0x290
                                sp=e00001b03a8d7930 bsp=e00001b03a8d12d8
 [<a000000100844b20>] read_cache+0x40/0x60
                                sp=e00001b03a8d7b00 bsp=e00001b03a8d12c8
 [<a000000100844fb0>] target_handler+0xd0/0xe0
                                sp=e00001b03a8d7b00 bsp=e00001b03a8d1298
 [<a000000100845150>] measure_one+0x190/0x240
                                sp=e00001b03a8d7b00 bsp=e00001b03a8d1260
 [<a000000100845890>] measure_cacheflush_time+0x270/0x420
                                sp=e00001b03a8d7b30 bsp=e00001b03a8d1200
 [<a0000001000a7350>] calibrate_cache_decay+0x710/0x740
                                sp=e00001b03a8d7b40 bsp=e00001b03a8d1148
 [<a000000100056180>] arch_init_sched_domains+0x12c0/0x1e40
                                sp=e00001b03a8d7b60 bsp=e00001b03a8d0e80
 [<a000000100845a60>] sched_init_smp+0x20/0x60
                                sp=e00001b03a8d7de0 bsp=e00001b03a8d0e70
 [<a000000100009570>] init+0x250/0x440
                                sp=e00001b03a8d7de0 bsp=e00001b03a8d0e38
 [<a000000100012940>] kernel_thread_helper+0xe0/0x100
                                sp=e00001b03a8d7e30 bsp=e00001b03a8d0e10
 [<a000000100009120>] start_kernel_thread+0x20/0x40
                                sp=e00001b03a8d7e30 bsp=e00001b03a8d0e10
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
============================= end =============================


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
