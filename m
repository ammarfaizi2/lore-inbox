Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTEGXbE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264322AbTEGXDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:03:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50431 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264312AbTEGXCC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:02:02 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10523493873374@kroah.com>
Subject: Re: [PATCH] TTY changes for 2.5.69
In-Reply-To: <10523493872313@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 7 May 2003 16:16:27 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1104, 2003/05/07 15:00:32-07:00, hannal@us.ibm.com

[PATCH] moxa tty_driver add .owner field remove MOD_INC/DEC_USE_COUNT


 drivers/char/moxa.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)


diff -Nru a/drivers/char/moxa.c b/drivers/char/moxa.c
--- a/drivers/char/moxa.c	Wed May  7 16:00:52 2003
+++ b/drivers/char/moxa.c	Wed May  7 16:00:52 2003
@@ -341,6 +341,7 @@
 	memset(&moxaDriver, 0, sizeof(struct tty_driver));
 	memset(&moxaCallout, 0, sizeof(struct tty_driver));
 	moxaDriver.magic = TTY_DRIVER_MAGIC;
+	moxaDriver.owner = THIS_MODULE;
 	moxaDriver.name = "ttya";
 	moxaDriver.major = ttymajor;
 	moxaDriver.minor_start = 0;
@@ -544,7 +545,6 @@
 			ch->asyncflags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CALLOUT_ACTIVE);
 		}
 	}
-	MOD_DEC_USE_COUNT;
 }
 
 static int moxa_open(struct tty_struct *tty, struct file *filp)
@@ -556,7 +556,6 @@
 
 	port = PORTNO(tty);
 	if (port == MAX_PORTS) {
-		MOD_INC_USE_COUNT;
 		return (0);
 	}
 	if (!MoxaPortIsValid(port)) {
@@ -579,7 +578,6 @@
 	}
 	up(&moxaBuffSem);
 
-	MOD_INC_USE_COUNT;
 	ch = &moxaChannels[port];
 	ch->count++;
 	tty->driver_data = ch;
@@ -619,7 +617,6 @@
 
 	port = PORTNO(tty);
 	if (port == MAX_PORTS) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	if (!MoxaPortIsValid(port)) {
@@ -633,7 +630,6 @@
 		return;
 	}
 	if (tty_hung_up_p(filp)) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	ch = (struct moxa_str *) tty->driver_data;
@@ -649,7 +645,6 @@
 		ch->count = 0;
 	}
 	if (ch->count) {
-		MOD_DEC_USE_COUNT;
 		return;
 	}
 	ch->asyncflags |= ASYNC_CLOSING;
@@ -688,7 +683,6 @@
 	ch->asyncflags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CALLOUT_ACTIVE |
 			    ASYNC_CLOSING);
 	wake_up_interruptible(&ch->close_wait);
-	MOD_DEC_USE_COUNT;
 }
 
 static int moxa_write(struct tty_struct *tty, int from_user,
@@ -1024,9 +1018,7 @@
 						wake_up_interruptible(&ch->open_wait);
 					else {
 						set_bit(MOXA_EVENT_HANGUP, &ch->event);
-						MOD_DEC_USE_COUNT;
-						if (schedule_work(&ch->tqueue) == 0)
-							MOD_INC_USE_COUNT;
+						schedule_work(&ch->tqueue);
 					}
 				}
 			}

