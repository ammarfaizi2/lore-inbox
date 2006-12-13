Return-Path: <linux-kernel-owner+w=401wt.eu-S964845AbWLMLTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWLMLTb (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 06:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWLMLTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 06:19:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57328 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbWLMLTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 06:19:23 -0500
X-Greylist: delayed 636 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 06:19:06 EST
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Cc: <containers@lists.osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3/12] tty: Fix the locking for signal->session in disassociate_ctty
Date: Wed, 13 Dec 2006 04:07:47 -0700
Message-Id: <1166008077979-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commit 24ec839c431eb79bb8f6abc00c4e1eb3b8c4d517 while fixing
the locking for signal->tty got the locking wrong for
signal->session.  This places our accesses of signal->session
back under the tasklist_lock where they belong.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/tty_io.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index acb2f5d..628925e 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1496,7 +1496,6 @@ void disassociate_ctty(int on_exit)
 {
 	struct tty_struct *tty;
 	int tty_pgrp = -1;
-	int session;
 
 	lock_kernel();
 
@@ -1530,7 +1529,6 @@ void disassociate_ctty(int on_exit)
 
 	spin_lock_irq(&current->sighand->siglock);
 	current->signal->tty_old_pgrp = 0;
-	session = process_session(current);
 	spin_unlock_irq(&current->sighand->siglock);
 
 	mutex_lock(&tty_mutex);
@@ -1549,7 +1547,7 @@ void disassociate_ctty(int on_exit)
 
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
-	session_clear_tty(session);
+	session_clear_tty(process_session(current));
 	read_unlock(&tasklist_lock);
 	unlock_kernel();
 }
-- 
1.4.4.1.g278f

