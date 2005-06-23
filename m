Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbVFWCdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbVFWCdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 22:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbVFWCdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 22:33:00 -0400
Received: from fmr18.intel.com ([134.134.136.17]:21134 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261818AbVFWCcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 22:32:50 -0400
Date: Wed, 22 Jun 2005 19:32:42 -0700
Message-Id: <200506230232.j5N2WgwS018522@linux.jf.intel.com>
From: Rusty Lynch <rusty.lynch@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [ia64][patch] Refuse inserting kprobe on slot 1 
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
+	if (slot == 1) {
+		printk(KERN_WARNING "Inserting kprobes on slot #1 "
+		       "is not supported\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
