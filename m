Return-Path: <linux-kernel-owner+w=401wt.eu-S964843AbWLMLTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWLMLTQ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWLMLTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:19:16 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57328 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964843AbWLMLTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:19:15 -0500
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 06:19:06 EST
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <containers@lists.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 2/12] tty: Clarify disassociate_ctty
Date: Wed, 13 Dec 2006 04:07:46 -0700
Message-Id: <11660080763008-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code to look at tty_old_pgrp and send SIGHUP and SIGCONT
when it is present only executes when disassociate_ctty is
called from do_exit.  Make this clear by adding an explict
on_exit check, and explicitly setting tty_old_pgrp to 0.

In addition fix the locking by reading tty_old_pgrp under
the siglock.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/tty_io.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index bb09e4a..acb2f5d 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1508,8 +1508,12 @@ void disassociate_ctty(int on_exit)
 		/* XXX: here we race, there is nothing protecting tty */
 		if (on_exit && tty->driver->type != TTY_DRIVER_TYPE_PTY)
 			tty_vhangup(tty);
-	} else {
-		pid_t old_pgrp = current->signal->tty_old_pgrp;
+	} else if (on_exit) {
+		pid_t old_pgrp;
+		spin_lock_irq(&current->sighand->siglock);
+		old_pgrp = current->signal->tty_old_pgrp;
+		current->signal->tty_old_pgrp = 0;
+		spin_unlock_irq(&current->sighand->siglock);
 		if (old_pgrp) {
 			kill_pg(old_pgrp, SIGHUP, on_exit);
 			kill_pg(old_pgrp, SIGCONT, on_exit);
-- 
1.4.4.1.g278f

