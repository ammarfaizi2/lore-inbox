Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271498AbRIPK01>; Sun, 16 Sep 2001 06:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271569AbRIPK0R>; Sun, 16 Sep 2001 06:26:17 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:7433 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S271498AbRIPK0D>;
	Sun, 16 Sep 2001 06:26:03 -0400
Date: Sun, 16 Sep 2001 12:26:24 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux USB Mailinglist <linux-usb-devel@lists.sourceforge.net>,
        torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BUG] hiddev.c 2.4.10-pre9
Message-ID: <20010916122624.A1063@suse.cz>
In-Reply-To: <Pine.LNX.4.33.0109161202490.30202-100000@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109161202490.30202-100000@titan.lahn.de>; from pmhahn@titan.lahn.de on Sun, Sep 16, 2001 at 12:09:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 12:09:40PM +0200, Philipp Matthias Hahn wrote:
> Hello LKML, USB-ML, Vojtech!
> 
> The initialization order of hid.o and hiddev.o is wrong:
> 
> drivers/usb/hiddev.c:573 hiddev_connect() is called by
> drivers/usb/hid-core.c:1225 hid_probe() before
> drivers/usb/hiddev.c:665 hiddev_init() is called.
> 
> This results in hiddev_devfs_handle being NULL for each hid-device handled
> by hiddev, so that all device-nodes are created as /dev/hiddev%d instead
> of /dev/usb/hid/hiddev%d.

And here goes the fix. It also fixes a problem with devices with HID
type interface with no endpoints. Alan, Linus, please apply it. 

--- linux-2.4.9-ac10/drivers/usb/hid-core.c	Mon Sep 10 10:10:16 2001
+++ linux/drivers/usb/hid-core.c	Sun Sep 16 12:25:01 2001
@@ -1281,10 +1281,10 @@
 
 static int __init hid_init(void)
 {
-	usb_register(&hid_driver);
 #ifdef CONFIG_USB_HIDDEV
 	hiddev_init();
 #endif
+	usb_register(&hid_driver);
 	info(DRIVER_VERSION " " DRIVER_AUTHOR);
 

-- 
Vojtech Pavlik
SuSE Labs
