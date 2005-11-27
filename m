Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVK0Qyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVK0Qyd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 11:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVK0Qyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 11:54:33 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:22449 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751112AbVK0Qyc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 11:54:32 -0500
Message-ID: <4389F646.F97E070F@tv-sign.ru>
Date: Sun, 27 Nov 2005 21:09:10 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sigio: cleanup, don't take tasklist twice
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of send_sigio_to_task() already holds tasklist_lock,
so it is better not to send the signal via send_group_sig_info()
(which takes tasklist recursively) but use group_send_sig_info().

The same change in send_sigurg()->send_sigurg_to_task().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.15-rc2/fs/fcntl.c~	2005-09-17 18:57:28.000000000 +0400
+++ 2.6.15-rc2/fs/fcntl.c	2005-11-27 23:38:54.000000000 +0300
@@ -457,11 +457,11 @@ static void send_sigio_to_task(struct ta
 			else
 				si.si_band = band_table[reason - POLL_IN];
 			si.si_fd    = fd;
-			if (!send_group_sig_info(fown->signum, &si, p))
+			if (!group_send_sig_info(fown->signum, &si, p))
 				break;
 		/* fall-through: fall back on the old plain SIGIO signal */
 		case 0:
-			send_group_sig_info(SIGIO, SEND_SIG_PRIV, p);
+			group_send_sig_info(SIGIO, SEND_SIG_PRIV, p);
 	}
 }
 
@@ -495,7 +495,7 @@ static void send_sigurg_to_task(struct t
                                 struct fown_struct *fown)
 {
 	if (sigio_perm(p, fown, SIGURG))
-		send_group_sig_info(SIGURG, SEND_SIG_PRIV, p);
+		group_send_sig_info(SIGURG, SEND_SIG_PRIV, p);
 }
 
 int send_sigurg(struct fown_struct *fown)
