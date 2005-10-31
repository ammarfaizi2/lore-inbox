Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbVJaDqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbVJaDqG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVJaDqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:46:06 -0500
Received: from bdsl.66.14.168.118.gte.net ([66.14.168.118]:12815 "EHLO
	ispwest-email1.mdeinc.com") by vger.kernel.org with ESMTP
	id S1751309AbVJaDqE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:46:04 -0500
X-Modus-BlackList: 216.52.245.25=OK;kjak@ispwest.com=OK
X-Modus-Trusted: 216.52.245.25=YES
Message-ID: <614bc6487d064108ba9b11455687a5df.kjak@ispwest.com>
X-EM-APIVersion: 2, 0, 1, 0
X-Priority: 3 (Normal)
Reply-To: "Kris Katterjohn" <kjak@users.sourceforge.net>
From: "Kris Katterjohn" <kjak@ispwest.com>
To: jschlst@samba.org
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net/core/filter.c, kernel 2.6.14
Date: Sun, 30 Oct 2005 19:46:01 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Before, the socket filter would apply the filter, then, while running through the steps of the filter on each packet, it would check for division by zero. This patch checks for division by zero (when dividing by a constant) in sk_chk_filter() so the filter won't be applied if a divide-by-zero instruction is found.

This patch is a diff from kernel version 2.6.14.

Signed-off-by: Kris Katterjohn <kjak@users.sourceforge.net>

---

--- x/net/core/filter.c	2005-10-27 19:02:08.000000000 -0500
+++ y/net/core/filter.c	2005-10-30 21:38:41.000000000 -0600
@@ -116,8 +116,6 @@ int sk_run_filter(struct sk_buff *skb, s
 			A /= X;
 			continue;
 		case BPF_ALU|BPF_DIV|BPF_K:
-			if (fentry->k == 0)
-				return 0;
 			A /= fentry->k;
 			continue;
 		case BPF_ALU|BPF_AND|BPF_X:
@@ -320,6 +318,10 @@ int sk_chk_filter(struct sock_filter *fi
 			}
 		}
 
+		/* check for division by zero   -Kris Katterjohn 2005-10-30 */
+		if (ftest->code == (BPF_ALU|BPF_DIV|BPF_K) && ftest->k == 0)
+			return -EINVAL;
+
 		/* check that memory operations use valid addresses. */
 		if (ftest->k >= BPF_MEMWORDS) {
 			/* but it might not be a memory operation... */


