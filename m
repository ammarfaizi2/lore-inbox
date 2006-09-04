Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWIDPNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWIDPNo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIDPNn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:13:43 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:13474 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751452AbWIDPNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:13:43 -0400
Subject: Re: [PATCH] audit/accounting: tty locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1157380592.30801.94.camel@localhost.localdomain>
References: <1157380592.30801.94.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 16:36:19 +0100
Message-Id: <1157384179.30801.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-04 am 15:36 +0100, ysgrifennodd Alan Cox:
> Fairly basic stuff .. make sure the name we are encoding doesn't vanish
> under us.

Here's a replacement that is more paranoid about the locking as
suggested by Arjan. The whole current->signal-> locking is all deeply
strange but its for someone else to sort out. Add rather than replace
the lock for acct.c

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/kernel/acct.c linux-2.6.18-rc5-mm1/kernel/acct.c
--- linux.vanilla-2.6.18-rc5-mm1/kernel/acct.c	2006-09-01 13:39:20.000000000 +0100
+++ linux-2.6.18-rc5-mm1/kernel/acct.c	2006-09-04 15:47:58.324205496 +0100
@@ -483,10 +483,14 @@
 	ac.ac_ppid = current->parent->tgid;
 #endif
 
-	read_lock(&tasklist_lock);	/* pin current->signal */
+	mutex_lock(&tty_mutex);
+	/* FIXME: Whoever is responsible for current->signal locking needs
+	   to use the same locking all over the kernel and document it */
+	read_lock(&tasklist_lock);
 	ac.ac_tty = current->signal->tty ?
 		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
 	read_unlock(&tasklist_lock);
+	mutex_unlock(&tty_mutex);
 
 	spin_lock_irq(&current->sighand->siglock);
 	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_utime)));
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc5-mm1/kernel/auditsc.c linux-2.6.18-rc5-mm1/kernel/auditsc.c
--- linux.vanilla-2.6.18-rc5-mm1/kernel/auditsc.c	2006-09-01 13:39:20.000000000 +0100
+++ linux-2.6.18-rc5-mm1/kernel/auditsc.c	2006-09-01 13:55:51.000000000 +0100
@@ -766,6 +766,8 @@
 		audit_log_format(ab, " success=%s exit=%ld", 
 				 (context->return_valid==AUDITSC_SUCCESS)?"yes":"no",
 				 context->return_code);
+				 
+	mutex_lock(&tty_mutex);
 	if (tsk->signal && tsk->signal->tty && tsk->signal->tty->name)
 		tty = tsk->signal->tty->name;
 	else
@@ -787,6 +789,9 @@
 		  context->gid,
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid, tty);
+
+	mutex_unlock(&tty_mutex);
+	
 	audit_log_task_info(ab, tsk);
 	if (context->filterkey) {
 		audit_log_format(ab, " key=");

