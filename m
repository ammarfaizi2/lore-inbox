Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSFQPoo>; Mon, 17 Jun 2002 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSFQPon>; Mon, 17 Jun 2002 11:44:43 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:7045 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S313113AbSFQPol>; Mon, 17 Jun 2002 11:44:41 -0400
Date: Mon, 17 Jun 2002 17:44:29 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix incorrect inline assembly in RAID-5
Message-ID: <20020617174428.A4067@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pure luck that this ever worked at all. The optimized assembly for XOR 
in RAID-5 declared did clobber registers, but did declare them as read-only.
I'm pretty sure that at least the 4 disk and possibly the 5 disk cases
did corrupt callee saved registers. The others probably got away because
they were always used in own functions (and only clobbering caller saved
registers)and only called via pointers, preventing inlining.

Some of the replacements are a bit complicated because the functions
exceed gcc's 10 asm argument limit when each input/output register needs
two arguments. Works around that by saving/restoring some of the registers
manually.

I wasn't able to test it in real-life because I don't have a RAID
setup and the RAID code didn't compile since several 2.5 releases.
I wrote some test programs that did test the XOR and they showed
no regression.

Also aligns to XMM save area to 16 bytes to save a few cycles.

Patch for 2.5.22.

-Andi

--- linux/include/asm-i386/xor.h	Thu May 30 20:11:36 2002
+++ linux-2.5.22-work/include/asm-i386/xor.h	Tue Jun 11 14:58:32 2002
@@ -76,9 +76,9 @@
 	"       addl $128, %2         ;\n"
 	"       decl %0               ;\n"
 	"       jnz 1b                ;\n"
-       	:
-	: "r" (lines),
-	  "r" (p1), "r" (p2)
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2)
+	:
 	: "memory");
 
 	FPU_RESTORE;
@@ -126,9 +126,9 @@
 	"       addl $128, %3         ;\n"
 	"       decl %0               ;\n"
 	"       jnz 1b                ;\n"
-       	:
-	: "r" (lines),
-	  "r" (p1), "r" (p2), "r" (p3)
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3)
+	:
 	: "memory");
 
 	FPU_RESTORE;
@@ -181,14 +181,15 @@
 	"       addl $128, %4         ;\n"
 	"       decl %0               ;\n"
 	"       jnz 1b                ;\n"
-       	:
-	: "r" (lines),
-	  "r" (p1), "r" (p2), "r" (p3), "r" (p4)
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3), "+r" (p4)
+	:
 	: "memory");
 
 	FPU_RESTORE;
 }
 
+
 static void
 xor_pII_mmx_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 	      unsigned long *p3, unsigned long *p4, unsigned long *p5)
@@ -198,7 +199,11 @@
 
 	FPU_SAVE;
 
+	/* need to save/restore p4/p5 manually otherwise gcc's 10 argument
+	   limit gets exceeded (+ counts as two arguments) */
 	__asm__ __volatile__ (
+		"  pushl %4\n"
+		"  pushl %5\n"
 #undef BLOCK
 #define BLOCK(i) \
 	LD(i,0)					\
@@ -241,9 +246,11 @@
 	"       addl $128, %5         ;\n"
 	"       decl %0               ;\n"
 	"       jnz 1b                ;\n"
-       	:
-	: "g" (lines),
-	  "r" (p1), "r" (p2), "r" (p3), "r" (p4), "r" (p5)
+	"	popl %5\n"
+	"	popl %4\n"
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3)
+	: "r" (p4), "r" (p5) 
 	: "memory");
 
 	FPU_RESTORE;
@@ -297,9 +304,9 @@
 	"       addl $64, %2         ;\n"
 	"       decl %0              ;\n"
 	"       jnz 1b               ;\n"
-	: 
-	: "r" (lines),
-	  "r" (p1), "r" (p2)
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2)
+	:
 	: "memory");
 
 	FPU_RESTORE;
@@ -355,9 +362,9 @@
 	"       addl $64, %3         ;\n"
 	"       decl %0              ;\n"
 	"       jnz 1b               ;\n"
-	: 
-	: "r" (lines),
-	  "r" (p1), "r" (p2), "r" (p3)
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3)
+	:
 	: "memory" );
 
 	FPU_RESTORE;
@@ -422,9 +429,9 @@
 	"       addl $64, %4         ;\n"
 	"       decl %0              ;\n"
 	"       jnz 1b               ;\n"
-	: 
-	: "r" (lines),
-	  "r" (p1), "r" (p2), "r" (p3), "r" (p4)
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3), "+r" (p4)
+	:
 	: "memory");
 
 	FPU_RESTORE;
