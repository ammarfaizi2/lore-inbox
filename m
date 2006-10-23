Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWJWN44@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWJWN44 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 09:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932155AbWJWN44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 09:56:56 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:2539 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932154AbWJWN44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 09:56:56 -0400
Date: Mon, 23 Oct 2006 17:56:44 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] do_acct_process: don't take tty_mutex
Message-ID: <20061023135644.GA1501@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on
	tty-signal-tty-locking.patch

No need to take the global tty_mutex, signal->tty->driver can't go away
while we are holding ->siglock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- rc2-mm2/kernel/acct.c~	2006-10-22 19:28:17.000000000 +0400
+++ rc2-mm2/kernel/acct.c	2006-10-23 17:09:12.000000000 +0400
@@ -484,12 +484,9 @@ static void do_acct_process(struct file 
 	ac.ac_ppid = current->parent->tgid;
 #endif
 
-	mutex_lock(&tty_mutex);
-	tty = get_current_tty();
-	ac.ac_tty = tty ? old_encode_dev(tty_devnum(tty)) : 0;
-	mutex_unlock(&tty_mutex);
-
 	spin_lock_irq(&current->sighand->siglock);
+	tty = current->signal->tty;
+	ac.ac_tty = tty ? old_encode_dev(tty_devnum(tty)) : 0;
 	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_utime)));
 	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_stime)));
 	ac.ac_flag = pacct->ac_flag;

