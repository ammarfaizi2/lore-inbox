Return-Path: <linux-kernel-owner+w=401wt.eu-S1422704AbXAETl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422704AbXAETl2 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 14:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbXAETl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 14:41:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:52290 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422703AbXAETl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 14:41:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c1GRxRFwp8xrYuBplsd+eKEYO4akOyFHgFw8fbUOt8s3Pl+lz8jqVvEF7+MuuytO+Xwy+I9H/OrF+PcnELOYezp54diLKAgvePDqeV1kQgnBKrKgLyib6/03ER1CtH2W+809tBA54LiJoecYJraNxU7qjLcsGKRFYn6+Za3IBNM=
Message-ID: <5157576d0701051141l3591040dw8e62359a011c94a7@mail.gmail.com>
Date: Fri, 5 Jan 2007 22:41:25 +0300
From: "Tomasz Kvarsin" <kvarsin@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [BUG] 2.6.20-rc3-mm1: can not mount root
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <20070105104927.b2dfd2d7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5157576d0701050620l14fd0a6emdf5793c5214931a8@mail.gmail.com>
	 <20070105104927.b2dfd2d7.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/07, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 5 Jan 2007 17:20:38 +0300
> "Tomasz Kvarsin" <kvarsin@gmail.com> wrote:
>
> > I can not boot machine with 2.6.20-rc3-mm1 and  2.6.20-rc2-mm1.
> > I made binary search, patch bellow cause this bug:
> > $quilt top
> > patches/sched-improve-sched_clock-on-i686.patch
> >
> > backtrace which I got by connecting "gdb" to machine:
>
> How did you manage to use gdb on an i386 kernel?  Using qemu or something?
>

Yes, I use qemu.

> > _raw_spin_lock (lock=0xc06c0c60) at lib/spinlock_debug.c:108
> > 108                     for (i = 0; i < loops; i++) {
> > (gdb) bt
> > #0  _raw_spin_lock (lock=0xc06c0c60) at lib/spinlock_debug.c:108
> > #1  0xc056ac42 in _spin_lock (lock=0xc06c0c60) at kernel/spinlock.c:182
> > #2  0xc011c3bb in vprintk (fmt=0xc0649c00 "<0>BUG: spinlock %s on
> > CPU#%d, %s/%d\n",
> >     args=0xc1167a84 "") at kernel/printk.c:534
> > #3  0xc011c6c7 in printk (fmt=0xc0649c00 "<0>BUG: spinlock %s on
> > CPU#%d, %s/%d\n")
> >     at kernel/printk.c:508
> > #4  0xc027be42 in spin_bug (lock=0xc06c0c60, msg=0xc065fc00
> > "recursion") at lib/spinlock_debug.c:61
> > #5  0xc027c178 in _raw_spin_lock (lock=0xc06c0c60) at lib/spinlock_debug.c:79
> > #6  0xc056ac42 in _spin_lock (lock=0xc06c0c60) at kernel/spinlock.c:182
> > #7  0xc011c3bb in vprintk (fmt=0xc0626ed0 "<1>BUG: unable to handle
> > kernel paging request",
> >     args=0xc1167b8c "") at kernel/printk.c:534
> > #8  0xc011c6c7 in printk (fmt=0xc0626ed0 "<1>BUG: unable to handle
> > kernel paging request")
> >     at kernel/printk.c:508
> > #9  0xc0116de4 in do_page_fault (regs=0xc1167bcc, error_code=0) at
> > arch/i386/mm/fault.c:555
> > #10 0xc056b11c in page_fault ()
> > #11 0xc0808160 in ?? ()
> > #12 0xc0626ed0 in kallsyms_token_index ()
> > #13 0xc1167cac in ?? ()
> > #14 0x00000001 in ?? ()
> > #15 0xc0808163 in printk_buf.19225 ()
> > #16 0xc1167c0c in ?? ()
> > #17 0x00000000 in ?? ()
>
> It looks like the machine was trying to oops, only it gets stuck on
> logbuf_lock.  Perhaps it hit an oops while running printk_clock() inside
> vprintk() then tried to go recursive.
>
> oopses while holding logbuf_lock are rare, and appear to be fatal.  Perhaps
> we should ignore logbuf_lock if oops_in_progress, but the chances are we'll
> just hit the same oops again..
>
> Do you have "time" on the kernel boot command line?  If so, does removing
> that option make the hang go away?
>

No, I have no "time" option,
I use grub, the config looks like:
kernel /boot/kernel root=/dev/hda1 init=/linuxrc
