Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVDLKig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVDLKig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVDLKhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:37:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:7112 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262122AbVDLKbK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:10 -0400
Message-Id: <200504121031.j3CAV6mR005237@shell0.pdx.osdl.net>
Subject: [patch 029/198] ppc32: fix single-stepping of emulated instructions
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, paulus@samba.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paul Mackerras <paulus@samba.org>

On ppc, we emulate instructions that cause alignment exceptions.  If we are
single-stepping an instruction and it causes an alignment exception, we
will currently do the next instruction as well before taking the
single-step exception.  This patch fixes that, so we take the single-step
exception after emulating the instruction.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ppc/kernel/traps.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/ppc/kernel/traps.c~ppc32-fix-single-stepping-of-emulated-instructions arch/ppc/kernel/traps.c
--- 25/arch/ppc/kernel/traps.c~ppc32-fix-single-stepping-of-emulated-instructions	2005-04-12 03:21:10.375559576 -0700
+++ 25-akpm/arch/ppc/kernel/traps.c	2005-04-12 03:21:10.378559120 -0700
@@ -679,6 +679,7 @@ void AlignmentException(struct pt_regs *
 	fixed = fix_alignment(regs);
 	if (fixed == 1) {
 		regs->nip += 4;	/* skip over emulated instruction */
+		emulate_single_step(regs);
 		return;
 	}
 	if (fixed == -EFAULT) {
_
