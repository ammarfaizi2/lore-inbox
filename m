Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbVIXNgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbVIXNgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 09:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVIXNgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 09:36:40 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:12179 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750746AbVIXNgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 09:36:40 -0400
Message-ID: <43355943.12A13BD0@tv-sign.ru>
Date: Sat, 24 Sep 2005 17:48:51 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH rc2-mm1] remove unneeded SI_TIMER checks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on "cleanup the usage of SEND_SIG_xxx constants"
patch in the rc2-mm1 tree, filename is
	cleanup-the-usage-of-send_sig_xxx-constants.patch

This patch removes checks for ->si_code == SI_TIMER from
send_signal, specific_send_sig_info, __group_send_sig_info.

I think posix-timers.c used these functions some time ago,
now it sends signals via send_{,group_}sigqueue, so these
hooks are unneeded.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.14-rc2/kernel/signal.c~2_TIMER	2005-09-24 18:33:51.000000000 +0400
+++ 2.6.14-rc2/kernel/signal.c	2005-09-24 18:47:16.000000000 +0400
@@ -840,12 +840,6 @@ static int send_signal(int sig, struct s
 		 * and sent by user using something other than kill().
 		 */
 			return -EAGAIN;
-		if (info->si_code == SI_TIMER)
-			/*
-			 * Set up a return to indicate that we dropped 
-			 * the signal.
-			 */
-			ret = info->si_sys_private;
 	}
 
 out_set:
@@ -866,12 +860,6 @@ specific_send_sig_info(int sig, struct s
 		BUG();
 	assert_spin_locked(&t->sighand->siglock);
 
-	if (!is_si_special(info) && (info->si_code == SI_TIMER))
-		/*
-		 * Set up a return to indicate that we dropped the signal.
-		 */
-		ret = info->si_sys_private;
-
 	/* Short-circuit ignored signals.  */
 	if (sig_ignored(t, sig))
 		goto out;
@@ -1061,12 +1049,6 @@ __group_send_sig_info(int sig, struct si
 	assert_spin_locked(&p->sighand->siglock);
 	handle_stop_signal(sig, p);
 
-	if (!is_si_special(info) && (info->si_code == SI_TIMER))
-		/*
-		 * Set up a return to indicate that we dropped the signal.
-		 */
-		ret = info->si_sys_private;
-
 	/* Short-circuit ignored signals.  */
 	if (sig_ignored(p, sig))
 		return ret;
