Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbUHaXyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUHaXyP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 19:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262085AbUHaXyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 19:54:08 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:405 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S269162AbUHaXvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 19:51:13 -0400
Date: Tue, 31 Aug 2004 16:51:02 -0700
Message-Id: <200408312351.i7VNp28j001804@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Michael Kerrisk <mtk-lkml@gmx.net>,
       akpm@osdl.org, drepper@redhat.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] waitid system call
In-Reply-To: Linus Torvalds's message of  Tuesday, 31 August 2004 11:26:59 -0700 <Pine.LNX.4.58.0408311122430.2295@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please replace waitid-clear-fields.patch with this one.
The old log entry is still good.


Thanks,
Roland

--- linux-2.6.9-rc1-mm1/kernel/exit.c.~1~
+++ linux-2.6.9-rc1-mm1/kernel/exit.c
@@ -1369,8 +1369,19 @@ check_continued:
 end:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&current->wait_chldexit,&wait);
-	if (infop && retval > 0)
-		retval = 0;
+	if (infop) {
+		if (retval > 0)
+			retval = 0;
+		else if (retval == 0) {
+			/*
+			 * For a WNOHANG return, clear out all the fields
+			 * we would set so the user can easily tell the
+			 * difference.
+			 */
+			if (clear_user(infop, sizeof *infop))
+				retval = -EFAULT;
+		}
+	}
 	return retval;
 }
