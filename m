Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTJPHXE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 03:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262736AbTJPHXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 03:23:03 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:63872
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262723AbTJPHXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 03:23:01 -0400
Date: Thu, 16 Oct 2003 03:22:35 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][2.6] Fix 4G/4G and WP test lockup
Message-ID: <Pine.LNX.4.53.0310160244150.2328@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,
	It looks like when we do the WP test and trigger a 
(write) protection fault, the 4G/4G page fault handling path doesn't 
expect this kind of fault and instead results in recursive fault handling 
(or so it appears).

How does the following look?

Index: linux-2.6.0-test7-mm1/arch/i386/mm/fault.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test7-mm1/arch/i386/mm/fault.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 fault.c
--- linux-2.6.0-test7-mm1/arch/i386/mm/fault.c	15 Oct 2003 09:01:14 -0000	1.1.1.1
+++ linux-2.6.0-test7-mm1/arch/i386/mm/fault.c	16 Oct 2003 06:42:42 -0000
@@ -260,8 +260,12 @@ asmlinkage void do_page_fault(struct pt_
 	/*
 	 * On 4/4 all kernels faults are either bugs, vmalloc or prefetch
 	 */
-	if (unlikely((regs->xcs & 3) == 0))
+	if (unlikely((regs->xcs & 3) == 0)) {
+		if (error_code & 3)
+			goto bad_area_nosemaphore;
+
  		goto vmalloc_fault;
+	}
 #else
 	if (unlikely(address >= TASK_SIZE)) { 
 		if (!(error_code & 5))
