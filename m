Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266526AbUIMSME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUIMSME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUIMSMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:12:03 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:46600 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266526AbUIMSLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:11:45 -0400
Message-ID: <9e473391040913111158292add@mail.gmail.com>
Date: Mon, 13 Sep 2004 14:11:41 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: radeon-pre-2
Cc: Dave Airlie <airlied@linux.ie>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1095093816.14586.51.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de>
	 <1094853588.18235.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409110137590.26651@skynet>
	 <1094912726.21157.52.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0409122319550.20080@skynet>
	 <1095074778.14374.41.camel@localhost.localdomain>
	 <9e47339104091308063c394704@mail.gmail.com>
	 <1095087860.14582.37.camel@localhost.localdomain>
	 <9e47339104091309281c4e6fb7@mail.gmail.com>
	 <1095093816.14586.51.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It wasn't intended to stay in the PCI layer. Something needs to be
done about hotplugging bridges. There aren't callouts from the PCI
layer for that. A hotplugged bridge can be capable of VGA routing and
have VGA devices behind it. I just started off in the PCI layer while
I figured out what hooks were needed. If a VGA capable bridge is
hotplugged, the VGA driver needs to know about it since it has to
create sysfs attributes and directories for it.

Another solution would be to split it. VGA attributes for the bridges
would be handled by the PCI layer. The other stuff by the VGA driver.

The driver has to have a few capabilities:
1) Turn off all VGA devices in this "VGA space". This is needed
because resetting a card is going to turn on it's VGA mode and we
can't have more than one.
2) It can't rely on the kernel structures representing the VGA state
or bridge routing state. For example the reset program is going to
turn a VGA device on without telling the kernel. There are other
things like X that do VGA programming from user space. Instead of
using the structure you need to query the hardware.
3) Activate a new VGA device. The only safe way to do this is to turn
off all devices using function #1 first. User space may have turned a
device on with telling the kernel. Activating a new device need to
tell vgacon about new screen size/mode.

sysfs looks like this:

/class/vga
     vga0
     vga1 --- one for each "VGA space"

/class/vga/vga0/dev - causes hotplug to create /dev/vga0. I used the
major from DRM and started the minors at 512.

/class/vga/vga0/vga - setting this attribute to zero turns off all VGA
devices in this space

/class/vga/vga0/* - links to all of the VGA devices in this "VGA space"

/class/vga/vga0/0000:01:00.0/vga - set this to one to enable a
specific VGA device. As a side effect it will always disable all other
VGA device in this space.

Each PCI bridge device has a vga attribute indicating it's state of
VGA routing. These are readonly. The actual bridge routing state is
set as a function of activating a new VGA device.

The IA64 people want a file/ioctl interface on the /dev/vga0 devices
so that they can issue control calls to the active device in each "VGA
space"
