Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129541AbQKRQ5S>; Sat, 18 Nov 2000 11:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQKRQ5I>; Sat, 18 Nov 2000 11:57:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:18697 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129541AbQKRQ44>; Sat, 18 Nov 2000 11:56:56 -0500
Date: Sat, 18 Nov 2000 08:26:27 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: linux-kernel@vger.kernel.org, Markus Schoder <markus_schoder@yahoo.de>
Subject: Re: Freeze on FPU exception with Athlon
In-Reply-To: <3A168F08.F124A76A@didntduck.org>
Message-ID: <Pine.LNX.4.10.10011180809250.8465-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Nov 2000, Brian Gerst wrote:
> 
> I get Floating Point Exception (core dumped), but I needed to use the
> modified program below to keep GCC from optimizing the division away as
> a constant.  This is on test11-pre5.

I'm starting to suspect that it's really a combination of three things: 
 - 3dnow optimization (ie you have to compile the kernel with Athlon
   support)
 - pending, but not yet noticed, FPU exceptions.
 - a bug/feature in the kernel, where a process exit does not bother to
   clear the FPU, only marks it as "unused".

If I'm right, the proper test-program should be something like

	int main(int argc, char **argv)
	{
	        asm("fldcw %0": :"m" (0));
	        asm("fldz ; fld1 ; fdiv");
		sleep(1);
	        return 0;
	}

where it's important that we do not wait for the result of the fdiv, we
just exit after having caused a pending exception (and you cannot do this 
reliably from C code - depending on compiler version and optimizations
gcc may try to write the bad value back to memory etc). 

Now, with the pending exception, do a 3dnow MMX memcpy() - which will
clear the TS bit (because it decides that the FP state can be thrown
away and doesn't need to do a full save/restore) and start using the FPU.
Boom. Instant FP exception. With the exception handler deciding that
nobody owns the FP state, and thus doing nothing sane.

If I'm right (and I'm _always_ right), the following patch would make a
difference.

Markus?

		Linus

----
--- v2.4.0-test10/linux/arch/i386/kernel/traps.c	Tue Oct 31 12:42:26 2000
+++ linux/arch/i386/kernel/traps.c	Fri Nov 17 21:52:55 2000
@@ -643,6 +640,12 @@
 asmlinkage void do_coprocessor_error(struct pt_regs * regs, long error_code)
 {
 	ignore_irq13 = 1;
+
+	/* Due to lazy error handling, we might have false pending errors! */
+	if (!current->used_math) {
+		init_fpu();
+		return;
+	}	
 	math_error((void *)regs->eip);
 }
 
@@ -700,6 +703,12 @@
 	if (cpu_has_xmm) {
 		/* Handle SIMD FPU exceptions on PIII+ processors. */
 		ignore_irq13 = 1;
+
+		/* Due to lazy error handling, we might have false pending errors! */
+		if (!current->used_math) {
+			init_fpu();
+			return;
+		}	
 		simd_math_error((void *)regs->eip);
 	} else {
 		/*

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
