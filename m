Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270807AbUJUVBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270807AbUJUVBb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270838AbUJUVB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:01:28 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:51815 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S270807AbUJUVBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:01:02 -0400
Subject: [PATCH 2.4] serial send_break duration fix
From: Paul Fulghum <paulkf@microgate.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098392462.3288.65.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 21 Oct 2004 16:01:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix tty_io.c send_break() to assert break for proper duration.
If driver break_ctl() changes task state, then break may end
prematurely. USB serial driver break_ctl() sends a URB,
changing task state to TASK_RUNNING.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

-- 
Paul Fulghum
paulkf@microgate.com

--- linux-2.4.28-pre4/drivers/char/tty_io.c	2004-04-14 08:05:29.000000000 -0500
+++ b/drivers/char/tty_io.c	2004-10-21 15:55:40.516247240 -0500
@@ -1684,11 +1684,11 @@ static int tiocsetd(struct tty_struct *t
 
 static int send_break(struct tty_struct *tty, int duration)
 {
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	tty->driver.break_ctl(tty, -1);
-	if (!signal_pending(current))
+	if (!signal_pending(current)) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		schedule_timeout(duration);
+	}
 	tty->driver.break_ctl(tty, 0);
 	if (signal_pending(current))
 		return -EINTR;


