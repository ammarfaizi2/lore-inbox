Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTKOT4c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 14:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTKOT4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 14:56:31 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:7554
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261956AbTKOTzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 14:55:06 -0500
Date: Sat, 15 Nov 2003 14:52:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH][2.6-mm] Fix 4G/4G X11/vm86 oops
In-Reply-To: <Pine.LNX.4.53.0311151427080.30079@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0311151447350.30079@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0311141344290.5877-100000@home.osdl.org>
 <Pine.LNX.4.53.0311141954160.27998@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0311151427080.30079@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003, Zwane Mwaikambo wrote:

> The 4G/4G page fault handling path doesn't appear to handle faults 
> happening whilst in vm86. The regs->xcs != __USER_CS so it confused the in 
> kernel test.

Perhaps this would be more desirable?

Index: linux-2.6.0-test9-mm3/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm3/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fault.c
--- linux-2.6.0-test9-mm3/arch/i386/mm/fault.c	13 Nov 2003 08:07:17 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm3/arch/i386/mm/fault.c	15 Nov 2003 19:40:17 -0000
@@ -264,7 +264,9 @@ asmlinkage void do_page_fault(struct pt_
 		if (error_code & 3)
 			goto bad_area_nosemaphore;
 
- 		goto vmalloc_fault;
+		/* If it's vm86 fall through */
+		if (!(regs->eflags & VM_MASK))
+			goto vmalloc_fault;
 	}
 #else
 	if (unlikely(address >= TASK_SIZE)) { 
