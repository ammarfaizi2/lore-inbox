Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVDDFkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVDDFkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDDFkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 01:40:19 -0400
Received: from ozlabs.org ([203.10.76.45]:37823 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261723AbVDDFjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 01:39:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16976.54118.845859.810616@cargo.ozlabs.ibm.com>
Date: Mon, 4 Apr 2005 15:40:54 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc: fix single-stepping of emulated instructions
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ppc, we emulate instructions that cause alignment exceptions.  If
we are single-stepping an instruction and it causes an alignment
exception, we will currently do the next instruction as well before
taking the single-step exception.  This patch fixes that, so we take
the single-step exception after emulating the instruction.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/traps.c pmac-2.5/arch/ppc/kernel/traps.c
--- linux-2.5/arch/ppc/kernel/traps.c	2005-03-29 16:24:53.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/traps.c	2005-03-31 08:37:53.000000000 +1000
@@ -679,6 +701,7 @@
 	fixed = fix_alignment(regs);
 	if (fixed == 1) {
 		regs->nip += 4;	/* skip over emulated instruction */
+		emulate_single_step(regs);
 		return;
 	}
 	if (fixed == -EFAULT) {
