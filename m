Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263631AbSITU55>; Fri, 20 Sep 2002 16:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263633AbSITU5z>; Fri, 20 Sep 2002 16:57:55 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:17417 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263631AbSITU5l>; Fri, 20 Sep 2002 16:57:41 -0400
Date: Fri, 20 Sep 2002 23:02:25 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pre-empt and smp in 2.5.37 - is it supposed to work? [contains 2 oopses, one in set_cpus_allowed, one in md code]
Message-ID: <20020920210225.GA526@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <20020920200441.GA3677@middle.of.nowhere> <1032552562.966.832.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1032552562.966.832.camel@phantasy>
User-Agent: Mutt/1.4i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Love <rml@tech9.net>
Date: Fri, Sep 20, 2002 at 04:09:22PM -0400
> On Fri, 2002-09-20 at 16:04, Jurriaan wrote:
> 
> > I get a large screen full of hex addresses even before my framebuffer
> > activates, so I wonder if breakage when using preempt and smp is a known
> > issue in 2.5.37 or not?
> 
> You need this yet-to-be-merged patch.  It should work fine with it.
> 
> It is just an overzealous debugging test..
> 
> 	Robert Love
> 
> diff -urN linux-2.5.37/kernel/sched.c linux/kernel/sched.c
> --- linux-2.5.37/kernel/sched.c	Fri Sep 20 11:20:32 2002
> +++ linux/kernel/sched.c	Fri Sep 20 15:49:05 2002
> @@ -940,8 +940,17 @@
>  	struct list_head *queue;
>  	int idx;
>  
> -	if (unlikely(in_atomic()))
> -		BUG();
> +	/*
> +	 * Test if we are atomic.  Since do_exit() needs to call into
> +	 * schedule() atomically, we ignore that path for now.
> +	 * Otherwise, whine if we are scheduling when we should not be.
> +	 */
> +	if (likely(current->state != TASK_ZOMBIE)) {
> +		if (unlikely(in_atomic())) {
> +			printk(KERN_ERR "bad: scheduling while atomic!\n");
> +			dump_stack();
> +		}
> +	}
>  
>  #if CONFIG_DEBUG_HIGHMEM
>  	check_highmem_ptes();
> 
Well, then, perhaps you're interested in the dump?
I get two 'bad: scheduling while atomic' messages when booting:

ksymoops 2.4.6 on i686 2.5.37.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.37/ (default)
     -m /boot/System.map-2.5.37 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.5.37 failed
ksymoops: No such file or directory
cpu: 0, clocks: 100440, slice: 3043
cpu: 1, clocks: 100440, slice: 3043
CPU 1 IS NOW UP!
c1b69f00 c01165f1 c02db020 c1b68000 c1b69f70 c1b69f78 00000000 00000000 
       00000000 00000000 00000000 00000000 c1b68000 c1b69f78 c0116c3c 00000000 
       c1b68000 c03e24a0 c1b68000 c1b69fa4 00000000 c1b75bc0 c01169fc 00000000 
Call Trace: [<c01165f1>] [<c0116c3c>] [<c01169fc>] [<c01169fc>] [<c01180e6>] 
   [<c0118158>] [<c0118108>] [<c01054f1>] 
c1b67f1c c01165f1 c02db020 c1b66000 c1b67f8c c1b67f94 00000000 00000000 
       00000000 00000000 00000000 00000000 c1b66000 c1b67f94 c0116c3c 00000000 
       c1b66000 c03e24a0 c1b66000 c1b67fc0 00000000 c1b762a0 c01169fc 00000000 
