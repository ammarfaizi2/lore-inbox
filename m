Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264471AbUESRjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUESRjb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 13:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUESRjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 13:39:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:61591 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264471AbUESRja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 13:39:30 -0400
Date: Wed, 19 May 2004 19:39:29 +0200
From: Olaf Hering <olh@suse.de>
To: akpm@osdl.org, Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] out of bounds access in hiddev_cleanup
Message-ID: <20040519173929.GA25589@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hiddev_table[] is an array of pointers. the minor number is used as an
offset. hiddev minors start either with zero, or with 96.
If they start with 96, the offset must be reduced by HIDDEV_MINOR_BASE
because only 16 minors are available.
unplugging a hiddevice will zero data outside the hiddev_table array.

this was spotted by Takashi Iwai.

--- linux-2.6.5/drivers/usb/input/hiddev.c-dist	2004-05-16 17:16:20.260126241 +0200
+++ linux-2.6.5/drivers/usb/input/hiddev.c	2004-05-16 17:16:55.285207314 +0200
@@ -232,7 +232,7 @@ static int hiddev_fasync(int fd, struct 
 static struct usb_class_driver hiddev_class;
 static void hiddev_cleanup(struct hiddev *hiddev)
 {
-	hiddev_table[hiddev->hid->minor] = NULL;
+	hiddev_table[hiddev->hid->minor - HIDDEV_MINOR_BASE] = NULL;
 	usb_deregister_dev(hiddev->hid->intf, &hiddev_class);
 	kfree(hiddev);
 }



-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
