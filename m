Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVAZAgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVAZAgX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 19:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVAZAeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 19:34:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:27809 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262275AbVAZAcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 19:32:48 -0500
Date: Tue, 25 Jan 2005 16:32:47 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fix audit skb leak on congested netlink socket
Message-ID: <20050125163247.N24171@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When auditd is congested the kernel's audit system leaks skb's.  First,
it takes them off the audit_buffer sklist at which point they are lost,
second, it allocates a new skb with 0 length payload.  Then (likely still
congested), it repeats this losing the new skb.  Plug the leak by making
sure to requeue the skb, and avoid audit_log_move() on 0 len audit_buffer.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/audit.c 1.6 vs edited =====
--- 1.6/kernel/audit.c	2005-01-20 20:56:04 -08:00
+++ edited/kernel/audit.c	2005-01-25 14:34:32 -08:00
@@ -494,6 +494,10 @@ static void audit_log_move(struct audit_
 	char		*start;
 	int		extra = ab->nlh ? 0 : NLMSG_SPACE(0);
 
+	/* possible resubmission */
+	if (ab->len == 0)
+		return;
+
 	skb = skb_peek(&ab->sklist);
 	if (!skb || skb_tailroom(skb) <= ab->len + extra) {
 		skb = alloc_skb(2 * ab->len + extra, GFP_ATOMIC);
@@ -535,6 +539,7 @@ static inline int audit_log_drain(struct
 		}
 		if (retval == -EAGAIN && ab->count < 5) {
 			++ab->count;
+			skb_queue_tail(&ab->sklist, skb);
 			audit_log_end_irq(ab);
 			return 1;
 		}
