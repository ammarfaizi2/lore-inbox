Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266687AbUHaGE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266687AbUHaGE4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 02:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266708AbUHaGE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 02:04:56 -0400
Received: from mail2.speakeasy.net ([216.254.0.202]:41156 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S266687AbUHaGEx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 02:04:53 -0400
Date: Mon, 30 Aug 2004 23:04:46 -0700
Message-Id: <200408310604.i7V64k7o010652@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
X-Fcc: ~/Mail/linus
Cc: torvalds@osdl.org, akpm@osdl.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] waitid system call
In-Reply-To: Michael Kerrisk's message of  Tuesday, 24 August 2004 13:51:02 +0200 <12606.1093348262@www48.gmx.net>
Emacs: well, why *shouldn't* you pay property taxes on your editor?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The AIX results someone posted suggested that it does not clear siginfo_t
fields on WNOHANG early returns.  I still maintain that a POSIX application
must not assume that waitid will clear any fields.  However, since the
majority do, I see no harm in making Linux do so as well.

Andrew, please throw this on top of the waitid patches.  This patch is
relative to 2.6.9-rc1-mm1.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6.9-rc1-mm1/kernel/exit.c.~1~	2004-08-27 13:46:37.000000000 -0700
+++ linux-2.6.9-rc1-mm1/kernel/exit.c	2004-08-30 22:52:54.246036355 -0700
@@ -1369,8 +1369,29 @@ check_continued:
 end:
 	current->state = TASK_RUNNING;
 	remove_wait_queue(&current->wait_chldexit,&wait);
-	if (infop && retval > 0)
+	if (infop) {
+		if (retval > 0)
 		retval = 0;
+		else {
+			/*
+			 * For a WNOHANG return, clear out all the fields
+			 * we would set so the user can easily tell the
+			 * difference.
+			 */
+			if (!retval)
+				retval = put_user(0, &infop->si_signo);
+			if (!retval)
+				retval = put_user(0, &infop->si_errno);
+			if (!retval)
+				retval = put_user(0, &infop->si_code);
+			if (!retval)
+				retval = put_user(0, &infop->si_pid);
+			if (!retval)
+				retval = put_user(0, &infop->si_uid);
+			if (!retval)
+				retval = put_user(0, &infop->si_status);
+		}
+	}
 	return retval;
 }
 
