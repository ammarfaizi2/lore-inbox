Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262587AbUKEEVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262587AbUKEEVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 23:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUKEEVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 23:21:23 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:54998 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262587AbUKEEVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 23:21:12 -0500
Date: Fri, 5 Nov 2004 05:20:54 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
Message-ID: <20041105042053.GK8229@dualathlon.random>
References: <20041103022606.GI3571@dualathlon.random> <418846E9.1060906@us.ibm.com> <20041103030558.GK3571@dualathlon.random> <1099612923.1022.10.camel@localhost> <1099615248.5819.0.camel@localhost> <20041105005344.GG8229@dualathlon.random> <1099619740.5819.65.camel@localhost> <20041105020831.GI8229@dualathlon.random> <1099621391.5819.72.camel@localhost> <20041105040308.GJ8229@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105040308.GJ8229@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 05:03:08AM +0100, Andrea Arcangeli wrote:
> doing. I believe my code would now fall apart even if you were using it
> with PSE disabled (nopentium or something). So I've to fix that bit at

ah no pse disabled was working fine thanks to the cpu_has_pse (I even
already considered that case while doing the patch), only 4k pages setup
at boot time would screw it up and frankly there's no good reason at all
that such 4k pages should exist at all. However adding the reserved
check won't make the code more robust. This way I don't need to drop the
memleak detector from the code (there was a true gigantic memleak in
that code that was triggering in the common case, and it got hidden just
to let those 4k pages pass through).

The only reason to set the page_count 0 on bootmem is to crash on
put_page, nobody should ever care about the page_count of bootmem
memory. bootmem memory will be PageReserved, that is the only thing I'd
like to relay on.

So I believe this is the right fix to make the change_page_attr aware
about all kind of pagetables that might be mapping the direct mapping.
This is really what the code should be doing, since we've to reconstruct
a largepage and drop the pte only if the pte itself was not-reserved. We
shouldn't mess 4k pages instantiated at boot time.

--- sles/arch/i386/mm/pageattr.c.~1~	2004-11-05 02:36:42.000000000 +0100
+++ sles/arch/i386/mm/pageattr.c	2004-11-05 05:18:27.216553680 +0100
@@ -129,13 +129,15 @@ __change_page_attr(struct page *page, pg
 	} else
 		BUG();
 
-	/* memleak and potential failed 2M page regeneration */
-	BUG_ON(!page_count(kpte_page));
-
-	if (cpu_has_pse && (page_count(kpte_page) == 1)) {
-		list_add(&kpte_page->lru, &df_list);
-		revert_page(kpte_page, address);
-	} 
+	if (!PageReserved(kpte_page)) {
+		/* memleak and potential failed 2M page regeneration */
+		BUG_ON(!page_count(kpte_page));
+
+		if (cpu_has_pse && (page_count(kpte_page) == 1)) {
+			list_add(&kpte_page->lru, &df_list);
+			revert_page(kpte_page, address);
+		}
+	}
 	return 0;
 } 
 
I'll prepare a new complete patch against mainline for Andrew with some
more comment (only the pageattr.c part, the ioremap.c was already fine).

next things to do for the longer term:

1) fix this remaining oops with the debug knob enabled ;) (this is
unrelated to change_page_attr)

Unable to handle kernel paging request at virtual address c04c1a6e
 printing eip:
c04c1a6e
*pde = 0053b027
*pte = 004c1000
Oops: 0000 [#1]
SMP DEBUG_PAGEALLOC
CPU:    2
EIP:    0060:[<c04c1a6e>]    Not tainted
EFLAGS: 00013287   (2.6.5-0-andrea )
EIP is at mp_find_ioapic+0x0/0x53
eax: 00000016   ebx: 00000016   ecx: 00000001   edx: 00000001
esi: 00000001   edi: 00000016   ebp: 00000016   esp: f7fc1e60
ds: 007b   es: 007b   ss: 0068
Process X (pid: 2153, threadinfo=f7fc0000 task=f7fc21f0)
Stack: c0115a6f c03da597 00000000 f7e29000 c025cfc6 00000001 00000001
00000016
       00000001 00000001 00000016 c01130d0 00000016 00000016 f7e29000
f7fc1eb8
       00000016 c0265ae3 00000002 00000001 00000001 00e29000 00400000
c03da600
Call Trace:
 [<c0115a6f>] mp_register_gsi+0x23/0x114
 [<c025cfc6>] acpi_ut_value_exit+0x30/0x3b
 [<c01130d0>] acpi_register_gsi+0x71/0x85
 [<c0265ae3>] acpi_pci_irq_enable+0x2fd/0x36e
 [<c032a29d>] pcibios_enable_device+0x14/0x18
 [<c0235ee1>] pci_enable_device_bars+0x16/0x22
 [<c028e477>] radeon_irq_busid+0x74/0x16c
 [<c028e403>] radeon_irq_busid+0x0/0x16c
 [<c0106403>] sys_get_thread_area+0xfa/0x139
 [<c0287e8a>] radeon_ioctl+0xfd/0x125
 [<c015a645>] vfs_write+0xa5/0xfc
 [<c0106403>] sys_get_thread_area+0xfa/0x139
 [<c016be6c>] sys_ioctl+0x2cc/0x492
 [<c015a868>] sys_write+0x85/0xc6
 [<c0106403>] sys_get_thread_area+0xfa/0x139
 [<c0107f9f>] syscall_call+0x7/0xb
 [<c0106403>] sys_get_thread_area+0xfa/0x139

Code:  Bad EIP value.

2) drop those 4k pages from the first few megs of ram that just hurt
performance and waste ram (I guess the main problem is that this is in
strict talk with head.S, and the only communication between head.S and
the C code so far was to check the contents of each pgd and not to touch
what was not-null IIRC)
