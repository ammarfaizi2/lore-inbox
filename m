Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVCRJ6q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVCRJ6q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVCRJ6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:58:46 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13321 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261535AbVCRJzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:55:52 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] add a clear_pages function to clear pages of higher order
Date: Fri, 18 Mar 2005 11:54:37 +0200
User-Agent: KMail/1.5.4
Cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mel Gorman <mel@csn.ul.ie>, linux-ia64@vger.kernel.org,
       Jens.Maurer@gmx.net
References: <Pine.LNX.4.58.0503101229420.13911@schroedinger.engr.sgi.com> <200503111008.12134.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0503161720570.1787@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dVqOCAfmkOGprew"
Message-Id: <200503181154.37414.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dVqOCAfmkOGprew
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 17 March 2005 03:33, Christoph Lameter wrote:
> On Fri, 11 Mar 2005, Denis Vlasenko wrote:
> 
> > Andi Kleen (iirc) says that non-temporal stores seem to be
> > big win in microbenchmarks (and I second that), but they are
> > a net loss when we are going to use zeroed page just after
> > zeroing. He recommends avoid using non-temporal stores
> >
> > With this new page prezeroing infrastructure, that argument
> > most likely is not right anymore. Especially clearing of
> > high-order pages definitely will benefit from NT stores
> > because they do not kill L1 data cache in the process.
> >
> > I don't have K8 and therefore cannot be 100% sure, but
> > I really doubt that K8 optimize "rep stosq" into _NT_ stores.
> 
> Hmm. That would be interesting to know and may be necessary to justify
> the continued existence of this patch. I tried to get some numbers on
> the performance wins for zeroing larger pages with the patch as is (no
> NT stores) and came up with:
> 
> Processor				Performance Increase
> ----------------------------------------------------------------
> Itanium 2 1.3Ghz M1/R5			1.5%
> AMD Athlon 64 3200+ i386 mode		3%
> AMD Athlon 64 3200+ x86_64 mode		3.3%
> 
> (this is if the zeroing engine is the cpu of course. Prezeroing
> may be done through some DMA gizmo independent of the cpu)
> 
> Itanium has more extensive optimization capabilities and
> seems to be able to better cope with the loop logic for regular
> clear_page. Thus the improvement is even less on Itanium.
> 
> Numbers obtained with the following patch that allows to get performance
> data from /proc/meminfo on zeroing performance (just divide Cycles by
> Pages for clear_page and clear_pages):

Here is a patch which allows to try different page zeroing
optimizations to be tested at runtime via sysctl.
Was run tested in 2.6.8 time. Rediffed to 2.6.11.
Feel free to adapt to your patch and test.

Also attached is a tarball for microbenchmarking routines. There are two
result files. Duron:

               normal_clear_page - took  8644 max, 8400 min cycles per page
             repstosl_clear_page - took  8626 max, 8418 min cycles per page
                 movq_clear_page - took  8647 max, 8300 min cycles per page
               movntq_clear_page - took  2777 max, 2720 min cycles per page

And amd64:
               normal_clear_page - took  9427 max, 5781 min cycles per page
             repstosl_clear_page - took  9305 max, 5680 min cycles per page
                 movq_clear_page - took  6167 max, 5576 min cycles per page
               movntq_clear_page - took  5456 max, 2354 min cycles per page

NT stores are not about 5% increase. 200%-300%. Provided you are ok with
the fact that zeroed page ends up evicted from cache. Luckily, this is exactly
what you want with prezeroing.
--
vda

--Boundary-00=_dVqOCAfmkOGprew
Content-Type: text/x-diff;
  charset="koi8-r";
  name="x86_SSE_clear_page.2611.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="x86_SSE_clear_page.2611.patch"

diff -urpN linux-2.6.11.src/arch/i386/lib/Makefile linux-2.6.11-nt.src/arch/i386/lib/Makefile
--- linux-2.6.11.src/arch/i386/lib/Makefile	Tue Oct 19 00:53:10 2004
+++ linux-2.6.11-nt.src/arch/i386/lib/Makefile	Fri Mar 18 11:30:51 2005
@@ -4,7 +4,7 @@
 
 
 lib-y = checksum.o delay.o usercopy.o getuser.o memcpy.o strstr.o \
-	bitops.o
+	bitops.o page_ops.o mmx_page.o sse_page.o
 
 lib-$(CONFIG_X86_USE_3DNOW) += mmx.o
 lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o
diff -urpN linux-2.6.11.src/arch/i386/lib/mmx.c linux-2.6.11-nt.src/arch/i386/lib/mmx.c
--- linux-2.6.11.src/arch/i386/lib/mmx.c	Tue Oct 19 00:54:23 2004
+++ linux-2.6.11-nt.src/arch/i386/lib/mmx.c	Fri Mar 18 11:30:51 2005
@@ -120,280 +120,3 @@ void *_mmx_memcpy(void *to, const void *
 	kernel_fpu_end();
 	return p;
 }
