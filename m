Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262242AbRE0VIK>; Sun, 27 May 2001 17:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262281AbRE0VIB>; Sun, 27 May 2001 17:08:01 -0400
Received: from nilpferd.fachschaften.tu-muenchen.de ([129.187.176.79]:2775
	"HELO nilpferd.fachschaften.tu-muenchen.de") by vger.kernel.org
	with SMTP id <S262242AbRE0VHr>; Sun, 27 May 2001 17:07:47 -0400
Date: Sun, 27 May 2001 23:07:38 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: <bunk@mimas.fachschaften.tu-muenchen.de>
To: Abramo Bagnara <abramo@alsa-project.org>, <linux@arm.linux.org.uk>,
        <davem@caip.rutgers.edu>, <anton@linuxcare.com.au>,
        Ralf Baechle <ralf@oss.sgi.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Inconsistent "#ifdef __KERNEL__" on different architectures
In-Reply-To: <3B115279.CE436CEA@alsa-project.org>
Message-ID: <Pine.NEB.4.33.0105272301280.8551-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 May 2001, Abramo Bagnara wrote:

> Adrian Bunk wrote:
> >
> > while looking for the reason of a build failure of the ALSA libraries on
> > ARM [1] I discovered the following strange thing:
> >
> > On some architectures a function is inside an "#ifdef __KERNEL__" in the
> > header file and on others not. Is there a reason for this or is this
> > inconsistency simply a bug?
>
> This is a bug on some architectures, I've personally fixed this on PPC
> sending a patch to Cort Dougan. It has been included in 2.4.5.
>
> I'd like you send a patch to maintainers (or perhaps to Alan).

I do also explicitely send this mail to the people that seem to be
responsible for the pieces of code I touch.

I'm not sure whether the compete removal of the "#ifdef __KERNEL__"'s is
too rude but there are already other architectures that don't have it in
their architecture specific versions of these files.

A patch for the problems I mentioned (except for parisc) would be:

--- include/asm-arm/atomic.h.old	Sun May 27 22:30:58 2001
+++ include/asm-arm/atomic.h	Sun May 27 22:58:20 2001
@@ -12,6 +12,7 @@
  *   13-04-1997	RMK	Made functions atomic!
  *   07-12-1997	RMK	Upgraded for v2.1.
  *   26-08-1998	PJB	Added #ifdef __KERNEL__
+ *   27-05-2001	APB     Removed #ifdef __KERNEL__
  */
 #ifndef __ASM_ARM_ATOMIC_H
 #define __ASM_ARM_ATOMIC_H
@@ -30,7 +31,6 @@

 #define ATOMIC_INIT(i)	{ (i) }

-#ifdef __KERNEL__
 #include <asm/proc/system.h>

 #define atomic_read(v)	((v)->counter)
@@ -107,5 +107,4 @@
 	__restore_flags(flags);
 }

-#endif
 #endif
--- include/asm-arm/system.h.old	Sun May 27 22:31:47 2001
+++ include/asm-arm/system.h	Sun May 27 22:31:56 2001
@@ -1,8 +1,6 @@
 #ifndef __ASM_ARM_SYSTEM_H
 #define __ASM_ARM_SYSTEM_H

-#ifdef __KERNEL__
-
 #include <linux/config.h>
 #include <linux/kernel.h>

@@ -84,7 +82,5 @@
 #define save_flags_cli(x)	__save_flags_cli(x)

 #endif /* CONFIG_SMP */
-
-#endif /* __KERNEL__ */

 #endif
--- include/asm-sparc/atomic.h.old	Sun May 27 22:32:29 2001
+++ include/asm-sparc/atomic.h	Sun May 27 22:32:48 2001
@@ -11,7 +11,6 @@

 typedef struct { volatile int counter; } atomic_t;

-#ifdef __KERNEL__
 #ifndef CONFIG_SMP

 #define ATOMIC_INIT(i)  { (i) }
@@ -99,7 +98,5 @@
 #define atomic_dec(v) ((void)__atomic_sub(1, (v)))

 #define atomic_add_negative(i, v) (__atomic_add((i), (v)) < 0)
-
-#endif /* !(__KERNEL__) */

 #endif /* !(__ARCH_SPARC_ATOMIC__) */
--- include/asm-sparc/system.h.old	Sun May 27 22:32:50 2001
+++ include/asm-sparc/system.h	Sun May 27 22:33:52 2001
@@ -33,8 +33,6 @@
   ap1000      = 0x07, /* almost a sun4m */
 };

-/* Really, userland should not be looking at any of this... */
-#ifdef __KERNEL__

 extern enum sparc_cpu sparc_cpu_model;

@@ -335,8 +333,6 @@
 }

 extern void die_if_kernel(char *str, struct pt_regs *regs) __attribute__ ((noreturn));
-
-#endif /* __KERNEL__ */

 #endif /* __ASSEMBLY__ */

--- include/asm-mips/atomic.h.old	Sun May 27 22:38:35 2001
+++ include/asm-mips/atomic.h	Sun May 27 22:38:48 2001
@@ -24,7 +24,6 @@
 typedef struct { int counter; } atomic_t;
 #endif

-#ifdef __KERNEL__
 #define ATOMIC_INIT(i)    { (i) }

 #define atomic_read(v)	((v)->counter)
@@ -199,6 +198,5 @@

 #define atomic_inc(v) atomic_add(1,(v))
 #define atomic_dec(v) atomic_sub(1,(v))
-#endif /* defined(__KERNEL__) */

 #endif /* __ASM_MIPS_ATOMIC_H */
--- include/asm-mips64/atomic.h.old	Sun May 27 22:38:53 2001
+++ include/asm-mips64/atomic.h	Sun May 27 22:39:02 2001
@@ -18,7 +18,6 @@

 typedef struct { volatile int counter; } atomic_t;

-#ifdef __KERNEL__
 #define ATOMIC_INIT(i)    { (i) }

 #define atomic_read(v)	((v)->counter)
@@ -99,6 +98,5 @@

 #define atomic_inc(v) atomic_add(1,(v))
 #define atomic_dec(v) atomic_sub(1,(v))
-#endif /* defined(__KERNEL__) */

 #endif /* _ASM_ATOMIC_H */


cu
Adrian

-- 
A "No" uttered from deepest conviction is better and greater than a
"Yes" merely uttered to please, or what is worse, to avoid trouble.
                -- Mahatma Ghandi


