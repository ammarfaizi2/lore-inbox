Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbUKTCRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbUKTCRY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbUKTCMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:12:00 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:33176 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S263048AbUKTCH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:07:57 -0500
From: pmeda@akamai.com
Date: Fri, 19 Nov 2004 19:09:26 -0800
Message-Id: <200411200309.TAA20975@allur.sanmateo.akamai.com>
To: akpm@osdl.org
Subject: [PATCH] ptrace: locked accesss to ptrace last_siginfo
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ptrace_setsiginfo/ptrace_getsiginfo need to do locked access
to last_siginfo.  ptrace_notify()/ptrace_stop() sets the
current->last_siginfo and sleeps on schedule(). It can be waked
up by kill signal from signal_wake_up before debugger wakes it up.
On return from schedule(), the current->last_siginfo is reset.

Signed-off-by: Prasanna Meda <pmeda@akamai.com>


--- a/kernel/ptrace.c	Fri Nov 19 18:27:26 2004
+++ b/kernel/ptrace.c	Fri Nov 19 18:52:52 2004
@@ -303,18 +303,33 @@
 
 static int ptrace_getsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
-	return copy_siginfo_to_user(data, child->last_siginfo);
+	siginfo_t lastinfo;
+
+	spin_lock_irq(&child->sighand->siglock);
+	if (likely(child->last_siginfo != NULL)) {
+		memcpy(&lastinfo, child->last_siginfo, sizeof (siginfo_t));
+		spin_unlock_irq(&child->sighand->siglock);
+		return copy_siginfo_to_user(data, &lastinfo);
+	}
+	spin_unlock_irq(&child->sighand->siglock);
+	return -EINVAL;
 }
 
 static int ptrace_setsiginfo(struct task_struct *child, siginfo_t __user * data)
 {
-	if (child->last_siginfo == NULL)
-		return -EINVAL;
-	if (copy_from_user(child->last_siginfo, data, sizeof (siginfo_t)) != 0)
+	siginfo_t newinfo;
+
+	if (copy_from_user(&newinfo, data, sizeof (siginfo_t)) != 0)
 		return -EFAULT;
-	return 0;
+
+	spin_lock_irq(&child->sighand->siglock);
+	if (likely(child->last_siginfo != NULL)) {
+		memcpy(child->last_siginfo, &newinfo, sizeof (siginfo_t));
+		spin_unlock_irq(&child->sighand->siglock);
+		return 0;
+	}
+	spin_unlock_irq(&child->sighand->siglock);
+	return -EINVAL;
 }
 
 int ptrace_request(struct task_struct *child, long request,