-
-#ifdef CONFIG_MK7
-
-/*
- *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
- *	other MMX using processors do not.
- */
-
-static void fast_clear_page(void *page)
-{
-	int i;
-
-	kernel_fpu_begin();
-	
-	__asm__ __volatile__ (
-		"  pxor %%mm0, %%mm0\n" : :
-	);
-
-	for(i=0;i<4096/64;i++)
-	{
-		__asm__ __volatile__ (
-		"  movntq %%mm0, (%0)\n"
-		"  movntq %%mm0, 8(%0)\n"
-		"  movntq %%mm0, 16(%0)\n"
-		"  movntq %%mm0, 24(%0)\n"
-		"  movntq %%mm0, 32(%0)\n"
-		"  movntq %%mm0, 40(%0)\n"
-		"  movntq %%mm0, 48(%0)\n"
-		"  movntq %%mm0, 56(%0)\n"
-		: : "r" (page) : "memory");
-		page+=64;
-	}
-	/* since movntq is weakly-ordered, a "sfence" is needed to become
-	 * ordered again.
-	 */
-	__asm__ __volatile__ (
-		"  sfence \n" : :
-	);
-	kernel_fpu_end();
-}
-
-static void fast_copy_page(void *to, void *from)
-{
-	int i;
-
-	kernel_fpu_begin();
-
-	/* maybe the prefetch stuff can go before the expensive fnsave...
-	 * but that is for later. -AV
-	 */
-	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 4\n"
-		"	.long 1b, 3b\n"
-		".previous"
-		: : "r" (from) );
-
-	for(i=0; i<(4096-320)/64; i++)
-	{
-		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
-		"   movntq %%mm0, (%1)\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movntq %%mm1, 8(%1)\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movntq %%mm2, 16(%1)\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movntq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm4\n"
-		"   movntq %%mm4, 32(%1)\n"
-		"   movq 40(%0), %%mm5\n"
-		"   movntq %%mm5, 40(%1)\n"
-		"   movq 48(%0), %%mm6\n"
-		"   movntq %%mm6, 48(%1)\n"
-		"   movq 56(%0), %%mm7\n"
-		"   movntq %%mm7, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 4\n"
-		"	.long 1b, 3b\n"
-		".previous"
-		: : "r" (from), "r" (to) : "memory");
-		from+=64;
-		to+=64;
-	}
-	for(i=(4096-320)/64; i<4096/64; i++)
-	{
-		__asm__ __volatile__ (
-		"2: movq (%0), %%mm0\n"
-		"   movntq %%mm0, (%1)\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movntq %%mm1, 8(%1)\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movntq %%mm2, 16(%1)\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movntq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm4\n"
-		"   movntq %%mm4, 32(%1)\n"
-		"   movq 40(%0), %%mm5\n"
-		"   movntq %%mm5, 40(%1)\n"
-		"   movq 48(%0), %%mm6\n"
-		"   movntq %%mm6, 48(%1)\n"
-		"   movq 56(%0), %%mm7\n"
-		"   movntq %%mm7, 56(%1)\n"
-		: : "r" (from), "r" (to) : "memory");
-		from+=64;
-		to+=64;
-	}
-	/* since movntq is weakly-ordered, a "sfence" is needed to become
-	 * ordered again.
-	 */
-	__asm__ __volatile__ (
-		"  sfence \n" : :
-	);
-	kernel_fpu_end();
-}
-
-#else
-
-/*
- *	Generic MMX implementation without K7 specific streaming
- */
- 
-static void fast_clear_page(void *page)
-{
-	int i;
-	
-	kernel_fpu_begin();
-	
-	__asm__ __volatile__ (
-		"  pxor %%mm0, %%mm0\n" : :
-	);
-
-	for(i=0;i<4096/128;i++)
-	{
-		__asm__ __volatile__ (
-		"  movq %%mm0, (%0)\n"
-		"  movq %%mm0, 8(%0)\n"
-		"  movq %%mm0, 16(%0)\n"
-		"  movq %%mm0, 24(%0)\n"
-		"  movq %%mm0, 32(%0)\n"
-		"  movq %%mm0, 40(%0)\n"
-		"  movq %%mm0, 48(%0)\n"
-		"  movq %%mm0, 56(%0)\n"
-		"  movq %%mm0, 64(%0)\n"
-		"  movq %%mm0, 72(%0)\n"
-		"  movq %%mm0, 80(%0)\n"
-		"  movq %%mm0, 88(%0)\n"
-		"  movq %%mm0, 96(%0)\n"
-		"  movq %%mm0, 104(%0)\n"
-		"  movq %%mm0, 112(%0)\n"
-		"  movq %%mm0, 120(%0)\n"
-		: : "r" (page) : "memory");
-		page+=128;
-	}
-
-	kernel_fpu_end();
-}
-
-static void fast_copy_page(void *to, void *from)
-{
-	int i;
-	
-	
-	kernel_fpu_begin();
-
-	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 4\n"
-		"	.long 1b, 3b\n"
-		".previous"
-		: : "r" (from) );
-
-	for(i=0; i<4096/64; i++)
-	{
-		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movq %%mm0, (%1)\n"
-		"   movq %%mm1, 8(%1)\n"
-		"   movq %%mm2, 16(%1)\n"
-		"   movq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm0\n"
-		"   movq 40(%0), %%mm1\n"
-		"   movq 48(%0), %%mm2\n"
-		"   movq 56(%0), %%mm3\n"
-		"   movq %%mm0, 32(%1)\n"
-		"   movq %%mm1, 40(%1)\n"
-		"   movq %%mm2, 48(%1)\n"
-		"   movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		".section __ex_table,\"a\"\n"
-		"	.align 4\n"
-		"	.long 1b, 3b\n"
-		".previous"
-		: : "r" (from), "r" (to) : "memory");
-		from+=64;
-		to+=64;
-	}
-	kernel_fpu_end();
-}
-
-
-#endif
-
-/*
- *	Favour MMX for page clear and copy. 
- */
-
-static void slow_zero_page(void * page)
-{
-	int d0, d1;
-	__asm__ __volatile__( \
-		"cld\n\t" \
-		"rep ; stosl" \
-		: "=&c" (d0), "=&D" (d1)
-		:"a" (0),"1" (page),"0" (1024)
-		:"memory");
-}
- 
-void mmx_clear_page(void * page)
-{
-	if(unlikely(in_interrupt()))
-		slow_zero_page(page);
-	else
-		fast_clear_page(page);
-}
-
-static void slow_copy_page(void *to, void *from)
-{
-	int d0, d1, d2;
-	__asm__ __volatile__( \
-		"cld\n\t" \
-		"rep ; movsl" \
-		: "=&c" (d0), "=&D" (d1), "=&S" (d2) \
-		: "0" (1024),"1" ((long) to),"2" ((long) from) \
-		: "memory");
-}
-  
-
-void mmx_copy_page(void *to, void *from)
-{
-	if(unlikely(in_interrupt()))
-		slow_copy_page(to, from);
-	else
-		fast_copy_page(to, from);
-}
diff -urpN linux-2.6.11.src/arch/i386/lib/mmx_page.c linux-2.6.11-nt.src/arch/i386/lib/mmx_page.c
--- linux-2.6.11.src/arch/i386/lib/mmx_page.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.11-nt.src/arch/i386/lib/mmx_page.c	Fri Mar 18 11:30:51 2005
@@ -0,0 +1,253 @@
+/*
+ *	MMX/3DNow! library helper functions
+ *
+ *	To do:
+ *	We can use MMX just for prefetch in IRQ's. This may be a win. 
+ *		(reported so on K6-III)
+ *	We should use a better code neutral filler for the short jump
+ *		leal ebx. [ebx] is apparently best for K6-2, but Cyrix ??
+ *	We also want to clobber the filler register so we don't get any
+ *		register forwarding stalls on the filler. 
+ *
+ *	Add *user handling. Checksums are not a win with MMX on any CPU
+ *	tested so far for any MMX solution figured.
+ *
+ *	22/09/2000 - Arjan van de Ven 
+ *		Improved for non-egineering-sample Athlons 
+ *
+ */
+ 
+#include <asm/i387.h>
+
+/*
+ *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
+ *	other MMX using processors do not.
+ */
+
+void zero_page_3dnow(void *page)
+{
+	int i;
+
+	kernel_fpu_begin();
+	
+	__asm__ __volatile__ (
+		"	pxor %%mm0, %%mm0\n" : :
+	);
+
+	for(i = 0; i < PAGE_SIZE/64; i++)
+	{
+		__asm__ __volatile__ (
+		"	movntq %%mm0, (%0)\n"
+		"	movntq %%mm0, 8(%0)\n"
+		"	movntq %%mm0, 16(%0)\n"
+		"	movntq %%mm0, 24(%0)\n"
+		"	movntq %%mm0, 32(%0)\n"
+		"	movntq %%mm0, 40(%0)\n"
+		"	movntq %%mm0, 48(%0)\n"
+		"	movntq %%mm0, 56(%0)\n"
+		: : "r" (page) : "memory"
+		);
+		page+=64;
+	}
+	/* since movntq is weakly-ordered, a "sfence" is needed to become
+	 * ordered again.
+	 */
+	__asm__ __volatile__ (
+		"	sfence\n" : :
+	);
+	kernel_fpu_end();
+}
+
+void copy_page_3dnow(void *to, void *from)
+{
+	int i;
+
+	kernel_fpu_begin();
+
+	/* maybe the prefetch stuff can go before the expensive fnsave...
+	 * but that is for later. -AV
+	 */
+	__asm__ __volatile__ (
+		"1:	prefetch (%0)\n"
+		"	prefetch 64(%0)\n"
+		"	prefetch 128(%0)\n"
+		"	prefetch 192(%0)\n"
+		"	prefetch 256(%0)\n"
+		"2:\n"
+		".section .fixup, \"ax\"\n"
+		"3:	movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
+		"	jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from)
+	);
+
+	for(i = 0; i < (PAGE_SIZE-320)/64; i++)
+	{
+		__asm__ __volatile__ (
+		"1:	prefetch 320(%0)\n"
+		"2:	movq (%0), %%mm0\n"
+		"	movntq %%mm0, (%1)\n"
+		"	movq 8(%0), %%mm1\n"
+		"	movntq %%mm1, 8(%1)\n"
+		"	movq 16(%0), %%mm2\n"
+		"	movntq %%mm2, 16(%1)\n"
+		"	movq 24(%0), %%mm3\n"
+		"	movntq %%mm3, 24(%1)\n"
+		"	movq 32(%0), %%mm4\n"
+		"	movntq %%mm4, 32(%1)\n"
+		"	movq 40(%0), %%mm5\n"
+		"	movntq %%mm5, 40(%1)\n"
+		"	movq 48(%0), %%mm6\n"
+		"	movntq %%mm6, 48(%1)\n"
+		"	movq 56(%0), %%mm7\n"
+		"	movntq %%mm7, 56(%1)\n"
+		".section .fixup, \"ax\"\n"
+		"3:	movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
+		"	jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from), "r" (to) : "memory"
+		);
+		from+=64;
+		to+=64;
+	}
+	for(i = (PAGE_SIZE-320)/64; i < PAGE_SIZE/64; i++)
+	{
+		__asm__ __volatile__ (
+		"2:	movq (%0), %%mm0\n"
+		"	movntq %%mm0, (%1)\n"
+		"	movq 8(%0), %%mm1\n"
+		"	movntq %%mm1, 8(%1)\n"
+		"	movq 16(%0), %%mm2\n"
+		"	movntq %%mm2, 16(%1)\n"
+		"	movq 24(%0), %%mm3\n"
+		"	movntq %%mm3, 24(%1)\n"
+		"	movq 32(%0), %%mm4\n"
+		"	movntq %%mm4, 32(%1)\n"
+		"	movq 40(%0), %%mm5\n"
+		"	movntq %%mm5, 40(%1)\n"
+		"	movq 48(%0), %%mm6\n"
+		"	movntq %%mm6, 48(%1)\n"
+		"	movq 56(%0), %%mm7\n"
+		"	movntq %%mm7, 56(%1)\n"
+		: : "r" (from), "r" (to) : "memory"
+		);
+		from+=64;
+		to+=64;
+	}
+	/* since movntq is weakly-ordered, a "sfence" is needed to become
+	 * ordered again.
+	 */
+	__asm__ __volatile__ (
+		"  sfence\n" : :
+	);
+	kernel_fpu_end();
+}
+
+/*
+ *	Generic MMX implementation without K7 specific streaming
+ */
+void zero_page_mmx(void *page)
+{
+	int i;
+	
+	kernel_fpu_begin();
+	
+	__asm__ __volatile__ (
+		"	pxor %%mm0, %%mm0\n" : :
+	);
+
+	for(i = 0; i < PAGE_SIZE/128; i++)
+	{
+		__asm__ __volatile__ (
+		"	movq %%mm0, (%0)\n"
+		"	movq %%mm0, 8(%0)\n"
+		"	movq %%mm0, 16(%0)\n"
+		"	movq %%mm0, 24(%0)\n"
+		"	movq %%mm0, 32(%0)\n"
+		"	movq %%mm0, 40(%0)\n"
+		"	movq %%mm0, 48(%0)\n"
+		"	movq %%mm0, 56(%0)\n"
+		"	movq %%mm0, 64(%0)\n"
+		"	movq %%mm0, 72(%0)\n"
+		"	movq %%mm0, 80(%0)\n"
+		"	movq %%mm0, 88(%0)\n"
+		"	movq %%mm0, 96(%0)\n"
+		"	movq %%mm0, 104(%0)\n"
+		"	movq %%mm0, 112(%0)\n"
+		"	movq %%mm0, 120(%0)\n"
+		: : "r" (page) : "memory"
+		);
+		page+=128;
+	}
+
+	kernel_fpu_end();
+}
+
+void copy_page_mmx(void *to, void *from)
+{
+	int i;
+	
+	
+	kernel_fpu_begin();
+
+	__asm__ __volatile__ (
+		"1:	prefetch (%0)\n"
+		"	prefetch 64(%0)\n"
+		"	prefetch 128(%0)\n"
+		"	prefetch 192(%0)\n"
+		"	prefetch 256(%0)\n"
+		"2:\n"
+		".section .fixup, \"ax\"\n"
+		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
+		"	jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from)
+	);
+
+	for(i = 0; i < PAGE_SIZE/64; i++)
+	{
+		__asm__ __volatile__ (
+		"1:	prefetch 320(%0)\n"
+		"2:	movq (%0), %%mm0\n"
+		"	movq 8(%0), %%mm1\n"
+		"	movq 16(%0), %%mm2\n"
+		"	movq 24(%0), %%mm3\n"
+		"	movq %%mm0, (%1)\n"
+		"	movq %%mm1, 8(%1)\n"
+		"	movq %%mm2, 16(%1)\n"
+		"	movq %%mm3, 24(%1)\n"
+		"	movq 32(%0), %%mm0\n"
+		"	movq 40(%0), %%mm1\n"
+		"	movq 48(%0), %%mm2\n"
+		"	movq 56(%0), %%mm3\n"
+		"	movq %%mm0, 32(%1)\n"
+		"	movq %%mm1, 40(%1)\n"
+		"	movq %%mm2, 48(%1)\n"
+		"	movq %%mm3, 56(%1)\n"
+		".section .fixup, \"ax\"\n"
+		"3:	movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
+		"	jmp 2b\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b, 3b\n"
+		".previous"
+		: : "r" (from), "r" (to) : "memory"
+		);
+		from+=64;
+		to+=64;
+	}
+	kernel_fpu_end();
+}
diff -urpN linux-2.6.11.src/arch/i386/lib/page_ops.c linux-2.6.11-nt.src/arch/i386/lib/page_ops.c
--- linux-2.6.11.src/arch/i386/lib/page_ops.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.11-nt.src/arch/i386/lib/page_ops.c	Fri Mar 18 11:30:51 2005
@@ -0,0 +1,108 @@
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/sysctl.h>
+
+#include <asm/hardirq.h> 
+
+void zero_page_mmx(void*);
+void copy_page_mmx(void*, const void*);
+void zero_page_3dnow(void*);
+void copy_page_3dnow(void*, const void*);
+void zero_page_sse(void*);
+void copy_page_sse(void*, const void*);
+
+static void zero_page_slow(void * page)
+{
+	int d0, d1;
+	__asm__ __volatile__(
+		"	cld\n"
+		"	rep ; stosl\n"
+		: "=&c" (d0), "=&D" (d1)
+		:"a" (0),"1" (page),"0" (PAGE_SIZE/4)
+		:"memory"
+	);
+}
+ 
+static void copy_page_slow(void *to, const void *from)
+{
+	int d0, d1, d2;
+	__asm__ __volatile__(
+		"	cld\n"
+		"	rep ; movsl\n"
+		: "=&c" (d0), "=&D" (d1), "=&S" (d2)
+		: "0" (PAGE_SIZE/4),"1" ((long) to),"2" ((long) from)
+		: "memory"
+	);
+}
+
+int change_pageops = 0;
+
+static void (*zero_f)(void *) = zero_page_slow;
+static void (*copy_f)(void *, const void*) = copy_page_slow;
+
+#define SW_TO(a) do { \
+	zero_f = zero_page_##a; \
+	copy_f = copy_page_##a; \
+	printk("Switched to " #a " clear/copy page ops\n"); \
+} while(0)
+
+static void change_ops(void)
+{
+	switch(change_pageops) {
+	case 1: SW_TO(slow); break;
+	case 2: SW_TO(mmx); break;
+	case 3: SW_TO(3dnow); break;
+	case 4: SW_TO(sse); break;
+	default:
+		printk("unimplemented!\n");
+	}
+	change_pageops = 0;
+}
+
+void clear_page(void *page)
+{
+	if(unlikely(in_interrupt())) {
+		zero_page_slow(page);
+		return;
+	}
+	if(!change_pageops) {
+		zero_f(page);
+		return;
+	}
+	change_ops();
+	zero_f(page);
+}
+
+void copy_page(void *to, const void *from)
+{
+	if(unlikely(in_interrupt())) {
+		copy_page_slow(to, from);
+		return;
+	}
+	if(!change_pageops) {
+		copy_f(to, from);
+		return;
+	}
+	change_ops();
+	copy_f(to, from);
+}
+
+static struct ctl_table pageop_table[] = {
+	{
+		.ctl_name	= 19847,	/* I typed random number */
+		.procname	= "pageop",
+		.data		= &change_pageops,
+		.maxlen		= sizeof(change_pageops),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ .ctl_name = 0 }
+};
+
+static int __init pageops_init(void)
+{
+	register_sysctl_table(pageop_table, 1);
+	return 0;
+}
+
+module_init(pageops_init)
diff -urpN linux-2.6.11.src/arch/i386/lib/sse_page.c linux-2.6.11-nt.src/arch/i386/lib/sse_page.c
--- linux-2.6.11.src/arch/i386/lib/sse_page.c	Thu Jan  1 03:00:00 1970
+++ linux-2.6.11-nt.src/arch/i386/lib/sse_page.c	Fri Mar 18 11:30:51 2005
@@ -0,0 +1,112 @@
+/*
+* linux/arch/i386/lib/sse.c
+*
+* Copyright 2004 Jens Maurer
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*
+* Send feedback to <Jens.Maurer@gmx.net>
+*/
+
+#include <linux/preempt.h>	/* preempt_disable */
+#include <asm/page.h>		/* PAGE_SIZE */
+#include <asm/system.h>		/* cr0 ops */
+
+
+/*
+*	SSE library helper functions
+*/
+
+#define SSE_START(cr0) do { \
+	preempt_disable(); \
+	cr0 = read_cr0(); \
+	clts(); \
+	} while(0)
+
+
+#define SSE_END(cr0) do { \
+	write_cr0(cr0); \
+	preempt_enable(); \
+	} while(0)
+
+void zero_page_sse(void * page)
+{
+	unsigned char xmm_save[16];
+	unsigned int cr0;
+	int i;
+
+	SSE_START(cr0);
+	asm volatile(
+		"	movups %%xmm0, (%0)\n"
+		"	xorps %%xmm0, %%xmm0\n"
+		: : "r" (xmm_save)
+	);
+	for(i = 0; i < PAGE_SIZE/16/4; i++) {
+		asm volatile(
+			"	movntps %%xmm0,   (%0)\n"
+			"	movntps %%xmm0, 16(%0)\n"
+			"	movntps %%xmm0, 32(%0)\n"
+			"	movntps %%xmm0, 48(%0)\n"
+			: : "r"(page) : "memory"
+		);
+		page += 16*4;
+	}
+	asm volatile(
+		"	movups (%0), %%xmm0\n"
+		"	sfence\n"
+		: : "r" (xmm_save) : "memory"
+	);
+	SSE_END(cr0);
+}
+
+void copy_page_sse(void *to, void *from)
+{
+	unsigned char xmm_save[16*4];
+	unsigned int cr0;
+	int i;
+
+	SSE_START(cr0);
+	asm volatile(
+		"	movups %%xmm0,   (%0)\n"
+		"	movups %%xmm1, 16(%0)\n"
+		"	movups %%xmm2, 32(%0)\n"
+		"	movups %%xmm3, 48(%0)\n"
+		: : "r" (xmm_save)
+	);
+	for(i = 0; i < PAGE_SIZE/16/4; i++) {
+		asm volatile(
+			"	movaps   (%0), %%xmm0\n"
+			"	movaps 16(%0), %%xmm1\n"
+			"	movaps 32(%0), %%xmm2\n"
+			"	movaps 48(%0), %%xmm3\n"
+			"	movntps %%xmm0,   (%1)\n"
+			"	movntps %%xmm1, 16(%1)\n"
+			"	movntps %%xmm2, 32(%1)\n"
+			"	movntps %%xmm3, 48(%1)\n"
+			: : "r" (from), "r" (to) : "memory"
+		);
+		from += 16*4;
+		to += 16*4;
+	}
+	asm volatile(
+		"	movups   (%0), %%xmm0\n"
+		"	movups 16(%0), %%xmm1\n"
+		"	movups 32(%0), %%xmm2\n"
+		"	movups 48(%0), %%xmm3\n"
+		"	sfence\n"
+		: : "r" (xmm_save) : "memory"
+	);
+	SSE_END(cr0);
+}
diff -urpN linux-2.6.11.src/include/asm-i386/page.h linux-2.6.11-nt.src/include/asm-i386/page.h
--- linux-2.6.11.src/include/asm-i386/page.h	Thu Mar  3 09:31:08 2005
+++ linux-2.6.11-nt.src/include/asm-i386/page.h	Fri Mar 18 11:30:51 2005
@@ -12,26 +12,8 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-#include <linux/config.h>
-
-#ifdef CONFIG_X86_USE_3DNOW
-
-#include <asm/mmx.h>
-
-#define clear_page(page)	mmx_clear_page((void *)(page))
-#define copy_page(to,from)	mmx_copy_page(to,from)
-
-#else
-
-/*
- *	On older X86 processors it's not a win to use MMX here it seems.
- *	Maybe the K6-III ?
- */
- 
-#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
-#define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
-
-#endif
+extern void clear_page(void*);
+extern void copy_page(void*, const void*);
 
 #define clear_user_page(page, vaddr, pg)	clear_page(page)
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)

