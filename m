Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVA1LZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVA1LZF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 06:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbVA1LZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 06:25:04 -0500
Received: from styx.suse.cz ([82.119.242.94]:33701 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261299AbVA1LXT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 06:23:19 -0500
Subject: [PATCH 1/1] One more: Fix libps2 timeout handling
In-Reply-To: <20050127165958.GA15690@ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 28 Jan 2005 12:26:26 +0100
Message-Id: <11069115862461@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1978, 2005-01-28 02:01:34-05:00, dtor_core@ameritech.net
  Input: libps2 - fix timeout handling in ps2_command, switch to using
         wait_event_timeout instead of wait_event_interruptible_timeout
         now that first form is available.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 libps2.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
--- a/drivers/input/serio/libps2.c	2005-01-28 12:24:29 +01:00
+++ b/drivers/input/serio/libps2.c	2005-01-28 12:24:29 +01:00
@@ -60,9 +60,9 @@
 	serio_continue_rx(ps2dev->serio);
 
 	if (serio_write(ps2dev->serio, byte) == 0)
-		wait_event_interruptible_timeout(ps2dev->wait,
-					!(ps2dev->flags & PS2_FLAG_ACK),
-					msecs_to_jiffies(timeout));
+		wait_event_timeout(ps2dev->wait,
+				   !(ps2dev->flags & PS2_FLAG_ACK),
+				   msecs_to_jiffies(timeout));
 
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags &= ~PS2_FLAG_ACK;
@@ -115,8 +115,8 @@
 	 */
 	timeout = msecs_to_jiffies(command == PS2_CMD_RESET_BAT ? 4000 : 500);
 
-	wait_event_interruptible_timeout(ps2dev->wait,
-		!(ps2dev->flags & PS2_FLAG_CMD1), timeout);
+	timeout = wait_event_timeout(ps2dev->wait,
+				     !(ps2dev->flags & PS2_FLAG_CMD1), timeout);
 
 	if (ps2dev->cmdcnt && timeout > 0) {
 
@@ -147,8 +147,8 @@
 			serio_continue_rx(ps2dev->serio);
 		}
 
-		wait_event_interruptible_timeout(ps2dev->wait,
-				!(ps2dev->flags & PS2_FLAG_CMD), timeout);
+		wait_event_timeout(ps2dev->wait,
+				   !(ps2dev->flags & PS2_FLAG_CMD), timeout);
 	}
 
 	if (param)
@@ -259,7 +259,7 @@
 		ps2dev->flags |= PS2_FLAG_CMD | PS2_FLAG_CMD1;
 
 	ps2dev->flags &= ~PS2_FLAG_ACK;
-	wake_up_interruptible(&ps2dev->wait);
+	wake_up(&ps2dev->wait);
 
 	if (data != PS2_RET_ACK)
 		ps2_handle_response(ps2dev, data);
@@ -281,12 +281,12 @@
 	if (ps2dev->flags & PS2_FLAG_CMD1) {
 		ps2dev->flags &= ~PS2_FLAG_CMD1;
 		if (ps2dev->cmdcnt)
-			wake_up_interruptible(&ps2dev->wait);
+			wake_up(&ps2dev->wait);
 	}
 
 	if (!ps2dev->cmdcnt) {
 		ps2dev->flags &= ~PS2_FLAG_CMD;
-		wake_up_interruptible(&ps2dev->wait);
+		wake_up(&ps2dev->wait);
 	}
 
 	return 1;
@@ -298,7 +298,7 @@
 		ps2dev->nak = 1;
 
 	if (ps2dev->flags & (PS2_FLAG_ACK | PS2_FLAG_CMD))
-		wake_up_interruptible(&ps2dev->wait);
+		wake_up(&ps2dev->wait);
 
 	ps2dev->flags = 0;
 }

