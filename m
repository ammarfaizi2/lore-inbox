Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268008AbUJLWdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268008AbUJLWdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268013AbUJLWdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 18:33:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14272 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268008AbUJLWdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 18:33:32 -0400
Date: Tue, 12 Oct 2004 15:33:21 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, danmechanic@yahoo.com, zaitcev@redhat.com,
       greg@kroah.com
Subject: Crash with cat /proc/bus/usb/devices and disconnect
Message-ID: <20041012153321.525d753f@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs119.1 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marcelo:

Here's a patch, I'd like to be in -pre.

It is not the best fix. The 2.6 took a more fundamental approach, but I do
not wish to rock the boat too much. Also, I'm not sure if 2.6 even gets it
right at all, considering Fedora Core 3 bug 135171. At least this patch fixes
the problem for me! :-)  so I suppose better this than nothing, because
getting oops otherwise is just too easy.

I would like this to be in -pre.

Here's the 2.6 bug (unfixed yet):
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=135171

The 2.4 bug (fixed by this patch - admittedly a contrived scenario):
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=129265

Thanks,
-- Pete

diff -urp -X dontdiff linux-2.4.28-pre3/drivers/usb/devices.c linux-2.4.28-pre3-usb/drivers/usb/devices.c
--- linux-2.4.28-pre3/drivers/usb/devices.c	2004-09-12 14:24:09.000000000 -0700
+++ linux-2.4.28-pre3-usb/drivers/usb/devices.c	2004-10-05 13:54:14.000000000 -0700
@@ -552,9 +552,13 @@ static ssize_t usb_device_dump(char **bu
 	
 	/* Now look at all of this device's children. */
 	for (chix = 0; chix < usbdev->maxchild; chix++) {
-		if (usbdev->children[chix]) {
-			ret = usb_device_dump(buffer, nbytes, skip_bytes, file_offset, usbdev->children[chix],
+		struct usb_device *childdev = usbdev->children[chix];
+		if (childdev) {
+			usb_inc_dev_use(childdev);
+			ret = usb_device_dump(buffer, nbytes, skip_bytes,
+					file_offset, childdev,
 					bus, level + 1, chix, ++cnt);
+			usb_dec_dev_use(childdev);
 			if (ret == -EFAULT)
 				return total_written;
 			total_written += ret;
