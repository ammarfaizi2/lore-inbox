Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755220AbWKMRCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220AbWKMRCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755280AbWKMRCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:02:41 -0500
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:14758 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1755220AbWKMRCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:02:40 -0500
Date: Mon, 13 Nov 2006 12:02:38 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
       Chad Sellers <csellers@tresys.com>
Subject: Subject: [PATCH 2/4] SELinux: export object class and permission
 definitions
In-Reply-To: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
Message-ID: <XMMS.LNX.4.64.0611131202160.6437@d.namei>
References: <XMMS.LNX.4.64.0611131158490.6437@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chad Sellers <csellers@tresys.com>

Moves the definition of the 3 structs containing object class and
permission definitions from avc.c to avc_ss.h so that the security
server can access them for validation on policy load. This also adds
a new struct type, defined_classes_perms_t, suitable for allowing the
security server to access these data structures from the avc.

Signed-off-by: Chad Sellers <csellers@tresys.com>
Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: James Morris <jmorris@namei.org>
---
 security/selinux/avc.c            |   23 +++++++++++------------
 security/selinux/include/avc_ss.h |   24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 12 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index a300702..74c0319 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -32,12 +32,7 @@ #include <net/ipv6.h>
 #include "avc.h"
 #include "avc_ss.h"
 
-static const struct av_perm_to_string
-{
-  u16 tclass;
-  u32 value;
-  const char *name;
-} av_perm_to_string[] = {
+static const struct av_perm_to_string av_perm_to_string[] = {
 #define S_(c, v, s) { c, v, s },
 #include "av_perm_to_string.h"
 #undef S_
@@ -57,17 +52,21 @@ #undef TB_
 #undef TE_
 #undef S_
 
-static const struct av_inherit
-{
-    u16 tclass;
-    const char **common_pts;
-    u32 common_base;
-} av_inherit[] = {
+static const struct av_inherit av_inherit[] = {
 #define S_(c, i, b) { c, common_##i##_perm_to_string, b },
 #include "av_inherit.h"
 #undef S_
 };
 
+const struct selinux_class_perm selinux_class_perm = {
+	av_perm_to_string,
+	ARRAY_SIZE(av_perm_to_string),
+	class_to_string,
+	ARRAY_SIZE(class_to_string),
+	av_inherit,
+	ARRAY_SIZE(av_inherit)
+};
+
 #define AVC_CACHE_SLOTS			512
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
diff --git a/security/selinux/include/avc_ss.h b/security/selinux/include/avc_ss.h
index 450a283..ff869e8 100644
--- a/security/selinux/include/avc_ss.h
+++ b/security/selinux/include/avc_ss.h
@@ -10,5 +10,29 @@ #include "flask.h"
 
 int avc_ss_reset(u32 seqno);
 
+struct av_perm_to_string
+{
+	u16 tclass;
+	u32 value;
+	const char *name;
+};
+
+struct av_inherit
+{
+	u16 tclass;
+	const char **common_pts;
+	u32 common_base;
+};
+
+struct selinux_class_perm
+{
+	const struct av_perm_to_string *av_perm_to_string;
+	u32 av_pts_len;
+	const char **class_to_string;
+	u32 cts_len;
+	const struct av_inherit *av_inherit;
+	u32 av_inherit_len;
+};
+
 #endif /* _SELINUX_AVC_SS_H_ */
 
-- 
1.4.2.1

