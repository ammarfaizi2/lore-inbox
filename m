Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267168AbUHRPLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267168AbUHRPLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 11:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266919AbUHRPKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 11:10:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30642 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266898AbUHRPKk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 11:10:40 -0400
Date: Wed, 18 Aug 2004 20:42:40 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: paulus@samba.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: Fix v_regs pointer setup
Message-ID: <20040818151240.GB9524@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

During some signal test, we found that v_regs pointer was not setup correctly.
v_regs was made to point to itself, as a result of which the pointer was
corrupted when vec registers were copied over. When the signal handler
returned, restore_sigcontext tried derefering the invalid pointer and in
the process killed the app with SIGSEGV.

Following patch should fix it. Please review and apply:


Signed-off-by: Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.8.1-vatsa/arch/ppc64/kernel/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc64/kernel/signal.c~signal_fix arch/ppc64/kernel/signal.c
--- linux-2.6.8.1/arch/ppc64/kernel/signal.c~signal_fix	2004-08-18 20:30:23.000000000 +0530
+++ linux-2.6.8.1-vatsa/arch/ppc64/kernel/signal.c	2004-08-18 20:31:35.000000000 +0530
@@ -127,7 +127,7 @@ static long setup_sigcontext(struct sigc
 	 * v_regs pointer or not
 	 */
 #ifdef CONFIG_ALTIVEC
-	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve) & ~0xful);
+	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve + 16) & ~0xful);
 #endif
 	long err = 0;
 

_

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
