Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262870AbUKTHLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262870AbUKTHLr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 02:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbUKTHLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 02:11:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:45971 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263073AbUKTHJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 02:09:56 -0500
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brking@us.ibm.com, Greg KH <greg@kroah.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1100917635.9398.12.camel@localhost.localdomain>
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>
	 <1100917635.9398.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 18:09:27 +1100
Message-Id: <1100934567.3669.12.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Even better, put that code in your private debug tree. Replace the
> locked cases with BUG() and fix the driver to get its internal locking
> right in this situation.
> 
> It seems wrong to put expensive checks in core code paths when you could
> just as easily provide
> 
> 	my_device_is_stupid_pci_read_config_byte()
> 
> and equivalent lock taking functions that wrap the existing ones and are
> locked against the reset path without hurting sane computing devices
> (and PC's).

Unfortunately, Alan, the cases where it matters aren't a driver with bad
locking or some something that can be fixed at the driver level. There
are already 2 uses of the above:

 - The device he's working on, which sometimes need to trigger a BIST
(built-in self test). During this operation, the device stops responding
on the PCI bus, which can be sort-of fatal if anything (userland playing
with /sys/bus/pci/* for example) touches the config space.

 - On Macs, I can turn the clock of some PCI devices on/off for power
management (and I do). However, when such a device is powered off, it
will not respond to config cycles neither, resulting in all-1's reads on
some HW setups or even in deadlock iirc on the G5. We need to "cloack"
them properly while the kernel still has the pci_dev entry for them
since they are just locally power managed by their driver , while
retaining userland visibility in /proc/pci or /sysfs or things like
kudzu stops finding them.

Also, the "Mac" case here (power management) is something I've seen
doable in a variety of embedded setups.

I would add: Config space accesses are slow anyways. They are even
horribly slow. They are worse than IO accesses. I _VERY_MUCH_ doubt that
a test of a variable member of pci_dev like the above would have any
noticeable impact here.

Ben.
 

