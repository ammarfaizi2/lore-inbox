Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVKOBad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVKOBad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVKOBad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:30:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932179AbVKOBac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:30:32 -0500
Date: Mon, 14 Nov 2005 17:30:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com,
       Dave Airlie <airlied@linux.ie>
Subject: Re: 2.6.14 X spinning in the kernel
Message-Id: <20051114173037.286db0d4.akpm@osdl.org>
In-Reply-To: <1132015952.24066.45.camel@localhost.localdomain>
References: <1132012281.24066.36.camel@localhost.localdomain>
	<20051114161704.5b918e67.akpm@osdl.org>
	<1132015952.24066.45.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> On Mon, 2005-11-14 at 16:17 -0800, Andrew Morton wrote:
> > Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > >
> > > My 2-cpu EM64T machine started showing this problem again on 2.6.14.
> > > On some reboots, X seems to spin in the kernel forever.
> > > 
> > > sysrq-t output shows nothing.
> > > 
> > > X             R  running task       0  3607   3589          3903
> > > (L-TLB)
> > > 
> > > top shows:
> > >  3607 root      25   0     0    0    0 R 99.1  0.0 262:04.69 X
> > > 
> > > 
> > > So, I wrote a module to do smp_call_function() on all CPUs
> > > to show stacks on them. CPU0 seems to be spinning in exit_mmap().
> > > I did this multiple times to collect stacks few times.
> > > 
> > > Is this a known issue ?
> > 
> > Nope.  Maybe your vma list has a loop in it, in remove_vma()?  slab
> > debugging would detect that, due to the repeated
> > kmem_cache_free(vm_area_cachep, vma);
> 
> I compiled the kernel with slab debug and rebooted the machine.
> X seems to be spinning again. But this time, it shows completely
> different routines  (and seems to be switching CPUs) :(
> Something weird is happening on my machine..
> 
> top:
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>  3600 root      25   0     0    0    0 R 99.9  0.0   8:29.18 X
> 
> 
> ...
> 
> Then I tried killing it and ran into..
> 
> CPU0:
> ffffffff8053c750 0000000000000000 00000000000018ff ffff81011c9a4230
>        ffff81011c9a4000 ffffffff8053c788 ffffffff8026de8f
> ffffffff8053c7a8
>        ffffffff80119591 ffffffff8053c7a8
> Call Trace: <IRQ> <ffffffff8026de8f>{showacpu+47}
> <ffffffff80119591>{smp_call_function_interrupt+81}
>        <ffffffff8010e968>{call_function_interrupt+132}  <EOI>
> <ffffffff880fa225>{:radeon:radeon_do_wait_for_idle+117}
>        <ffffffff880fa236>{:radeon:radeon_do_wait_for_idle+134}
>        <ffffffff880fa590>{:radeon:radeon_do_cp_idle+336}
> <ffffffff880fc215>{:radeon:radeon_do_release+85}
>        <ffffffff88104369>{:radeon:radeon_driver_pretakedown+9}
>        <ffffffff802783aa>{drm_takedown+74}

ah-hah.  We've had machines stuck in radeon_do_wait_for_idle() before.  In
fact, my workstation was doing it a year or two back.

Are you able to identify the most recent kernel which didn't do this?

David, is there a common cause for this?  ISTR that it's a semi-FAQ.
