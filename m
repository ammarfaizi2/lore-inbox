Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVCKWOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVCKWOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 17:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVCKWNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 17:13:32 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:36548 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261647AbVCKWMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 17:12:40 -0500
Date: Fri, 11 Mar 2005 16:12:19 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: Andrew Morton <akpm@osdl.org>
cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: emulate load/store string instructions
Message-ID: <Pine.LNX.4.61.0503111609001.9384@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Some Book-E implementations (e500) do not implement the userland 
load/store string instructions.  Apparently these instructions are rather 
painful to implement do to the fact that they modify the destination 
register differently then ever other instruction.  Matt did the inital 
work some time ago, and I finally got around to cleaning it up.

Signed-off-by: Matt McClintock
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2005-03-11 15:07:28 -06:00
+++ b/arch/ppc/kernel/traps.c	2005-03-11 15:07:28 -06:00
@@ -389,6 +389,87 @@
 #define INST_MCRXR		0x7c000400
 #define INST_MCRXR_MASK		0x7c0007fe
 
+#define INST_STRING		0x7c00042a
+#define INST_STRING_MASK	0x7c0007fe
+#define INST_STRING_GEN_MASK	0x7c00067e
+#define INST_LSWI		0x7c0004aa
+#define INST_LSWX		0x7c00042a
+#define INST_STSWI		0x7c0005aa
+#define INST_STSWX		0x7c00052a
+
+static int emulate_string_inst(struct pt_regs *regs, u32 instword)
+{
+	u8 rT = (instword >> 21) & 0x1f;
+	u8 rA = (instword >> 16) & 0x1f;
+	u8 NB_RB = (instword >> 11) & 0x1f;
+	u32 num_bytes;
+	u32 EA;
+	int pos = 0;
+
+	/* Early out if we are an invalid form of lswx */
+	if ((instword & INST_STRING_MASK) == INST_LSWX)
+		if ((rA >= rT) || (NB_RB >= rT) || (rT == rA) || (rT == NB_RB))
+			return -EINVAL;
+
+	/* Early out if we are an invalid form of lswi */
+	if ((instword & INST_STRING_MASK) == INST_LSWX)
+		if ((rA >= rT) || (rT == rA))
+			return -EINVAL;
+
+	EA = (rA == 0) ? 0 : regs->gpr[rA];
+
+	switch (instword & INST_STRING_MASK) {
+		case INST_LSWX:
+		case INST_STSWX:
+			EA += NB_RB;
+			num_bytes = regs->xer & 0x7f;
+			break;
+		case INST_LSWI:
+		case INST_STSWI:
+			num_bytes = (NB_RB == 0) ? 32 : NB_RB;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	while (num_bytes != 0)
+	{
+		u8 val;
+		u32 shift = 8 * (3 - (pos & 0x3));
+
+		switch ((instword & INST_STRING_MASK)) {
+			case INST_LSWX:
+			case INST_LSWI:
+				if (get_user(val, (u8 __user *)EA))
+					return -EFAULT;
+				/* first time updating this reg,
+				 * zero it out */
+				if (pos == 0)
+					regs->gpr[rT] = 0;
+				regs->gpr[rT] |= val << shift;
+				break;
+			case INST_STSWI:
+			case INST_STSWX:
+				val = regs->gpr[rT] >> shift;
+				if (put_user(val, (u8 __user *)EA))
+					return -EFAULT;
+				break;
+		}
+		/* move EA to next address */
+		EA += 1;
+		num_bytes--;
+
+		/* manage our position within the register */
+		if (++pos == 4) {
+			pos = 0;
+			if (++rT == 32)
+				rT = 0;
+		}
+	}
+
+	return 0;
+}
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
@@ -422,6 +503,10 @@
 		regs->xer &= ~0xf0000000UL;
 		return 0;
 	}
+
+	/* Emulate load/store string insn. */
+	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
+		return emulate_string_inst(regs, instword);
 
 	return -EINVAL;
 }
