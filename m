Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVCFXte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVCFXte (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVCFXrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:47:40 -0500
Received: from coderock.org ([193.77.147.115]:60847 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261567AbVCFWhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:37:00 -0500
Subject: [patch 09/14] tc/zs: replace schedule_timeout() with msleep_interruptible()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com,
       janitor@sternwelten.at
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:43 +0100
Message-Id: <20050306223643.D1CBA1ED3D@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/tc/zs.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff -puN drivers/tc/zs.c~msleep_interruptible-drivers_tc_zs drivers/tc/zs.c
--- kj/drivers/tc/zs.c~msleep_interruptible-drivers_tc_zs	2005-03-05 16:09:39.000000000 +0100
+++ kj-domen/drivers/tc/zs.c	2005-03-05 16:09:39.000000000 +0100
@@ -1368,8 +1368,7 @@ static void rs_close(struct tty_struct *
 	info->tty = 0;
 	if (info->blocked_open) {
 		if (info->close_delay) {
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(info->close_delay);
+			msleep_interruptible(jiffies_to_msecs(info->close_delay));
 		}
 		wake_up_interruptible(&info->open_wait);
 	}
@@ -1403,8 +1402,7 @@ static void rs_wait_until_sent(struct tt
 	if (timeout)
 		char_time = min(char_time, timeout);
 	while ((read_zsreg(info->zs_channel, 1) & Tx_BUF_EMP) == 0) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(char_time);
+		msleep_interruptible(jiffies_to_msecs(char_time));
 		if (signal_pending(current))
 			break;
 		if (timeout && time_after(jiffies, orig_jiffies + timeout))
_
