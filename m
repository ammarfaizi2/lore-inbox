Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTAFFL0>; Mon, 6 Jan 2003 00:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbTAFFL0>; Mon, 6 Jan 2003 00:11:26 -0500
Received: from dp.samba.org ([66.70.73.150]:35987 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266434AbTAFFLY>;
	Mon, 6 Jan 2003 00:11:24 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au,
       Thomas Sailer <sailer@ife.ee.ethz.ch>,
       Marcel Holtmann <marcel@holtmann.org>,
       Jose Orlando Pereira <jop@di.uminho.pt>,
       J.E.J.Bottomley@HansenPartnership.com
Subject: Re: [PATCH] Deprecated exec_usermodehelper, enhance call_usermodehelper 
In-reply-to: Your message of "Sun, 05 Jan 2003 19:54:07 -0800."
             <Pine.LNX.4.44.0301051952450.3087-100000@home.transmeta.com> 
Date: Mon, 06 Jan 2003 15:35:45 +1100
Message-Id: <20030106052000.DE13C2C276@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301051952450.3087-100000@home.transmeta.com> you wri
te:
> 
> On Mon, 6 Jan 2003, Rusty Russell wrote:
> >
> > Linus, please apply.
> 
> Nope, I really don't want to deprecate any more interfaces while my build 
> is still so noisy about the _existing_ deprecated stuff.

OK.  I'll work with the various authors to actually remove all 3 users
in the tree, then submit a patch to rip it out.

> The noisiness of the current build is quite distracting, and likely makes 
> people just ignore potentially valid warnings simply because there are too 
> many of them-

Damn.  I guess you don't want this patch then?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Deprecate cli/sti/restore_flags etc.
Author: Rusty Russell
Status: Tested on 2.5.54

D: These functions have long been deprecated: they don't exist on SMP.
D: Mark them deprecated.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5-bk/include/linux/interrupt.h working-2.5-bk-clisti/include/linux/interrupt.h
--- linux-2.5-bk/include/linux/interrupt.h	Thu Jan  2 12:36:08 2003
+++ working-2.5-bk-clisti/include/linux/interrupt.h	Mon Jan  6 14:41:25 2003
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
+#include <linux/compiler.h>
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/ptrace.h>
@@ -28,12 +29,29 @@ extern void free_irq(unsigned int, void 
 /*
  * Temporary defines for UP kernels, until all code gets fixed.
  */
-#if !CONFIG_SMP
-# define cli()			local_irq_disable()
-# define sti()			local_irq_enable()
-# define save_flags(x)		local_save_flags(x)
-# define restore_flags(x)	local_irq_restore(x)
-# define save_and_cli(x)	local_irq_save(x)
+#ifndef CONFIG_SMP
+static inline void __deprecated cli(void)
+{
+	local_irq_disable();
+}
+static inline void __deprecated sti(void)
+{
+	local_irq_enable();
+}
+static inline void __deprecated deprecated_save_flags(unsigned long *flags)
+{
+	local_save_flags(*flags);
+}
+static inline void __deprecated restore_flags(unsigned long flags)
+{
+	local_irq_restore(flags);
+}
+static inline void __deprecated deprecated_save_and_cli(unsigned long *flags)
+{
+	local_irq_save(*flags);
+}
+# define save_flags(x)		deprecated_save_flags(&(x))
+# define save_and_cli(x)	deprecated_save_and_cli(&(x))
 #endif
 
 
