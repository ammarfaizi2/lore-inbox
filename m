Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964927AbWBGBnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964927AbWBGBnN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964929AbWBGBnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:43:12 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:35771 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964927AbWBGBnL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:43:11 -0500
Subject: [RFC][PATCH] i386: incorrect xtime locking on resume
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>
Content-Type: text/plain
Date: Mon, 06 Feb 2006 17:43:07 -0800
Message-Id: <1139276587.10057.188.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Nigel was asking about some suspend2 patches, and while looking at them
I noticed what looks to be a bug where jiffies and wall_jiffies are
modified without holding the xtime_lock in the resume path.

This patch should fix it, but I wanted to get some review and testing
done before I submit it.

thanks
-john


Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
index a14d594..406c8d8 100644
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -412,9 +412,9 @@ static int timer_resume(struct sys_devic
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
-	write_sequnlock_irqrestore(&xtime_lock, flags);
 	jiffies += sleep_length;
 	wall_jiffies += sleep_length;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
 	if (last_timer->resume)
 		last_timer->resume();
 	cur_timer = last_timer;


