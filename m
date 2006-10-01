Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWJAMau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWJAMau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWJAMau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:30:50 -0400
Received: from havoc.gtf.org ([69.61.125.42]:24550 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932109AbWJAMat (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:30:49 -0400
Date: Sun, 1 Oct 2006 08:30:45 -0400
From: Jeff Garzik <jeff@garzik.org>
To: dwmw2@infradead.org
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kauditd thread API fixes
Message-ID: <20061001123045.GA29682@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kill the "function should return a value" warning, and use the standard
mechanism for deciding when a thread should stop.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

Given the security-sensitive nature of the audit function, _perhaps_ the
omission of kthread_should_stop() was intentional.  If so, it at least
deserves a comment.  But I think this is more correct.

diff --git a/kernel/audit.c b/kernel/audit.c
index f9889ee..b9146b1 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -340,7 +340,7 @@ static int kauditd_thread(void *dummy)
 {
 	struct sk_buff *skb;
 
-	while (1) {
+	do {
 		skb = skb_dequeue(&audit_skb_queue);
 		wake_up(&audit_backlog_wait);
 		if (skb) {
@@ -368,7 +368,9 @@ static int kauditd_thread(void *dummy)
 			__set_current_state(TASK_RUNNING);
 			remove_wait_queue(&kauditd_wait, &wait);
 		}
-	}
+	} while (!kthread_should_stop());
+
+	return 0;
 }
 
 int audit_send_list(void *_dest)
