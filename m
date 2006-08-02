Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWHBTVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWHBTVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWHBTVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:21:07 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:3243 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932164AbWHBTVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:21:06 -0400
Subject: [patch 1/3] selinux: eliminate selinux_task_ctxid
From: Stephen Smalley <sds@tycho.nsa.gov>
To: linux-audit@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 02 Aug 2006 15:23:27 -0400
Message-Id: <1154546607.16917.181.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate selinux_task_ctxid since it duplicates selinux_task_get_sid.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---
 include/linux/selinux.h    |   15 ---------------
 kernel/auditsc.c           |    2 +-
 security/selinux/exports.c |    9 ---------
 3 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index aad4e39..79e4707 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -70,16 +70,6 @@ int selinux_audit_rule_match(u32 ctxid, 
 void selinux_audit_set_callback(int (*callback)(void));
 
 /**
- *	selinux_task_ctxid - determine a context ID for a process.
- *	@tsk: the task object
- *	@ctxid: ID value returned via this
- *
- *	On return, ctxid will contain an ID for the context.  This value
- *	should only be used opaquely.
- */
-void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid);
-
-/**
  *     selinux_ctxid_to_string - map a security context ID to a string
  *     @ctxid: security context ID to be converted.
  *     @ctx: address of context string to be returned
@@ -166,11 +156,6 @@ static inline void selinux_audit_set_cal
 	return;
 }
 
-static inline void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)
-{
-	*ctxid = 0;
-}
-
 static inline int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
 {
        *ctx = NULL;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index ae40ac8..6322547 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -333,7 +333,7 @@ static int audit_filter_rules(struct tas
 			   logged upon error */
 			if (f->se_rule) {
 				if (need_sid) {
-					selinux_task_ctxid(tsk, &sid);
+					selinux_get_task_sid(tsk, &sid);
 					need_sid = 0;
 				}
 				result = selinux_audit_rule_match(sid, f->type,
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index 9d7737d..ee0fb47 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -21,15 +21,6 @@ #include <linux/ipc.h>
 #include "security.h"
 #include "objsec.h"
 
-void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)
-{
-	struct task_security_struct *tsec = tsk->security;
-	if (selinux_enabled)
-		*ctxid = tsec->sid;
-	else
-		*ctxid = 0;
-}
-
 int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
 {
 	if (selinux_enabled)
-- 
1.4.1



