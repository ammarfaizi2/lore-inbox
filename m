Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTEIL1j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 07:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262470AbTEIL1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 07:27:38 -0400
Received: from mrt-aod.iram.es ([150.214.224.146]:29196 "EHLO mrt-lx16.iram.es")
	by vger.kernel.org with ESMTP id S262464AbTEIL0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 07:26:38 -0400
Date: Fri, 9 May 2003 10:48:43 +0000
From: paubert <paubert@iram.es>
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@suse.de>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Mask mxcsr according to cpu features.
Message-ID: <20030509104843.A16311@mrt-lx16.iram.es>
References: <20030509004200.A22795@mrt-lx16.iram.es> <3EBB4B60.4080905@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBB4B60.4080905@wanadoo.fr>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 06:32:00AM +0000, Philippe Elie wrote:
> paubert wrote:
> >[CC'ed to x86_64 and ia64 maintainers because they might have the 
> >same issues. For existing x86_64 processors, s/0xffbf/0xffff/ in 
> >arch/x86-64/ia32/{fpu32,ptrace32}.c might be sufficient]
> >
> >With SSE2, mxcsr bit 6 is defined as controlling whether
> >denormals should be treated as zeroes or not. Setting it
> >no more causes an exception, but with the current code it 
> >would be cleared at every signal return which is a bit harsh.
> >
> >The following patch fixes this (2.5, but easily ported to 2.4).
> >
> >===== arch/i386/kernel/i387.c 1.16 vs edited =====
> >--- 1.16/arch/i386/kernel/i387.c	Wed Apr  9 05:45:37 2003
> >+++ edited/arch/i386/kernel/i387.c	Thu May  8 23:30:23 2003
> >@@ -25,6 +25,12 @@
> > #define HAVE_HWFP 1
> > #endif
> > 
> >+/* mxcsr bits 31-16 must be zero for security reasons,
> >+ * bit 6 depends on cpu features.
> >+ */
> >+#define MXCSR_MASK (cpu_has_sse2 ? 0xffff : 0xffbf)
> >+
> >+
> 
> I don't think daz bit depend on sse2, it's a separate features

The doc I have state in several places:
"The denormals-are-zeros mode was introduced in the Pentium 4 processor 
with the SSE2 extensions."

Maybe I should download a newer doc from Intel. The one I have states
that DAZ is associated with sse2, and does not speak at _all_ of the 
MXCSR_MASK field (I have seen it in my x86_64 doc though).


> 
> > /*
> >  * The _current_ task is using the FPU for the first time
> >  * so initialize it and set the mxcsr to its default
> >@@ -208,7 +214,7 @@
> > void set_fpu_mxcsr( struct task_struct *tsk, unsigned short mxcsr )
> > {
> > 	if ( cpu_has_xmm ) {
> >-		tsk->thread.i387.fxsave.mxcsr = (mxcsr & 0xffbf);
> >+		tsk->thread.i387.fxsave.mxcsr = (mxcsr & MXCSR_MASK);
> 
> 
> intel and x64 doc advocate to use
> 
> mxcsr &= tsk->thread.i387.fxsave.mxscr_mask
> 	? 0xffbf : tsk->thread.i387.fxsave.mxscr_mask;
> tsk->thread.i387.fxsave.mxscr =  mxcsr;
> 
> with mxscr_mask the 16 upper bits of field currently named
> mxscr in fxsave area. This bits was zeroed by previous processor
> so this must be backward compatible.

So the question is, are there processors in the wild which have DAZ but
still clear the MXCSR_MASK field?

It's simply a matter of rewriting the MXCSR_MASK macro, but to avoid
a conditional, I'd rather have a global mxcsr_mask variable somewhere
with the cpu feature flags. 
 
	Gabriel


 
	Gabriel.
