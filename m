Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWAPQpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWAPQpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 11:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWAPQpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 11:45:00 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:35801 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751093AbWAPQo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 11:44:59 -0500
Message-ID: <43CBDF73.81E2316F@tv-sign.ru>
Date: Mon, 16 Jan 2006 21:01:23 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sigprocmask: kill unneeded temp var
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup, remove unneeded double copying of current->blocked.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15/kernel/signal.c~	2005-11-22 19:35:52.000000000 +0300
+++ 2.6.15/kernel/signal.c	2006-01-16 14:50:17.000000000 +0300
@@ -2004,10 +2004,11 @@ long do_no_restart_syscall(struct restar
 int sigprocmask(int how, sigset_t *set, sigset_t *oldset)
 {
 	int error;
-	sigset_t old_block;
 
 	spin_lock_irq(&current->sighand->siglock);
-	old_block = current->blocked;
+	if (oldset)
+		*oldset = current->blocked;
+
 	error = 0;
 	switch (how) {
 	case SIG_BLOCK:
@@ -2024,8 +2025,7 @@ int sigprocmask(int how, sigset_t *set, 
 	}
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
-	if (oldset)
-		*oldset = old_block;
+
 	return error;
 }
