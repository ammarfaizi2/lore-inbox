Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVGCQFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVGCQFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 12:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbVGCQFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 12:05:16 -0400
Received: from ozlabs.org ([203.10.76.45]:60613 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261468AbVGCPzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 11:55:35 -0400
Date: Sun, 24 Jul 2005 01:02:10 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] quieten OOM killer noise
Message-ID: <20050723150209.GA15055@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We now print statistics when invoking the OOM killer, however this
information is not rate limited and you can get into situations where
the console is continually spammed.

For example, when a task is exiting the OOM killer will simply return
(waiting for that task to exit and clear up memory). If the VM
continually calls back into the OOM killer we get thousands of copies of
show_mem() on the console.

Use printk_ratelimit() to quieten it.

Signed-off-by: Anton Blanchard <anton@samba.org>

Index: foobar2/mm/oom_kill.c
===================================================================
--- foobar2.orig/mm/oom_kill.c	2005-07-02 15:56:13.000000000 +1000
+++ foobar2/mm/oom_kill.c	2005-07-04 01:38:59.474324542 +1000
@@ -258,9 +258,11 @@
 	struct mm_struct *mm = NULL;
 	task_t * p;
 
-	printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
-	/* print memory stats */
-	show_mem();
+	if (printk_ratelimit()) {
+		printk("oom-killer: gfp_mask=0x%x\n", gfp_mask);
+		/* print memory stats */
+		show_mem();
+	}
 
 	read_lock(&tasklist_lock);
 retry:
