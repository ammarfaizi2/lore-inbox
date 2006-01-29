Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWA2G1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWA2G1q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 01:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbWA2G1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 01:27:46 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27358 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750845AbWA2G1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 01:27:45 -0500
To: Andrew Morton <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] do_tty_hangup: Use group_send_sig_info not
 send_group_sig_info.
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 28 Jan 2006 23:27:17 -0700
Message-ID: <m1mzhfft16.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We already have the tasklist_lock so there is no need for us
to reacquire it with send_group_sig_info.  reader/writer
locks allow multiple readers and thus recursion so the old
code was ok just wastful.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 drivers/char/tty_io.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

b4634b339062085cc463041341a662d2d41c78b8
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index da9ed47..1d83cd5 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -1075,8 +1075,8 @@ static void do_tty_hangup(void *data)
 				p->signal->tty = NULL;
 			if (!p->signal->leader)
 				continue;
-			send_group_sig_info(SIGHUP, SEND_SIG_PRIV, p);
-			send_group_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
+			group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
 			if (tty->pgrp > 0)
 				p->signal->tty_old_pgrp = tty->pgrp;
 		} while_each_task_pid(tty->session, PIDTYPE_SID, p);
-- 
1.1.5.g3480

