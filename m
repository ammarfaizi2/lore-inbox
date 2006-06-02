Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWFBN4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWFBN4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWFBN4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:56:04 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63701 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932107AbWFBN4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:56:02 -0400
Date: Fri, 2 Jun 2006 15:56:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch, -rc5-mm2] lock validator: early_boot_irqs_[on|off]() build fix
Message-ID: <20060602135630.GA6676@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5168]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: lock validator: early_boot_irqs_[on|off]() build fix
From: Ingo Molnar <mingo@elte.hu>

fix build bug if CONFIG_TRACE_IRQFLAGS is off: the existence of
early_boot_irqs_[on|off]() depends on CONFIG_TRACE_IRQFLAGS,
not on CONFIG_LOCKDEP.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/lockdep.h |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Index: linux/include/linux/lockdep.h
===================================================================
--- linux.orig/include/linux/lockdep.h
+++ linux/include/linux/lockdep.h
@@ -210,9 +210,6 @@ extern void lockdep_release(struct lockd
 
 # define INIT_LOCKDEP				.lockdep_recursion = 0,
 
-extern void early_boot_irqs_off(void);
-extern void early_boot_irqs_on(void);
-
 #else /* LOCKDEP */
 # define lockdep_init()				do { } while (0)
 # define lockdep_info()				do { } while (0)
@@ -222,14 +219,20 @@ extern void early_boot_irqs_on(void);
 # define INIT_LOCKDEP
 # define lockdep_reset()		do { debug_locks = 1; } while (0)
 # define lockdep_free_key_range(start, size)	do { } while (0)
-# define early_boot_irqs_off()			do { } while (0)
-# define early_boot_irqs_on()			do { } while (0)
 /*
  * The type key takes no space if lockdep is disabled:
  */
 struct lockdep_type_key { };
 #endif /* !LOCKDEP */
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+extern void early_boot_irqs_off(void);
+extern void early_boot_irqs_on(void);
+#else
+# define early_boot_irqs_off()			do { } while (0)
+# define early_boot_irqs_on()			do { } while (0)
+#endif
+
 /*
  * For trivial one-depth nesting of a lock-type, the following
  * global define can be used. (Subsystems with multiple levels
