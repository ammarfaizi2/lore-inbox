Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVCARt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVCARt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 12:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVCARt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 12:49:26 -0500
Received: from fire.osdl.org ([65.172.181.4]:41617 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261991AbVCARs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 12:48:58 -0500
Date: Tue, 1 Mar 2005 09:48:43 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] send audit reply to correct socket
Message-ID: <20050301174843.GV15867@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Send audit repsonse to socket which request came from, rather than pid
that request came from.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== kernel/audit.c 1.9 vs edited =====
--- 1.9/kernel/audit.c	2005-01-30 22:33:47 -08:00
+++ edited/kernel/audit.c	2005-02-28 18:34:47 -08:00
@@ -360,7 +360,7 @@ static int audit_receive_msg(struct sk_b
 		status_set.backlog_limit = audit_backlog_limit;
 		status_set.lost		 = atomic_read(&audit_lost);
 		status_set.backlog	 = atomic_read(&audit_backlog);
-		audit_send_reply(pid, seq, AUDIT_GET, 0, 0,
+		audit_send_reply(NETLINK_CB(skb).pid, seq, AUDIT_GET, 0, 0,
 				 &status_set, sizeof(status_set));
 		break;
 	case AUDIT_SET:
@@ -407,8 +407,8 @@ static int audit_receive_msg(struct sk_b
 		/* fallthrough */
 	case AUDIT_LIST:
 #ifdef CONFIG_AUDITSYSCALL
-		err = audit_receive_filter(nlh->nlmsg_type, pid, uid, seq,
-					   data);
+		err = audit_receive_filter(nlh->nlmsg_type, NETLINK_CB(skb).pid,
+					   uid, seq, data);
 #else
 		err = -EOPNOTSUPP;
 #endif
