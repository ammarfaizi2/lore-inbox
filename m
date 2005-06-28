Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVF1WSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVF1WSB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbVF1WQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:16:35 -0400
Received: from mtaout5.barak.net.il ([212.150.49.175]:11693 "EHLO
	mtaout5.barak.net.il") by vger.kernel.org with ESMTP
	id S261436AbVF1WOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:14:23 -0400
Date: Wed, 29 Jun 2005 01:18:55 +0300
From: eliad lubovsky <eliadl@013.net>
Subject: Handle kernel page faults using task gate
To: linux-kernel@vger.kernel.org
Message-id: <1119997135.4074.106.camel@localhost.localdomain>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2)
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to handle page faults exceptions in the kernel using the
task gate mechanism. I succeeded to transfer the execution to my page
fault handler using a new TSS and updates to the GDT and IDT tables
(similar to the double fault mechanism in 2.6). After handling the fault
and allocating the physical page I use the iret instruction to switch
back to the previous task. The problem is that I got a double fault with
the same address that cause the fault (although the physical page is
allocated and mapped). Any clues?

The new page fault TSS:
struct tss_struct pagefault_tss __cacheline_aligned = {
        .esp0           = STACK_START,
        .ss0            = __KERNEL_DS,
        .ldt            = 0,
        .io_bitmap_base = INVALID_IO_BITMAP_OFFSET,
                                                     
        .eip            = (unsigned long) pagefault_fn,
        .eflags         = X86_EFLAGS_SF|0x2,/* 0x2 bit is always set */
        .esp            = STACK_START,
        .es             = __USER_DS,
        .cs             = __KERNEL_CS,
        .ss             = __KERNEL_DS,
        .ds             = __USER_DS,
                                                      
        .__cr3          = __pa(swapper_pg_dir)
};


