Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbTKUXTO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 18:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTKUXTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 18:19:14 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:27521
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261660AbTKUXTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 18:19:10 -0500
Date: Fri, 21 Nov 2003 18:17:45 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6-mm] __kunmap/oprofile final link failure
Message-ID: <Pine.LNX.4.53.0311211811040.2498@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/built-in.o(.text+0x927): In function `__switch_to':
arch/i386/kernel/process.c:564: undefined reference to 
`__kunmap_atomic_type'
arch/i386/kernel/built-in.o(.text+0x92e):arch/i386/kernel/process.c:565: 
undefined reference to `__kunmap_atomic_type'
arch/i386/kernel/built-in.o(.text+0x939):arch/i386/kernel/process.c:566: 
undefined reference to `__kmap_atomic'
arch/i386/kernel/built-in.o(.text+0x944):arch/i386/kernel/process.c:567: 
undefined reference to `__kmap_atomic'
arch/i386/kernel/built-in.o(.text+0x94e):arch/i386/kernel/process.c:572: 
undefined reference to `__kmap_atomic_vaddr'
arch/i386/oprofile/built-in.o(.text+0x171a): In function 
`oprofile_reset_stats':
include/asm/bitops.h:251: undefined reference to `cpu_possible_map'
arch/i386/oprofile/built-in.o(.text+0x179e): In function 
`oprofile_create_stats_files':
include/asm/bitops.h:251: undefined reference to `cpu_possible_map'

Test compiled with NR_CPUS = 4, 64 and !CONFIG_SMP on i386

Index: linux-2.6.0-test9-mm5/arch/i386/kernel/process.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/arch/i386/kernel/process.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 process.c
--- linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 20:59:15 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm5/arch/i386/kernel/process.c	21 Nov 2003 22:20:00 -0000
@@ -50,6 +50,7 @@
 #include <asm/desc.h>
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
+#include <asm/atomic_kmap.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
Index: linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 oprofile_stats.c
--- linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 20:59:40 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm5/drivers/oprofile/oprofile_stats.c	21 Nov 2003 21:27:44 -0000
@@ -10,7 +10,8 @@
 #include <linux/oprofile.h>
 #include <linux/cpumask.h>
 #include <linux/threads.h>
- 
+#include <linux/smp.h>
+
 #include "oprofile_stats.h"
 #include "cpu_buffer.h"
  
Index: linux-2.6.0-test9-mm5/include/linux/cpumask.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test9-mm5/include/linux/cpumask.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpumask.h
--- linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 20:59:57 -0000	1.1.1.1
+++ linux-2.6.0-test9-mm5/include/linux/cpumask.h	21 Nov 2003 21:52:39 -0000
@@ -39,9 +39,8 @@ typedef unsigned long cpumask_t;
 
 
 #ifdef CONFIG_SMP
-
+#include <asm/smp.h>
 extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
 
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
