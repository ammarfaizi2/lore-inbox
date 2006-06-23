Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161467AbWFWAgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbWFWAgk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 20:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161470AbWFWAgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 20:36:40 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:34526 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161467AbWFWAgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 20:36:39 -0400
Date: Thu, 22 Jun 2006 20:33:04 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] x86_64: enlarge window for stack growth
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606222035_MC3-1-C33B-4A7F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow stack growth so the 'enter' instruction works.  Also
fixes problem in compat_sys_kexec_load() which could allocate
more than 128 bytes using compat_alloc_user_space().

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-rc6-64.orig/arch/x86_64/mm/fault.c
+++ 2.6.17-rc6-64/arch/x86_64/mm/fault.c
@@ -410,8 +410,10 @@ asmlinkage void __kprobes do_page_fault(
 	if (!(vma->vm_flags & VM_GROWSDOWN))
 		goto bad_area;
 	if (error_code & 4) {
-		// XXX: align red zone size with ABI 
-		if (address + 128 < regs->rsp)
+		/* Allow userspace just enough access below the stack pointer
+		 * to let the 'enter' instruction work.
+		 */
+		if (address + 65536 + 32 * sizeof(unsigned long) < regs->rsp)
 			goto bad_area;
 	}
 	if (expand_stack(vma, address))
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
