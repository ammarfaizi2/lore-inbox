Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270921AbUJUUIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270921AbUJUUIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270929AbUJUUEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:04:24 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:50018 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270933AbUJUT7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 15:59:00 -0400
Subject: [PATCH 2.6] serial send_break duration fix
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098388732.3288.62.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 14:58:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tty_io.c send_break() to assert break for proper duration.
If driver break_ctl() changes task state, then break may end
prematurely. USB serial driver break_ctl() sends a URB,
changing task state to TASK_RUNNING.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.8/drivers/char/tty_io.c	2004-08-14 00:37:15.000000000 -0500
+++ b/drivers/char/tty_io.c	2004-10-20 21:31:55.000000000 -0500
@@ -1703,11 +1703,11 @@ static int tiocsetd(struct tty_struct *t
 
 static int send_break(struct tty_struct *tty, int duration)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	tty->driver->break_ctl(tty, -1);
-	if (!signal_pending(current))
+	if (!signal_pending(current)) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(duration);
+	}
 	tty->driver->break_ctl(tty, 0);
 	if (signal_pending(current))
 		return -EINTR;



