Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTKOTf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 14:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTKOTf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 14:35:26 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:47490
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261930AbTKOTfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 14:35:20 -0500
Date: Sat, 15 Nov 2003 14:34:08 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311141954160.27998@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0311151427080.30079@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311141344290.5877-100000@home.osdl.org>
 <Pine.LNX.4.53.0311141954160.27998@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 4G/4G page fault handling path doesn't appear to handle faults 
happening whilst in vm86. The regs->xcs != __USER_CS so it confused the in 
kernel test.

However i'm still debugging the X11 triple fault in test9-mm3

Unable to handle kernel paging request at virtual address 00002000
 printing eip:
00007341
*pde = 00000000
Oops: 0004 [#1]
SMP DEBUG_PAGEALLOC
CPU:    0
EIP:    c000:[<00007341>]    Not tainted VLI
EFLAGS: 00033246
EIP is at 0x7341
eax: 32454256   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00002000   ebp: 00000fd6   esp: 087bbf24
ds: 0000   es: 0000   ss: 0068
Process X (pid: 939, threadinfo=087ba000 task=0891c690)
Stack: 00000fcb 00000100 00000000 0000c000 00000000 00000000 00000000 00000000
       00000005 ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
       ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
Call Trace:

Index: linux-2.6.0-test9-mm3/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm3/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fault.c
--- linux-2.6.0-test9-mm3/arch/i386/mm/fault.c	13 Nov 2003 08:07:17 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm3/arch/i386/mm/fault.c	15 Nov 2003 19:08:34 -0000
@@ -264,7 +264,9 @@ asmlinkage void do_page_fault(struct pt_
 		if (error_code & 3)
 			goto bad_area_nosemaphore;
 
- 		goto vmalloc_fault;
+		/* If it's vm86 fall through */
+		if (!(error_code & 4))
+			goto vmalloc_fault;
 	}
 #else
 	if (unlikely(address >= TASK_SIZE)) { 
