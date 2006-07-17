Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWGQQRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWGQQRi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbWGQQRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:17:38 -0400
Received: from koto.vergenet.net ([210.128.90.7]:57248 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750763AbWGQQRh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:17:37 -0400
Date: Mon, 17 Jul 2006 12:17:20 -0400
From: Horms <horms@verge.net.au>
To: Russell King <rmk@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] panic_on_oops: remove ssleep()
Message-ID: <31687.FP.7244@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is part of an effort to unify the panic_on_oops behaviour
across all architectures that implement it.

It was pointed out to me by Andi Kleen that if an oops has occured
in interrupt context, then calling sleep() in the oops path will only cause
a panic, and that it would be really better for it not to be in the path at
all. 

This patch removes the ssleep() call and reworks the console message
accordinly.  I have a slght concern that the resulting console message is
too long, feedback welcome.

For powerpc it also unifies the 32bit and 64bit behaviour.

Fror x86_64, this patch only updates the console message, as
ssleep() is already not present.

Signed-Off-By: Horms <horms@verge.net.au>

 arch/arm/kernel/traps.c     |    7 ++-----
 arch/i386/kernel/traps.c    |    8 +++-----
 arch/ia64/kernel/traps.c    |    7 ++-----
 arch/powerpc/kernel/traps.c |   10 +++-------
 arch/x86_64/kernel/traps.c  |    2 +-
 arch/xtensa/kernel/traps.c  |    8 +++-----
 6 files changed, 14 insertions(+), 28 deletions(-)

--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -232,11 +232,8 @@ NORET_TYPE void die(const char *str, str
 	bust_spinlocks(0);
 	spin_unlock_irq(&die_lock);
 
-	if (panic_on_oops) {
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		ssleep(5);
-		panic("Fatal exception");
-	}
+	if (panic_on_oops)
+		panic("Fatal exception: panic_on_oops");
 
 	do_exit(SIGSEGV);
 }
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -442,11 +442,9 @@ #endif
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
-	if (panic_on_oops) {
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		ssleep(5);
-		panic("Fatal exception");
-	}
+	if (panic_on_oops)
+		panic("Fatal exception: panic_on_oops");
+
 	oops_exit();
 	do_exit(SIGSEGV);
 }
--- a/arch/ia64/kernel/traps.c
+++ b/arch/ia64/kernel/traps.c
@@ -117,11 +117,8 @@ die (const char *str, struct pt_regs *re
 	die.lock_owner = -1;
 	spin_unlock_irq(&die.lock);
 
-	if (panic_on_oops) {
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		ssleep(5);
-		panic("Fatal exception");
-	}
+	if (panic_on_oops)
+		panic("Fatal exception: panic_on_oops");
 
   	do_exit(SIGSEGV);
 }
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -150,13 +150,9 @@ #endif
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
-	if (panic_on_oops) {
-#ifdef CONFIG_PPC64
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		ssleep(5);
-#endif
-		panic("Fatal exception");
-	}
+	if (panic_on_oops)
+		panic("Fatal exception: panic_on_oops");
+
 	do_exit(err);
 
 	return 0;
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -521,7 +521,7 @@ void __kprobes oops_end(unsigned long fl
 		/* Nest count reaches zero, release the lock. */
 		spin_unlock_irqrestore(&die_lock, flags);
 	if (panic_on_oops)
-		panic("Oops");
+		panic("Fatal exception: panic_on_oops");
 }
 
 void __kprobes __die(const char * str, struct pt_regs * regs, long err)
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -487,11 +487,9 @@ #endif
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
-	if (panic_on_oops) {
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds\n");
-		ssleep(5);
-		panic("Fatal exception");
-	}
+	if (panic_on_oops)
+		panic("Fatal exception: panic_on_oops");
+
 	do_exit(err);
 }
 
