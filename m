Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754566AbWKHMpv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566AbWKHMpv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754583AbWKHMpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:45:51 -0500
Received: from master.altlinux.org ([62.118.250.235]:46346 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP
	id S1754566AbWKHMpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:45:51 -0500
From: Sergey Vlasov <vsu@altlinux.ru>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Zack Weinberg <zackw@panix.com>, linux-kernel@vger.kernel.org,
       Sergey Vlasov <vsu@altlinux.ru>
Subject: [RFC PATCH 1/2] sys_syslog: check open permission for reading and getting unread count
Date: Wed,  8 Nov 2006 15:45:44 +0300
Message-Id: <11629899452160-git-send-email-vsu@altlinux.ru>
X-Mailer: git-send-email 1.4.3.3.gddcc6
In-Reply-To: <20061108154229.eb6d4626.vsu@altlinux.ru>
References: <20061108154229.eb6d4626.vsu@altlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "read" (2) and "get unread count" (9) operations of sys_syslog() may
also be invoked through /proc/kmsg; however, /proc/kmsg also performs
security checks during open.  Perform the same security check when these
operations are invoked through the syslog system call.

Currently this does not change the behavior - for cap_syslog() and
dummy_syslog() the "read" and "get unread count" operations are
identical to "open", and selinux_syslog() maps all of them to
SYSTEM__SYSLOG_MOD.  The next patch will enable syslog read for normal
users, so that a process could open /proc/kmsg, then drop privileges and
continue reading kernel messages from the open file descriptor - then
the added check in sys_syslog() will catch attempts to read kernel
messages without having /proc/kmsg open.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 kernel/printk.c |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 1149365..91c3f39 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -316,7 +316,21 @@ out:
 
 asmlinkage long sys_syslog(int type, char __user *buf, int len)
 {
-	return do_syslog(type, buf, len);
+	int retval;
+
+	if ((type == 2) || (type == 9)) {
+		/*
+		 * These operation can also be invoked through /proc/kmsg, but
+		 * you need to have an open file descriptor for that.  Make the
+		 * syslog system call also require the syslog open permission.
+		 */
+		retval = security_syslog(1);
+		if (retval)
+			goto out;
+	}
+	retval = do_syslog(type, buf, len);
+out:
+	return retval;
 }
 
 /*
-- 
1.4.3.3.gddcc6

