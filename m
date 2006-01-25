Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750883AbWAYTGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbWAYTGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 14:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWAYTGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 14:06:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25257 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750857AbWAYTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 14:06:34 -0500
To: Richard Henderson <rth@twiddle.net>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] alpha: Fix getxpid on alpha so it works for threads.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 25 Jan 2006 12:05:58 -0700
Message-ID: <m1vew8i0vd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While looking in the code I discovered that
alpha has fallen behind because it doesn't use sys_getppid.
The problem is that it doesn't follow the task struct
to the task_group_leader.

The following (untested) patch should fix the problem.

Eric


---

 arch/alpha/kernel/asm-offsets.c |    1 +
 arch/alpha/kernel/entry.S       |   16 +++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

df0f0250c67ba8366c3c70570412b8dee08bd710
diff --git a/arch/alpha/kernel/asm-offsets.c b/arch/alpha/kernel/asm-offsets.c
index 8f2e5c7..6c56c75 100644
--- a/arch/alpha/kernel/asm-offsets.c
+++ b/arch/alpha/kernel/asm-offsets.c
@@ -28,6 +28,7 @@ void foo(void)
         DEFINE(TASK_GID, offsetof(struct task_struct, gid));
         DEFINE(TASK_EGID, offsetof(struct task_struct, egid));
         DEFINE(TASK_REAL_PARENT, offsetof(struct task_struct, real_parent));
+        DEFINE(TASK_GROUP_LEADER, offsetof(struct task_struct, group_leader));
         DEFINE(TASK_TGID, offsetof(struct task_struct, tgid));
         BLANK();
 
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index e38671c..7af15bf 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -879,17 +879,19 @@ sys_getxpid:
 
 	/* See linux/kernel/timer.c sys_getppid for discussion
 	   about this loop.  */
-	ldq	$3, TASK_REAL_PARENT($2)
-1:	ldl	$1, TASK_TGID($3)
+	ldq	$3, TASK_GROUP_LEADER($2)
+	ldq	$4, TASK_REAL_PARENT($3)
+	ldl	$0, TASK_TGID($2)
+1:	ldl	$1, TASK_TGID($4)
 #ifdef CONFIG_SMP
-	mov	$3, $4
+	mov	$4, $5
 	mb
-	ldq	$3, TASK_REAL_PARENT($2)
-	cmpeq	$3, $4, $4
-	beq	$4, 1b
+	ldq	$3, TASK_GROUP_LEADER($2)
+	ldq	$4, TASK_REAL_PARENT($3)
+	cmpeq	$4, $5, $5
+	beq	$5, 1b
 #endif
 	stq	$1, 80($sp)
-	ldl	$0, TASK_TGID($2)
 	ret
 .end sys_getxpid
 
-- 
1.1.3.g5c7d

