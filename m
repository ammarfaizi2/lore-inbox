Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVGFDlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVGFDlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVGFDkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:40:19 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:12185 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262082AbVGFCTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:33 -0400
Subject: [PATCH] [42/48] Suspend2 2.1.9.8 for 2.6.12: 618-core.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:44 +1000
Message-Id: <11206164443244@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 619-userspace-nofreeze.patch-old/kernel/power/suspend2_core/userspace-nofreeze.c 619-userspace-nofreeze.patch-new/kernel/power/suspend2_core/userspace-nofreeze.c
--- 619-userspace-nofreeze.patch-old/kernel/power/suspend2_core/userspace-nofreeze.c	1970-01-01 10:00:00.000000000 +1000
+++ 619-userspace-nofreeze.patch-new/kernel/power/suspend2_core/userspace-nofreeze.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,69 @@
+/*
+ * kernel/power/suspend2_core/userspace-nofreeze.c
+ *
+ * Mark/unmark userspace processes as PF_NOFREEZE.
+ *
+ * This should be used with extreme caution!
+ *
+ * Initial purpose: make nbd-client about to be NOFREEZE.
+ */
+
+#include <linux/module.h>
+#include <linux/suspend.h>
+#include <asm/tlbflush.h>
+#include "../suspend.h"
+
+int toggle_pid;
+
+/*
+ * toggle_thread_nofreeze
+ *
+ * Toggle a thread's PF_NOFREEZE flag
+ *
+ * Returns:
+ * -1: PID not found
+ *  0: NO_FREEZE cleared.
+ *  1: NO_FREEZE set.
+ */
+static int __toggle_thread_nofreeze(int pid)
+{
+	struct task_struct *p, *g;
+	int result = -1;
+
+	read_lock(&tasklist_lock);
+
+	do_each_thread(g, p) {
+		if (p->pid == pid) {
+			if (p->mm) {
+				p->flags ^=PF_NOFREEZE;
+				result = !!(p->flags & PF_NOFREEZE);
+			} else
+				printk("Cowardly refusing to toggle NOFREEZE on a real kernel thread!");
+		}
+	} while_each_thread(g, p);
+
+	read_unlock(&tasklist_lock);
+
+	return result;
+}
+
+void toggle_thread_nofreeze(void)
+{
+	int result;
+	printk("Seeking %d... ", toggle_pid);
+
+	switch ((result = __toggle_thread_nofreeze(toggle_pid)))
+	{
+		case -1:
+			printk("Can't toggle NO_FREEZE for thread - not found.\n");
+			break;
+		case 0:
+			printk("NO_FREEZE flag cleared.\n");
+			break;
+		case 1:
+			printk("NO_FREEZE flag set.\n");
+			break;
+		default:
+			printk("what does %d mean?!", result);
+	}
+}

