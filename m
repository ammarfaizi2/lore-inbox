Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266619AbUJDN0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUJDN0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUJDNXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:23:19 -0400
Received: from gprs214-62.eurotel.cz ([160.218.214.62]:22400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266619AbUJDNUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:20:22 -0400
Date: Mon, 4 Oct 2004 14:24:22 +0200
From: Pavel Machek <pavel@ucw.cz>
To: lkml@kcore.org, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: swsusp: fix suspending with mysqld
Message-ID: <20041004122422.GA2601@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

mysqld does signal calls in pretty tight loop, and swsusp is not able
to stop processes in such case. This should fix it. Please apply,
								Pavel


Index: linux/kernel/signal.c
===================================================================
--- linux.orig/kernel/signal.c	2004-10-01 12:24:26.000000000 +0200
+++ linux/kernel/signal.c	2004-10-01 01:00:26.000000000 +0200
@@ -1483,8 +1483,7 @@
 	unsigned long flags;
 	struct sighand_struct *psig;
 
-	if (sig == -1)
-		BUG();
+	BUG_ON(sig == -1);
 
  	/* do_notify_parent_cldstop should have been called instead.  */
  	BUG_ON(tsk->state & (TASK_STOPPED|TASK_TRACED));
@@ -2260,6 +2259,8 @@
 			ret = -EINTR;
 	}
 
+	if (current->flags & PF_FREEZE)
+		refrigerator(1);
 	return ret;
 }
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
