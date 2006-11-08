Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965592AbWKHMp5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965592AbWKHMp5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965593AbWKHMp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:45:56 -0500
Received: from master.altlinux.org ([62.118.250.235]:47882 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S965592AbWKHMp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:45:56 -0500
From: Sergey Vlasov <vsu@altlinux.ru>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zack Weinberg <zackw@panix.com>, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
Subject: [RFC PATCH 2/2] security: allow reads from an open /proc/kmsg fd by unprivileged processes
Date: Wed,  8 Nov 2006 15:45:45 +0300
Message-Id: <11629899491709-git-send-email-vsu@altlinux.ru>
X-Mailer: git-send-email 1.4.3.3.gddcc6
In-Reply-To: <11629899452160-git-send-email-vsu@altlinux.ru>
References: <20061108154229.eb6d4626.vsu@altlinux.ru> <11629899452160-git-send-email-vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the added check for syslog open rights in sys_syslog() it is
possible to relax restrictions on syslog access in cap_syslog() and
dummy_syslog(), so that a process could open /proc/kmsg, then drop all
privileges including CAP_SYS_ADMIN, and still be able to use the
/proc/kmsg file descriptor for reading kernel messages.

selinux_syslog() is not modified - a process which handles kernel
messages still needs to have the "syslog_mod" permission.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 security/commoncap.c |   24 +++++++++++++++++++++---
 security/dummy.c     |   24 +++++++++++++++++++++---
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/security/commoncap.c b/security/commoncap.c
index f50fc29..966cfce 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -311,9 +311,27 @@ void cap_task_reparent_to_init (struct t
 
 int cap_syslog (int type)
 {
-	if ((type != 3 && type != 10) && !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	return 0;
+	switch (type) {
+	case 3:		/* Read last kernel messages */
+	case 10:	/* Size of the log buffer */
+		/* Allow dmesg for unprivileged users. */
+		return 0;
+
+	case 2:		/* Read from log */
+	case 9:		/* Number of chars in the log buffer */
+		/*
+		 * Allow read() and poll() on a /proc/kmsg file descriptor
+		 * opened by a privileged process.  This does not enable
+		 * uncontrolled access through the syslog system call, because
+		 * sys_syslog() additionally checks the syslog open permission.
+		 */
+		return 0;
+
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		return 0;
+	}
 }
 
 int cap_vm_enough_memory(long pages)
diff --git a/security/dummy.c b/security/dummy.c
index 58c6d39..3da65fe 100644
--- a/security/dummy.c
+++ b/security/dummy.c
@@ -96,9 +96,27 @@ static int dummy_quota_on (struct dentry
 
 static int dummy_syslog (int type)
 {
-	if ((type != 3 && type != 10) && current->euid)
-		return -EPERM;
-	return 0;
+	switch (type) {
+	case 3:		/* Read last kernel messages */
+	case 10:	/* Size of the log buffer */
+		/* Allow dmesg for unprivileged users. */
+		return 0;
+
+	case 2:		/* Read from log */
+	case 9:		/* Number of chars in the log buffer */
+		/*
+		 * Allow read() and poll() on a /proc/kmsg file descriptor
+		 * opened by a privileged process.  This does not enable
+		 * uncontrolled access through the syslog system call, because
+		 * sys_syslog() additionally checks the syslog open permission.
+		 */
+		return 0;
+
+	default:
+		if (current->euid)
+			return -EPERM;
+		return 0;
+	}
 }
 
 static int dummy_settime(struct timespec *ts, struct timezone *tz)
-- 
1.4.3.3.gddcc6

