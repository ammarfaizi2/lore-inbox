Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267644AbTBEA62>; Tue, 4 Feb 2003 19:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTBEA62>; Tue, 4 Feb 2003 19:58:28 -0500
Received: from 4-088.ctame701-1.telepar.net.br ([200.193.162.88]:18601 "EHLO
	4-088.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267644AbTBEA60>; Tue, 4 Feb 2003 19:58:26 -0500
Date: Tue, 4 Feb 2003 23:07:54 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org, "" <tytso@thunk.org>, "" <rddunlap@osdl.org>
Subject: Re: [PATCH][RESEND 3] disassociate_ctty SMP fix
In-Reply-To: <Pine.LNX.4.50L.0302042235180.32328-100000@imladris.surriel.com>
Message-ID: <Pine.LNX.4.50L.0302042306230.32328-100000@imladris.surriel.com>
References: <Pine.LNX.4.50L.0302042235180.32328-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2003, Rik van Riel wrote:

> the following patch, against today's BK tree, fixes a small
> SMP race in disassociate_ctty.  This function gets called
> from do_exit, without the BKL held.

Here's a better one, this one does the same fix not only
in disassociate_ctty() but also in do_tty_hangup()

If we're lucky it might fix:
http://bugme.osdl.org/show_bug.cgi?id=54

Please apply. Thank you,

Rik

===== drivers/char/tty_io.c 1.55 vs edited =====
--- 1.55/drivers/char/tty_io.c	Tue Jan 14 23:37:20 2003
+++ edited/drivers/char/tty_io.c	Tue Feb  4 23:02:52 2003
@@ -425,19 +425,21 @@
  */
 void do_tty_hangup(void *data)
 {
-	struct tty_struct *tty = (struct tty_struct *) data;
+	struct tty_struct *tty;
 	struct file * cons_filp = NULL;
 	struct task_struct *p;
 	struct list_head *l;
 	struct pid *pid;
 	int    closecount = 0, n;

-	if (!tty)
-		return;
-
 	/* inuse_filps is protected by the single kernel lock */
 	lock_kernel();
-
+	tty = (struct tty_struct *) data;
+	if (!tty) {
+		unlock_kernel();
+		return;
+	}
+
 	check_tty_count(tty, "do_tty_hangup");
 	file_list_lock();
 	for (l = tty->tty_files.next; l != &tty->tty_files; l = l->next) {
@@ -571,7 +573,7 @@
  */
 void disassociate_ctty(int on_exit)
 {
-	struct tty_struct *tty = current->tty;
+	struct tty_struct *tty;
 	struct task_struct *p;
 	struct list_head *l;
 	struct pid *pid;
@@ -579,6 +581,7 @@

 	lock_kernel();

+	tty = current->tty;
 	if (tty) {
 		tty_pgrp = tty->pgrp;
 		if (on_exit && tty->driver.type != TTY_DRIVER_TYPE_PTY)
