Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWEAKat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWEAKat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWEAKar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:30:47 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:29375 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751338AbWEAKae
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:30:34 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] Audit Filter Performance
Message-Id: <E1FaVfl-000546-MO@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:30:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Grubb <sgrubb@redhat.com>
Date: Tue Apr 11 08:50:56 2006 -0400

While testing the watch performance, I noticed that selinux_task_ctxid()
was creeping into the results more than it should. Investigation showed
that the function call was being called whether it was needed or not. The
below patch fixes this.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/auditsc.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

2ad312d2093ae506ae0fa184d8d026b559083087
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index a300736..1c03a4e 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -168,11 +168,9 @@ static int audit_filter_rules(struct tas
 			      struct audit_context *ctx,
 			      enum audit_state *state)
 {
-	int i, j;
+	int i, j, need_sid = 1;
 	u32 sid;
 
-	selinux_task_ctxid(tsk, &sid);
-
 	for (i = 0; i < rule->field_count; i++) {
 		struct audit_field *f = &rule->fields[i];
 		int result = 0;
@@ -271,11 +269,16 @@ static int audit_filter_rules(struct tas
 			   match for now to avoid losing information that
 			   may be wanted.   An error message will also be
 			   logged upon error */
-			if (f->se_rule)
+			if (f->se_rule) {
+				if (need_sid) {
+					selinux_task_ctxid(tsk, &sid);
+					need_sid = 0;
+				}
 				result = selinux_audit_rule_match(sid, f->type,
 				                                  f->op,
 				                                  f->se_rule,
 				                                  ctx);
+			}
 			break;
 		case AUDIT_ARG0:
 		case AUDIT_ARG1:
-- 
1.3.0.g0080f
