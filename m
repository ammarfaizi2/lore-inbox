Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTKQVLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbTKQVLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:11:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:13238 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261744AbTKQVL1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:11:27 -0500
Date: Mon, 17 Nov 2003 13:11:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: alpha@steudten.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-alpha@vger.kernel.org
Subject: Re: BUG: Kernel Panic: kernel-2.6.0-test9-bk21  for alpha in scsi
 context ll_rw_blk.c
Message-Id: <20031117131145.07266f43.akpm@osdl.org>
In-Reply-To: <3FB92938.8040906@steudten.com>
References: <3FB92938.8040906@steudten.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Steudten <alpha@steudten.com> wrote:
>
> In ./drivers/block/ll_rw_blk.c __make_request:2021
>     2021         spin_lock_prefetch(q->queue_lock);
>     2022
>     2023         barrier = test_bit(BIO_RW_BARRIER, &bio->bi_rw);
>     2024
>     2025         ra = bio->bi_rw & (1 << BIO_RW_AHEAD);
> 
> 
>      3338:       00 00 e3 8b     lds     $f31,0(t2)
> 
> processor.h:94
> extern inline void spin_lock_prefetch(const void *ptr)
> {
>          __builtin_prefetch(ptr, 1, 3);
> }
> 
> So q->queue_lock isn´t aligned for alpha - or q isn´t valid.

The spinlock is aligned OK.  Could you add this patch so we can see
a bit more context?

diff -puN arch/alpha/kernel/traps.c~alpha-stack-dump arch/alpha/kernel/traps.c
--- 25/arch/alpha/kernel/traps.c~alpha-stack-dump	Mon Nov 17 13:10:21 2003
+++ 25-akpm/arch/alpha/kernel/traps.c	Mon Nov 17 13:10:30 2003
@@ -636,6 +636,7 @@ do_entUna(void * va, unsigned long opcod
 	lock_kernel();
 	printk("Bad unaligned kernel access at %016lx: %p %lx %ld\n",
 		pc, va, opcode, reg);
+	dump_stack();
 	do_exit(SIGSEGV);
 
 got_exception:

_

