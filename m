Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTHUQi3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 12:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262804AbTHUQi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 12:38:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64663
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262799AbTHUQiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 12:38:25 -0400
Date: Thu, 21 Aug 2003 18:39:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: BKL on reboot ?
Message-ID: <20030821163938.GG29612@dualathlon.random>
References: <3F434BD1.9050704@suse.de> <20030820112918.0f7ce4fe.akpm@osdl.org> <20030820113520.281fe8bb.davem@redhat.com> <1061411024.9371.33.camel@nighthawk> <3F447D40.5020000@suse.de> <20030821154113.GE29612@dualathlon.random> <3F44EB85.5000108@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F44EB85.5000108@suse.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 05:55:49PM +0200, Hannes Reinecke wrote:
> Andrea Arcangeli wrote:
> >On Thu, Aug 21, 2003 at 10:05:20AM +0200, Hannes Reinecke wrote:
> [ .. ]
> >>
> >>Exactly what happened here. CPU#1 entered sys_reboot, got BKL and 
> >>prepared to stop. It will never release BKL, leaving a nice big window 
> >>for CPU#0 to deadlock.
> >
> >
> >if that was really the case it shouldn't deadlock, because CPU0
> >shouldn't depend on a big kernel lock to be able to re-enable the irqs,
> >and to receive the IPI. Nor any IPI handler could ever be allowed to
> >take the big kernel lock.
> >
> >Unless you can demonstrate a dependency on the big kernel lock for CPU0
> >to re-enable the irqs eventually, I can't see how the above could
> >deadlock.
> >
> 
> What happened was this:
> 
> ================================================================
> TASK HAS CPU (0): 0x904000 (kupdated):
>  LOWCORE INFO:
>   -psw      : 0x400100180000000 0x0000000007aa22
>   -function : sync_old_buffers+58
>   -prefix   : 0x009c8000
>   -cpu timer: 0xfffffa77 0x33465f80
>   -clock cmp: 0x00b9e503 0x235324f4
>   -general registers:
>      0000000000000000 0x000000002e1000
>      0x0000000007aa22 0x0000000004919e
>      0x00000000907f28 0x0000000022b428
>      0000000000000000 0000000000000000
>      0x00000000224340 0000000000000000
>      0x00000000970000 0x00000000233b00
>      0x00000000904000 0x000000001deb60
>      0x00000000907e78 0x00000000907dd8
> [ .. ]
>  STACK:
>  0 kupdate+424 [0x7af4c]
>  1 arch_kernel_thread+70 [0x18d72]
> ================================================================
> TASK HAS CPU (1): 0x3318000 (reboot):
>  LOWCORE INFO:
>   -psw      : 0x700100180000000 0x0000007ffe0d8e
>   -function : not found in System map
>   -prefix   : 0x009c2000
>   -cpu timer: 0xfff79e2d 0x014244c0
>   -clock cmp: 0x00b9e503 0x3a5d9504
>   -general registers:
>      0x00000000000001 0000000000000000
>      0000000000000000 0000000000000000
>      0x0000000001f268 0000000000000000
>      0x00000000000003 0x000000000002c0
>      0x000000000490f0 0x00000003318000
>      0x00000000016422 0000000000000000
>      0x00000000000001 0x000000001da280
>      0x0000000001f268 0x0000000331bae0
> [ .. ]
>  STACK:
>  0 machine_restart_smp+62 [0x1f5f2]
>  1 machine_restart+48 [0x19884]
>  2 sys_reboot+306 [0x49222]
>  3 sysc_noemu+16 [0x16242]

This can't be the lock_kernel, you see, there's no lock_kernel
invocation at all in the machine_restart_smp path.

> 
> Not sure why CPU#0 wanted to execute kupdate(), but hey ...

kupdate always runs in the background, once every few seconds.

I perfectly see why it hangs on s390, that's a bug in the arch code
and it's unrelated to whatever lock_kernel and even unrelated to the
potential deadlock prone shutdown of cpus that I mentioned in my
previous email:

static void do_machine_restart(void * __unused)
{
	clear_bit(smp_processor_id(), &cpu_restart_map);
	if (smp_processor_id() == 0) {
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

if the `reboot` program doesn't run by luck on cpu 0, it will be the one
that will hang instead of the others. the above check must be changed to:

	smp_processor_id() == reboot_cpu

and you should snapshot reboot_cpu in machine_restart_smp. then it won't
hang anymore.

The x86 code may be safe in hanging in the IPI if it's extremely careful
in not touching any lock that maybe hold by other cpus, between the IPI
delivery and the hard reboot. So probably we don't need to replace the
IPI with a kernel thread in 2.4, despite I find the kernel thread way
more robust.

Overall the lock_kernel I think is _needed_ (not only if something it's
safer), to serialize reboot against reboot and I wouldn't bother
changing it to another spinlock (at least not in 2.4)

Andrea
