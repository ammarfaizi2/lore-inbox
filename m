Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbWDDQ3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWDDQ3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWDDQ3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:29:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1038 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750738AbWDDQ3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:29:37 -0400
Date: Tue, 4 Apr 2006 18:29:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Zachary Amsden <zach@vmware.com>
Subject: [-mm patch] i386: pre_intr_init_hook optimization
Message-ID: <20060404162935.GL6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.16-mm2:
>...
> +x86-clean-up-subarch-definitions.patch
>...
>  x86 updates.
>...

Let's make the kernel smaller for everyone.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/i8259.c      |   13 ++++++++++++-
 include/asm-i386/arch_hooks.h |   14 --------------
 2 files changed, 12 insertions(+), 15 deletions(-)

--- linux-2.6.17-rc1-mm1-full/include/asm-i386/arch_hooks.h.old	2006-04-04 16:54:15.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/include/asm-i386/arch_hooks.h	2006-04-04 16:56:14.000000000 +0200
@@ -44,20 +44,6 @@
 /* these are the default hooks */
 
 /**
- * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
- *
- * Description:
- *	Perform any necessary interrupt initialisation prior to setting up
- *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
- *	interrupts should be initialised here if the machine emulates a PC
- *	in any way.
- **/
-#ifndef pre_intr_init_hook
-#define pre_intr_init_hook() init_ISA_irqs()
-#endif
-
-
-/**
  * intr_init_hook - post gate setup interrupt initialisation
  *
  * Description:
--- linux-2.6.17-rc1-mm1-full/arch/i386/kernel/i8259.c.old	2006-04-04 16:55:01.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/arch/i386/kernel/i8259.c	2006-04-04 16:56:08.000000000 +0200
@@ -368,7 +368,17 @@
  */
 static struct irqaction fpu_irq = { math_error_irq, 0, CPU_MASK_NONE, "fpu", NULL, NULL };
 
-void __init init_ISA_irqs (void)
+/**
+ * pre_intr_init_hook - initialisation prior to setting up interrupt vectors
+ *
+ * Description:
+ *	Perform any necessary interrupt initialisation prior to setting up
+ *	the "ordinary" interrupt call gates.  For legacy reasons, the ISA
+ *	interrupts should be initialised here if the machine emulates a PC
+ *	in any way.
+ **/
+#ifndef pre_intr_init_hook
+static void __init pre_intr_init_hook(void)
 {
 	int i;
 
@@ -395,6 +405,7 @@
 		}
 	}
 }
+#endif  /*  pre_intr_init_hook  */
 
 void __init init_IRQ(void)
 {

