Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWHBTYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWHBTYr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 15:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWHBTYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 15:24:47 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:22927 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932157AbWHBTYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 15:24:46 -0400
Subject: [patch 2/3] selinux: rename selinux_ctxid_to_string
From: Stephen Smalley <sds@tycho.nsa.gov>
To: linux-audit@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@namei.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 02 Aug 2006 15:27:07 -0400
Message-Id: <1154546827.16917.184.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename selinux_ctxid_to_string to selinux_sid_to_string to be
consistent with other interfaces.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Acked-by:  James Morris <jmorris@namei.org>

---

 include/linux/selinux.h    |    8 ++++----
 kernel/audit.c             |   14 +++++++-------
 kernel/auditfilter.c       |    2 +-
 kernel/auditsc.c           |    4 ++--
 security/selinux/exports.c |    4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/selinux.h b/include/linux/selinux.h
index 79e4707..df9098d 100644
--- a/include/linux/selinux.h
+++ b/include/linux/selinux.h
@@ -70,8 +70,8 @@ int selinux_audit_rule_match(u32 ctxid, 
 void selinux_audit_set_callback(int (*callback)(void));
 
 /**
- *     selinux_ctxid_to_string - map a security context ID to a string
- *     @ctxid: security context ID to be converted.
+ *     selinux_sid_to_string - map a security context ID to a string
+ *     @sid: security context ID to be converted.
  *     @ctx: address of context string to be returned
  *     @ctxlen: length of returned context string.
  *
@@ -79,7 +79,7 @@ void selinux_audit_set_callback(int (*ca
  *     string will be allocated internally, and the caller must call
  *     kfree() on it after use.
  */
-int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen);
+int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen);
 
 /**
  *     selinux_get_inode_sid - get the inode's security context ID
@@ -156,7 +156,7 @@ static inline void selinux_audit_set_cal
 	return;
 }
 
-static inline int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
+static inline int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen)
 {
        *ctx = NULL;
        *ctxlen = 0;
diff --git a/kernel/audit.c b/kernel/audit.c
index d417ca1..6a0a30a 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -244,7 +244,7 @@ static int audit_set_rate_limit(int limi
 		char *ctx = NULL;
 		u32 len;
 		int rc;
-		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+		if ((rc = selinux_sid_to_string(sid, &ctx, &len)))
 			return rc;
 		else
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
@@ -267,7 +267,7 @@ static int audit_set_backlog_limit(int l
 		char *ctx = NULL;
 		u32 len;
 		int rc;
-		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+		if ((rc = selinux_sid_to_string(sid, &ctx, &len)))
 			return rc;
 		else
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
@@ -293,7 +293,7 @@ static int audit_set_enabled(int state, 
 		char *ctx = NULL;
 		u32 len;
 		int rc;
-		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+		if ((rc = selinux_sid_to_string(sid, &ctx, &len)))
 			return rc;
 		else
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
@@ -321,7 +321,7 @@ static int audit_set_failure(int state, 
 		char *ctx = NULL;
 		u32 len;
 		int rc;
-		if ((rc = selinux_ctxid_to_string(sid, &ctx, &len)))
+		if ((rc = selinux_sid_to_string(sid, &ctx, &len)))
 			return rc;
 		else
 			audit_log(NULL, GFP_KERNEL, AUDIT_CONFIG_CHANGE,
@@ -538,7 +538,7 @@ static int audit_receive_msg(struct sk_b
 		if (status_get->mask & AUDIT_STATUS_PID) {
 			int old   = audit_pid;
 			if (sid) {
-				if ((err = selinux_ctxid_to_string(
+				if ((err = selinux_sid_to_string(
 						sid, &ctx, &len)))
 					return err;
 				else
@@ -576,7 +576,7 @@ static int audit_receive_msg(struct sk_b
 						 "user pid=%d uid=%u auid=%u",
 						 pid, uid, loginuid);
 				if (sid) {
-					if (selinux_ctxid_to_string(
+					if (selinux_sid_to_string(
 							sid, &ctx, &len)) {
 						audit_log_format(ab, 
 							" ssid=%u", sid);
@@ -614,7 +614,7 @@ static int audit_receive_msg(struct sk_b
 					   loginuid, sid);
 		break;
 	case AUDIT_SIGNAL_INFO:
-		err = selinux_ctxid_to_string(audit_sig_sid, &ctx, &len);
+		err = selinux_sid_to_string(audit_sig_sid, &ctx, &len);
 		if (err)
 			return err;
 		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 5b4e162..9cf9f2e 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -1345,7 +1345,7 @@ static void audit_log_rule_change(uid_t 
 	if (sid) {
 		char *ctx = NULL;
 		u32 len;
-		if (selinux_ctxid_to_string(sid, &ctx, &len))
+		if (selinux_sid_to_string(sid, &ctx, &len))
 			audit_log_format(ab, " ssid=%u", sid);
 		else
 			audit_log_format(ab, " subj=%s", ctx);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 6322547..a0b2888 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -842,7 +842,7 @@ static void audit_log_exit(struct audit_
 			if (axi->osid != 0) {
 				char *ctx = NULL;
 				u32 len;
-				if (selinux_ctxid_to_string(
+				if (selinux_sid_to_string(
 						axi->osid, &ctx, &len)) {
 					audit_log_format(ab, " osid=%u",
 							axi->osid);
@@ -949,7 +949,7 @@ static void audit_log_exit(struct audit_
 		if (n->osid != 0) {
 			char *ctx = NULL;
 			u32 len;
-			if (selinux_ctxid_to_string(
+			if (selinux_sid_to_string(
 				n->osid, &ctx, &len)) {
 				audit_log_format(ab, " osid=%u", n->osid);
 				call_panic = 2;
diff --git a/security/selinux/exports.c b/security/selinux/exports.c
index ee0fb47..b6f9694 100644
--- a/security/selinux/exports.c
+++ b/security/selinux/exports.c
@@ -21,10 +21,10 @@ #include <linux/ipc.h>
 #include "security.h"
 #include "objsec.h"
 
-int selinux_ctxid_to_string(u32 ctxid, char **ctx, u32 *ctxlen)
+int selinux_sid_to_string(u32 sid, char **ctx, u32 *ctxlen)
 {
 	if (selinux_enabled)
-		return security_sid_to_context(ctxid, ctx, ctxlen);
+		return security_sid_to_context(sid, ctx, ctxlen);
 	else {
 		*ctx = NULL;
 		*ctxlen = 0;
-- 
1.4.1



