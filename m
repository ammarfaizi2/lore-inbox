Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbTEKXS1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 19:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbTEKXS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 19:18:26 -0400
Received: from mrt-lx1.iram.es ([150.214.224.59]:60109 "EHLO mrt-lx1.iram.es")
	by vger.kernel.org with ESMTP id S261446AbTEKXSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 19:18:23 -0400
Date: Sun, 11 May 2003 23:31:03 +0000
From: Gabriel Paubert <paubert@iram.es>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@suse.de>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [CFT] [RFC] Correct mxcsr handling (was: Mask mxcsr according to cpu features.)
Message-ID: <20030511233103.A27165@mrt-lx1.iram.es>
References: <20030509004200.A22795@mrt-lx16.iram.es> <3EBB4B60.4080905@wanadoo.fr> <20030509104843.A16311@mrt-lx16.iram.es> <3EBBD861.5070404@wanadoo.fr> <20030509165051.A31465@mrt-lx16.iram.es> <3EBC16FE.506@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBC16FE.506@wanadoo.fr>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 09:00:46PM +0000, Philippe Elie wrote:
> >I don't believe that there is any, but that maybe some which don't
> >write anything, hence the requirement for clearing the area in the
> >DAZ detection algorithm.
> 
> right

That's indeed the case on a Celeron/Coppermine I just tested
with a trivial application.
 
> uh? you just need to fxsave on stack, extract the mask, the struct
> is 512 bytes length, surely during kernel init 512 bytes stack
> allocation is right

Beware of the alignment requirement, in the following patch I just
allocated 512 bytes of initdata for this. Not elegant but safe.

> 
> >not want to touch too many files in my patch, but it seems unavoidable. 
> 
> 
> >Now a last question, are there SMP systems in which one processor
> >supports DAZ and the other does not, just to complicate matters a
> >little more?
> 
> Such system are not symetric. I don't think we must take care
> about this theorical things and I'm pretty sure than mixing old
> P4 and newers in a box can't work. Anyway even if it works
> userspace program using DAZ will be not reliable since they can
> run from time to time on cpu with DAZ then cpu w/o DAZ.

Hmmm, the (misnamed) boot_cpu_data flags are the intersection of 
all the cpu flags. So I did the same for mxcsr_mask.

Anyway, here is the second version of the patch. Unfortunately I could
not test it, only compile, and I'm going to be away from any machine 
I can play with until mid-June or so. It took me some time to
understand early boot, especially how cr4 OSFXSR, first set up through
check_bugs(!), propagated to other processors through the global
(and misnamed) mmu_cr4_features, and I might have missed other things.

I repeat, handle with care, I'm not sure at all that it won't eat
your data and there are things that I don't like about it: mostly
that boot_cpu_data should be reordered so that mxcsr_mask is close
to the capabilities. There are #defines of the offsets in this 
structure in head.S, changing this is far too dangerous for a patch 
that I can't test. 

     Regards,
     Gabriel

===== arch/i386/kernel/i387.c 1.16 vs edited =====
--- 1.16/arch/i386/kernel/i387.c	Wed Apr  9 05:45:37 2003
+++ edited/arch/i386/kernel/i387.c	Sun May 11 20:55:32 2003
@@ -208,7 +208,8 @@
 void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr )
 {
 	if ( cpu_has_xmm ) {
-		tsk->thread.i387.fxsave.mxcsr = (mxcsr & 0xffbf);
+		tsk->thread.i387.fxsave.mxcsr = 
+		    mxcsr & boot_cpu_data.mxcsr_mask;
 	}
 }
 
@@ -356,8 +357,7 @@
 	clear_fpu( tsk );
 	err = __copy_from_user( &tsk->thread.i387.fxsave, &buf->_fxsr_env[0],
 				sizeof(struct i387_fxsave_struct) );
-	/* mxcsr bit 6 and 31-16 must be zero for security reasons */
-	tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+	tsk->thread.i387.fxsave.mxcsr &= boot_cpu_data.mxcsr_mask;
 	return err ? 1 : convert_fxsr_from_user( &tsk->thread.i387.fxsave, buf );
 }
 
@@ -455,8 +455,7 @@
 	if ( cpu_has_fxsr ) {
 		__copy_from_user( &tsk->thread.i387.fxsave, buf,
 				  sizeof(struct user_fxsr_struct) );
-		/* mxcsr bit 6 and 31-16 must be zero for security reasons */
-		tsk->thread.i387.fxsave.mxcsr &= 0xffbf;
+		tsk->thread.i387.fxsave.mxcsr &= boot_cpu_data.mxcsr_mask;
 		return 0;
 	} else {
 		return -EIO;
===== arch/i386/kernel/cpu/common.c 1.21 vs edited =====
--- 1.21/arch/i386/kernel/cpu/common.c	Sun Mar 23 15:55:48 2003
+++ edited/arch/i386/kernel/cpu/common.c	Sun May 11 22:43:44 2003
@@ -262,6 +262,7 @@
 __setup("serialnumber", x86_serial_nr_setup);
 
 
+static struct i387_fxsave_struct fxsave_area __initdata;
 
 /*
  * This does the hard work of actually picking apart the CPU stuff...
@@ -324,6 +325,24 @@
 		clear_bit(X86_FEATURE_XMM, c->x86_capability);
 	}
 
+	if (test_bit(X86_FEATURE_XMM, c->x86_capability)) {
+		/* Setting OSFXSR may not be necessary */
+		unsigned cr0, cr4;
+		long mask;
+
+		memset(&fxsave_area, 0, sizeof fxsave_area);
+		cr0 = read_cr0();
+		cr4 = read_cr4();
+		write_cr4(cr4|X86_CR4_OSFXSR);
+		clts();
+		__asm__ __volatile__("fxsave %0": "=m" (fxsave_area));
+		write_cr4(cr4);
+		write_cr0(cr0);
+		mask = fxsave_area.mxcsr_mask;
+		mask = mask ? mask : 0xffbf;
+		c->mxcsr_mask = mask;
+	}
+
 	if (disable_pse)
 		clear_bit(X86_FEATURE_PSE, c->x86_capability);
 
@@ -357,6 +376,7 @@
 		/* AND the already accumulated flags with these */
 		for ( i = 0 ; i < NCAPINTS ; i++ )
 			boot_cpu_data.x86_capability[i] &= c->x86_capability[i];
+		boot_cpu_data.mxcsr_mask &= c->mxcsr_mask;
 	}
 
 	/* Init Machine Check Exception if available. */
===== include/asm-i386/processor.h 1.50 vs edited =====
--- 1.50/include/asm-i386/processor.h	Fri May  9 21:24:03 2003
+++ edited/include/asm-i386/processor.h	Sun May 11 20:53:22 2003
@@ -63,6 +63,7 @@
 	int	f00f_bug;
 	int	coma_bug;
 	unsigned long loops_per_jiffy;
+	long    mxcsr_mask;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL 0
@@ -320,7 +321,7 @@
 	long	foo;
 	long	fos;
 	long	mxcsr;
-	long	reserved;
+	long	mxcsr_mask;
 	long	st_space[32];	/* 8*16 bytes for each FP-reg = 128 bytes */
 	long	xmm_space[32];	/* 8*16 bytes for each XMM-reg = 128 bytes */
 	long	padding[56];
