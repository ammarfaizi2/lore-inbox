Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWGXSnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWGXSnG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 14:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWGXSnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 14:43:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:3712 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751414AbWGXSnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 14:43:01 -0400
Date: Mon, 24 Jul 2006 20:42:51 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, levon@movementarian.org
Subject: [PATCH for 2.6.18rc2] [2/7] i386/x86-64: Add user_mode checks to
 profile_pc for oprofile
Message-ID: <44c514ab.tRvUIWV9iP3YgG28%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes a obscure user space triggerable crash during oprofiling.

Oprofile calls profile_pc from NMIs even when user_mode(regs) is not true and
the program counter is inside the kernel lock section. This opens
a race - when a user program jumps to a kernel lock address and 
a NMI happens before the illegal page fault exception is raised
and the program has a unmapped esp or ebp then the kernel could
oops. NMIs have a higher priority than exceptions so that could
happen.

Add user_mode checks to i386/x86-64 profile_pc to prevent that.

Cc: John Levon <levon@movementarian.org>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/time.c   |    2 +-
 arch/x86_64/kernel/time.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/time.c
===================================================================
--- linux.orig/arch/i386/kernel/time.c
+++ linux/arch/i386/kernel/time.c
@@ -135,7 +135,7 @@ unsigned long profile_pc(struct pt_regs 
 {
 	unsigned long pc = instruction_pointer(regs);
 
-	if (in_lock_functions(pc))
+	if (!user_mode_vm(regs) && in_lock_functions(pc))
 		return *(unsigned long *)(regs->ebp + 4);
 
 	return pc;
Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c
+++ linux/arch/x86_64/kernel/time.c
@@ -195,7 +195,7 @@ unsigned long profile_pc(struct pt_regs 
 	   is just accounted to the spinlock function.
 	   Better would be to write these functions in assembler again
 	   and check exactly. */
-	if (in_lock_functions(pc)) {
+	if (!user_mode(regs) && in_lock_functions(pc)) {
 		char *v = *(char **)regs->rsp;
 		if ((v >= _stext && v <= _etext) ||
 			(v >= _sinittext && v <= _einittext) ||
