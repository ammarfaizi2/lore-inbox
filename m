Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbWHJTnB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbWHJTnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWHJTnA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:43:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:21228 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932687AbWHJThg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:36 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [135/145] x86_64: wire up oops_enter()/oops_exit()
Message-Id: <20060810193735.455D21394D@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:35 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Andrew Morton <akpm@osdl.org>

Implement pause_on_oops() on x86_64.

AK: I redid the patch to do the oops_enter/exit in the existing
oops_begin()/end(). This makes it much shorter.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Andi Kleen <ak@suse.de>

---

 arch/x86_64/kernel/traps.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -559,6 +559,8 @@ unsigned __kprobes long oops_begin(void)
 	int cpu = safe_smp_processor_id();
 	unsigned long flags;
 
+	oops_enter();
+
 	/* racy, but better than risking deadlock. */
 	local_irq_save(flags);
 	if (!spin_trylock(&die_lock)) { 
@@ -587,6 +589,8 @@ void __kprobes oops_end(unsigned long fl
 		spin_unlock_irqrestore(&die_lock, flags);
 	if (panic_on_oops)
 		panic("Fatal exception: panic_on_oops");
+
+	oops_exit();
 }
 
 void __kprobes __die(const char * str, struct pt_regs * regs, long err)
