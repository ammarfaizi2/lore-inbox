Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUG0WAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUG0WAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266655AbUG0WAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:00:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:57994 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266654AbUG0WAp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:00:45 -0400
Subject: Use of __pa() with CONFIG_NONLINEAR
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-mm <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1090965630.15847.575.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 27 Jul 2004 15:00:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, for CONFIG_NONLINEAR, we introduce a new indirection layer for
virtual to physical conversions (and the inverse as well).  Our
implementation uses some data structures to do this (patch is here:
http://lwn.net/Articles/79124/), and the side-effect is that we can't
use __pa() or __va() until after the initialization has run, which is
early in setup_arch().

But, there are quite a few things that obviously need physical addresses
earlier than that, such as cr3 initialization at compile-time.  So, in
Dave McCracken's patch, he introduced a new function: __boot_pa() that
does what the old __pa() did.

This is the largest and hardest to maintain part of the CONFIG_NONLINEAR
patch at this point, and I'd love to start merging bits of it back in. 
Would anybody object to a patch that just does this for a bunch of
architectures?

--- include/asm-i386/page.h.orig	2004-07-27 14:31:09.000000000 -0700
+++ include/asm-i386/page.h	2004-07-27 14:31:36.000000000 -0700
@@ -128,8 +128,10 @@ static __inline__ int get_order(unsigned
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
 #define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
-#define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
+#define __boot_pa(x)		((unsigned long)(x)-PAGE_OFFSET)
+#define __boot_va(x)		((void *)((unsigned long)(x)+PAGE_OFFSET))
+#define __pa(x)			__boot_pa(x)
+#define __va(x)			__boot_va(x)
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 #ifndef CONFIG_DISCONTIGMEM
 #define pfn_to_page(pfn)	(mem_map + (pfn))

We will, of course be overriding __{v,p}a() for any architectures that
we do nonlinear with, later on.

The only other thing I can think of is to make __pa() effectively the
boot-time, simple one, and make virt_to_phys() the more sophisticated
one that we override with nonlinear.  But, some architectures '#define
__pa() virt_to_phys()', while others do the opposite, so that approach
could be significantly more work.  

Does anybody really remember what the different between the __{p,v}a()
functions and the virt_to_phys() ones is supposed to be?

-- Dave

