Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261907AbVBUHYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVBUHYM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 02:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVBUHYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 02:24:12 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:52621 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261907AbVBUHYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 02:24:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=a+7lVUQoXDuBWBh6a/87oE1/w44NrJhH/SNSANnLkuDjefsvu8AndyNYKLyt2asPGesnMEKcO+3sp0mB8eTeoWFYtGa41rpySDOLezuQylr/1tbkH+3nmDrms2uXWUPvis0McXd0UqUMVPfKIjdfRe5fqe4vn+3doMwRjkBUXTs=
Message-ID: <9e47339105022023242e2fd9ce@mail.gmail.com>
Date: Mon, 21 Feb 2005 02:24:07 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>,
       fbdev <linux-fbdev-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Problem: how to sequence reset of PCI hardware
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Secondary video cards need to be reset before they will work. How can
we get the kernel to do this? I can not come up with a good solution
for triggering this from a device driver.

One sequence I tried:
modprobe driver
driver registers sysfs class and triggers hotplug
probe code fail because HW is not reset
user space hotplug reset app runs
when reset is finished poke a sysfs attribute
in attribute handler reprobe the card

The sequence needs to be tolerant of the user space hotplug app failing
It also has to handle a rmmod of the driver while the user space app is running

An alternative is to put a emu86 execution module into the kernel.
That will allow the reset to occur synchronously. The linuxbios people
have one that is about 40-50K in size.

Another solution would be to have the PCI subsystem track devices that
have not been reset yet. modprobe of a driver would trigger a hotplug
reset event and fail the modprobe. The user space reset app would tell
the PCI subsystem when the hardware was successfully reset. After that
the modprobe would be allow to procede like normal.

I haven't been able to come up with a reliable way to call a user
space reset program from a driver's probe function except with an
in-kernel emu86. Is there another way? I'd also like to try an find a
solution that doesn't need to modify the 73 existing framebuffer
drivers.

-- 
Jon Smirl
jonsmirl@gmail.com
