Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVLIT3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVLIT3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVLIT3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:29:04 -0500
Received: from fmr21.intel.com ([143.183.121.13]:13287 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932418AbVLIT3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:29:03 -0500
Date: Fri, 9 Dec 2005 11:28:53 -0800
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       anil.s.keshavamurthy@intel.com,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>
Subject: [BUG][PATCH]Kprobes - No probes on critical path
Message-ID: <20051209112852.A31972@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[BUG][PATCH]Kprobes - No probes on critical path

For Kprobes critical path is the path from debug break exception
handler till the control reaches kprobes exception code. No probes
can be supported in this path as we will end up in recursion.

This patch prevents this by moving the below function to safe
__kprobes section onto which no probes can be inserted.

Please apply.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
---------------------------------------------------------------
 kernel/sys.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.15-rc5-mm1/kernel/sys.c
===================================================================
--- linux-2.6.15-rc5-mm1.orig/kernel/sys.c
+++ linux-2.6.15-rc5-mm1/kernel/sys.c
@@ -32,6 +32,7 @@
 
 #include <linux/compat.h>
 #include <linux/syscalls.h>
+#include <linux/kprobes.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -168,7 +169,7 @@ EXPORT_SYMBOL(notifier_chain_unregister)
  *	of the last notifier function called.
  */
  
-int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
+int __kprobes notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
 {
 	int ret=NOTIFY_DONE;
 	struct notifier_block *nb = *n;
