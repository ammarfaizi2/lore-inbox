Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSFENi5>; Wed, 5 Jun 2002 09:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSFENi4>; Wed, 5 Jun 2002 09:38:56 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:5561 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314485AbSFENiv>; Wed, 5 Jun 2002 09:38:51 -0400
Date: Wed, 5 Jun 2002 15:38:34 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Call for testers - fixed RAID5 XOR functions
Message-ID: <20020605153834.A15485@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While porting xor.h to x86-64 I noticed that the accelerated RAID-5 XOR
functions for i386 used incorrect inline assembly. The were clobbering
upto 7 registers without gcc telling it. It is pure luck that it worked
so far, although I'm dubious about it for the versions with 4 and 5 inputs
(has that been really tested? - they clobber 5 or 6 registers and unless it 
was pure luck that the caller had some dead registers in one particular
compiler output it must have caused data corruptions) 

I unfortunately don't have a RAID-5 so I cannot test. From visual inspection
the new assembly seems to be correct. I would be grateful if someone with
RAID-5 could test it by doing some writes and then removing one disk and
testing recovery. Best would be tests with 3,4,5,6 disks, but only specific
cases will do also. 

I did also align the XMM saves on 16 bytes to save a few cycles.

Here is the patch for 2.4.19pre9 (but should apply to most 2.4 and 2.5) 

-Andi

--- linux-2.4.19pre9/include/asm-i386/xor.h	Fri Sep 14 23:25:21 2001
+++ linux-2.4.19pre9-work/include/asm-i386/xor.h	Wed Jun  5 15:06:40 2002
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

