Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWA3D0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWA3D0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 22:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWA3D0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 22:26:54 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:24702 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750701AbWA3D0y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 22:26:54 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marek =?utf-8?q?Va=C5=A1ut?= <marek.vasut@gmail.com>
Subject: Re: [PATCH] iforce: fix -ENOMEM check
Date: Sun, 29 Jan 2006 22:26:50 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200601281903.28176.marek.vasut@gmail.com> <200601282314.21222.dtor_core@ameritech.net> <200601291209.15864.marek.vasut@gmail.com>
In-Reply-To: <200601291209.15864.marek.vasut@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601292226.51488.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 January 2006 06:09, Marek Vašut wrote:
> Dne neděle 29 ledna 2006 05:14 jste napsal(a):
> > On Saturday 28 January 2006 13:03, Marek Vašut wrote:
> > > I have tried that patch, but nothing changed ...
> > > That error is still there and no new device in /dev/input appears
> >
> > You do have updated udev, don't you? Could you pease post your dmesg
> > with the patch applied?
> 
> usb 4-2: new full speed USB device using uhci_hcd and address 2
> usb 4-2: configuration #1 chosen from 1 choice
> iforce-main.c: Timeout waiting for response from device.
> usbcore: registered new driver iforce
> 
> I´ve cut off the unnecessary parts. This is what shows up when I connect it.
> There is no js0 in /dev/input ... thats weird, isn´t it?
> 

OK, the patch below should get it going... Please let me know if it makes
device appear.

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joystick/iforce/iforce-packets.c |    4 ++--
 drivers/input/joystick/iforce/iforce-usb.c     |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

Index: work/drivers/input/joystick/iforce/iforce-packets.c
===================================================================
--- work.orig/drivers/input/joystick/iforce/iforce-packets.c
+++ work/drivers/input/joystick/iforce/iforce-packets.c
@@ -167,9 +167,9 @@ void iforce_process_packet(struct iforce
 		iforce->expect_packet = 0;
 		iforce->ecmd = cmd;
 		memcpy(iforce->edata, data, IFORCE_MAX_LENGTH);
-		wake_up(&iforce->wait);
 	}
 #endif
+	wake_up(&iforce->wait);
 
 	if (!iforce->type) {
 		being_used--;
@@ -264,7 +264,7 @@ int iforce_get_id_packet(struct iforce *
 		wait_event_interruptible_timeout(iforce->wait,
 			iforce->ctrl->status != -EINPROGRESS, HZ);
 
-		if (iforce->ctrl->status != -EINPROGRESS) {
+		if (iforce->ctrl->status) {
 			usb_unlink_urb(iforce->ctrl);
 			return -1;
 		}
Index: work/drivers/input/joystick/iforce/iforce-usb.c
===================================================================
--- work.orig/drivers/input/joystick/iforce/iforce-usb.c
+++ work/drivers/input/joystick/iforce/iforce-usb.c
@@ -95,7 +95,6 @@ static void iforce_usb_irq(struct urb *u
 		goto exit;
 	}
 
-	wake_up(&iforce->wait);
 	iforce_process_packet(iforce,
 		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1, regs);
 
