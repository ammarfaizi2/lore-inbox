Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270620AbTHFKfO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270700AbTHFKfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:35:14 -0400
Received: from [66.212.224.118] ([66.212.224.118]:12301 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270620AbTHFKfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:35:06 -0400
Date: Wed, 6 Aug 2003 06:23:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH][2.6-mm] fix any_online_cpu() with cpumask_t and NR_CPUS <
 BITS_PER_LONG
Message-ID: <Pine.LNX.4.53.0308060608590.7244@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have no idea how this slipped in, all my boxes couldn't boot, the thing 
is it'll boot on 2way but as soon as you get to cpu2 you're shafted. 
Tested on 3x and 8x. The problem is that we really want to find the first 
cpu in the map and not whether there are processors in the map.

checking TSC synchronization across 8 CPUs: passed.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Starting migration thread for cpu 2
------------[ cut here ]------------
kernel BUG at kernel/softirq.c:334!
invalid operand: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    1
EIP:    0060:[<c012b187>]    Not tainted VLI
EFLAGS: 00010297
EIP is at ksoftirqd+0x47/0xf0
eax: cc3fd000   ebx: 00000002   ecx: c0329718   edx: 00000004
esi: cc3c8000   edi: 00000000   ebp: 00000000   esp: cc3c9fe8
ds: 007b   es: 007b   ss: 0068
Process ksoftirqd/2 (pid: 7, threadinfo=cc3c8000 task=cc3fd000)
Stack: c012b140 00000000 c010abd9 00000002 00000000 00000000
Call Trace:
 [<c012b140>] ksoftirqd+0x0/0xf0
 [<c010abd9>] kernel_thread_helper+0x5/0xc

Code: 50 e8 1e 6e ff ff 8b 06 88 d9 83 c4 10 81 48 0c 00 80 00 00 b8 01 00 
00 00 d3 e0 50 8b 0e 51 e8 c0 80 ff ff 58 5a 39 5e 10 74 08 <0f> 0b 4e 01 
43 99 32 c0 8b 06 c7 00 01 00 00 00 f0 83 44 24 00

--- linux-2.6.0-test2-mm4/include/asm-generic/cpumask_arith.h.fix	2003-08-06 06:05:28.810903144 -0400
+++ linux-2.6.0-test2-mm4/include/asm-generic/cpumask_arith.h	2003-08-06 06:06:16.364673872 -0400
@@ -38,9 +38,6 @@
 #define cpus_shift_right(dst, src, n)	do { dst = (src) >> (n); } while (0)
 #define cpus_shift_left(dst, src, n)	do { dst = (src) >> (n); } while (0)
 
-#define any_online_cpu(map)		(!cpus_empty(map))
-
-
 #define CPU_MASK_ALL	(~((cpumask_t)0) >> (8*sizeof(cpumask_t) - NR_CPUS))
 #define CPU_MASK_NONE	((cpumask_t)0)
 
@@ -58,4 +55,6 @@
 #define next_cpu(cpu, map)		1
 #endif /* CONFIG_SMP */
 
+#define any_online_cpu(map)		first_cpu(map)
+
 #endif /* __ASM_GENERIC_CPUMASK_ARITH_H */
