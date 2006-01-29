Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWA2HeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWA2HeT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 02:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWA2HeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 02:34:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29919 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750744AbWA2HeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 02:34:07 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: [PATCH 4/5] vt: Update spawnpid to use a task_ref.
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com>
	<m1lkwza479.fsf@ebiederm.dsl.xmission.com>
	<m1hd7na44b.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 29 Jan 2006 00:33:27 -0700
In-Reply-To: <m1d5iba3xf.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Sun, 29 Jan 2006 00:28:28 -0700")
Message-ID: <m18xsza3p4.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a classic example of a random kernel subsystem
holding a pid for purposes of signalling it later.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/char/keyboard.c |    8 ++++----
 drivers/char/vt_ioctl.c |    5 +++--
 2 files changed, 7 insertions(+), 6 deletions(-)

7ed8301463a49ad03f8c9de2bbf8c41a5d9843ea
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 8b603b2..4e1f2e0 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -109,7 +109,8 @@ struct kbd_struct kbd_table[MAX_NR_CONSO
 static struct kbd_struct *kbd = kbd_table;
 static struct kbd_struct kbd0;
 
-int spawnpid, spawnsig;
+TASK_REF(spawnpid);
+int spawnsig;
 
 /*
  * Variables exported for vt.c
@@ -567,9 +568,8 @@ static void fn_compose(struct vc_data *v
 
 static void fn_spawn_con(struct vc_data *vc, struct pt_regs *regs)
 {
-	if (spawnpid)
-		if (kill_proc(spawnpid, spawnsig, 1))
-			spawnpid = 0;
+	if (kill_tref(spawnpid, spawnsig, 1))
+		tref_clear(&spawnpid);
 }
 
 static void fn_SAK(struct vc_data *vc, struct pt_regs *regs)
diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 24011e7..f8a527b 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -646,12 +646,13 @@ int vt_ioctl(struct tty_struct *tty, str
 	 */
 	case KDSIGACCEPT:
 	{
-		extern int spawnpid, spawnsig;
+		extern struct task_ref *spawnpid;
+		extern int spawnsig;
 		if (!perm || !capable(CAP_KILL))
 		  return -EPERM;
 		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
 		  return -EINVAL;
-		spawnpid = current->pid;
+		tref_set(&spawnpid, tref_get_by_task(current, PIDTYPE_PID));
 		spawnsig = arg;
 		return 0;
 	}
-- 
1.1.5.g3480