--Boundary-00=_dVqOCAfmkOGprew
Content-Type: application/x-tbz;
  name="page_asm.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="page_asm.tar.bz2"

QlpoOTFBWSZTWTxQ/Y0AQAT/7v6/IMB7////v//f/v////sREAAQAEEQCYAEAKhgHh3vsANZXWqp
dpARXjHcZTKvuc7I0GZtSKk82mrIo2Svm17ULyZ1FMQNSUtbWqrTVBVIje7BKcSSoolYSUhJ6gDa
gaNNADQAAAaAZBoAAAGgAyDT0g0NBCENVP1RtIAAZGmR6gNNNAAABoDCZNAAGhoKT0yqNMTI0GmJ
iAxDJkyGIwCMmJgQyDABGIMhowhSUJiaqep7VPCPVMaYoNHk9UeoZANDRoAD1ABoPSaDIAAESgRN
JtRpk1TxNJip+p6ZBqT1P1PKTxT9SfqjJsSGn6o2oB5QGhoAGQCJIgTRMmjU9RkyGgp5CE09E8mp
kGjQaekAYQPUegT1AAD/x5BTjleMQ75d/ZpQ9CNuqiiNwphgEgQFmQKIcoA/a97zZ7LW8vmJPfqU
oZXtfPeZImdCJjoiXmWUtpRpWJRe5VTryFNiA84pAoWTCrESlHJBEe0IwqkyUNBS0IVEkMjCFEUo
bJXAAQ68I0qmV+AAJWGTBHqxFxWKqiiFDdC7NJtzFczFc1kQxJKQEREqyFIkITKkI0MUiTMBBQzs
MMAJlgkCCqpUmQYJJ6/tKHo/DR4Lvk9oNMwzmDQnvUAA+DCtLSsywVQkEwTBMkhPgihQi6tGBEZu
UODucYQJm0hhSBIqz2mYH0Q2BmR2U1F/KsdriZjoWgtC0Tqdqa0uEYFRBpZDjQSBZLHzMgQsF0CD
Zu3s3YSTjaxaDkaglCmLGQHYQLMULWhvslt97PxY3lrkHo1aTXP+T3AcNlsqMj732bW0VOioSKIB
9c5HA0DQhwNsRqThLxy+1WrqcPvga4KDYmhU7Y9a00EUpwXPlisIBzEmjIZ5NF0w72PMghbyLHH7
tVJh6+XAC8C/mOvjz6G9SBgV+xXbvofp4reIkofdu7t1rCOQC+ABlBfNFJUU2eT+O8w4d/KPwZyf
RbTD9GB+eAgfT95QEOZ+ZBOHzX0mhJYUClhlkJEBiN3kPGJ8VR+A98YknJQ5UKYEFboHL5NMT9AA
4CMAwDAMAwDAMJCQkJCQSCQTMWwu9zzuu9EDJA/KG5NDeRA9FAflcClOqIu5liJ1MQLgedQPR2z3
JEHjRI8xDj2sSszLLMIcIMnJrp1LfIrw71lwL7GjQjFfP3BgAcmItDzBt8ETsMA3vRaobOeXafXg
WhJhVAcw7E8Zrcx3kDJQraDaZGUYZEK3TrmWaBFDBlkSECV8HHIMkCyhjEDSFzm/NmP4zYgbFDhB
dSyBSh0WdDjntS7IGOSBBSrjdo38l4m8OCZ9J0UmckZAki7tabbUCINEhFb01A2qZbVChWm3IDEw
B99D6H8B9vEdvS5SnN8bgbfp+RfrZX7PSUBoe+BsfUuV674Hu9Z+iwhrE7ByPhsL+ztoGww6HKuB
dopwyv8By8ZHtIYcw+pofAAh3S/fOic5q0d5/NqPBiGsnpr4G7R8mxLGsw5n9AQe7eabCRfIv9nD
ZkbR+rJdg7Gn4fNVO6+RouV50UqKB7GNQwPwLkNscmODYPlKtHHyN1cOwcD+p5On7b4gPB83WObt
4rqu/v9bwkkxceT9fwYF+0Z86jn8ovj5HEsPQM3GKBSBEDevoLjv5vHJt8L7sjuTAi6jsA+Pz2b3
OqotV7E8Tft9OvdktEA3McShuOwb5B7/gSkz5vH5S793zurPHCwbfDR7LsYh1ervapmGq83N4hjD
RdeFL3F7RepZpZF1TeEHH42e9O+AGqbhmohtdgXTZtWjtWRU7qaZLEi1nqKp0cG5UtN8LY6GGeBV
YZ2qs+l6XyeHq5gdgCnSBEEPKSIxUWh8Dw9niQ5/HmHlzNgHrwqyHlGl9l+9857RMtreKgesYxDj
T7BuPIfpDH6J7PYm8FDf13v9PaYaIipiINoHEdPP0DiXEgSRK8elpysWHduHTAXOFGQ7ALDm5s73
HchrDt6wNoG04PYUHm2772DUsaD3e87Axw5e47npkkkfLcf5VqOt76d2pv5Llw3jqNR7By8J1YvF
3njsLtfrIIZpjNx00Ico0OO70OmQGAGA4/BoVoLxOwQuuTgOVvQNPFs8EDvfxtxtMzq9U6BEE2kH
aRFOg8LqIeoRAMoQiqWPA9j6fa5B8QfGdgLwxxsZWpA0Az3PQbl3YKPsoD18U9oLx0ihEJ4fd9cq
VLh3OeoOLyJqITCV2KOwHjqKA87WmdQsRlpFlQNaCfU1ucADBUQsICwFgCBsabsPtgoh3idS2Xt1
MUflkIkd71SAhnJ7i7EDxIHmr4kCl95Slg4CXEuJcG4UFzALJZLWOYBESEiIhQhBCIkREBHIwgkk
ZCRwOAABjgCSDWLgxColRuJdCwlFutFqt1oBdStUC3RE07tx40KDbX3wKEQP1hwl+seX4vxXE3cH
HKj1eMJDRrWwXpBZF0LPWG7I8OFVVUUVVVWmMIwMwx5h5DYvvwQN/ft3SRYJAml76FkDmZAeLzer
nQfK7VDhweY+CD8eXVdpqSRSj0dN/zN4JBiv10zQMyA+ffvpf4z0mhuGnxNUKHHjpgOjove9zi+9
d9Abz3t6BYBA466tuJ4VA2uQO74p5BDiwtYsWfcAHpilcM361jp7gTFkwu0+fSmrYLYm6DK1hcDr
0ER3kRgAkQIBmieVCPWeMhFBVLvCSGIqQkYoPqiPVFUymujD5KqsKbBGxavGKfYFMQ8fiQJzQOsO
YQ6tmD4mz5ztsAPAgAsUMInQgd1HBAqjQSIfIhxWXFseQTJbWP1VzWNm0FjkgSkZFmm0j63puGJ6
B+EjPPy5BfIXiB4O5tADHZtcHDw2PN7/IAJ1JCr1F9h+z2bOkDU6j8t9Mx4PTbm6TTSZaerllT8E
qdtp3U8+MQ4XoVMUyMitrZXvb1df7WvkTtVgidIQi6JXrHZKz/YPvvf5GCywuEFVgsAzLMsgbvde
DuQdEB08+u6bWlqEwNc18rBfDf7fKHd+xdE9nsLwQiCliX7/hkv378ZUtPMFlCt1ogaB90BA89qC
KZ84g4B8Wt9OjrsgprhgWAU2fk+58vz188PnqUlfHhb+3+/yiAc/h5vh7LinP28MTJU4wShxzMsF
MWwSvHKt7ZWxXGMoGWMUgtMUoKX7wHYL7AYLE/ye0R+gF3eGe3W+vHaG/K+PRvxxqYY+YO8PNxAQ
IBwAbGvL6pVbQ8QpkVxPgoNsesWuubC51+hLLbA22LXJIHTGY4Qspz1rJfxZmWb/VoVyrEM4pJac
1b8uvBl1mAQvkKXpixbaNB7cfgqbtKRo0hnYOwU8Z5AHpx8lVUqSEKSqydPbbiEnDfL0Ofo55wmM
5X1dBhAwzE2VQogdBtGnapvAanTn09NJTTMbS/VSp126OPC5WQUhW+J1FVe8kMoVjpcEKG8pH7wa
YabMuuxaxnpoZcZgpbLGxVVYOpXqOIDfp6aqqoI0lV0htVboq5bdNdyupbaN4GgATTRVwLXrTXIs
I0emcTGoCAesoTe4juEZNcYjoLAscnoBBnwWN7sgQNUimuhVhvAejfJAiSpx2TZkibZOm4GB9eCu
Uyy1z3GWVuUzLoEQmUrIhQhsPHUniJvE1KdGAQz11kC2feInuI5bi+EygZ2o2tc568arzqkxAmcy
375XF66VyNkBDOViRQNYoBuCBdyJrE57NHCZNo8Gbvm8tkEBq+mjBy1xihni17UoaYtTF62NLVQM
iRSCEDXOsBNmCDVHIIOIEYJolZ54xKQ2caUtZyalgrTVIALKE2ykYgRQqENokEK2ZZVpnjfZpgiW
pE1yAtjQvnRM83DvUDDgIdl7bKrXdnvdIVVCSh1IGymAlVWKzbxXaLlF26hAX1yo3bQl4VsrBBmA
gslTN0UUrwJMLD2WrhrcGRrsNGzWFIVbzZw4EtlgulljKgdAg8m4ysINg75HGWufQgUgaIVUmNiy
FhIsWbalYXhbZpmRFti2FSGFOMKXUB7Bka7ICbsZsxUM0EDCyIREl4l1yRmxNzMs64gBLGcMHstO
qs0NYFnugQQ7VESMA4dMDYKgGxq72KrAsiDzU4RO49I2jFCQVp7vV9lT6/J/RiyVjmBmwVrntOnd
8VVWv27K67YYg7WCQdv2dx94FntQkEOk48+4O+WZG79l1cAu4EkS/yT7RlGQkkC6prHtQIYcOKv2
EAD6YhB45/Rb5xe1oHzvyu2oZww1OYPFqIX15ygGoeVoDSIQjgemlOiCEFsgRT6iTtLgQoW+z77Z
LhqP6cRyjtbIvo+lk+wqid8TCBYEKd5dTqbrB0gKIpJFwIRuaYBtyKGIAxIjseIcVgNAMWaA4CYC
BiRxniGzelX6pAXAE8iOAegJNFxyK4g/jUPq/MAXp0qkM09agUFsqNX6gNjcNj+NKf4g/xcyOtnW
XB20QNAcAwELWfuRnqpkfGJDjipmCH8hrhqVSvQc1qkiYs7KQPmHlk+vJEwBAjpDcsIIGElPhesF
KKdan9Sh53lY5F1Ckgd5OlQPQETYj9IfovyfEAZI6qS9bBCkUqLAUsyI/IgUAqMdy+kS65IWwvqE
wgVBH4nQKKfw/OUHc3gUFfjg5Fr/xs8B7Gmbmj9Yv3DGUZD1CaAvzC+AEQ4+MFPiFP2NyIEQQieX
xoJ54i0nIpRD0zaKcREPt/l9ftP3PzOYGNBFzaLmB3QjuR3YrEPDghiIDxDw4sN4MBhDKDRUKUVl
cuSRKPCrBdaKuGcrAh1COWDO8QSGbds4byIuk/R631yraFlI1SFVg4GAtFFKURIyVAhEVBC7QihY
RKm4RD3xTALvi4gwenu9s9Y/ke3HgPp9Am1fN1j9Ib9XLzU91+4/QP5GrwHJRU9DEMx0AoETz7eJ
7hZgMAaE4X+G/jPS+J+bmuR9F9h/pXkPumwDXaOVw8VRTJALgh9jcQ1bBqBZzRLMGGwAGcVdwVfR
vqjqA8RENyLcDM6kF3Cg8Sg/grLo5sDm+ZpH3OR71nHwseV/COB26BQFocwiJ+moeV9G13xQsIfe
CoFrqS+RwzN322mcMdCJRfMPHXSCY/LXcO57QFyWIRmgnF1piBdbjkwF0C3Ixcp0Wkk4AHAqgtVB
7wKGGwEg3R55Y70THcEu90Zm+qqqqqqqrYCptMiwXWYBt2sYbXb1zfxHh0a4IoaMG5RAJPTAGGsm
yRDznToAgkLAQaq4xTpOymhgaB0BoECBCGtsjMq6MNQSksmRxPcuwvuF3Qsebr0e+vfLAZjCGGQF
h7vSKGDlQQgAGAw7f7urQQ9PqF4r3ZjpBQNBMYpkXdS8LY+wcm66c+nPHF0bOe3Vu3HBXcVrZDnm
47RmO6l0PevYbUHja2EXbHftR4QKGCN3LGnNoZDIXNXegXHcImq3dBEIKZjAyNlwPtDrSiadcttO
qwc5Ho6xwNw2gqVvW9HxN3b5T9ddOQMABi6ckdSzzXvJvHof6R5nNN6EVNlVWh+3azF2uSu2nKrd
0gyBzeNA6wcdOqXDiRNzxBQu8+IFIYDIwpglDyjRGMRbJTubPALlIcS9S4DrKrmPkbblyyHXUFDY
Zjq9j0YQn3dwqeQbHPxbziADQ3Qd0E3j6/Ry7fDsHk+J7E9CBCuIsHtPXFH44ua/Sn7sDMx9PK6H
iAoAOLgAG/eADmarksjnh5ddupggRQwjm6uwC4LssDwiy5IHzQdiBrq0hgu+IzUB7HAwzbgG05wg
Ic8NxESOaIj1RRLERfPAcAyMikR52AjfzAL5ay9uQyDe9RrQgT3SyEkryuA6NGFxweXXy7hxHAgx
gOcQ55qtjcB7Pxdg8aeswgRipIpA1QL9BteUUO61X0d7iInkgDv0cysl8om/2nqPBxRHcND0CIew
Dv6FCqHBaKoQC1GRDzgle3VcDsd9acD28R4bF4ok7IGIt8wOlYBFgBv3Lhd4xCKQAgxg4aB71ukX
eFkXGNg+cya0Imv6m9BDuesS7R4DtOjMayPSGcwHaMVVNFVRTRVUFz7RENvb4jsPGagKUAna00Ch
tmQ8LL2O4H9cYFsDqQoBO6ESDwquDbpQ4GMA2gmjju58KzGhzHUc7SzwH3gWCOcQHR1C7BDkCiF0
KEQnD2zxAM4va0qhH1PJsjsNTv8KDZ+SPiN6pC41AuaNAUNGjR0dcHjBRDahgeR85VlSAdlUAptA
0MAtYsWC1H5Aq5YsFrFiwWsWLBaqKo/KFICNwt+YtR+cKuFjELWLFgtYsWC1GIV5CHrQo2Ku83r2
B44lzIoiEcF4M/NrS5ZjM+VwLoIVQF6KGkLFDBybC3yQRG5ebM8Fm0CtKpUbiZWxxfO2F0U0jmiW
obZECkJaEGDVxbxgnmBG2xu3BCEWLBlzXFWzom8NxvCtA3gUQ8c+rWQB0bei1gRirrZtQDCFNFyQ
IdwLcQvfuRUNKfQHp5oamrTePoggGyC+0PGcgyA7T5puQPJd8L0CAajmohQRCg2BEt2Q3AO1YOwc
FTGuC59T2jhAauYBcAOh0AiCFw2ApzF1yIIoacffMxabREd2InIeNwxCIe+PIB5mlmgO58SppmJQ
EOgFMwKPnQOe7TbwA+wBxHWLiFACjs6pJDjArZwwHeEB3lBSPRw7YoQKEKBAyHPyqqwQ13Tz3vDa
mas6bMyZcr6+Zc19x+a+/QbXTOrQqkJQmCaGAkHCCCeiPhXwHw+JC0CCj94ij7ovt9dQyX0e+NTe
Px+XI11dRApG42OEqIeL04SEqqAqiilJCWUhYZYJYBIBAiKqFGmKqpgqgQ3cwpsRIckcVwIgMF3g
aQ0+GBQ8M5Gl6FUxcXwhC4gnMykZKvBc/S8w1MIt3ABndajUMmjKJRCIc1sJu4iv31iRYqm543HA
7Q1Os6gsFSvI18TjhomCgooKv9LteC9k7DhzC/q7D2BW3GQBglzpgcARLfhFP/RTUbrsDboaECIP
augtVLZLuxZUyAlF9SxDZ2Yzb1+FpflDvDdaYxGh0pbD+sbBso4Y4DQKGKFxm2mQZyuYLp0WQkbD
SEM0riPBXxiJ0neZIejjuAYd/TS+duN77Tbfjk3vjUqBWAXxARpgXA0B5uaSSSBFoYABks3z9fBw
b1MlYaOS6DVhAqKWorQ6imL3g+qDJ+A6Ws3YL4B1GZxGijXaqUMAys9PRxJ5wyCgUw1AyONnS3Kw
eM1ALzMd10CrDKiOdUztZ48aEJQjnESs8Y/fLm02GUxDrLqyhVCBBgLsRuVBHEMQgKlF26Bnt6HB
4D4B/i0Sg4hA+Rv3PIYiaovO5WAp2LXDAz0pQpSQVuL94f6+FwDlPx2oB+kh1omcEQt7mPWZjvwW
3KhZAMujxh4IaDyugWBsdKBLi3KEU4isMkVDtWxZ8KTtGKELe4DUPKO4DsvVB8RvVTYPf0BNGPsB
DMwde0zAycx5dyuP300wh1ByoApApoKTAC8A0TNB0xA3f/CnQHbmvHEHerQwRLLx40FCYK4FqiKh
HoflhQsQICYj4CIXVEDnIMOAt0DYNjpGtwiGW1sR5ddHaRBDOPeiGmrlT3DdRDhYDTps4eWMXpiV
S2aWjQDBUxIBZZSqBsBQ3u4CoHI3hsX9HOBkJvUIMh0osIoUQCElx6gUP/i7kinChIHih+xo

--Boundary-00=_dVqOCAfmkOGprew--

