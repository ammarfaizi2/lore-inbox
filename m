Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261958AbTCZTMX>; Wed, 26 Mar 2003 14:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261967AbTCZTMX>; Wed, 26 Mar 2003 14:12:23 -0500
Received: from amdext2.amd.com ([163.181.251.1]:51926 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id <S261958AbTCZTMV>;
	Wed, 26 Mar 2003 14:12:21 -0500
X-Server-Uuid: BB5E7757-34FD-4146-B9CC-0950D472AE87
Message-ID: <99F2150714F93F448942F9A9F112634CA54B3A@txexmtae.amd.com>
From: ravikumar.chakaravarthy@amd.com
To: linux-kernel@vger.kernel.org
Subject: Unable to turn paging on!!
Date: Wed, 26 Mar 2003 13:23:17 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 129F21AD1460981-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tweaked the kernel and boot loader to load the kernel at 0xdf000000, physical address. I did the following changes to setup the initial page table.

However during boot, in arch/i386/kernel/head.S when the paging bit is set 
       movl %eax,%cr0          /* ..and set paging (PG) bit */

My computer hangs!!

Any idea why??

  -Ravi



.org 0x1000
ENTRY(swapper_pg_dir)
        .fill 0x37c,4,0
        .long 0xdf002007
        .long 0xdf003007
        .fill 0x2,4,0
        /* default: 766 entries */
        .long 0xdf002007
        .long 0xdf003007
        /* default: 254 entries */
        .fill 0x7e,4,0

/*
 * The page tables are initialized to only 8MB here - the final page
 * tables are set up later depending on memory size.
 */
.org 0x2000
ENTRY(pg0)

.org 0x3000
ENTRY(pg1)




Arch/i386/kernel/head.S

/*
 * Initialize page tables
 */
        movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
        movl $007,%eax          /* "007" doesn't mean with right to kill, but
                                   PRESENT+RW+USER */
        addl $0xdf000000,%eax
2:      stosl
        add $0x1000,%eax
        cmp $empty_zero_page-__PAGE_OFFSET,%edi
        jne 2b

/*
 * Enable paging
 */
3:
        movl $swapper_pg_dir-__PAGE_OFFSET,%eax
        movl %eax,%cr3          /* set the page table pointer.. */
        movl %cr0,%eax
        orl $0x80000000,%eax
        movl %eax,%cr0          /* ..and set paging (PG) bit */  ----------------  Fails here
        jmp 1f                  /* flush the prefetch-queue */





