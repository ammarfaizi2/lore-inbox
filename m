Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWCYRMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWCYRMS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 12:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWCYRMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 12:12:17 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:21519 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751448AbWCYRMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 12:12:16 -0500
Date: Sat, 25 Mar 2006 18:12:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: greg@kroah.com
Cc: linux-usb-devel@lists.sourceforge.ne, linux-kernel@vger.kernel.org
Subject: [2.6 patch] usb/input/keyspan_remote.c: don't use an uninitialized variable
Message-ID: <20060325171214.GG4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc reported the following:

<--  snip  -->

...
  CC      drivers/usb/input/keyspan_remote.o
drivers/usb/input/keyspan_remote.c: In function 'keyspan_irq_recv':
drivers/usb/input/keyspan_remote.c:186: warning: 'message.toggle' may be used uninitialized in this function
...

<--  snip  -->


gcc is right, there is an error case where this actually happens.

What about this patch that returns in this error case?

Signed-off-by: Darren Jenkins <darrenrjenkins@gmail.com>

--- linux-2.6.16-mm1-full/drivers/usb/input/keyspan_remote.c.old	2006-03-25 15:44:56.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/usb/input/keyspan_remote.c	2006-03-25 15:45:48.000000000 +0100
@@ -285,30 +285,31 @@ static void keyspan_check_data(struct us
 				return;
 			}
 		}
 
 		keyspan_load_tester(remote, 6);
 		if ((remote->data.tester & ZERO_MASK) == ZERO) {
 			message.toggle = 0;
 			remote->data.tester = remote->data.tester >> 5;
 			remote->data.bits_left -= 5;
 		} else if ((remote->data.tester & ONE_MASK) == ONE) {
 			message.toggle = 1;
 			remote->data.tester = remote->data.tester >> 6;
 			remote->data.bits_left -= 6;
 		} else {
 			err("%s - Error in message, invalid toggle.\n", __FUNCTION__);
+			return;
 		}
 
 		keyspan_load_tester(remote, 5);
 		if ((remote->data.tester & STOP_MASK) == STOP) {
 			remote->data.tester = remote->data.tester >> 5;
 			remote->data.bits_left -= 5;
 		} else {
 			err("Bad message recieved, no stop bit found.\n");
 		}
 
 		dev_dbg(&remote->udev->dev,
 			"%s found valid message: system: %d, button: %d, toggle: %d\n",
 			__FUNCTION__, message.system, message.button, message.toggle);
 
 		if (message.toggle != remote->toggle) {

