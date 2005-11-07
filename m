Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVKGHNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVKGHNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbVKGHNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:13:04 -0500
Received: from [85.8.13.51] ([85.8.13.51]:51863 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932448AbVKGHNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:13:01 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Add try_to_freeze to kauditd
Date: Mon, 07 Nov 2005 08:13:00 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: akpm@osdl.org
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
Message-Id: <20051107071300.7073.47106.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kauditd was causing suspends to fail because it refused to freeze.
Adding a try_to_freeze() to its sleep loop solves the issue.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
Acked-by: Pavel Machek <pavel@suse.cz>
---

 kernel/audit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -291,8 +291,10 @@ int kauditd_thread(void *dummy)
 			set_current_state(TASK_INTERRUPTIBLE);
 			add_wait_queue(&kauditd_wait, &wait);
 
-			if (!skb_queue_len(&audit_skb_queue))
+			if (!skb_queue_len(&audit_skb_queue)) {
+				try_to_freeze();
 				schedule();
+			}
 
 			__set_current_state(TASK_RUNNING);
 			remove_wait_queue(&kauditd_wait, &wait);

