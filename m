Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWCYBYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWCYBYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbWCYBYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:24:37 -0500
Received: from fmr20.intel.com ([134.134.136.19]:32163 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751456AbWCYBYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:24:36 -0500
Message-Id: <200603250124.k2P1OKg21526@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Mark Rustad'" <mrustad@mac.com>, "'Andrew Morton'" <akpm@osdl.org>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.16 hugetlbfs problem - DEBUG_PAGEALLOC
Date: Fri, 24 Mar 2006 17:24:41 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZPa7BGCRiOwyfSTbOGGRG2UBdFjwAO0q6A
In-Reply-To: <C53A96CB-5B11-4BF3-879E-CF7B91E1BFEC@mac.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rustad wrote on Friday, March 24, 2006 9:52 AM
> I have narrowed this down to DEBUG_PAGEALLOC. If that option is  
> enabled, attempts to reference areas mmap-ed from hugetlbfs files  
> fault forever. You can see that I had that set in the failing config  
> I reported below.

Yeah, it turns out that the debug option is not compatible with hugetlb
page support. That debug option turns off PSE. Once it is turned off in
CR4, cpu will ignore pse bit in the pmd and causing infinite page-not-
present fault :-(

void __init early_cpu_init(void)
{ ...

#ifdef CONFIG_DEBUG_PAGEALLOC
        /* pse is not compatible with on-the-fly unmapping,
         * disable it even if the cpus claim to support it.
         */
        clear_bit(X86_FEATURE_PSE, boot_cpu_data.x86_capability);
        disable_pse = 1;
#endif


[patch] mark DEBUG_PAGEALLOC to be mutually exclusive option with
        HUGETLBFS.  Bug found by Mark Rustad.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>


--- ./arch/i386/Kconfig.debug.orig	2006-03-24 17:50:39.000000000 -0800
+++ ./arch/i386/Kconfig.debug	2006-03-24 17:50:58.000000000 -0800
@@ -36,7 +36,7 @@
 
 config DEBUG_PAGEALLOC
 	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL && !SOFTWARE_SUSPEND
+	depends on DEBUG_KERNEL && !SOFTWARE_SUSPEND && !HUGETLBFS
 	help
 	  Unmap pages from the kernel linear mapping after free_pages().
 	  This results in a large slowdown, but helps to find certain types


