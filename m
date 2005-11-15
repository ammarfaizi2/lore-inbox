Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVKOQBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVKOQBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbVKOQBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:01:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:18634 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751083AbVKOQBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:01:32 -0500
Message-ID: <437A0649.7010702@suse.de>
Date: Tue, 15 Nov 2005 17:01:13 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>
In-Reply-To: <4379ECC1.20005@suse.de>
Content-Type: multipart/mixed;
 boundary="------------060603030000030303060401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060603030000030303060401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

> Yep, extending alternatives is probably better than duplicating the 
> code.  Maybe having some alternative_smp() macro which places both code 
> versions into the .altinstr_replacement table?  If that sounds ok I'll 
> try to come up with a experimental patch.

i.e. something like this (as basic idea, patch is far away from doing 
anything useful ...)?

   Gerd

--------------060603030000030303060401
Content-Type: text/x-patch;
 name="smp-alternatives.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp-alternatives.diff"

diff -pu -urp linux-2.6.14/arch/i386/kernel/setup.c work-2.6.14/arch/i386/kernel/setup.c
--- linux-2.6.14/arch/i386/kernel/setup.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/setup.c	2005-11-15 16:49:13.000000000 +0100
@@ -1435,9 +1435,9 @@ void apply_alternatives(void *start, voi
 		}
 	} 
 	for (a = start; (void *)a < end; a++) { 
+		BUG_ON(a->replacementlen > a->instrlen); 
 		if (!boot_cpu_has(a->cpuid))
 			continue;
-		BUG_ON(a->replacementlen > a->instrlen); 
 		memcpy(a->instr, a->replacement, a->replacementlen); 
 		diff = a->instrlen - a->replacementlen; 
 		/* Pad the rest with nops */
@@ -1450,6 +1450,19 @@ void apply_alternatives(void *start, voi
 	}
 } 
 
+void apply_alternatives_smp(void *start, void *end) 
+{ 
+	struct alt_instr *a; 
+
+	for (a = start; (void *)a < end; a++) { 
+		if (X86_FEATURE_UP != a->cpuid)
+			continue;
+		memcpy(a->instr,
+		       a->replacement + a->replacementlen,
+		       a->instrlen);
+	}
+} 
+
 void __init alternative_instructions(void)
 {
 	extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
diff -pu -urp linux-2.6.14/include/asm-i386/cpufeature.h work-2.6.14/include/asm-i386/cpufeature.h
--- linux-2.6.14/include/asm-i386/cpufeature.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/cpufeature.h	2005-11-15 15:52:03.000000000 +0100
@@ -70,6 +70,8 @@
 #define X86_FEATURE_P3		(3*32+ 6) /* P3 */
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 
+#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
+
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
diff -pu -urp linux-2.6.14/include/asm-i386/system.h work-2.6.14/include/asm-i386/system.h
--- linux-2.6.14/include/asm-i386/system.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/system.h	2005-11-15 15:47:43.000000000 +0100
@@ -329,6 +329,25 @@ struct alt_instr { 
 		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
 		      ".previous" :: "i" (feature) : "memory")  
 
+#ifdef CONFIG_SMP
+#define alternative_smp(smpinstr, upinstr, input) 	\
+	asm volatile ("661:\n\t" smpinstr "\n662:\n" 		     \
+		      ".section .altinstructions,\"a\"\n"     	     \
+		      "  .align 4\n"				       \
+		      "  .long 661b\n"            /* label */          \
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte %c0\n"             /* feature bit */    \
+		      "  .byte 662b-661b\n"       /* sourcelen */      \
+		      "  .byte 664f-663f\n"       /* replacementlen */ \
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
+		      "663:\n\t" upinstr "\n"     /* replacement */    \
+		      "664:\n\t" smpinstr "\n"    /* original again */ \
+		      ".previous" :: "i" (X86_FEATURE_UP), ##input)
+#else
+#define alternative_smp(smpinstr, upinstr) asm(upinstr, ##input)
+#endif
+
 /*
  * Alternative inline assembly with input.
  * 

--------------060603030000030303060401--
