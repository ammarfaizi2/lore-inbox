Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262623AbTDAQA1>; Tue, 1 Apr 2003 11:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262624AbTDAQA1>; Tue, 1 Apr 2003 11:00:27 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:30718
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262623AbTDAQA0>; Tue, 1 Apr 2003 11:00:26 -0500
Date: Tue, 1 Apr 2003 11:07:21 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][RFT] sfence wmb for K7,P3,VIAC3-2(?)
In-Reply-To: <1049197774.31041.15.camel@averell>
Message-ID: <Pine.LNX.4.50.0304011105540.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010242250.8773-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0304010320220.8773-100000@montezuma.mastecende.com>
 <1049191863.30759.3.camel@averell>  <20030401112800.GA23027@suse.de>
 <1049197774.31041.15.camel@averell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003, Andi Kleen wrote:

> Yes, you're correct. It was SSE1, not SSE2.
> 
> The problem Zwane encountered is that early Athlons don't support SSE1,
> only XP+ do

hmm wouldn't they illegal op? Some tested this on an Athlon 600.

> To use it he would need an a new CONFIG split for Athlon XP and earlier
> Athlon. iirc it didn't make much difference on the athlon anyways which
> has quite fast locked operations on exclusive cachelines - sfence seems
> to be more useful on P4.

How about this instead then;

Index: linux-2.5.66/arch/i386/Kconfig
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/arch/i386/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 Kconfig
--- linux-2.5.66/arch/i386/Kconfig	24 Mar 2003 23:40:26 -0000	1.1.1.1
+++ linux-2.5.66/arch/i386/Kconfig	1 Apr 2003 16:02:46 -0000
@@ -368,6 +368,11 @@ config X86_PREFETCH
 	depends on MPENTIUMIII || MPENTIUM4 || MVIAC3_2
 	default y
 
+config X86_USE_SFENCE
+	bool
+	depends on MPENTIUM4
+	default y
+
 config X86_SSE2
 	bool
 	depends on MK8 || MPENTIUM4
Index: linux-2.5.66/include/asm-i386/system.h
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/include/asm-i386/system.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 system.h
--- linux-2.5.66/include/asm-i386/system.h	24 Mar 2003 23:40:20 -0000	1.1.1.1
+++ linux-2.5.66/include/asm-i386/system.h	1 Apr 2003 16:03:50 -0000
@@ -355,11 +355,15 @@ static inline unsigned long __cmpxchg(vo
 
 #define read_barrier_depends()	do { } while(0)
 
+#ifdef CONFIG_X86_USE_SFENCE
+#define wmb()	__asm__ __volatile__ ("sfence;": : :"memory")
+#else
 #ifdef CONFIG_X86_OOSTORE
 #define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif
+#endif /* CONFIG_USE_SFENCE */
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()

-- 
function.linuxpower.ca
