Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275334AbTHSE1H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 00:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275342AbTHSE1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 00:27:07 -0400
Received: from waste.org ([209.173.204.2]:36527 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S275334AbTHSE1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 00:27:03 -0400
Date: Mon, 18 Aug 2003 23:26:44 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: akpm@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
Message-ID: <20030819042644.GJ16387@waste.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com> <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org> <20030818140729.2e3b02f2.rddunlap@osdl.org> <20030819001316.GF22433@redhat.com> <20030818171545.5aa630a0.akpm@osdl.org> <32789.4.4.25.4.1061263463.squirrel@www.osdl.org> <20030818203513.393c4a48.akpm@osdl.org> <32829.4.4.25.4.1061264369.squirrel@www.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32829.4.4.25.4.1061264369.squirrel@www.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 08:39:29PM -0700, Randy.Dunlap wrote:
> > "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >>
> >> Debug: sleeping function called with interrupts disabled at
> >>  include/asm/uaccess.h:473
> >
> > OK, now my vague understanding of what's going on is that the app has chosen
> > to disable local interupts (via iopl()) and has taken a vm86 trap.  I guess
> > we'd see the same thing if the app performed some sleeping syscall while
> > interrupts are disabled.
> >
> > If that is correct then it really is just a false positive.
> >
> > It could also point at a bug in the application; it is presumably disabling
> > interrupts for some form of locking, atomicity or timing guarantee.  But it
> > will not lock against other CPUs and the fact that it trapped into the
> > kernel indicates tat it may not be getting the atomicity which it desires.
> 
> Call Trace:
>  [<c0120d93>] __might_sleep+0x53/0x74
>  [<c010d001>] save_v86_state+0x71/0x1f0
>  [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
>  [<c019cac8>] ext3_file_write+0x28/0xc0
>  [<c011cd96>] __change_page_attr+0x26/0x220
>  [<c010b310>] do_general_protection+0x0/0x90
>  [<c010a69d>] error_code+0x2d/0x40
>  [<c0109657>] syscall_call+0x7/0xb
> 
> My (more) vague understanding is that X(?) got the kernel to
> do_general_protection() somehow, but change_page_attr() does this:
> 	spin_lock_irqsave(&cpa_lock, flags);
> in arch/i386/mm/pageattr.c (I'm on a UP box),
> so irqs are disabled by the kernel and then we calls put_user()
> with a spinlock held.

My suspicion is that the X driver (MGA, right?) copies its BIOS into
its address space, sets up io permissions for it to fiddle with your
card, and then calls sys_vm86 with the appropriate registers to call
into the interrupt handler when sys_vm86 swaps those registers in and
does "jmp resume_userspace". When the video BIOS software interrupt
handler does iret, we get the fault, copy the registers to our 32-bit
usermode (tripping might_sleep), and then swap the 32-bit registers
back in for another jump to resume_userspace.

The fix is making return_to_32_bit return back to the end of
do_sys_vm86 rather than straight to userspace, at which point we can
safely handle the registers.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
