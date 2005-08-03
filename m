Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVHCFKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVHCFKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 01:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVHCFKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 01:10:25 -0400
Received: from ozlabs.org ([203.10.76.45]:48772 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262053AbVHCFKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 01:10:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17136.20802.654471.934480@cargo.ozlabs.ibm.com>
Date: Wed, 3 Aug 2005 15:08:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: anton@samba.org, hbabu@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Xmon bug fix for soft-reset
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haren Myneni <haren@us.ibm.com>

For soft reset during system hang, got an error "CPU did not take 
control" for some CPUs even though they responded to soft-reset (called 
SystemReset, die and called debugger - xmon).   First these CPUs entered 
into xmon by IPI callback and then got a soft-reset exception and 
re-entered into xmon again. The first CPU which re-entered into xmon got 
the output lock and made into xmon successfully without unlocking. 
Hence, the next CPU(s) which re-entered into xmon try to acquire a lock  
(get_output_lock). Therefore, we can not view state of those CPU(s).

[This is a simple, very low risk, obvious fix for an obvious bug, and
should go into 2.6.13.  -- paulus]

Signed-off-by: Haren Myneni <hbabu@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
--- linux-2.6.13-rc4-git4/arch/ppc64/xmon/xmon.c.orig	2005-08-01 22:31:09.000000000 -0700
+++ linux-2.6.13-rc4-git4/arch/ppc64/xmon/xmon.c	2005-08-01 22:33:16.000000000 -0700
@@ -329,13 +329,16 @@ int xmon_core(struct pt_regs *regs, int 
 		printf("cpu 0x%x: Exception %lx %s in xmon, "
 		       "returning to main loop\n",
 		       cpu, regs->trap, getvecname(TRAP(regs)));
+		release_output_lock();
 		longjmp(xmon_fault_jmp[cpu], 1);
 	}
 
 	if (setjmp(recurse_jmp) != 0) {
 		if (!in_xmon || !xmon_gate) {
+			get_output_lock();
 			printf("xmon: WARNING: bad recursive fault "
 			       "on cpu 0x%x\n", cpu);
+			release_output_lock();
 			goto waiting;
 		}
 		secondary = !(xmon_taken && cpu == xmon_owner);
