Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293136AbSB1Mip>; Thu, 28 Feb 2002 07:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292955AbSB1MgJ>; Thu, 28 Feb 2002 07:36:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58380 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293338AbSB1MeP>; Thu, 28 Feb 2002 07:34:15 -0500
Date: Thu, 28 Feb 2002 13:31:06 +0100
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: Warn about save_flags(int)
Message-ID: <20020228123105.GA14238@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We still have people trying to store flags in something else than
unsigned long. If it is long it does not break anything, but people
use int there, too.

This patch makes at least warning on i386, so we do not have to fix so
much on x86-64. I'd like to submit this for official kernel.

									Pavel

--- clean.2.4/include/linux/kernel.h	Thu Feb 28 11:18:25 2002
+++ x86/linux/include/linux/kernel.h	Thu Feb 28 12:03:13 2002
@@ -180,5 +175,7 @@
 	unsigned int mem_unit;		/* Memory unit size in bytes */
 	char _f[20-2*sizeof(long)-sizeof(int)];	/* Padding: libc5 uses this.. */
 };
+
+#define warn_if_not_ulong(x) do { unsigned long foo; (void) (&(x) == &foo); } while (0)
 
 #endif
--- clean.2.4/include/asm-i386/system.h	Wed Dec  5 23:46:05 2001
+++ x86/linux/include/asm-i386/system.h	Thu Feb 28 12:53:14 2002
@@ -310,7 +310,7 @@
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
 /* interrupt control.. */
-#define __save_flags(x)		__asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */)
+#define __save_flags(x)		do { warn_if_not_ulong(x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while(0)
 #define __restore_flags(x) 	__asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc")
 #define __cli() 		__asm__ __volatile__("cli": : :"memory")
 #define __sti()			__asm__ __volatile__("sti": : :"memory")
@@ -318,7 +318,7 @@
 #define safe_halt()		__asm__ __volatile__("sti; hlt": : :"memory")
 
 /* For spinlocks etc */
-#define local_irq_save(x)	__asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory")
+#define local_irq_save(x)	do { __save_flags(x); __cli(); } while (0)
 #define local_irq_restore(x)	__restore_flags(x)
 #define local_irq_disable()	__cli()
 #define local_irq_enable()	__sti()

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
