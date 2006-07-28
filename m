Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161180AbWG1QHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161180AbWG1QHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWG1QGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:06:50 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:31160 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752032AbWG1QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:06:44 -0400
Subject: [patch 4/5] Add the __stack_chk_fail() function
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1154102546.6416.9.camel@laptopd505.fenrus.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 18:05:05 +0200
Message-Id: <1154102705.6416.17.camel@laptopd505.fenrus.org>
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

Index: linux-2.6.18-rc2-git5-stackprot/kernel/panic.c
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/kernel/panic.c
+++ linux-2.6.18-rc2-git5-stackprot/kernel/panic.c
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

