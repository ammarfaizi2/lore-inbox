Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVCFWg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVCFWg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 17:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVCFWg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 17:36:57 -0500
Received: from coderock.org ([193.77.147.115]:51887 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261559AbVCFWgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:36:37 -0500
Subject: [patch 04/14] ftape/fdc-io: insert set_current_state() before schedule_timeout()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:26 +0100
Message-Id: <20050306223626.D468C1EC90@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Inserts a set_current_state(TASK_INTERRUPTIBLE) before the
schedule_timeout() call. Without this change, after the first iteration of the
loop, schedule_timeout() will not only return immediately, but the loop will
break, as the conditional will no longer be satisfied. In fact, this conditional
makes little sense given the workings of schedule_timeout. The timeout variable
is ignored, as well, and I'm fairly certain that it should be included in the
loop conditional. That way, if the timeout expires before a signal hits, -ETIME
will be returned by fdc_interrupt_wait() instead of -EINTR.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/ftape/lowlevel/fdc-io.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/char/ftape/lowlevel/fdc-io.c~set_current_state-drivers_char_ftape_lowlevel_fdc-io drivers/char/ftape/lowlevel/fdc-io.c
--- kj/drivers/char/ftape/lowlevel/fdc-io.c~set_current_state-drivers_char_ftape_lowlevel_fdc-io	2005-03-05 16:11:11.000000000 +0100
+++ kj-domen/drivers/char/ftape/lowlevel/fdc-io.c	2005-03-05 16:11:11.000000000 +0100
@@ -387,7 +387,8 @@ int fdc_interrupt_wait(unsigned int time
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	add_wait_queue(&ftape_wait_intr, &wait);
-	while (!ft_interrupt_seen && (current->state == TASK_INTERRUPTIBLE)) {
+	while (!ft_interrupt_seen && timeout) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		timeout = schedule_timeout(timeout);
         }
 
_
