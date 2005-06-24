Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263157AbVFXQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263157AbVFXQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVFXQ6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:58:20 -0400
Received: from fmr18.intel.com ([134.134.136.17]:27555 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S263157AbVFXQ6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:58:14 -0400
Date: Fri, 24 Jun 2005 09:58:06 -0700
Message-Id: <200506241658.j5OGw6Kj007412@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       anil.s.keshavamurthy@intel.com
Subject: [ia64][patch] Refuse inserting kprobe on slot 1 - take 2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without the ability to atomically write 16 bytes, we can not update the
middle slot of a bundle, slot 1, unless we stop the machine first.  This 
patch will ensure the ability to robustly insert and remove a kprobe by
refusing to insert a kprobe on slot 1 until a mechanism is in place to 
safely handle this case.

	--rusty

Signed-off-by: Rusty Lynch <rusty.lynch@intel.com>

 arch/ia64/kernel/kprobes.c |    7 +++++++
 1 files changed, 7 insertions(+)

Index: linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.12-mm1.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6.12-mm1/arch/ia64/kernel/kprobes.c
@@ -270,6 +270,13 @@ static int valid_kprobe_addr(int templat
 				addr);
 		return -EINVAL;
 	}
+
+	if (slot == 1 && bundle_encoding[template][1] != L) {
+		printk(KERN_WARNING "Inserting kprobes on slot #1 "
+		       "is not supported\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