@@ -439,7 +446,10 @@
 
 	FPU_SAVE;
 
+	/* need to save p4/p5 manually to not exceed gcc's 10 argument limit */
 	__asm__ __volatile__ (
+	"	pushl %4\n"
+	"	pushl %5\n"        	
 	" .align 32,0x90             ;\n"
 	" 1:                         ;\n"
 	"       movq   (%1), %%mm0   ;\n"
@@ -498,9 +508,11 @@
 	"       addl $64, %5         ;\n"
 	"       decl %0              ;\n"
 	"       jnz 1b               ;\n"
-	: 
-	: "g" (lines),
-	  "r" (p1), "r" (p2), "r" (p3), "r" (p4), "r" (p5)
+	"	popl %5\n"
+	"	popl %4\n"
+	: "+g" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3)
+	: "r" (p4), "r" (p5)
 	: "memory");
 
 	FPU_RESTORE;
@@ -554,6 +566,8 @@
 		: "r" (cr0), "r" (xmm_save)	\
 		: "memory")
 
+#define ALIGN16 __attribute__((aligned(16)))
+
 #define OFFS(x)		"16*("#x")"
 #define PF_OFFS(x)	"256+16*("#x")"
 #define	PF0(x)		"	prefetchnta "PF_OFFS(x)"(%1)		;\n"
@@ -575,7 +589,7 @@
 xor_sse_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 {
         unsigned long lines = bytes >> 8;
-	char xmm_save[16*4];
+	char xmm_save[16*4] ALIGN16;
 	int cr0;
 
 	XMMS_SAVE;
@@ -616,9 +630,9 @@
         "       addl $256, %2           ;\n"
         "       decl %0                 ;\n"
         "       jnz 1b                  ;\n"
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2)
 	:
-	: "r" (lines),
-	  "r" (p1), "r" (p2)
         : "memory");
 
 	XMMS_RESTORE;
@@ -629,7 +643,7 @@
 	  unsigned long *p3)
 {
         unsigned long lines = bytes >> 8;
-	char xmm_save[16*4];
+	char xmm_save[16*4] ALIGN16;
 	int cr0;
 
 	XMMS_SAVE;
@@ -677,9 +691,9 @@
         "       addl $256, %3           ;\n"
         "       decl %0                 ;\n"
         "       jnz 1b                  ;\n"
+	: "+r" (lines),
+	  "+r" (p1), "+r"(p2), "+r"(p3)
 	:
-	: "r" (lines),
-	  "r" (p1), "r"(p2), "r"(p3)
         : "memory" );
 
 	XMMS_RESTORE;
@@ -690,7 +704,7 @@
 	  unsigned long *p3, unsigned long *p4)
 {
         unsigned long lines = bytes >> 8;
-	char xmm_save[16*4];
+	char xmm_save[16*4] ALIGN16;
 	int cr0;
 
 	XMMS_SAVE;
@@ -745,9 +759,9 @@
         "       addl $256, %4           ;\n"
         "       decl %0                 ;\n"
         "       jnz 1b                  ;\n"
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3), "+r" (p4)
 	:
-	: "r" (lines),
-	  "r" (p1), "r" (p2), "r" (p3), "r" (p4)
         : "memory" );
 
 	XMMS_RESTORE;
@@ -758,12 +772,15 @@
 	  unsigned long *p3, unsigned long *p4, unsigned long *p5)
 {
         unsigned long lines = bytes >> 8;
-	char xmm_save[16*4];
+	char xmm_save[16*4] ALIGN16;
 	int cr0;
 
 	XMMS_SAVE;
 
+	/* need to save p4/p5 manually to not exceed gcc's 10 argument limit */
         __asm__ __volatile__ (
+		" pushl %4\n"
+		" pushl %5\n"
 #undef BLOCK
 #define BLOCK(i) \
 		PF1(i)					\
@@ -820,9 +837,11 @@
         "       addl $256, %5           ;\n"
         "       decl %0                 ;\n"
         "       jnz 1b                  ;\n"
-	:
-	: "r" (lines),
-	  "r" (p1), "r" (p2), "r" (p3), "r" (p4), "r" (p5)
+	"	popl %5\n"	
+	"	popl %4\n"	
+	: "+r" (lines),
+	  "+r" (p1), "+r" (p2), "+r" (p3)
+	: "r" (p4), "r" (p5)
 	: "memory");
 
 	XMMS_RESTORE;
