Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWHFTJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWHFTJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 15:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbWHFTJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 15:09:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3741 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750947AbWHFTJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 15:09:07 -0400
Date: Sun, 6 Aug 2006 12:09:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Fabio Comolli" <fabio.comolli@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 2.6.18-rc3-mm2
Message-Id: <20060806120901.ee600a36.akpm@osdl.org>
In-Reply-To: <b637ec0b0608060848k22af58cbo6f13cee19498c2d2@mail.gmail.com>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<b637ec0b0608060848k22af58cbo6f13cee19498c2d2@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Aug 2006 17:48:52 +0200
"Fabio Comolli" <fabio.comolli@gmail.com> wrote:

> This kernel does not detect my HP laptop Alps touchpad. Also keyboard
> seems to be detected but does not work, with the only exception of the
> power button (I can use it to perform a clean shutdown).
> 
> 2.6.18-rc1-mm1 works perfectly.

hum.

-tycho kernel: ata1.00: configured for UDMA/33
+tycho kernel: ata1.00: configured for UDMA/100

That looks nice.

-tycho kernel: ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x18C8 irq 15
-tycho kernel: scsi1 : ata_piix
-tycho kernel: ata2: port disabled. ignoring.
-tycho kernel: ATA: abnormal status 0xFF on port 0x177

So does that.

-tycho kernel: input: PS/2 Mouse as /class/input/input1
-tycho kernel: input: AlpsPS/2 ALPS GlidePoint as /class/input/input2

That's not so good.


Dmitry, do you have anything in there which might have caused that?

Perhaps hdaps-handle-errors-from-input_register_device.patch is triggering
for some reason.  Fabio, it'd be useful if you could add this, see if it
triggers:


--- a/drivers/input/input.c~input_register_device-debug
+++ a/drivers/input/input.c
@@ -1007,6 +1007,10 @@ int input_register_device(struct input_d
  fail3:	sysfs_remove_group(&dev->cdev.kobj, &input_dev_id_attr_group);
  fail2:	sysfs_remove_group(&dev->cdev.kobj, &input_dev_attr_group);
  fail1:	class_device_del(&dev->cdev);
+	if (error) {
+		printk(KERN_ERR "%s failed: %d\n", __FUNCTION__, error);
+		dump_stack();
+	}
 	return error;
 }
 EXPORT_SYMBOL(input_register_device);
_