Call Trace: [<c01165f1>] [<c0116c3c>] [<c01169fc>] [<c01169fc>] [<c01180e6>] 
   [<c012031d>] [<c01202cc>] [<c01054f1>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c01165f1 <schedule+3d/404>
Trace; c0116c3c <wait_for_completion+9c/f8>
Trace; c01169fc <default_wake_function+0/80>
Trace; c01169fc <default_wake_function+0/80>
Trace; c01180e6 <set_cpus_allowed+13a/744>
Trace; c0118158 <set_cpus_allowed+1ac/744>
Trace; c0118108 <set_cpus_allowed+15c/744>
Trace; c01054f1 <enable_hlt+1c9/1d0>
Trace; c01165f1 <schedule+3d/404>
Trace; c0116c3c <wait_for_completion+9c/f8>
Trace; c01169fc <default_wake_function+0/80>
Trace; c01169fc <default_wake_function+0/80>
Trace; c01180e6 <set_cpus_allowed+13a/744>
Trace; c012031d <__run_task_queue+dd/168>
Trace; c01202cc <__run_task_queue+8c/168>
Trace; c01054f1 <enable_hlt+1c9/1d0>

8139too Fast Ethernet driver 0.9.26
Unable to handle kernel NULL pointer dereference at virtual address 0000000e
c024b6b9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c024b6b9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001e   ebx: fffffffa   ecx: c03675a8   edx: 00000292
esi: fffffffa   edi: ffffffea   ebp: 00002103   esp: f7737eec
ds: 0068   es: 0068   ss: 0068
Stack: 00002103 c024d562 fffffffa 00000931 00002103 00002103 00000000 c024dfd9 
       00002103 00000931 f7ca5e40 00002103 f77a3ee0 00000000 00000000 f778ba00 
       000061b0 00000001 00000000 00000006 00002103 00000000 00000000 00000000 
Call Trace: [<c024d562>] [<c024dfd9>] [<c014a826>] [<c0152d39>] [<c01071eb>] 
Code: 8b 43 14 85 c0 74 10 0f b7 50 10 b2 00 66 0f b6 40 10 09 c2 


>>EIP; c024b6b9 <partition_name+799/aa0>   <=====

>>ecx; c03675a8 <abi_defhandler_libcso+1b0/2a4>
>>esp; f7737eec <ipv4_config+370cd784/3a2a98f8>

Trace; c024d562 <md_print_devices+1ba2/2d24>
Trace; c024dfd9 <md_print_devices+2619/2d24>
Trace; c014a826 <blkdev_put+2ca/318>
Trace; c0152d39 <kill_fasync+4cd/534>
Trace; c01071eb <__read_lock_failed+f0f/1c3c>

Code;  c024b6b9 <partition_name+799/aa0>
00000000 <_EIP>:
Code;  c024b6b9 <partition_name+799/aa0>   <=====
   0:   8b 43 14                  mov    0x14(%ebx),%eax   <=====
Code;  c024b6bc <partition_name+79c/aa0>
   3:   85 c0                     test   %eax,%eax
Code;  c024b6be <partition_name+79e/aa0>
   5:   74 10                     je     17 <_EIP+0x17> c024b6d0 <partition_name+7b0/aa0>
Code;  c024b6c0 <partition_name+7a0/aa0>
   7:   0f b7 50 10               movzwl 0x10(%eax),%edx
Code;  c024b6c4 <partition_name+7a4/aa0>
   b:   b2 00                     mov    $0x0,%dl
Code;  c024b6c6 <partition_name+7a6/aa0>
   d:   66 0f b6 40 10            movzbw 0x10(%eax),%ax
Code;  c024b6cb <partition_name+7ab/aa0>
  12:   09 c2                     or     %eax,%edx


2 warnings and 1 error issued.  Results may not be reliable.

hde3 does no longer exist - I need to redo my configuration, but that
shouldn't oops the kernel.

checking TSC synchronization across 2 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
cpu: 1, clocks: 100440, slice: 3043
CPU1<T0:100432,T1:94336,D:10,S:3043,C:100440>
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
bad: scheduling while atomic!
c1b69f00 c01165f1 c02db020 c1b68000 c1b69f70 c1b69f78 00000000 00000000 
       00000000 00000000 00000000 00000000 c1b68000 c1b69f78 c0116c3c 00000000 
       c1b68000 c03e24a0 c1b68000 c1b69fa4 00000000 c1b75bc0 c01169fc 00000000 
Call Trace: [<c01165f1>] [<c0116c3c>] [<c01169fc>] [<c01169fc>] [<c01180e6>] 
   [<c0118158>] [<c0118108>] [<c01054f1>] 
bad: scheduling while atomic!
c1b67f1c c01165f1 c02db020 c1b66000 c1b67f8c c1b67f94 00000000 00000000 
       00000000 00000000 00000000 00000000 c1b66000 c1b67f94 c0116c3c 00000000 
       c1b66000 c03e24a0 c1b66000 c1b67fc0 00000000 c1b762a0 c01169fc 00000000 
Call Trace: [<c01165f1>] [<c0116c3c>] [<c01169fc>] [<c01169fc>] [<c01180e6>] 
   [<c012031d>] [<c01202cc>] [<c01054f1>] 
CPUS done 4294967295
Linux NET4.0 for Linux 2.4
md: could not lock hde3.
md: could not import hde3!
Unable to handle kernel NULL pointer dereference at virtual address 0000000e
 printing eip:
c024b6b9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c024b6b9>]    Not tainted
EFLAGS: 00010286
eax: 0000001e   ebx: fffffffa   ecx: c03675a8   edx: 00000292
esi: fffffffa   edi: ffffffea   ebp: 00002103   esp: f7737eec
ds: 0068   es: 0068   ss: 0068
Process raidstart (pid: 89, threadinfo=f7736000 task=f7aa1520)
Stack: 00002103 c024d562 fffffffa 00000931 00002103 00002103 00000000 c024dfd9 
       00002103 00000931 f7ca5e40 00002103 f77a3ee0 00000000 00000000 f778ba00 
       000061b0 00000001 00000000 00000006 00002103 00000000 00000000 00000000 
Call Trace: [<c024d562>] [<c024dfd9>] [<c014a826>] [<c0152d39>] [<c01071eb>] 

Code: 8b 43 14 85 c0 74 10 0f b7 50 10 b2 00 66 0f b6 40 10 09 c2 
 <6>note: raidstart[89] exited with preempt_count 1
found reiserfs format "3.6" with standard journal

Jurriaan
-- 
I am the special news bulletin that interrupts your favorite show
	Darkwing Duck
GNU/Linux 2.5.37 SMP/ReiserFS 2x1380 bogomips load av: 0.15 0.21 0.20
