Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267212AbTAKNdM>; Sat, 11 Jan 2003 08:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267214AbTAKNdM>; Sat, 11 Jan 2003 08:33:12 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:47326 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267212AbTAKNdL>; Sat, 11 Jan 2003 08:33:11 -0500
Date: Sat, 11 Jan 2003 11:41:41 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] disassociate_ctty SMP fix
Message-ID: <Pine.LNX.4.50L.0301111137580.24361-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch, against today's BK tree, fixes a small
SMP race in disassociate_ctty.  This function gets called
from do_exit, without the BKL held.

However, it sets the *tty variable before grabbing the bkl,
then makes decisions on what the variable was set to before
the lock was grabbed, despite the fact that another process
could modify its ->tty pointer in this same function.

please apply

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


===== drivers/char/tty_io.c 1.50 vs edited =====
--- 1.50/drivers/char/tty_io.c	Sat Dec  7 16:23:16 2002
+++ edited/drivers/char/tty_io.c	Sat Jan 11 11:37:34 2003
@@ -577,7 +577,7 @@
  */
 void disassociate_ctty(int on_exit)
 {
-	struct tty_struct *tty = current->tty;
+	struct tty_struct *tty;
 	struct task_struct *p;
 	struct list_head *l;
 	struct pid *pid;
@@ -585,6 +585,7 @@

 	lock_kernel();

+	tty = current->tty;
 	if (tty) {
 		tty_pgrp = tty->pgrp;
 		if (on_exit && tty->driver.type != TTY_DRIVER_TYPE_PTY)
