Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWEJGqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWEJGqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWEJGqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:46:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:9064 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750822AbWEJGqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:46:06 -0400
X-IronPort-AV: i="4.05,108,1146466800"; 
   d="scan'208"; a="34963791:sNHT1075930086"
Message-ID: <44618C0D.6020604@intel.com>
Date: Wed, 10 May 2006 14:45:33 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: akpm@osdl.org
CC: Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH]x86_64 debug_stack nested patch
Content-Type: multipart/mixed;
 boundary="------------060909040604050307040701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060909040604050307040701
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hi,
In x86_64 platform, INT1 and INT3 trap stack is IST stack called 
DEBUG_STACK, when INT1/INT3 trap happens, system will switch to 
DEBUG_STACK by hardware. Current DEBUG_STACK size is 4K, when int1/int3 
trap happens, kernel will minus current DEBUG_STACK IST value by 4k. But 
if int3/int1 trap is nested, it will destroy other vector's IST stack.
This patch modifies this, it sets DEBUG_STACK size as 8K and allows two 
level of nested int1/int3 trap.
Kprobe DEBUG_STACK may be nested, because kprobe hanlder may be probed 
by other kprobes. This patch is against 2.6.17-rc3.

Signed-Off-By: bibo, mao <bibo.mao@intel.com>

Thanks
bibo,mao

--------------060909040604050307040701
Content-Type: text/x-patch;
 name="DEBUG_STACK_NEST.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="DEBUG_STACK_NEST.patch"

diff -Nruap 2.6.17-rc3.org/arch/x86_64/kernel/traps.c 2.6.17-rc3/arch/x86_64/kernel/traps.c
--- 2.6.17-rc3.org/arch/x86_64/kernel/traps.c	2006-05-10 12:07:30.000000000 +0800
+++ 2.6.17-rc3/arch/x86_64/kernel/traps.c	2006-05-10 12:18:53.000000000 +0800
@@ -141,50 +141,24 @@ static unsigned long *in_exception_stack
 		[DOUBLEFAULT_STACK - 1] = "#DF",
 		[STACKFAULT_STACK - 1] = "#SS",
 		[MCE_STACK - 1] = "#MC",
-#if DEBUG_STKSZ > EXCEPTION_STKSZ
-		[N_EXCEPTION_STACKS ... N_EXCEPTION_STACKS + DEBUG_STKSZ / EXCEPTION_STKSZ - 2] = "#DB[?]"
-#endif
 	};
-	unsigned k;
+	unsigned stack_size, end, k;
 
 	for (k = 0; k < N_EXCEPTION_STACKS; k++) {
-		unsigned long end;
-
-		switch (k + 1) {
-#if DEBUG_STKSZ > EXCEPTION_STKSZ
-		case DEBUG_STACK:
-			end = cpu_pda(cpu)->debugstack + DEBUG_STKSZ;
-			break;
-#endif
-		default:
-			end = per_cpu(init_tss, cpu).ist[k];
-			break;
-		}
+		end = per_cpu(init_tss, cpu).ist[k];
 		if (stack >= end)
 			continue;
-		if (stack >= end - EXCEPTION_STKSZ) {
+		if (k == (DEBUG_STACK - 1))
+			stack_size = DEBUG_STKSZ;
+		else stack_size = EXCEPTION_STKSZ;
+
+		if (stack >= end - stack_size) {
 			if (*usedp & (1U << k))
 				break;
 			*usedp |= 1U << k;
 			*idp = ids[k];
 			return (unsigned long *)end;
 		}
-#if DEBUG_STKSZ > EXCEPTION_STKSZ
-		if (k == DEBUG_STACK - 1 && stack >= end - DEBUG_STKSZ) {
-			unsigned j = N_EXCEPTION_STACKS - 1;
-
-			do {
-				++j;
-				end -= EXCEPTION_STKSZ;
-				ids[j][4] = '1' + (j - N_EXCEPTION_STACKS);
-			} while (stack < end - EXCEPTION_STKSZ);
-			if (*usedp & (1U << j))
-				break;
-			*usedp |= 1U << j;
-			*idp = ids[j];
-			return (unsigned long *)end;
-		}
-#endif
 	}
 	return NULL;
 }
diff -Nruap 2.6.17-rc3.org/include/asm-x86_64/page.h 2.6.17-rc3/include/asm-x86_64/page.h
--- 2.6.17-rc3.org/include/asm-x86_64/page.h	2006-05-10 12:07:18.000000000 +0800
+++ 2.6.17-rc3/include/asm-x86_64/page.h	2006-05-10 12:19:24.000000000 +0800
@@ -20,7 +20,7 @@
 #define EXCEPTION_STACK_ORDER 0
 #define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)
 
-#define DEBUG_STACK_ORDER EXCEPTION_STACK_ORDER
+#define DEBUG_STACK_ORDER 1
 #define DEBUG_STKSZ (PAGE_SIZE << DEBUG_STACK_ORDER)
 
 #define IRQSTACK_ORDER 2

--------------060909040604050307040701--
