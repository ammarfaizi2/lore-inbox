Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTKVOsX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 09:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbTKVOsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 09:48:22 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:35458
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262308AbTKVOsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 09:48:20 -0500
Date: Sat, 22 Nov 2003 09:47:03 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Remi Colinet <remi.colinet@wanadoo.fr>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm5 : compile error
In-Reply-To: <3FBF5C79.5050409@wanadoo.fr>
Message-ID: <Pine.LNX.4.53.0311220946280.2498@montezuma.fsmlabs.com>
References: <3FBF5C79.5050409@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003, Remi Colinet wrote:

> arch/i386/oprofile/built-in.o: In function `oprofile_reset_stats':
> /usr/src/mm/include/asm/bitops.h:251: undefined reference to 
> `cpu_possible_map'
> arch/i386/oprofile/built-in.o: In function `oprofile_create_stats_files':
> /usr/src/mm/include/asm/bitops.h:251: undefined reference to 
> `cpu_possible_map'
> make: *** [.tmp_vmlinux1] Error 1

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
