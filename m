Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVDSJLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVDSJLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 05:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVDSJLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 05:11:07 -0400
Received: from [61.185.204.103] ([61.185.204.103]:25747 "EHLO
	dns.angelltech.com") by vger.kernel.org with ESMTP id S261276AbVDSJKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 05:10:34 -0400
Message-ID: <4264CBF4.7000706@angelltech.com>
Date: Tue, 19 Apr 2005 17:14:28 +0800
From: rjy <rjy@angelltech.com>
Reply-To: rjy@angelltech.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: init process freezed after run_init_process
References: <424B7A87.2070100@angelltech.com> <Pine.LNX.4.61.0503311113550.17113@yvahk01.tjqt.qr> <4254AB72.8070704@angelltech.com> <Pine.LNX.4.61.0504071341500.27692@yvahk01.tjqt.qr> <4255EF2A.709@angelltech.com> <Pine.LNX.4.61.0504081944120.19971@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0504081944120.19971@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>Make your own initrd and put a bash into it. Then start that, e.g. (for
>>>our linux live cd), initrd=initrd.sqfs root=/dev/ram0 init=/bin/bash
>>
>>I have tried these kernel parameters:
>>init=/bin/bash
>>init=/linuxrc
>>init=/init
>>init=/sbin/init
>>None works.
> 
> 
> What's the error message?

No error message at all. System seems freezed after spit out this message:
	Freeing unused kernel memory: 136k freed
The console echos the keyboard inputs.

It seems that the init started successfully: I attached the output
of "info threads" and "backtrace" after the system freezing.

I am digging the source these days and try to find out if the init
process has really been started. I found some difference between
the normal init process and the freezed init process:
----------------------------------------------------------------
		| Normal init		| Freezed init
----------------------------------------------------------------
mm->total_vm	| 0x145			| 0x1e
mm->map_count	| 9			| 5
----------------------------------------------------------------

Maybe, init is not loaded completely? Or just loaded an invalid one?
I am trying to dump the text segment at user space 0x08040000 of the
init process. But I have not found the way to find the related kernel 
space address. Any clue? Thanks! :)

> 
> 
>>Also, after some google, I found that the format of initrd has changed.
>>I also tried a new initrd with cpio format. The kernel recognized it:
> 
> 
> cpio initrd's (aka initramfs) are new - the "old style" initrd where you
> `mksquasfs mydir initrd.sqfs` (see above) continues to work, though.
> 
> 
>>After the kernel start, I add breakpoints at cpu_idle and do_schedule.
>>cpu_idle never reached, only do_schedule did. Is that strange?
> 
> 
> Until pid 1 is started, the cpu should never be idle.
> 
> 
> Jan Engelhardt

It seems that the init process is started:
(gdb) info threads
   11 Thread 123 (kseriod)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   10 Thread 9 (aio/0)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   9 Thread 8 (kswapd0)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   8 Thread 7 (pdflush)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   7 Thread 6 (pdflush)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   6 Thread 5 (khelper)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   5 Thread 4 (kblockd/0)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   4 Thread 3 (events/0)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
   3 Thread 2 (ksoftirqd/0)  0xc032d485 in do_schedule () at 
/kernel/via/kgdb/kernel/sched.c:923
* 2 Thread 1 (init)  breakpoint () at /kernel/via/kgdb/kernel/kgdb.c:1212
   1 Thread 32768 (Shadow task 0 for pid 0)  0xc032d485 in do_schedule 
() at /kernel/via/kgdb/kernel/sched.c:923

(gdb) bt
#0  breakpoint () at /kernel/via/kgdb/kernel/kgdb.c:1212
#1  0xc774fec4 in ?? ()
#2  0xc010893b in do_IRQ (regs=
       {ebx = -948641792, ecx = -948577792, edx = -944260388, esi = 0, 
edi = -948641792, ebp = -948633844, eax = -944260388, xds = 123, xes = 
123, orig_eax = -252, eip = -1072517263, xcs = 96, eflags = 646, esp = 
-948633660, xss = -948576428})
     at /kernel/via/kgdb/arch/i386/kernel/irq.c:574
#3  0xc0106888 in common_interrupt ()
#4  0xc01063f6 in do_signal (regs=0xc774e000, oldset=0x0) at 
/kernel/via/kgdb/arch/i386/kernel/signal.c:581
#5  0xc01064d9 in do_notify_resume (regs=0xc774ffc4, oldset=0x0, 
thread_info_flags=1)
     at /kernel/via/kgdb/arch/i386/kernel/signal.c:629
