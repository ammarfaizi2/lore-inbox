Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbWGYTZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbWGYTZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWGYTZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:25:15 -0400
Received: from liaag2ad.mx.compuserve.com ([149.174.40.155]:56723 "EHLO
	liaag2ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964836AbWGYTZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:25:14 -0400
Date: Tue, 25 Jul 2006 15:19:49 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386 TIF flags for debug regs and io bitmap in
  ctxsw (v2)
To: Stephane Eranian <eranian@hpl.hp.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Message-ID: <200607251522_MC3-1-C616-70EB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060725055439.GA18053@frankl.hpl.hp.com>

On Mon, 24 Jul 2006 22:54:39 -0700, Stephane Eranian wrote:
>
> I would like to follow-up the TIF flags and especially on the
> rules of inheritance. It appears the TIF flags are copied from
> parent to child task systematically on copy_process.
> Then they are adjusted in copy_threads() or sub-functions.
> 
> The TIF_IO_BITMAP is checked in copy_threads() with the following code:
> 
> int copy_thread(int nr, unsigned long clone_flags, unsigned long esp,
>       unsigned long unused,
>       struct task_struct * p, struct pt_regs * regs)
> {
>       ....
>       if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
>               p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
>               if (!p->thread.io_bitmap_ptr) {
>                       p->thread.io_bitmap_max = 0;
>                       return -ENOMEM;
>               }
>               memcpy(p->thread.io_bitmap_ptr, tsk->thread.io_bitmap_ptr,
>                       IO_BITMAP_BYTES);
>               set_tsk_thread_flag(p, TIF_IO_BITMAP);
>       }
> 
> I would think that the set_tsk_thread_flag() is extraneous.
> 

Yeah.  But harmless.

> As for TIF_DEBUG, my patch is not clearing it. I don't think you can
> have HW breakpoints be inherited from one task to the other.

Looks like the debug regs get copied on fork and only cleared on exec
in flush_thread().  So this should be OK.  Please doublecheck.

(The new TIF_DEBUG flag went into 2.8.18-rc, in case you didn't notice.)

-- 
Chuck

