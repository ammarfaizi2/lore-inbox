Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbTGOUzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbTGOUzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:55:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:3548 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269664AbTGOUy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:54:59 -0400
Date: Tue, 15 Jul 2003 14:09:58 -0700
From: Greg KH <greg@kroah.com>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /sys/class/tty bugglet in 2.6.0-test1 +
Message-ID: <20030715210958.GA5368@kroah.com>
References: <m3brvvzh4m.fsf@lugabout.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3brvvzh4m.fsf@lugabout.jhcloos.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 04:09:45PM -0400, James H. Cloos Jr. wrote:
> It looks like sysfs is creating a dir in class/tty by the name of
> usb/acm/0 for my acm modem:
> 
> :; ls -AF /sys/class/tty
> total 0
>    0 console/
>    0 ptmx/
>    0 tty/
>    0 tty0/
> [ tty1 to tty63 elided ]
>    0 ttyS0/
>    0 ttyS1/
>    0 ttyS2/
>    0 ttyS3/
>    0 usb/acm/0/

Ouch, someone forgot to fix up this driver's devfs_name logic.  The
patch below should fix it.  Let me know if it doesn't work for you.

greg k-h


# USB: fix up cdc-acm driver's tty and devfs names.

diff -Nru a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c	Tue Jul 15 14:08:30 2003
+++ b/drivers/usb/class/cdc-acm.c	Tue Jul 15 14:08:30 2003
@@ -765,7 +765,8 @@
 		return -ENOMEM;
 	acm_tty_driver->owner = THIS_MODULE,
 	acm_tty_driver->driver_name = "acm",
-	acm_tty_driver->name = "usb/acm/",
+	acm_tty_driver->name = "ttyACM",
+	acm_tty_driver->devfs_name = "usb/acm/",
 	acm_tty_driver->major = ACM_TTY_MAJOR,
 	acm_tty_driver->minor_start = 0,
 	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
