Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWBOXHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWBOXHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 18:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWBOXHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 18:07:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22537 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751172AbWBOXHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 18:07:23 -0500
Date: Wed, 15 Feb 2006 23:07:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: SMP BUG
Message-ID: <20060215230701.GD1508@flint.arm.linux.org.uk>
Mail-Followup-To: Hubertus Franke <frankeh@watson.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <43F12207.9010507@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F12207.9010507@watson.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 07:19:19PM -0500, Hubertus Franke wrote:
> Folks the change introduced in 2.6.16-rc2   over 2.6.15
> wrt to the SMP initialization are wrong.
> Please apply to unroll the change..
> 
> Here is the logic ...
> sched_init is called from start_kernel before the
> architecture specific function cpu_check_smp() is called
> which is done as part of rest_init().
> 
> On s390 this actually sets the cpu_possible_map, which
> is now used in sched_init through the for_each_cpu without
> properly being initialized.
> As a result bringing 2nd and subsequent cpu online
> breaks.
> 
> This should be a quick fix, until this chicken and egg
> problem is solved otherwise.
> 
> -- Hubertus
> 
> --- kernel/sched.c.orig 2006-02-13 19:08:28.000000000 -0500
> +++ kernel/sched.c      2006-02-13 19:09:08.000000000 -0500
> @@ -6111,7 +6111,7 @@ void __init sched_init(void)
>         runqueue_t *rq;
>         int i, j, k;
> 
> -       for_each_cpu(i) {
> +       for (i = 0; i < NR_CPUS; i++ ) {
>                 prio_array_t *array;
> 
>                 rq = cpu_rq(i);

(left most of the message intact because it seems to have been ignored.
Copying Linus and akpm in the vague hope of a response.)

Yes, I'm also seeing an oops caused by exactly this on ARM:

<5>Linux version 2.6.16-rc3-rmk (rmk@dyn-67.arm.linux.org.uk) (gcc version 3.3 20030728 (Red Hat Linux 3.3-16)) #201 SMP Wed Feb 15 22:34:57 GMT 2006
CPU: Some Random V6 Processor [410fb020] revision 0 (ARMv6TEJ)
Machine: ARM-RealView EB
Memory policy: ECC disabled, Data cache writealloc
<7>On node 0 totalpages: 32768
<7>  DMA zone: 32768 pages, LIFO batch:7
<7>  DMA32 zone: 0 pages, LIFO batch:0
<7>  Normal zone: 0 pages, LIFO batch:0
<7>  HighMem zone: 0 pages, LIFO batch:0
CPU0: D VIPT write-back cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists
<5>Kernel command line: root=/dev/nfs mem=128M console=ttyAMA0,38400 ip=dhcp cachepolicy=writealloc
PID hash table entries: 1024 (order: 10, 16384 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<6>Memory: 128MB = 128MB total
<5>Memory: 127104KB available (1992K code, 426K data, 100K init)
<7>Calibrating delay loop... 83.14 BogoMIPS (lpj=415744)
Mount-cache hash table entries: 512
<6>CPU: Testing write buffer coherency: ok
Calibrating local timer... 104.41MHz.
CPU1: Booted secondary processor
CPU1: D VIPT write-back cache
CPU1: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU1: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
<7>Calibrating delay loop... 83.14 BogoMIPS (lpj=415744)
<1>Unable to handle kernel NULL pointer dereference at virtual address 0000001c
<1>pgd = c0004000
<1>[0000001c] *pgd=00000000
Internal error: Oops: 5 [#1]
Modules linked in:
CPU: 0
PC is at enqueue_task+0x1c/0x64
LR is at activate_task+0xcc/0xe4
pc : [<c0034c28>]    lr : [<c0034f80>]    Not tainted
sp : c7c05ebc  ip : c7c05ed0  fp : c7c05ecc
r10: 00000001  r9 : c001b160  r8 : c038a240
r7 : c03fe2e0  r6 : 00000000  r5 : 0095257a  r4 : 00000008
r3 : 00000018  r2 : c03fe308  r1 : 00000000  r0 : c03fe2e0
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: C5787F  Table: 0000400A  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc7c04194)
Stack: (0xc7c05ebc to 0xc7c06000)
5ea0:                                                                00000008
5ec0: c7c05ef0 c7c05ed0 c0034f80 c0034c18 c001b160 00000001 00000000 c03fe2e0
5ee0: c038a240 c7c05f48 c7c05ef4 c0035960 c0034ec0 c0065a28 c00657b4 c7c04000
5f00: c7c0c000 c038a240 00000000 00000001 00000000 00000000 0000000f 80000013
5f20: c021a55c 00000001 00000001 00000000 c0264f8c 00000000 00000000 c7c05f58
5f40: c7c05f4c c00359d4 c00355e0 c7c05f88 c7c05f5c c00395dc c00359c8 c002b0a4
5f60: c021a55c 00000001 00000002 00000000 c0264f8c 00000000 00000000 c7c05fa4
5f80: c7c05f8c c004d544 c00394d4 00000000 00000001 00000001 c7c05fc8 c7c05fa8
5fa0: c005b488 c004d518 00000001 c0264f8c 00000000 00000000 00000000 c7c05fe0
5fc0: c7c05fcc c0008874 c005b3b8 c0262efc 00000000 c7c05ff4 c7c05fe4 c0021120
5fe0: c0008818 00000000 00000000 c7c05ff8 c0040a44 c0021084 2020202d 2d2d2020
Backtrace:
[<c0034c0c>] (enqueue_task+0x0/0x64) from [<c0034f80>] (activate_task+0xcc/0xe4) r4 = 00000008
[<c0034eb4>] (activate_task+0x0/0xe4) from [<c0035960>] (try_to_wake_up+0x38c/0x3e8)
[<c00355d4>] (try_to_wake_up+0x0/0x3e8) from [<c00359d4>] (wake_up_process+0x18/0x1c)
[<c00359bc>] (wake_up_process+0x0/0x1c) from [<c00395dc>] (migration_call+0x114/0x328)
[<c00394c8>] (migration_call+0x0/0x328) from [<c004d544>] (notifier_call_chain+0x38/0x50)
[<c004d50c>] (notifier_call_chain+0x0/0x50) from [<c005b488>] (cpu_up+0xdc/0x104)
[<c005b3ac>] (cpu_up+0x0/0x104) from [<c0008874>] (smp_init+0x68/0xc4)
[<c000880c>] (smp_init+0x0/0xc4) from [<c0021120>] (init+0xa8/0x1c8)
[<c0021078>] (init+0x0/0x1c8) from [<c0040a44>] (do_exit+0x0/0x3f4)
Code: e5903020 e2802028 e0813183 e2833018 (e593c004)
 <0>Kernel panic - not syncing: Attempted to kill init!
 <2>CPU1: stopping
[<c0027478>] (dump_stack+0x0/0x14) from [<c0028af8>] (ipi_cpu_stop+0x2c/0x64)
[<c0028acc>] (ipi_cpu_stop+0x0/0x64) from [<c0028bec>] (do_IPI+0xbc/0xe8)
[<c0028b30>] (do_IPI+0x0/0xe8) from [<c00219b0>] (__irq_svc+0x30/0xc0)
[<c0023b88>] (default_idle+0x0/0x44) from [<c0023c2c>] (cpu_idle+0x60/0x80)
[<c0023bcc>] (cpu_idle+0x0/0x80) from [<c00285b4>] (secondary_start_kernel+0xc8/0xd8)
[<c00284ec>] (secondary_start_kernel+0x0/0xd8) from [<000080e0>] (0x80e0)

enqueue_task is being called with p = c03fe2e0, array = NULL, leading
to a NULL pointer dereference because rq->array has not been initialised.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
