Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVFGLJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVFGLJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 07:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbVFGLJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 07:09:36 -0400
Received: from ozlabs.org ([203.10.76.45]:58527 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261813AbVFGLJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 07:09:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17061.32867.182516.172901@cargo.ozlabs.ibm.com>
Date: Tue, 7 Jun 2005 21:09:23 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
CC: linux-kernel@vger.kernel.org, anton@samba.org, ananth@in.ibm.com
Subject: [PATCH 1/2] ppc64 kprobes: correct kprobe registration return values
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

Add stricter checks during kprobe registration. Return correct error value
so insmod doesn't succeed. Also printk reason for registration failure.

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---

Index: linux-2.6.12-rc5/arch/ppc64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-rc5.orig/arch/ppc64/kernel/kprobes.c	2005-05-27 14:35:12.000000000 -0400
+++ linux-2.6.12-rc5/arch/ppc64/kernel/kprobes.c	2005-05-27 14:40:42.000000000 -0400
@@ -45,12 +45,17 @@ static kprobe_opcode_t stepped_insn;
 
 int arch_prepare_kprobe(struct kprobe *p)
 {
+	int ret = 0;
 	kprobe_opcode_t insn = *p->addr;
 
-	if (IS_MTMSRD(insn) || IS_RFID(insn))
-		/* cannot put bp on RFID/MTMSRD */
-		return 1;
-	return 0;
+	if ((unsigned long)p->addr & 0x03) {
+		printk("Attempt to register kprobe at an unaligned address\n");
+		ret = -EINVAL;
+	} else if (IS_MTMSRD(insn) || IS_RFID(insn)) {
+		printk("Cannot register a kprobe on rfid or mtmsrd\n");
+		ret = -EINVAL;
+	}
+	return ret;
 }
 
 void arch_copy_kprobe(struct kprobe *p)
