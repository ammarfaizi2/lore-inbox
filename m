Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266657AbUHOMSO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266657AbUHOMSO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 08:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUHOMSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 08:18:14 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42469 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266657AbUHOMSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 08:18:06 -0400
Date: Sun, 15 Aug 2004 14:18:05 +0200
From: maximilian attems <janitor@sternwelten.at>
To: linux-kernel@vger.kernel.org
Cc: kj <kernel-janitors@osdl.org>
Subject: Add msleep_interruptible() function to kernel/timer.c
Message-ID: <20040815121805.GA15111@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

while doing kernel-janitor msleep conversion of drivers own (incorrect),
functions, some places would need msleep_interruptible().

this function is equivalent to:
        current->state = TASK_INTERRUPTIBLE;
	schedule_timeout(timeout);

idea from Ingo Molnar:
well, aboves is not 100% equivalent because msleep() is uninterruptible so
stoppage of the md thread (upon shutdown) will occur with only a 250 msec
delay. Someone should add a msleep_interruptible() function to kernel/timer.c.

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.6.8-max/kernel/timer.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff -puN kernel/timer.c~add-msleep_interruptible kernel/timer.c
--- linux-2.6.8/kernel/timer.c~add-msleep_interruptible	2004-08-14 23:41:46.000000000 +0200
+++ linux-2.6.8-max/kernel/timer.c	2004-08-14 23:41:46.000000000 +0200
@@ -1503,3 +1503,18 @@ void msleep(unsigned int msecs)
 
 EXPORT_SYMBOL(msleep);
 
+/**
+ * msleep_interruptible - sleep waiting for waitqueue interruptions
+ * @msecs: Time in milliseconds to sleep for
+ */
+void msleep_interruptible(unsigned int msecs)
+{
+	unsigned long timeout = msecs_to_jiffies(msecs);
+
+	while (timeout) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		timeout = schedule_timeout(timeout);
+	}
+}
+
+EXPORT_SYMBOL(msleep_interruptible);

_


