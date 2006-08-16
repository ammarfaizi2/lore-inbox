Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWHPRKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWHPRKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWHPRKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:10:42 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:36062 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932117AbWHPRKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:10:40 -0400
Subject: [patch 4/5] -fstack-protector feature: Add the __stack_chk_fail()
	function
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1155746902.3023.63.camel@laptopd505.fenrus.org>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 18:52:23 +0200
Message-Id: <1155747144.3023.71.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch 4/5] Add the __stack_chk_fail() function

GCC emits a call to a __stack_chk_fail() function when the stack canary is
not matching the expected value.

Since this is a bad security issue; lets panic the kernel rather than limping
along; the kernel really can't be trusted anymore when this happens.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>

---
 kernel/panic.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6.18-rc4-stackprot/kernel/panic.c
===================================================================
--- linux-2.6.18-rc4-stackprot.orig/kernel/panic.c
+++ linux-2.6.18-rc4-stackprot/kernel/panic.c
@@ -269,3 +269,15 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 }
+
+#ifdef CONFIG_CC_STACKPROTECTOR
+/*
+ * Called when gcc's -fstack-protector feature is used, and
+ * gcc detects corruption of the on-stack canary value
+ */
+void __stack_chk_fail(void)
+{
+	panic("stack-protector: Kernel stack is corrupted");
+}
+EXPORT_SYMBOL(__stack_chk_fail);
+#endif

