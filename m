Return-Path: <linux-kernel-owner+w=401wt.eu-S1751920AbWLSOCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWLSOCS (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWLSOCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:02:18 -0500
Received: from fgwmail8.fujitsu.co.jp ([192.51.44.38]:43563 "EHLO
	fgwmail8.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751920AbWLSOCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:02:17 -0500
X-Greylist: delayed 1156 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Dec 2006 09:02:16 EST
Date: Tue, 19 Dec 2006 22:41:30 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Andi Kleen <ak@suse.de>
Subject: [Patch]compile error of register_memory()
Cc: bibo.mao@intel.com, Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20061219222812.683D.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.27 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

register_memory() becomes double definition in 2.6.20-rc1.
It is defined in arch/i386/kernel/setup.c as static definition in
2.6.19.  But it is moved to arch/i386/kernel/e820.c in 2.6.20-rc1.
And same name function is defined in driver/base/memory.c too.
So, it becomes cause of compile error of duplicate definition if 
memory hotplug option is on.

This patch is to fix it. 

Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>


---
 arch/i386/kernel/e820.c  |    2 +-
 arch/i386/kernel/setup.c |    2 +-
 include/asm-i386/e820.h  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.20-rc1/arch/i386/kernel/e820.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/i386/kernel/e820.c	2006-12-19 21:52:36.000000000 +0900
+++ linux-2.6.20-rc1/arch/i386/kernel/e820.c	2006-12-19 22:15:59.000000000 +0900
@@ -668,7 +668,7 @@
 	}
 }
 
-void __init register_memory(void)
+void __init e820_register_memory(void)
 {
 	unsigned long gapstart, gapsize, round;
 	unsigned long long last;
Index: linux-2.6.20-rc1/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/i386/kernel/setup.c	2006-12-19 21:52:36.000000000 +0900
+++ linux-2.6.20-rc1/arch/i386/kernel/setup.c	2006-12-19 22:15:59.000000000 +0900
@@ -639,7 +639,7 @@
 		get_smp_config();
 #endif
 
-	register_memory();
+	e820_register_memory();
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
Index: linux-2.6.20-rc1/include/asm-i386/e820.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-i386/e820.h	2006-12-19 21:52:36.000000000 +0900
+++ linux-2.6.20-rc1/include/asm-i386/e820.h	2006-12-19 22:16:28.000000000 +0900
@@ -40,7 +40,7 @@
 			   unsigned type);
 extern void find_max_pfn(void);
 extern void register_bootmem_low_pages(unsigned long max_low_pfn);
-extern void register_memory(void);
+extern void e820_register_memory(void);
 extern void limit_regions(unsigned long long size);
 extern void print_memory_map(char *who);
 

-- 
Yasunori Goto 


