Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314678AbSDTSMV>; Sat, 20 Apr 2002 14:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314679AbSDTSMU>; Sat, 20 Apr 2002 14:12:20 -0400
Received: from [195.223.140.120] ([195.223.140.120]:31330 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314678AbSDTSMR>; Sat, 20 Apr 2002 14:12:17 -0400
Date: Sat, 20 Apr 2002 20:12:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Brian Gerst <bgerst@didntduck.org>, "H. Peter Anvin" <hpa@zytor.com>,
        ak@suse.de, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Re: SSE related security hole
Message-ID: <20020420201205.M1291@dualathlon.random>
In-Reply-To: <20020420192729.I1291@dualathlon.random> <Pine.LNX.4.44.0204201036400.19512-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2002 at 10:38:59AM -0700, Linus Torvalds wrote:
> 
> 
> On Sat, 20 Apr 2002, Andrea Arcangeli wrote:
> >
> > Then the thing is different, I expected SSE3 not to mess the xmm layout.
> > If you just know SSE3 would break with the xorps the fxrestor way is
> > better. Anyways the problems I have about the implementation remains
> > (memset and duplicate efforts with ptrace in creating the empty fpu
> > state).
> 
> Hey, send a clean patch and it will definitely get fixed.. I don't
> disagree with that part, although actual numbers are always good to have.

Well, my preferred patch is still this one :)

--- linux/arch/i386/kernel/i387.c.org	Thu Apr 18 09:30:26 2002
+++ linux/arch/i386/kernel/i387.c	Thu Apr 18 09:38:23 2002
@@ -33,9 +33,30 @@
 void init_fpu(void)
 {
 	__asm__("fninit");
-	if ( cpu_has_xmm )
+
+	if ( cpu_has_mmx )
+		asm volatile(
+			"pxor %mm0, %mm0	\n"
+			"pxor %mm1, %mm1	\n"
+			"pxor %mm2, %mm2	\n"
+			"pxor %mm3, %mm3	\n"
+			"pxor %mm4, %mm4	\n"
+			"pxor %mm5, %mm5	\n"
+			"pxor %mm6, %mm6	\n"
+			"pxor %mm7, %mm7	\n"
+			"emms			\n");
+	if ( cpu_has_xmm ) {
 		load_mxcsr(0x1f80);
+		asm volatile(
+			"xorps %xmm0, %xmm0	\n"
+			"xorps %xmm1, %xmm1	\n"
+			"xorps %xmm2, %xmm2	\n"
+			"xorps %xmm3, %xmm3	\n"
+			"xorps %xmm4, %xmm4	\n"
+			"xorps %xmm5, %xmm5	\n"
+			"xorps %xmm6, %xmm6	\n"
+			"xorps %xmm7, %xmm7	");
-		
+	}		
 	current->used_math = 1;
 }
 
--- linux/include/asm-i386/processor.h~	Thu Apr 18 10:06:37 2002
+++ linux/include/asm-i386/processor.h	Thu Apr 18 10:06:37 2002
@@ -89,6 +89,7 @@
 #define cpu_has_vme	(test_bit(X86_FEATURE_VME,  boot_cpu_data.x86_capability))
 #define cpu_has_fxsr	(test_bit(X86_FEATURE_FXSR, boot_cpu_data.x86_capability))
 #define cpu_has_xmm	(test_bit(X86_FEATURE_XMM,  boot_cpu_data.x86_capability))
+#define cpu_has_mmx	(test_bit(X86_FEATURE_MMX,  boot_cpu_data.x86_capability))
 #define cpu_has_fpu	(test_bit(X86_FEATURE_FPU,  boot_cpu_data.x86_capability))
 #define cpu_has_apic	(test_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability))
 


My strongest argument is that even if it's true the fxrestor logic may
not need changes even if they add registers or control words, that
doesn't apply to the kernel as a whole too. The same 2.4 kernel binary
image with the fxrestor patch applied cannot enable SSE3 automatically.
Further patching, recompilation and in turn a new fresh binary image
will be necessary to enable SSE3, regardless of the universal fxrestor
logic.  This obviously assuming that they won't release again a chip
that is not backwards compatible 8).

I mean, if they change the registers layout, and so if they require a
different empty FPU state, they must as well add yet another bitflag to
enable SSE3, if they don't the chip isn't backwards compatible.

If they only add new instructions like in sse2 than everything is fine
and the same binary image will work regardless of xorps or
universal-rxrestor.

If the register layout changes, by the time we change the kernel to
enable SSE3, it will be trivial to add yet another series of xoprs in
init_fpu (or a control word initialization ala load_mxcsr) and it will
remain much faster than fxrestor, and actually much simpler as well
IMHO.

This is why I don't feel the need of compilcating the code creating the
"empty fpu" during boot etc..

Andrea
