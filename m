Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVA1HNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVA1HNi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 02:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVA1HNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 02:13:38 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:57516 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261235AbVA1HNP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 02:13:15 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/16] New set of input patches
Date: Fri, 28 Jan 2005 02:13:12 -0500
User-Agent: KMail/1.7.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <d120d50005012706045b2e84af@mail.gmail.com> <20050127161518.GA14020@ucw.cz>
In-Reply-To: <20050127161518.GA14020@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501280213.13005.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 January 2005 11:15, Vojtech Pavlik wrote:
> > I think that the very first path ("while true; do xset led 3; xset
> > -led 3; done" makes keyboard miss release events and makes it
> > unusable) should go in 2.6.11 so please do:
> > 
> >         bk pull bk://dtor.bkbits.net/for-2.6.11
> 
> Pulled, pushed into my tree. I verified the patch, and it is indeed
> correct. Before we get an ACK for a command we sent, we still may
> receive normal data. After we got the ACK we know for sure that no more
> regular data will come, and can expect the command response.

Hi Vojtech,

I have another one that I think needs to be in 2.6.11 - in ps2_command
does not update timeout variable when waiting for the first byte of
response so even if command times out the code still goes and tries to
wait for more data. It actually causes problems with GETID command - we
end up reporting success even if we did not get any response (except for
initial ACK). 

Also, now taht wait_event_timeout is available we shoudl use it instead
of wait_event_interruptible_timeout.

-- 
Dmitry


===================================================================


ChangeSet@1.1986, 2005-01-28 01:53:11-05:00, dtor_core@ameritech.net
  Input: libps2 - fix timeout handling in ps2_command, switch to using
         wait_event_timeout instead of wait_event_interruptible_timeout
         now that first form is available.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 libps2.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
--- a/drivers/input/serio/libps2.c	2005-01-28 02:12:06 -05:00
+++ b/drivers/input/serio/libps2.c	2005-01-28 02:12:06 -05:00
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


