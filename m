Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbVKOAws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbVKOAws (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVKOAws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:52:48 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:19939 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932253AbVKOAws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:52:48 -0500
Subject: Re: 2.6.14 X spinning in the kernel
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, hugh@veritas.com
In-Reply-To: <20051114161704.5b918e67.akpm@osdl.org>
References: <1132012281.24066.36.camel@localhost.localdomain>
	 <20051114161704.5b918e67.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 16:52:32 -0800
Message-Id: <1132015952.24066.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 16:17 -0800, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > My 2-cpu EM64T machine started showing this problem again on 2.6.14.
> > On some reboots, X seems to spin in the kernel forever.
> > 
> > sysrq-t output shows nothing.
> > 
> > X             R  running task       0  3607   3589          3903
> > (L-TLB)
> > 
> > top shows:
> >  3607 root      25   0     0    0    0 R 99.1  0.0 262:04.69 X
> > 
> > 
> > So, I wrote a module to do smp_call_function() on all CPUs
> > to show stacks on them. CPU0 seems to be spinning in exit_mmap().
> > I did this multiple times to collect stacks few times.
> > 
> > Is this a known issue ?
> 
> Nope.  Maybe your vma list has a loop in it, in remove_vma()?  slab
> debugging would detect that, due to the repeated
> kmem_cache_free(vm_area_cachep, vma);

I compiled the kernel with slab debug and rebooted the machine.
X seems to be spinning again. But this time, it shows completely
different routines  (and seems to be switching CPUs) :(
Something weird is happening on my machine..

top:
  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3600 root      25   0     0    0    0 R 99.9  0.0   8:29.18 X


CPU0:
ffffffff8053c750 0000000000000000 0000000000000000 0000000000000000
       ffff81011c451000 ffffffff8053c788 ffffffff8026de8f
ffffffff8053c7a8
       ffffffff80119591 ffffffff8053c7a8
Call Trace: <IRQ> <ffffffff8026de8f>{showacpu+47}
<ffffffff80119591>{smp_call_function_interrupt+81}
       <ffffffff8010e968>{call_function_interrupt+132}  <EOI>
<ffffffff880fc60a>{:radeon:radeon_freelist_get+122}
       <ffffffff880fc69d>{:radeon:radeon_freelist_get+269}
       <ffffffff880fc81a>{:radeon:radeon_cp_buffers+314}
<ffffffff880fc6e0>{:radeon:radeon_cp_buffers+0}
       <ffffffff80278b32>{drm_ioctl+386} <ffffffff80199f9d>{do_ioctl
+125}
       <ffffffff8019a272>{vfs_ioctl+690} <ffffffff8019a2fa>{sys_ioctl
+106}
       <ffffffff8010dc9e>{system_call+126}



again,

CPU1:
ffff8100d7f2bf50 0000000000000000 0000000000000000 0000000000000000
       ffff81011c451000 ffff8100d7f2bf88 ffffffff8026de8f
ffff8100d7f2bfa8
       ffffffff80119591 ffff8100d7f2bfa8
Call Trace: <IRQ> <ffffffff8026de8f>{showacpu+47}
<ffffffff80119591>{smp_call_function_interrupt+81}
       <ffffffff8010e968>{call_function_interrupt+132}  <EOI>
<ffffffff8021363a>{__delay+10}
       <ffffffff8021367a>{__const_udelay+42}
<ffffffff880fc69d>{:radeon:radeon_freelist_get+269}
<ffffffff880fc81a>{:radeon:radeon_cp_buffers+314}
<ffffffff880fc6e0>{:radeon:radeon_cp_buffers+0}
       <ffffffff80278b32>{drm_ioctl+386} <ffffffff80199f9d>{do_ioctl
+125}
       <ffffffff8019a272>{vfs_ioctl+690} <ffffffff8019a2fa>{sys_ioctl
+106}
       <ffffffff8010dc9e>{system_call+126}


Then I tried killing it and ran into..

CPU0:
ffffffff8053c750 0000000000000000 00000000000018ff ffff81011c9a4230
       ffff81011c9a4000 ffffffff8053c788 ffffffff8026de8f
ffffffff8053c7a8
       ffffffff80119591 ffffffff8053c7a8
Call Trace: <IRQ> <ffffffff8026de8f>{showacpu+47}
<ffffffff80119591>{smp_call_function_interrupt+81}
       <ffffffff8010e968>{call_function_interrupt+132}  <EOI>
<ffffffff880fa225>{:radeon:radeon_do_wait_for_idle+117}
       <ffffffff880fa236>{:radeon:radeon_do_wait_for_idle+134}
       <ffffffff880fa590>{:radeon:radeon_do_cp_idle+336}
<ffffffff880fc215>{:radeon:radeon_do_release+85}
       <ffffffff88104369>{:radeon:radeon_driver_pretakedown+9}
       <ffffffff802783aa>{drm_takedown+74}
<ffffffff80279733>{drm_release+1267}
       <ffffffff801a0d01>{destroy_inode+81}
<ffffffff801a26a1>{generic_delete_inode+337}
       <ffffffff8019e9f6>{d_free+54} <ffffffff8018655a>{__fput+202}
       <ffffffff80186654>{fput+20} <ffffffff80184b8e>{filp_close+110}
       <ffffffff80138f62>{put_files_struct+130}
<ffffffff80139945>{do_exit+549}
       <ffffffff8012f85d>{try_to_wake_up+1085}
<ffffffff80141682>{recalc_sigpending+18}
       <ffffffff80141dc5>{__dequeue_signal+501}
<ffffffff8013a42d>{do_group_exit+237}
       <ffffffff80143f6b>{get_signal_to_deliver+1419}
<ffffffff8010d09d>{do_signal+125}
       <ffffffff803b84a9>{__up+25}
<ffffffff803bad7b>{.text.lock.kernel_lock+32}
       <ffffffff80199fa5>{do_ioctl+133} <ffffffff8019a272>{vfs_ioctl
+690}
       <ffffffff8010dd27>{sysret_signal+28}
<ffffffff8010d800>{do_notify_resume+48}
       <ffffffff8010e00f>{ptregscall_common+103}


Thanks,
Badari

