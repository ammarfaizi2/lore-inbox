Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264549AbUANW4d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 17:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUANWzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 17:55:40 -0500
Received: from fmr06.intel.com ([134.134.136.7]:26605 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265200AbUANWs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 17:48:29 -0500
Date: Wed, 14 Jan 2004 14:50:32 -0800
From: inaky.perez-gonzalez@intel.com
To: linux-kernel@vger.kernel.org
Cc: inaky.perez-gonzalez@intel.com, robustmutexes@lists.osdl.org
Subject: [RFC/PATCH] FUSYN 9/10: stub for priority protection
Message-ID: <0401141450.1csdscaa2ckcVcJcZdDdhcfdocVdFabd9031@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0401141450.od8bZbVcfdkcKdCcXdtdZdFbcaNdraOc9031@intel.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 fulock-pp.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+)

--- /dev/null	Wed Jan 14 14:39:30 2004
+++ linux/kernel/fulock-pp.c	Wed Jan 14 11:13:33 2004
@@ -0,0 +1,66 @@
+
+/*
+ * Fast User real-time/pi/pp/robust/deadlock SYNchronization
+ * (C) 2002-2003 Intel Corp
+ * Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>.
+ *
+ * Licensed under the FSF's GNU Public License v2 or later.
+ *
+ * Based on normal futexes (futex.c), (C) Rusty Russell.
+ * Please refer to Documentation/fusyn.txt for more info.
+ *
+ * Stuff for priority-protected fulocks
+ */
+
+#include <linux/fulock.h>
+#include <linux/plist.h>
+#include <linux/time.h>     /* struct timespec */
+#include <linux/sched.h>    /* MAX_SCHEDULE_TIMEOUT */
+#include <linux/errno.h>
+#include <linux/fulock.h>
+
+/**
+ * Check if a process is allowed to lock a PP fulock.
+ *
+ * @fulock: fulock to check on.
+ * @task:   Task to check for acquisition.
+ */
+int __fulock_pp_allowed (struct fulock *fulock)
+{
+	int policy = fulock->flags & FULOCK_FL_PP_PLC_MK > 20;
+	int priority = fulock->flags & FULOCK_FL_PP_PRIO_MK > 12;
+	int prio;
+
+	if (policy != SCHED_NORMAL)
+		prio = MAX_USER_RT_PRIO - 1 - priority;
+	else
+		prio = priority;
+	fulock->flags &= ~FULOCK_FL_PP_PRIO_MK;
+	fulock->flags |= prio & FULOCK_FL_PP_PRIO_MK;
+#warning FIXME: interaction with PI? Compare against static, not dynamic?
+	if (prio > current->prio)
+		return -EINVAL;
+	return 0;
+}
+
+
+/** FIXME */
+void __fulock_pp_boost (struct fulock *fulock)
+{
+#warning FIXME: finish me
+}
+
+
+/**
+ * Remove the boosting in priority of the owner of a
+ * priority-protected @fulock.
+ *
+ * @fulock: fulock whose owner's priority is to be boosted.
+ *
+ * If the fulock is a priority-protected lock, boost the priority of
+ * the owner to the fulock's priority ceiling.
+ */
+void __fulock_pp_unboost (struct fulock *fulock)
+{
+}
+
