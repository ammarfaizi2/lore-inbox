Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757173AbWKVXlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbWKVXlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 18:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbWKVXlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 18:41:14 -0500
Received: from junsun.net ([66.29.16.26]:1032 "EHLO junsun.net")
	by vger.kernel.org with ESMTP id S1757173AbWKVXlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 18:41:14 -0500
Date: Wed, 22 Nov 2006 15:41:11 -0800
From: Jun Sun <jsun@junsun.net>
To: linux-kernel@vger.kernel.org
Subject: failed 'ljmp' in linear addressing mode
Message-ID: <20061122234111.GA8499@srv.junsun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am plowing along as I am learning about the in'n'outs about i386.  I am
totally stuck on this one.  I would appreciate any help.

As you can see, the function turns off paging mode (of course it
runs from identically mapped page) and tries to jump to an absolute
address at 0x10000000.  It appears the machine would reboot when running
"ljmp" instruction.

Any pointers?

I was not too certain about the %cs, %ds business and did quite 
a few experiments with different values but with no luck.

Thanks in advance.

Jun

--------------------------

/* [JSUN] we will map this page into identity mapping before execution */
        .align  4096
ENTRY(do_os_switching)
	/* interrupt is disabled! */

        /* the black magic, some copied form relocate_new_kernel, JSUN */
        /* Set cr0 to a known state:
         * 31 0 == Paging disabled
         * 18 0 == Alignment check disabled
         * 16 0 == Write protect disabled
         * 3  0 == No task switch
         * 2  0 == Don't do FP software emulation.
         * 0  1 == Proctected mode enabled
         */

        movl    %cr0, %eax
        andl    $~((1<<31)|(1<<18)|(1<<16)|(1<<3)|(1<<2)), %eax
        orl     $(1<<0), %eax
        movl    %eax, %cr0


        /* JSUN, 0x11 was the boot up value for cr0.
        movl    $0x11, %eax
        movl    %eax, %cr0
        */

        /* clear cr4 */
        movl    $0, %eax
        movl    %eax, %cr4

	/* why this? */
        jmp     1f
1:

        /* clear cr3, flush TLB */
        movl    $0, %eax
        movl    %eax, %cr3

        /*
        movl    $(__KERNEL_DS),%eax
        movl    %eax,%ds
        movl    %eax,%es
        movl    %eax,%fs
        movl    %eax,%gs
        movl    %eax,%ss
        */

        ljmp    $(__KERNEL_CS), $0x10000000

