Return-Path: <linux-kernel-owner+w=401wt.eu-S964873AbWLMLVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWLMLVF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964871AbWLMLTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:19:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57332 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbWLMLTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:19:37 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <containers@lists.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/12] signal: Use kill_pgrp not kill_pg in the sunos compatibility code.
Date: Wed, 13 Dec 2006 04:07:48 -0700
Message-Id: <11660080772016-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am slowly moving to a model where all process killing
is struct pid based instead of pid_t based.   The sunos
compatibility code is one of the last users of the old pid_t
based kill_pg in the kernel.  By being complete I allow
for the future removal of kill_pg from the kernel, which
will ensure I don't miss something.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/sparc/kernel/sys_sunos.c     |   10 ++++++----
 arch/sparc64/kernel/sys_sunos32.c |   11 +++++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/sys_sunos.c b/arch/sparc/kernel/sys_sunos.c
index 0bf8c16..da6606f 100644
--- a/arch/sparc/kernel/sys_sunos.c
+++ b/arch/sparc/kernel/sys_sunos.c
@@ -859,14 +859,16 @@ asmlinkage int sunos_wait4(pid_t pid, unsigned int __user *stat_addr,
 	return ret;
 }
 
-extern int kill_pg(int, int, int);
 asmlinkage int sunos_killpg(int pgrp, int sig)
 {
 	int ret;
 
-	lock_kernel();
-	ret = kill_pg(pgrp, sig, 0);
-	unlock_kernel();
+	rcu_read_lock();
+	ret = -EINVAL;
+	if (pgrp > 0)
+		ret = kill_pgrp(find_pid(pgrp), sig, 0);
+	rcu_read_unlock();
+
 	return ret;
 }
 
diff --git a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
index 4446f66..d9280b1 100644
--- a/arch/sparc64/kernel/sys_sunos32.c
+++ b/arch/sparc64/kernel/sys_sunos32.c
@@ -824,10 +824,17 @@ asmlinkage int sunos_wait4(compat_pid_t pid, compat_uint_t __user *stat_addr, in
 	return ret;
 }
 
-extern int kill_pg(int, int, int);
 asmlinkage int sunos_killpg(int pgrp, int sig)
 {
-	return kill_pg(pgrp, sig, 0);
+	int ret;
+
+	rcu_read_lock();
+	ret = -EINVAL;
+	if (pgrp > 0)
+		ret = kill_pgrp(find_pid(pgrp), sig, 0);
+	rcu_read_unlock();
+
+	return ret;
 }
 
 asmlinkage int sunos_audit(void)
-- 
1.4.4.1.g278f

