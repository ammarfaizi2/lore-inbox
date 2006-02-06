Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWBFTrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWBFTrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWBFTrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:47:32 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52717 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932327AbWBFTra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:47:30 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 08/20] vt: Update the virtual console to handle
 pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:44:53 -0700
In-Reply-To: <m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:41:18 -0700")
Message-ID: <m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Currently I am lazy and disable all advanced signal sending
features of virtual consoles if you are not a member of the initial
process id space.  Not quite right but it certainly saves the
reference counting hassle, and it is unlikely that anyone cares at
this point.


Fix this when I get pspace disappearence notifiers.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/char/keyboard.c |    3 ++-
 drivers/char/vt.c       |    2 +-
 drivers/char/vt_ioctl.c |    9 +++++++--
 3 files changed, 10 insertions(+), 4 deletions(-)

74c362e5aab6c780cf6a27d861874e71cebc8b2e
diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 8b603b2..511dad7 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -33,6 +33,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/pspace.h>
 
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
@@ -568,7 +569,7 @@ static void fn_compose(struct vc_data *v
 static void fn_spawn_con(struct vc_data *vc, struct pt_regs *regs)
 {
 	if (spawnpid)
-		if (kill_proc(spawnpid, spawnsig, 1))
+		if (kill_proc(&init_pspace, spawnpid, spawnsig, 1))
 			spawnpid = 0;
 }
 
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
index 0900d1d..e354c56 100644
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -856,7 +856,7 @@ int vc_resize(struct vc_data *vc, unsign
 		ws.ws_ypixel = vc->vc_scan_lines;
 		if ((ws.ws_row != cws->ws_row || ws.ws_col != cws->ws_col) &&
 		    vc->vc_tty->pgrp > 0)
-			kill_pg(vc->vc_tty->pgrp, SIGWINCH, 1);
+			kill_pg(vc->vc_tty->pspace, vc->vc_tty->pgrp, SIGWINCH, 1);
 		*cws = ws;
 	}
 
diff --git a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
index 24011e7..431c3ed 100644
--- a/drivers/char/vt_ioctl.c
+++ b/drivers/char/vt_ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/console.h>
 #include <linux/signal.h>
 #include <linux/timex.h>
+#include <linux/pspace.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -649,6 +650,8 @@ int vt_ioctl(struct tty_struct *tty, str
 		extern int spawnpid, spawnsig;
 		if (!perm || !capable(CAP_KILL))
 		  return -EPERM;
+		if (current->pspace != &init_pspace)
+		  return -EPERM;
 		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
 		  return -EINVAL;
 		spawnpid = current->pid;
@@ -666,6 +669,8 @@ int vt_ioctl(struct tty_struct *tty, str
 			return -EFAULT;
 		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS)
 			return -EINVAL;
+		if ((tmp.mode == VT_PROCESS) && (current->pspace != &init_pspace))
+			return -EINVAL;
 		acquire_console_sem();
 		vc->vt_mode = tmp;
 		/* the frsig is ignored, so we set it to 0 */
@@ -1113,7 +1118,7 @@ static void complete_change_console(stru
 		 * tell us if the process has gone or something else
 		 * is awry
 		 */
-		if (kill_proc(vc->vt_pid, vc->vt_mode.acqsig, 1) != 0) {
+		if (kill_proc(&init_pspace, vc->vt_pid, vc->vt_mode.acqsig, 1) != 0) {
 		/*
 		 * The controlling process has died, so we revert back to
 		 * normal operation. In this case, we'll also change back
@@ -1173,7 +1178,7 @@ void change_console(struct vc_data *new_
 		 * tell us if the process has gone or something else
 		 * is awry
 		 */
-		if (kill_proc(vc->vt_pid, vc->vt_mode.relsig, 1) == 0) {
+		if (kill_proc(&init_pspace, vc->vt_pid, vc->vt_mode.relsig, 1) == 0) {
 			/*
 			 * It worked. Mark the vt to switch to and
 			 * return. The process needs to send us a
-- 
1.1.5.g3480

