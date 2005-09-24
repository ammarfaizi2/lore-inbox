Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbVIXTzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbVIXTzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 15:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbVIXTy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 15:54:59 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26118 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750725AbVIXTy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 15:54:59 -0400
Date: Sat, 24 Sep 2005 21:52:05 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Davide Libenzi <davidel@xmailserver.org>, Andrew Morton <akpm@osdl.org>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>,
       Nish Aravamudan <nish.aravamudan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] 2.6.14-rc2-mm1 : fixes for overflow in sys_poll()
Message-ID: <20050924195205.GE26197@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain> <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050924193839.GB26197@alpha.home.local>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch simplifies the overflow fix which was applied to sys_poll() in
2.6.14-rc2-mm1 by relying on the overflow detection code added to jiffies.h
by patch 1/3. This also removes a useless divide for HZ <= 1000.

It might be worth applying too. It's only for -mm1, and does *not* apply
to 2.6.14-rc2 because this code has already received patches in -mm1.

Signed-off-by: Willy Tarreau <willy@w.ods.org>

- Willy


diff -purN linux-2.6.14-rc2-mm1/fs/select.c linux-2.6.14-rc2-mm1-poll/fs/select.c
--- linux-2.6.14-rc2-mm1/fs/select.c	Sat Sep 24 21:12:36 2005
+++ linux-2.6.14-rc2-mm1-poll/fs/select.c	Sat Sep 24 21:23:21 2005
@@ -469,7 +469,6 @@ asmlinkage long sys_poll(struct pollfd _
 {
 	struct poll_wqueues table;
 	int fdcount, err;
-	int overflow;
  	unsigned int i;
 	struct poll_list *head;
  	struct poll_list *walk;
@@ -486,22 +485,11 @@ asmlinkage long sys_poll(struct pollfd _
 		return -EINVAL;
 
 	/*
-	 * We compare HZ with 1000 to work out which side of the
-	 * expression needs conversion.  Because we want to avoid
-	 * converting any value to a numerically higher value, which
-	 * could overflow.
-	 */
-#if HZ > 1000
-	overflow = timeout_msecs >= jiffies_to_msecs(MAX_SCHEDULE_TIMEOUT);
-#else
-	overflow = msecs_to_jiffies(timeout_msecs) >= MAX_SCHEDULE_TIMEOUT;
-#endif
-
-	/*
 	 * If we would overflow in the conversion or a negative timeout
-	 * is requested, sleep indefinitely.
+	 * is requested, sleep indefinitely. Note: msecs_to_jiffies checks
+	 * for the overflow.
 	 */
-	if (overflow || timeout_msecs < 0)
+	if (timeout_msecs < 0)
 		timeout_jiffies = MAX_SCHEDULE_TIMEOUT;
 	else
 		timeout_jiffies = msecs_to_jiffies(timeout_msecs) + 1;


