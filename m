Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946512AbWKAFlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946512AbWKAFlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946532AbWKAFlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:41:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31890 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946528AbWKAFl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:41:26 -0500
Message-Id: <20061101054130.262716000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Zachary Amsden <zach@vmware.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 35/61] Fix potential interrupts during alternative patching
Content-Disposition: inline; filename=fix-potential-interrupts-during-alternative-patching.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Zachary Amsden <zach@vmware.com>

Interrupts must be disabled during alternative instruction patching.
On systems with high timer IRQ rates, or when running in an emulator,
timing differences can result in random kernel panics because of
running partially patched instructions.  This doesn't yet fix NMIs,
which requires extricating the patch code from the late bug checking
and is logically separate (and also less likely to cause problems).

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/kernel/alternative.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-2.6.18.1.orig/arch/i386/kernel/alternative.c
+++ linux-2.6.18.1/arch/i386/kernel/alternative.c
@@ -344,6 +344,7 @@ void alternatives_smp_switch(int smp)
 
 void __init alternative_instructions(void)
 {
+	unsigned long flags;
 	if (no_replacement) {
 		printk(KERN_INFO "(SMP-)alternatives turned off\n");
 		free_init_pages("SMP alternatives",
@@ -351,6 +352,8 @@ void __init alternative_instructions(voi
 				(unsigned long)__smp_alt_end);
 		return;
 	}
+
+	local_irq_save(flags);
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 	/* switch to patch-once-at-boottime-only mode and free the
@@ -386,4 +389,5 @@ void __init alternative_instructions(voi
 		alternatives_smp_switch(0);
 	}
 #endif
+	local_irq_restore(flags);
 }

--
