Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWFTUa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWFTUa3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWFTUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:30:29 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:21634 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750894AbWFTUa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:30:28 -0400
Date: Tue, 20 Jun 2006 16:25:23 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [RFC, patch] i386: vgetcpu()
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200606201628_MC3-1-C2FA-3586@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the limit field of a GDT entry to store the current CPU
number for fast userspace access.  This still leaves 12 bits
free for other information.

/* vgetcpu.c: get CPU number we are running on.
 * Prints -1 if error occurred.
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * const argv[])
{
	int cpu;

	asm (
		"	lsl %1,%0		\n" \
		"	jnz 2f			\n" \
		"	and $0xff,%0		\n" \
		"2:				\n" \
		: "=&r" (cpu)
		: "r" ((27 << 3) | 3), "0" (-1)
	);

	printf("cpu: %d\n", cpu);

	return 0;
}

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.17-32.orig/arch/i386/kernel/cpu/common.c
+++ 2.6.17-32/arch/i386/kernel/cpu/common.c
@@ -642,6 +642,9 @@ void __cpuinit cpu_init(void)
 		((((__u64)stk16_off) << 32) & 0xff00000000000000ULL) |
 		(CPU_16BIT_STACK_SIZE - 1);
 
+	/* Set up GDT entry for per-cpu data */
+ 	*(__u64 *)(&gdt[27]) |= cpu;
+
 	cpu_gdt_descr->size = GDT_SIZE - 1;
  	cpu_gdt_descr->address = (unsigned long)gdt;
 
--- 2.6.17-32.orig/arch/i386/kernel/head.S
+++ 2.6.17-32/arch/i386/kernel/head.S
@@ -525,7 +525,13 @@ ENTRY(cpu_gdt_table)
 	.quad 0x004092000000ffff	/* 0xc8 APM DS    data */
 
 	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
+
+	/*
+	 * Use a GDT entry to store per-cpu data for user space (DPL 3.)
+	 * 32-bit data segment, byte granularity, base 0, limit set at runtime.
+	 */
+	.quad 0x0040f20000000000	/* 0xd8 - for per-cpu user data */
+
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
