Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314857AbSDVWZF>; Mon, 22 Apr 2002 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314854AbSDVWZE>; Mon, 22 Apr 2002 18:25:04 -0400
Received: from fmr01.intel.com ([192.55.52.18]:4349 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S314859AbSDVWZB>;
	Mon, 22 Apr 2002 18:25:01 -0400
Message-ID: <9287DC1579B0D411AA2F009027F44C3F171C1A9E@FMSMSX41>
From: "Saxena, Sunil" <sunil.saxena@intel.com>
To: "'rhkernel-dept-list@redhat.com'" <rhkernel-dept-list@redhat.com>
Cc: linux-kernel@vger.kernel.org, jakub@redhat.com, aj@suse.de, ak@suse.de,
        pavel@atrey.karlin.mff.cuni.cz
Subject: RE: SSE related security hole
Date: Mon, 22 Apr 2002 15:24:40 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

Sorry it took us some time to respond to this issue.

The Intel prescribed method for correct execution of SSE/SSE2 instructions
requires that software detect the support for these instructions via the
CPUID feature flags bits, prior to executing the instruction (see
<<ftp://download.intel.com/design/perftool/cbts/appnotes/ap900/cpuosid.pdf>>
). Also, Section 2.2 of the IA-32 Intel(R) Architecture Software Developer's
Manual, Vol 2, indicates that the use of the operand size prefix with
MMX/SSE/SSE2 instructions is reserved and may cause unpredictable behavior.


We recognized that there is a discrepancy in the individual instruction
descriptions in Vol 2 where it is indicated that the instruction would
generate a UD#. We will be rectifying this discrepancy in the next revision
of Vol 2 as well as via the monthly Specification Updates.

Thanks
Sunil


-----Original Message-----
From: Doug Ledford [mailto:dledford@redhat.com] 
Sent: Wednesday, April 17, 2002 4:56 PM
To: sunil.saxena@intel.com
Cc: linux-kernel@vger.kernel.org; jakub@redhat.com; aj@suse.de; ak@suse.de;
pavel@atrey.karlin.mff.cuni.cz
Subject: Re: SSE related security hole


Subject: Re: SSE related security hole
Reply-To: 
In-Reply-To: <200204171513.g3HFD3n04056@fenrus.demon.nl>; from
arjan@fenrus.demon.nl on Wed, Apr 17, 2002 at 04:13:03PM +0100

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

> The problem appears to be reproducible only on pentium3 and athlon4
systems,
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
  



_______________________________________________
rhkernel-dept-list mailing list
rhkernel-dept-list@redhat.com
http://post-office.corp.redhat.com/mailman/listinfo/rhkernel-dept-list
