Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314204AbSDQXnA>; Wed, 17 Apr 2002 19:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314205AbSDQXm7>; Wed, 17 Apr 2002 19:42:59 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:15773 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S314204AbSDQXm6>; Wed, 17 Apr 2002 19:42:58 -0400
Date: Wed, 17 Apr 2002 19:42:49 -0400
From: Doug Ledford <dledford@redhat.com>
To: jh@suse.cz
Cc: linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de, ak@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole
Message-ID: <20020417194249.B23438@redhat.com>
Mail-Followup-To: Doug Ledford <dledford@redhat.com>, jh@suse.cz,
	linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de,
	ak@suse.de, pavel@atrey.karlin.mff.cuni.cz
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: SSE related security hole
Reply-To: 
In-Reply-To: <200204171513.g3HFD3n04056@fenrus.demon.nl>; from arjan@fenrus.demon.nl on Wed, Apr 17, 2002 at 04:13:03PM +0100

(NOTE: This may have already been answered by someone else, but I haven't 
seen it if it has, so I'm sending this through)

> Hi,
> while debugging GCC bugreport, I noticed following behaviour of simple
> program with no syscalls:
> 
> hubicka@nikam:~$ ./a.out
> sum of 7 ints: 28
> hubicka@nikam:~$ ./a.out
> sum of 7 ints: 56
> Bad sum (seen with gcc -O -march=pentiumpro -msse)
> hubicka@nikam:~$ ./a.out
> sum of 7 ints: 84
> Bad sum (seen with gcc -O -march=pentiumpro -msse)
> hubicka@nikam:~$ ./a.out
> sum of 7 ints: 112
> Bad sum (seen with gcc -O -march=pentiumpro -msse)
> hubicka@nikam:~$ echo
> 
> hubicka@nikam:~$ ./a.out
> sum of 7 ints: 28
> 
> 
> ie it always returns different value, moreover when something else
> is run in meantime (verified by loading WWW page served by same machine),
> the counter is reinitialized to 28.
> 
> I am attaching the source, but it needs to be compiled by cfg-branch GCC
> with settings -O2 -march=pentium3 -mfpmath=sse, so I've placed static
> binary to http://atrey.karlin.mff.cuni.cz/~hubicka/badsum.bin

Compiling the asm source with a different compiler will also make it fail.

> The problem appears to be reproducible only on pentium3 and athlon4 systems,
> not pentium4 system, where it appears to work as expected.  Reproduced on
> both 2.4.9-RH and 2.4.16 kernels.

[ program snipped ]

So there are two different issues at play here.  First, the kernel uses
the fninit instruction to initialize the fpu on first use.  Nothing in the
Intel manuals says anything about the fninit instruction clearing the mmx
or sse registers, and experimentally we now know for sure that it doesn't.  
That means that when the first time your program was ran it left 28 in
register xmm1.  The next time the program was run, the fninit did nothing
to clear register xmm1 so it still held 28.  Now, the pxor instruction
that is part of the m() function and intended to 0 out the xmm1 register
is an sse2 instruction.  It just so happens that it doesn't work on sse
only processors such as P3 CPUs.  So, when 28 was left in xmm1, then the
pxor failed to 0 out xmm1, we saved 28 as the starting value for the loop
and then looped through 7 additions until we had, you guessed it, 56.  In
fact, if you do a while :;do bad; done loop the it will increment by 28
each time it is run except when something else intervenes.  Replacing the
pxor instruction with xorps instead makes it work.  So, that's a bug in
gcc I suspect, using sse2 instructions when only called to use sse
instructions.  It seems odd to me that the CPU wouldn't generate an
illegal instruction exception, but oh well, it evidently doesn't.

So, we really should change arch/i386/kernel/i387.c something like this:

(WARNING, totally untested and not even compile checked change follows)

--- i387.c.save	Wed Apr 17 19:22:47 2002
+++ i387.c	Wed Apr 17 19:28:27 2002
@@ -33,8 +33,26 @@
 void init_fpu(void)
 {
 	__asm__("fninit");
-	if ( cpu_has_xmm )
+	if ( cpu_has_mmx )
+		asm volatile("xorq %%mm0, %%mm0;
+			      xorq %%mm1, %%mm1;
+			      xorq %%mm2, %%mm2;
+			      xorq %%mm3, %%mm3;
+			      xorq %%mm4, %%mm4;
+			      xorq %%mm5, %%mm5;
+			      xorq %%mm6, %%mm6;
+			      xorq %%mm7, %%mm7");
+	if ( cpu_has_xmm ) {
+		asm volatile("xorps %%xmm0, %%xmm0;
+			      xorps %%xmm1, %%xmm1;
+			      xorps %%xmm2, %%xmm2;
+			      xorps %%xmm3, %%xmm3;
+			      xorps %%xmm4, %%xmm4;
+			      xorps %%xmm5, %%xmm5;
+			      xorps %%xmm6, %%xmm6;
+			      xorps %%xmm7, %%xmm7");
 		load_mxcsr(0x1f80);
+	}
 		
 	current->used_math = 1;
 }


The rest of the problem is a gcc bug and possibly something that Intel 
should make a note of on the p3 processors (that is, that the p3 will 
silently fail to execute some sse2 instructions without generating the 
expected exception).

-- 
  Doug Ledford <dledford@redhat.com>     919-754-3700 x44233
         Red Hat, Inc. 
         1801 Varsity Dr.
         Raleigh, NC 27606
  
