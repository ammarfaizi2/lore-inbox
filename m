Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266483AbRGQNXD>; Tue, 17 Jul 2001 09:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266490AbRGQNWx>; Tue, 17 Jul 2001 09:22:53 -0400
Received: from delta.Colorado.EDU ([128.138.139.9]:48645 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S266483AbRGQNWm>;
	Tue, 17 Jul 2001 09:22:42 -0400
Message-Id: <200107171322.HAA245907@ibg.colorado.edu>
To: andrewm@uow.edu.au (Andrew Morton)
cc: linux-kernel@vger.kernel.org
Subject: Re: Too much memory causes crash when reading/writing to disk
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Tue, 17 Jul 2001 07:22:42 -0600
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> 
>> I have done a bit more work on the problem I reported in my message
>> "Crashes reading and writing to disk".  To recap, on a machine with
>> 8GB of RAM, either
>> 
>> dd if=/dev/zero bs=1G count=10 | split -b 1073741824
>> 
>> or
>> 
>> find /bigfulldisk -type f -exec cat {} \; > /dev/null
>> 
>> can reliably cause a crash.
>
>It seems that one of your CPUs is stuck in an interrupt
>routine.  Could you please try running with the below
>patch?  Feed the output through ksymoops.

I tried the patch, but the machine came up in a very confused state.
It couldn't mount proc, and other badness.  I made the patch against
2.4.6, because 2.4.7-pre6 doesn't boot at all (I guess I should send
another message about that problem).

>Also (but separately) try enabling the NMI watchdog with
>the `nmi_watchdog=1' kernel boot parameter.

This worked, and I recreated the crash:

ksymoops 2.4.1 on i686 2.4.6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.6/ (default)
     -m /boot/System.map-2.4.6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

7552MB HIGHMEM available.
activating NMI Watchdog ... done.
cpu: 0, clocks: 999966, slice: 111107
cpu: 5, clocks: 999966, slice: 111107
cpu: 6, clocks: 999966, slice: 111107
cpu: 7, clocks: 999966, slice: 111107
cpu: 3, clocks: 999966, slice: 111107
cpu: 2, clocks: 999966, slice: 111107
cpu: 1, clocks: 999966, slice: 111107
cpu: 4, clocks: 999966, slice: 111107
NMI Watchdog detected LOCKUP on CPU5, registers:
CPU:    5
EIP:    0010:[<c010b50f>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046
eax: 00000080   ebx: c9c93f7c   ecx: 04b058ee   edx: 000019c0
esi: 20000001   edi: 000000a0   ebp: 00000000   esp: c9c93f2c
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c9c93000)
Stack: c0247e28 c01083b1 00000000 00000000 c9c93f7c c02af980 c0291800 00000000 
       c9c93f74 c0108596 00000000 c9c93f7c c0247e28 c0105180 c9c92000 c0105180 
       000000a0 c0247e28 00000000 c0106d04 c0105180 00000020 c9c92000 c9c92000 
Call Trace: [<c01083b1>] [<c0108596>] [<c0105180>] [<c0105180>] [<c0106d04>] [<c0105180>] [<c0105180>] 
       [<c01051ac>] [<c0105212>] [<c0114e66>] 
Code: c6 05 00 79 24 c0 01 53 e8 80 09 01 00 83 c4 04 83 3d 88 f2 

>>EIP; c010b50f <timer_interrupt+9b/130>   <=====
Trace; c01083b1 <handle_IRQ_event+4d/78>
Trace; c0108596 <do_IRQ+a6/ec>
Trace; c0105180 <default_idle+0/34>
Trace; c0105180 <default_idle+0/34>
Trace; c0106d04 <ret_from_intr+0/7>
Trace; c0105180 <default_idle+0/34>
Trace; c0105180 <default_idle+0/34>
Trace; c01051ac <default_idle+2c/34>
Trace; c0105212 <cpu_idle+3e/54>
Trace; c0114e66 <printk+16e/17c>
Code;  c010b50f <timer_interrupt+9b/130>
00000000 <_EIP>:
Code;  c010b50f <timer_interrupt+9b/130>   <=====
   0:   c6 05 00 79 24 c0 01      movb   $0x1,0xc0247900   <=====
Code;  c010b516 <timer_interrupt+a2/130>
   7:   53                        push   %ebx
Code;  c010b517 <timer_interrupt+a3/130>
   8:   e8 80 09 01 00            call   1098d <_EIP+0x1098d> c011be9c <do_timer+0/30>
Code;  c010b51c <timer_interrupt+a8/130>
   d:   83 c4 04                  add    $0x4,%esp
Code;  c010b51f <timer_interrupt+ab/130>
  10:   83 3d 88 f2 00 00 00      cmpl   $0x0,0xf288


1 warning issued.  Results may not be reliable.
