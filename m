Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131009AbRAHRQ5>; Mon, 8 Jan 2001 12:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131698AbRAHRQr>; Mon, 8 Jan 2001 12:16:47 -0500
Received: from Cantor.suse.de ([194.112.123.193]:1043 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131127AbRAHRQc>;
	Mon, 8 Jan 2001 12:16:32 -0500
Date: Mon, 8 Jan 2001 18:16:25 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [PATCH,serious] Fix raid5 crashes in 2.4.0
Message-ID: <20010108181625.A11766@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo Linus,

The following patch fixes an oops in 2.4.0 RAID5 initialisation when the kernel
was configured without CONFIG_X86_FXSR but is booted on a CPU supporting SSE. 
The problem is that without the FXSR config the OSFXSR flag is not set during
bootup, which causes any operation referencing XMM registers to fault. The 
raid code only checks for XMM support though, but not if FXSR support is enabled.
The sse2 code would oops while it's do its speed benchmarks, which happens at boot
when RAID5 is compiled in.
This patch just makes the SSE2 code conditional on CONFIG_X86_FXSR||
CONFIG_X86_RUNTIME_FXSR

I think it would impact CD users when their kernel doesn't boot because of this. 
It happened on several machines at SuSE.
Please consider it for 2.4.1.

-Andi

--- linux-work/include/asm/xor.h-o	Sat Dec 23 08:13:50 2000
+++ linux-work/include/asm/xor.h	Mon Jan  8 16:33:26 2001
@@ -13,6 +13,8 @@
  * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#include <linux/config.h>
+
 /*
  * High-speed RAID5 checksumming functions utilizing MMX instructions.
  * Copyright (C) 1998 Ingo Molnar.
@@ -525,6 +527,8 @@
 #undef FPU_SAVE
 #undef FPU_RESTORE
 
+#if defined(CONFIG_X86_FXSR) || defined(CONFIG_X86_RUNTIME_FXSR)
+
 /*
  * Cache avoiding checksumming functions utilizing KNI instructions
  * Copyright (C) 1999 Zach Brown (with obvious credit due Ingo)
@@ -835,6 +839,26 @@
         do_5: xor_sse_5,
 };
 
+#define XOR_SSE2 \
+	        if (cpu_has_xmm)			\
+			xor_speed(&xor_block_pIII_sse);	
+
+
+/* We force the use of the SSE xor block because it can write around L2.
+   We may also be able to load into the L1 only depending on how the cpu
+   deals with a load to a line that is being prefetched.  */
+#define XOR_SELECT_TEMPLATE(FASTEST) \
+	(cpu_has_xmm ? &xor_block_pIII_sse : FASTEST)
+
+#else
+
+/* Don't try any SSE2 when FXSR is not enabled, because OSFXSR will not be set
+   -AK */ 
+#define XOR_SSE2 
+#define XOR_SELECT_TEMPLATE(FASTEST) (FASTEST)
+
+#endif
+
 /* Also try the generic routines.  */
 #include <asm-generic/xor.h>
 
@@ -843,16 +867,9 @@
 	do {						\
 		xor_speed(&xor_block_8regs);		\
 		xor_speed(&xor_block_32regs);		\
-	        if (cpu_has_xmm)			\
-			xor_speed(&xor_block_pIII_sse);	\
+		XOR_SSE2	\
 	        if (md_cpu_has_mmx()) {			\
 	                xor_speed(&xor_block_pII_mmx);	\
 	                xor_speed(&xor_block_p5_mmx);	\
 	        }					\
 	} while (0)
-
-/* We force the use of the SSE xor block because it can write around L2.
-   We may also be able to load into the L1 only depending on how the cpu
-   deals with a load to a line that is being prefetched.  */
-#define XOR_SELECT_TEMPLATE(FASTEST) \
-	(cpu_has_xmm ? &xor_block_pIII_sse : FASTEST)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
