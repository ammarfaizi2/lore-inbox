Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132948AbRAKSyx>; Thu, 11 Jan 2001 13:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132952AbRAKSyn>; Thu, 11 Jan 2001 13:54:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33056 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132948AbRAKSyh>; Thu, 11 Jan 2001 13:54:37 -0500
Date: Thu, 11 Jan 2001 19:53:16 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Andi Kleen <ak@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre1 breaks XFree 4.0.2 and "w"
Message-ID: <20010111195316.A892@athlon.random>
In-Reply-To: <3A5C6417.6670FCB7@Hell.WH8.TU-Dresden.De> <20010110181516.X10035@nightmaster.csn.tu-chemnitz.de> <3A5C96BB.96B19DB@Hell.WH8.TU-Dresden.De> <200101110841.AAA01652@penguin.transmeta.com> <3A5D8583.F5F30BD2@Hell.WH8.TU-Dresden.De> <20010111111145.A19584@gruyere.muc.suse.de> <3A5D8B79.AD1E161D@Hell.WH8.TU-Dresden.De> <20010111183605.A828@athlon.random> <20010111184645.B828@athlon.random> <20010111184821.E828@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010111184821.E828@athlon.random>; from andrea@suse.de on Thu, Jan 11, 2001 at 06:48:21PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2001 at 06:48:21PM +0100, Andrea Arcangeli wrote:
> Ah no, I even better, just pass `nofxsr` to the 2.4.1-pre2 kernel. (no
> need to recompile)

Ok here the right fix against 2.4.1-pre2 so now you can use 3dnow and fxsr
at the same time (and nofxsr can still dynamically disable fxsr and xmm):

diff -urN -X /home/andrea/bin/dontdiff 2.4.1-pre2/arch/i386/kernel/i386_ksyms.c 2.4.1-pre2-fxsr/arch/i386/kernel/i386_ksyms.c
--- 2.4.1-pre2/arch/i386/kernel/i386_ksyms.c	Thu Dec 14 22:33:59 2000
+++ 2.4.1-pre2-fxsr/arch/i386/kernel/i386_ksyms.c	Thu Jan 11 18:07:53 2001
@@ -116,6 +116,7 @@
 EXPORT_SYMBOL(mmx_clear_page);
 EXPORT_SYMBOL(mmx_copy_page);
 #endif
+EXPORT_SYMBOL(mmu_cr4_features);
 
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
diff -urN -X /home/andrea/bin/dontdiff 2.4.1-pre2/arch/i386/kernel/i387.c 2.4.1-pre2-fxsr/arch/i386/kernel/i387.c
--- 2.4.1-pre2/arch/i386/kernel/i387.c	Thu Jan 11 17:52:05 2001
+++ 2.4.1-pre2-fxsr/arch/i386/kernel/i387.c	Thu Jan 11 18:55:52 2001
@@ -43,7 +43,7 @@
  * FPU lazy state save handling.
  */
 
-void save_init_fpu( struct task_struct *tsk )
+inline void __save_init_fpu( struct task_struct *tsk )
 {
 	if ( HAVE_FXSR ) {
 		asm volatile( "fxsave %0 ; fnclex"
@@ -53,6 +53,11 @@
 			      : "=m" (tsk->thread.i387.fsave) );
 	}
 	tsk->flags &= ~PF_USEDFPU;
+}
+
+void save_init_fpu( struct task_struct *tsk )
+{
+	__save_init_fpu(tsk);
 	stts();
 }
 
diff -urN -X /home/andrea/bin/dontdiff 2.4.1-pre2/arch/i386/lib/mmx.c 2.4.1-pre2-fxsr/arch/i386/lib/mmx.c
--- 2.4.1-pre2/arch/i386/lib/mmx.c	Tue Nov 28 18:39:59 2000
+++ 2.4.1-pre2-fxsr/arch/i386/lib/mmx.c	Thu Jan 11 19:23:53 2001
@@ -29,10 +29,7 @@
 	if (!(current->flags & PF_USEDFPU))
 		clts();
 	else
-	{
-		__asm__ __volatile__ ( " fnsave %0; fwait\n"::"m"(current->thread.i387));
-		current->flags &= ~PF_USEDFPU;
-	}
+		__save_init_fpu(current);
 
 	__asm__ __volatile__ (
 		"1: prefetch (%0)\n"		/* This set is 28 bytes */
@@ -98,10 +95,7 @@
 	if (!(current->flags & PF_USEDFPU))
 		clts();
 	else
-	{
-		__asm__ __volatile__ ( " fnsave %0; fwait\n"::"m"(current->thread.i387));
-		current->flags &= ~PF_USEDFPU;
-	}
+		__save_init_fpu(current);
 	
 	__asm__ __volatile__ (
 		"  pxor %%mm0, %%mm0\n" : :
@@ -136,10 +130,7 @@
 	if (!(current->flags & PF_USEDFPU))
 		clts();
 	else
-	{
-		__asm__ __volatile__ ( " fnsave %0; fwait\n"::"m"(current->thread.i387));
-		current->flags &= ~PF_USEDFPU;
-	}
+		__save_init_fpu(current);
 
 	/* maybe the prefetch stuff can go before the expensive fnsave...
 	 * but that is for later. -AV
diff -urN -X /home/andrea/bin/dontdiff 2.4.1-pre2/include/asm-i386/i387.h 2.4.1-pre2-fxsr/include/asm-i386/i387.h
--- 2.4.1-pre2/include/asm-i386/i387.h	Thu Jan 11 17:59:31 2001
+++ 2.4.1-pre2-fxsr/include/asm-i386/i387.h	Thu Jan 11 18:56:32 2001
@@ -20,6 +20,7 @@
 /*
  * FPU lazy state save handling...
  */
+extern void __save_init_fpu( struct task_struct *tsk );
 extern void save_init_fpu( struct task_struct *tsk );
 extern void restore_fpu( struct task_struct *tsk );
 

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
