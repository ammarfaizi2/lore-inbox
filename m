Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVCIAOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVCIAOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVCIAKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:10:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:10932 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262239AbVCIAHL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:07:11 -0500
Subject: Re: [PATCH] VGA arbitration: draft of kernel side
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: xorg@freedesktop.org, Egbert Eich <eich@freedesktop.org>,
       Jon Smirl <jonsmirl@yahoo.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105030815477d0c7688@mail.gmail.com>
References: <1110265919.13607.261.camel@gaston>
	 <1110319304.13594.272.camel@gaston>
	 <9e47339105030815477d0c7688@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 11:02:45 +1100
Message-Id: <1110326565.32556.7.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 18:47 -0500, Jon Smirl wrote:
> This very similar to the reset support patch I have been working on.
> 
> In the reset patch there is a 'vga' attribute on each VGA device. Set
> it to 0/1 to make the device active. This lets you move the console
> around betweem VGA devices.
> 
> You can also set it to 3, which disables all VGA devices but remembers
> the active one. Setting it to 4 disables all VGA devices then restores
> the active one. To use, set it to 3, post, set it to 4.
> 
> GregKH wants this code out of the pci directory but it needs hooks
> into pci_destroy_dev() to delete the arbiter. You also need a hook on
> add for when a hotplug device appears.
> 
> I'll try merging my sysfs support into your code.

Please wait.

I don't want that semantic for sysfs. First, I don't want to "move
around" the VGA device. This is very arch specific and will not work in
a variety if circumstances. Also, "outb's" to legacy VGA ports will only
work with some PCI domains on archs like PPC, even vgacon can't deal
with that, so let's avoid putting such "knowledge" in the arbiter
itself. I prefer for now defining a "default" vga device which is the
one used by vgacon. If you want to move vgacon around, do some arch
specific stuff or add way to change the default device, but that isn't
directly related to the arbitration process.

Also, I want the sysfs entry (or /dev if I can't get the proper
semantics in sysfs) to have open & release() callbacks like a char
device. The reason is that I want the vga "locks" owned by a process to
be automatically released if the process dies. Without that, kill -9 on
X will end up requiring a reboot in most circumstances :)

Finally, I want to keep the distinction between memory and IO enables.
That's quite important imho, since a lot of cards can operate with IO
disabled (all ATIs for example), which is good as I'm not completely
sure I can disable legacy IO port decoding on them (well, I don't know
how to do it).

Ben.
 

