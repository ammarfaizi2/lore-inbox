Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVCJCZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVCJCZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 21:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVCJCWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 21:22:46 -0500
Received: from ozlabs.org ([203.10.76.45]:57743 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261715AbVCJCS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 21:18:57 -0500
Date: Thu, 10 Mar 2005 13:18:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
       linux-kernel@vger.kernel.org
Subject: [PPC64] Allow emulation of mfpvr on ppc64 kernel
Message-ID: <20050310021848.GD30435@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@lists.linuxppc.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply.

Allow userspace programs on ppc64 to use the (privileged) mfpvr
instruction to determine the processor type.  At the moment it
emulates the instruction to provide the real PVR value, though it
could be made to lie in future if for some reason we wish to restrict
what CPU features userspace uses.

If nothing else this means that some existing ppc32 applications will
now run on a 64-bit kernel (the 32-bit kernel has long supported this
emulation).  It will also be necessary for ppc64 perfctr support,
where userspace requires finer-grained cpu type information than the
kernel in order to correctly program the performance monitor control
registers.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/kernel/traps.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/traps.c	2005-03-06 07:08:24.000000000 +1100
+++ working-2.6/arch/ppc64/kernel/traps.c	2005-03-10 13:05:25.000000000 +1100
@@ -279,6 +279,9 @@
  * fault.  Return zero on success.
  */
 
+#define INST_MFSPR_PVR		0x7c1f42a6
+#define INST_MFSPR_PVR_MASK	0xfc1fffff
+
 #define INST_DCBA		0x7c0005ec
 #define INST_DCBA_MASK		0x7c0007fe
 
@@ -297,6 +300,15 @@
 	if (get_user(instword, (unsigned int __user *)(regs->nip)))
 		return -EFAULT;
 
+	/* Emulate the mfspr rD, PVR. */
+	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
+		unsigned int rd;
+
+		rd = (instword >> 21) & 0x1f;
+		regs->gpr[rd] = mfspr(SPRN_PVR);
+		return 0;
+	}
+
 	/* Emulating the dcba insn is just a no-op.  */
 	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
 		static int warned;
@@ -390,11 +402,6 @@
 	if (regs->msr & 0x100000) {
 		/* IEEE FP exception */
 		parse_fpe(regs);
-
-	} else if (regs->msr & 0x40000) {
-		/* Privileged instruction */
-		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-
 	} else if (regs->msr & 0x20000) {
 		/* trap exception */
 
@@ -411,7 +418,7 @@
 		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 
 	} else {
-		/* Illegal instruction; try to emulate it.  */
+		/* Privileged or illegal instruction; try to emulate it. */
 		switch (emulate_instruction(regs)) {
 		case 0:
 			regs->nip += 4;
@@ -423,7 +430,12 @@
 			break;
 
 		default:
-			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+			if (regs->msr & 0x40000)
+				/* priveleged */
+				_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
+			else
+				/* illegal */
+				_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 			break;
 		}
 	}


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist.  NOT _the_ _other_ _way_
				| _around_!
http://www.ozlabs.org/people/dgibson
