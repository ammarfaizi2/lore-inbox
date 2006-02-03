Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWBCIem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWBCIem (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 03:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWBCIem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 03:34:42 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:64964 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750973AbWBCIel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 03:34:41 -0500
Date: Fri, 3 Feb 2006 02:30:59 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch -mm4] x86 SMP alternatives: update X86_FEATURE_UP on
  cpu0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Gerd Hoffman <kraxel@suse.de>
Message-ID: <200602030234_MC3-1-B77D-3328@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When cpu hotplug is enabled, the x86 feature "up" is always shown
for CPU 0 in /proc/cpuinfo.  Update CPU 0 when updating
boot_cpu_data so they stay in sync.  Also, get some definitions
from header files.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc1-mm4-386.orig/arch/i386/kernel/alternative.c
+++ 2.6.16-rc1-mm4-386/arch/i386/kernel/alternative.c
@@ -2,6 +2,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <asm/alternative.h>
+#include <asm/sections.h>
 
 #define DEBUG 0
 #if DEBUG
@@ -71,7 +72,6 @@ extern struct alt_instr __alt_instructio
 extern struct alt_instr __smp_alt_instructions[], __smp_alt_instructions_end[];
 extern u8 *__smp_locks[], *__smp_locks_end[];
 
-extern u8 _text[], _etext[];
 extern u8 __smp_alt_begin[], __smp_alt_end[];
 
 
@@ -264,6 +264,7 @@ void alternatives_smp_switch(int smp)
 	if (smp) {
 		printk(KERN_INFO "SMP alternatives: switching to SMP code\n");
 		clear_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+		clear_bit(X86_FEATURE_UP, cpu_data[0].x86_capability);
 		alternatives_smp_apply(__smp_alt_instructions,
 				       __smp_alt_instructions_end);
 		list_for_each_entry(mod, &smp_alt_modules, next)
@@ -272,6 +273,7 @@ void alternatives_smp_switch(int smp)
 	} else {
 		printk(KERN_INFO "SMP alternatives: switching to UP code\n");
 		set_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+		set_bit(X86_FEATURE_UP, cpu_data[0].x86_capability);
 		apply_alternatives(__smp_alt_instructions,
 				   __smp_alt_instructions_end);
 		list_for_each_entry(mod, &smp_alt_modules, next)
@@ -301,6 +303,7 @@ void __init alternative_instructions(voi
 		if (1 == num_possible_cpus()) {
 			printk(KERN_INFO "SMP alternatives: switching to UP code\n");
 			set_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+			set_bit(X86_FEATURE_UP, cpu_data[0].x86_capability);
 			apply_alternatives(__smp_alt_instructions,
 					   __smp_alt_instructions_end);
 			alternatives_smp_unlock(__smp_locks, __smp_locks_end,
-- 
Chuck
