Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbUBHIMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 03:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbUBHIMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 03:12:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:49341 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262794AbUBHIMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 03:12:07 -0500
Date: Sun, 8 Feb 2004 00:14:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopses on usbnet unload in 2.6.3-rc1
Message-Id: <20040208001424.77dac13e.akpm@osdl.org>
In-Reply-To: <20040208022921.GA1337@buk.vc.cvut.cz>
References: <20040208022921.GA1337@buk.vc.cvut.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
>   recent thread about buggy sysfs fbdev support reminded me that situation
>  with modules unloading is not quite correct... Besides floppy & nbd unload
>  crashes (I already reported floppy/sysfs problem during Christmas),

Could you please rereport the floppy and nbd problems?

> there 
>  is a doublefree in usbnet's unload. I have no idea what's correct fix, but
>  given fbdev's problems probably just removing kfree(dev->net).

usbnet has relevant changes in Jeff's tree (and hence in -mm).

diff -Nru a/drivers/usb/net/usbnet.c b/drivers/usb/net/usbnet.c
--- a/drivers/usb/net/usbnet.c	Sat Feb  7 17:16:08 2004
+++ b/drivers/usb/net/usbnet.c	Sat Feb  7 17:16:08 2004
@@ -2933,7 +2933,7 @@
 	if (dev->driver_info->unbind)
 		dev->driver_info->unbind (dev, intf);
 
-	kfree(dev->net);
+	free_netdev(dev->net);
 	kfree (dev);
 	usb_put_dev (xdev);
 }
@@ -3061,7 +3061,7 @@
 	if (info->unbind)
 		info->unbind (dev, udev);
 out2:
-	kfree(net);
+	free_netdev(net);
 out1:
 	kfree(dev);
 out:

