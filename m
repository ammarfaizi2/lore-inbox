Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262519AbVAJTyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbVAJTyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVAJTwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:52:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2193 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262511AbVAJTsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:48:08 -0500
Date: Mon, 10 Jan 2005 14:43:18 -0500
Message-Id: <200501101943.j0AJhId3028056@redrum.boston.redhat.com>
From: Peter Martuccelli <peterm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: peterm@redhat.com, sgrubb@redhat.com, rl@hellgate.ch, akpm@osdl.com
Subject: [PATCH 2.6.10] audit return code and log format fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew,

A couple of one liners to resolve two issues that have come up
regarding audit.  Roger reported a problem with 
audit.c:audit_receive_skb which improperly negates the errno
argument when netlink_ack is called.  The second issue was reported
by Steve on the linux-audit list, auditsc.s:audit_log_exit using %u 
instead of %d in the audit_log_format call.

Please incorporate the patch in the next version.

Please note, there is a mailing list available for audit discussion at 
https://www.redhat.com/archives/linux-audit/

Signed-off-by: Peter Martuccelli <peterm@redhat.com>
               Steve Grubb <sgrubb@redhat.com>
               Roger Luethi <rl@hellgate.ch>


Regards,

Peter

diffstat:
 audit.c   |    2 +-
 auditsc.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp linux-2.6.10-pristine/kernel/audit.c linux-2.6.10/kernel/audit.c
--- linux-2.6.10-pristine/kernel/audit.c	2004-12-24 16:35:50.000000000 -0500
+++ linux-2.6.10/kernel/audit.c	2005-01-07 15:37:22.329915776 -0500
@@ -419,7 +419,7 @@ static int audit_receive_skb(struct sk_b
 		if (rlen > skb->len)
 			rlen = skb->len;
 		if ((err = audit_receive_msg(skb, nlh))) {
-			netlink_ack(skb, nlh, -err);
+			netlink_ack(skb, nlh, err);
 		} else if (nlh->nlmsg_flags & NLM_F_ACK)
 			netlink_ack(skb, nlh, 0);
 		skb_pull(skb, rlen);
diff -Naurp linux-2.6.10-pristine/kernel/auditsc.c linux-2.6.10/kernel/auditsc.c
--- linux-2.6.10-pristine/kernel/auditsc.c	2004-12-24 16:35:24.000000000 -0500
+++ linux-2.6.10/kernel/auditsc.c	2005-01-07 15:37:17.675623336 -0500
@@ -591,7 +591,7 @@ static void audit_log_exit(struct audit_
 	if (context->personality != PER_LINUX)
 		audit_log_format(ab, " per=%lx", context->personality);
 	if (context->return_valid)
-		audit_log_format(ab, " exit=%u", context->return_code);
+		audit_log_format(ab, " exit=%d", context->return_code);
 	audit_log_format(ab,
 		  " a0=%lx a1=%lx a2=%lx a3=%lx items=%d"
 		  " pid=%d loginuid=%d uid=%d gid=%d"

