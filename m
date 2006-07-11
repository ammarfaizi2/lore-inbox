Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWGKRJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWGKRJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWGKRJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:09:13 -0400
Received: from mail.parknet.jp ([210.171.160.80]:25093 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1751120AbWGKRJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:09:11 -0400
X-AuthUser: hirofumi@parknet.jp
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix sighand->siglock usage in kernel/acct.c
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 12 Jul 2006 02:09:05 +0900
Message-ID: <873bd8oyq6.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IRQ must be disabled before taking ->siglock.

Noticed by lockdep.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 kernel/acct.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/acct.c~acct-lockdep-fix kernel/acct.c
--- linux-2.6/kernel/acct.c~acct-lockdep-fix	2006-07-12 01:35:28.000000000 +0900
+++ linux-2.6-hirofumi/kernel/acct.c	2006-07-12 01:35:28.000000000 +0900
@@ -488,7 +488,7 @@ static void do_acct_process(struct file 
 		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
 	read_unlock(&tasklist_lock);
 
-	spin_lock(&current->sighand->siglock);
+	spin_lock_irq(&current->sighand->siglock);
 	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_utime)));
 	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_stime)));
 	ac.ac_flag = pacct->ac_flag;
@@ -496,7 +496,7 @@ static void do_acct_process(struct file 
 	ac.ac_minflt = encode_comp_t(pacct->ac_minflt);
 	ac.ac_majflt = encode_comp_t(pacct->ac_majflt);
 	ac.ac_exitcode = pacct->ac_exitcode;
-	spin_unlock(&current->sighand->siglock);
+	spin_unlock_irq(&current->sighand->siglock);
 	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
 	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
 	ac.ac_swaps = encode_comp_t(0);
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
