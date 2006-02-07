Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWBGQV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWBGQV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 11:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWBGQV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 11:21:56 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:18134
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965159AbWBGQV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 11:21:56 -0500
Subject: Re: [PATCH] new tty buffering locking fix
From: Paul Fulghum <paulkf@microgate.com>
To: Olaf Hering <olh@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20060207123450.GA854@suse.de>
References: <200602032312.k13NCbWb012991@hera.kernel.org>
	 <20060207123450.GA854@suse.de>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 10:21:42 -0600
Message-Id: <1139329302.3019.14.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 13:34 +0100, Olaf Hering wrote:
> > [PATCH] new tty buffering locking fix

> This patch breaks the hvc console, no input is accepted, even with
> init=/bin/sash? Any idea what this driver needs to do now?
> I wonder if it worked ok on -mm.

I think this is happening:

1. hvc calls tty_buffer_request_room, claiming a
   tty buffer for use by the driver

2. hvc adds data to the tty buffer

3. hvc calls tty_schedule_flip or tty_flip_buffer_push,
   which releases the buffer for processing

4. *before* the buffer can be processed, hvc again calls
   tty_buffer_request_room, reclaiming the same buffer
   which still has free room

5. hvc does not have more data to input, so it does
   not call tty_schedule_flip or tty_flip_buffer_push

Now the tty buffer contains some data but can't be processed
because it is still marked as in use by the driver.

Try the below patches (for testing only, I'm not suggesting
these as a final fix yet) and let me know if it fixes it.

Thanks,
Paul


--- linux-2.6.16-rc2/drivers/char/hvc_console.c	2006-02-06 13:50:39.000000000 -0600
+++ b/drivers/char/hvc_console.c	2006-02-07 10:10:18.000000000 -0600
@@ -613,6 +613,7 @@ static int hvc_poll(struct hvc_struct *h
 				tty_hangup(tty);
 				spin_lock_irqsave(&hp->lock, flags);
 			}
+			tty_schedule_flip(tty);
 			break;
 		}
 		for (i = 0; i < n; ++i) {
@@ -633,8 +634,7 @@ static int hvc_poll(struct hvc_struct *h
 			tty_insert_flip_char(tty, buf[i], 0);
 		}
 
-		if (count)
-			tty_schedule_flip(tty);
+		tty_schedule_flip(tty);
 
 		/*
 		 * Account for the total amount read in one loop, and if above
--- linux-2.6.16-rc2/drivers/char/hvcs.c	2006-02-06 13:50:39.000000000 -0600
+++ b/drivers/char/hvcs.c	2006-02-07 10:09:57.000000000 -0600
@@ -469,8 +469,7 @@ static int hvcs_io(struct hvcs_struct *h
 
 	spin_unlock_irqrestore(&hvcsd->lock, flags);
 	/* This is synch because tty->low_latency == 1 */
-	if(got)
-		tty_flip_buffer_push(tty);
+	tty_flip_buffer_push(tty);
 
 	if (!got) {
 		/* Do this _after_ the flip_buffer_push */


