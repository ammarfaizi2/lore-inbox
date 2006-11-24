Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934988AbWKXQhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934988AbWKXQhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 11:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934989AbWKXQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 11:37:13 -0500
Received: from mail.fccps.cz ([195.146.112.10]:20865 "EHLO mail.fccps.cz")
	by vger.kernel.org with ESMTP id S934988AbWKXQhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 11:37:11 -0500
From: "Frantisek Rysanek" <Frantisek.Rysanek@post.cz>
To: linux-kernel@vger.kernel.org
Date: Fri, 24 Nov 2006 17:37:42 +0100
MIME-Version: 1.0
Subject: need to make my chrdev visible to udev: how to tug at sysfs from kspace?
Message-ID: <45672DE6.10097.6E8BEF43@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Everyone,

this may be a RTFM question, I just can't seem to find the right docs 
:-)

I have a simple custom device called the UNO-2050 - essentially a PCI 
device based on a generic slave bridge by PLX (PLX9052).
I've written a driver that registers a character device, so that I 
have something to open() when I need to send some ioctl()'s into 
kernel space.

After some quick search in drivers/char/mem.c and other places,
I've come up with a sequence of register_chrdev(), class_create()
and class_device_create(), along the lines of

uno2050_major = register_chrdev(0,"uno-2050",&uno2050_fops);
uno2050_class = class_create(THIS_MODULE, "uno-2050");
class_device_create(
                  uno2050_class,
                  &board->fn[1].pdev->bus->class_dev,
                  MKDEV(uno2050_major,
                  board->fn[1].uno2050_minor),
                  &board->fn[1].pdev->dev,
                  "uno-2050-%d", board->fn[1].uno2050_minor
                   );

I get a nice sysfs class "uno-2050" and a sysfs class device called 
"uno-2050-0".

Now comes the interesting point:

If I insert my driver module at runtime, well after udev has started,
I get a nice and functional device node of /dev/uno-2050-0.

If OTOH I compile that same driver monolithically into the kernel, so 
that the device is detected before initrd is mounted and before udev 
is started ("cold plug"?), udev doesn't create the device node, 
although the sysfs entries (and a line in /proc/devices) are clearly 
there, and if I make the device node by hand, I can use the device...

At least, this is the way it behaves in Fedora 6 and Mandriva 2006.0.
What am I doing wrong? Should I better post my initrc/rc.sysinit?
I do have /proc, /sys and /dev/pts mounted before I attempt to start
udev.

Thanks in advance for any ideas...

Frank Rysanek

