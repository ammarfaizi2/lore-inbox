Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312889AbSDSVDc>; Fri, 19 Apr 2002 17:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312895AbSDSVDb>; Fri, 19 Apr 2002 17:03:31 -0400
Received: from [195.223.140.120] ([195.223.140.120]:26713 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312889AbSDSVDa>; Fri, 19 Apr 2002 17:03:30 -0400
Date: Fri, 19 Apr 2002 23:04:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Cc: Jan Hubicka <jh@suse.cz>
Subject: Re: SSE related security hole
Message-ID: <20020419230454.C1291@dualathlon.random>
In-Reply-To: <20020418183639.20946.qmail@science.horizon.com.suse.lists.linux.kernel> <a9ncgs$2s2$1@cesium.transmeta.com.suse.lists.linux.kernel> <p73662naili.fsf@oldwotan.suse.de> <20020419140031.A25519@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 02:00:31PM -0400, Doug Ledford wrote:
> On Fri, Apr 19, 2002 at 04:06:17PM +0200, Andi Kleen wrote:
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > > 
> > > Perhaps the right thing to do is to have a description in data of the
> > > desired initialization state and just F[NX]RSTOR it?
> > 
> > Sounds like the cleanest solution. The state could be saved at CPU bootup
> > with just MXCSR initialized.
> > 
> > I'll implement that for x86-64.
> 
> Ummm...last I knew, fxrstor is *expensive*.  The fninit/xor regs setup is 
> likely *very* much faster.  Someone should check this before we sacrifice 
> 100 cycles needlessly or something.

most probably yes, fxrestor needs to read ram, pxor also takes some
icache and bytecode ram but it sounds like it will be faster.

Maybe we could also interleave the pxor with the xorps, since they uses
different parts of the cpu, Honza?

diff -urN ref/arch/x86_64/kernel/i387.c xmm/arch/x86_64/kernel/i387.c
--- ref/arch/x86_64/kernel/i387.c	Fri Apr 19 19:37:30 2002
+++ xmm/arch/x86_64/kernel/i387.c	Fri Apr 19 19:39:02 2002
@@ -34,6 +34,31 @@
 	struct task_struct *me = current;
 	__asm__("fninit");
 	load_mxcsr(0x1f80);
+	asm volatile("pxor %mm0, %mm0\n\t"
+		     "pxor %mm1, %mm1\n\t"
+		     "pxor %mm2, %mm2\n\t"
+		     "pxor %mm3, %mm3\n\t"
+		     "pxor %mm4, %mm4\n\t"
+		     "pxor %mm5, %mm5\n\t"
+		     "pxor %mm6, %mm6\n\t"
+		     "pxor %mm7, %mm7\n\t"
+		     "emms\n\t"
+		     "xorps %xmm0,  %xmm0\n\t"
+		     "xorps %xmm1,  %xmm1\n\t"
+		     "xorps %xmm2,  %xmm2\n\t"
+		     "xorps %xmm3,  %xmm3\n\t"
+		     "xorps %xmm4,  %xmm4\n\t"
+		     "xorps %xmm5,  %xmm5\n\t"
+		     "xorps %xmm6,  %xmm6\n\t"
+		     "xorps %xmm7,  %xmm7\n\t"
+		     "xorps %xmm8,  %xmm8\n\t"
+		     "xorps %xmm9,  %xmm9\n\t"
+		     "xorps %xmm10, %xmm10\n\t"
+		     "xorps %xmm11, %xmm11\n\t"
+		     "xorps %xmm12, %xmm12\n\t"
+		     "xorps %xmm13, %xmm13\n\t"
+		     "xorps %xmm14, %xmm14\n\t"
+		     "xorps %xmm15, %xmm15\n");
 	me->used_math = 1;
 }
 

Andrea
