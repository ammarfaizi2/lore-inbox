Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWHOSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWHOSYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbWHOSYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:24:12 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16094 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030442AbWHOSYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:24:07 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 6/7] vt: Update spawnpid to be a struct pid_t
Date: Tue, 15 Aug 2006 12:23:11 -0600
Message-Id: <1155666193191-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This keeps the wrong process from being notified if the
daemon to spawn a new console dies.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/keyboard.c |    9 ++++++---
 drivers/char/vt_ioctl.c |    5 +++--
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 3e90aac..9acd142 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -108,7 +108,8 @@ const int NR_TYPES = ARRAY_SIZE(max_vals
 struct kbd_struct kbd_table[MAX_NR_CONSOLES];
 static struct kbd_struct *kbd = kbd_table;
 
-int spawnpid, spawnsig;
+struct pid *spawnpid;
+int spawnsig;
 
 /*
  * Variables exported for vt.c
@@ -579,8 +580,10 @@ static void fn_compose(struct vc_data *v
 static void fn_spawn_con(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (spawnpid)
-		if (kill_proc(spawnpid, spawnsig, 1))
-			spawnpid = 0;
+		if (kill_pid(spawnpid, spawnsig, 1)) {
+			put_pid(spawnpid);
+			spawnpid = NULL;
+		}
 }
 
 static void fn_SAK(struct vc_data *vc, struct pt_regs *regs)
diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 28eff1a..d7e0187 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -645,12 +645,13 @@ #endif
 	 */
 	case KDSIGACCEPT:
 	{
-		extern int spawnpid, spawnsig;
+		struct pid *spawnpid;
+		extern int spawnsig;
 		if (!perm || !capable(CAP_KILL))
 		  return -EPERM;
 		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
 		  return -EINVAL;
-		spawnpid = current->pid;
+		spawnpid = get_pid(task_pid(current));
 		spawnsig = arg;
 		return 0;
 	}
-- 
1.4.2.rc3.g7e18e-dirty

