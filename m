Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbTDVMtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTDVMtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:49:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38364 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263040AbTDVMtt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:49:49 -0400
Date: Tue, 22 Apr 2003 14:01:52 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>
Subject: PCI sysfs resource handling
Message-ID: <20030422130152.GC3140@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As part of my PCI sysfs changes I posted on April 7th
(http://www.ussg.iu.edu/hypermail/linux/kernel/0304.0/1724.html),
I noted a TODO, to convert the `resource' file into directories.

Currently, we have:

willy@daiml:~$ cat /sys/bus/pci/devices/0000:02:00.1/resource 
        0x0000000000001080      0x0000000000001087      0x0000000000000101
        0x0000000010801000      0x00000000108017ff      0x0000000000000200
        0x0000000010801800      0x0000000010801fff      0x0000000000000200
        0x0000000000000000      0x0000000000000000      0x0000000000000000
        0x0000000000000000      0x0000000000000000      0x0000000000000000
        0x0000000000000000      0x0000000000000000      0x0000000000000000
        0x0000000010404000      0x0000000010407fff      0x0000000000007200

The suggested plan was to make it look
like this:

/sys/bus/pci/devices/0000:02:00.1/resource0/start
/sys/bus/pci/devices/0000:02:00.1/resource0/end
/sys/bus/pci/devices/0000:02:00.1/resource0/flags
/sys/bus/pci/devices/0000:02:00.1/resource1/start
/sys/bus/pci/devices/0000:02:00.1/resource1/end
/sys/bus/pci/devices/0000:02:00.1/resource1/flags
/sys/bus/pci/devices/0000:02:00.1/resource2/start
/sys/bus/pci/devices/0000:02:00.1/resource2/end
/sys/bus/pci/devices/0000:02:00.1/resource2/flags
/sys/bus/pci/devices/0000:02:00.1/resource6/start
/sys/bus/pci/devices/0000:02:00.1/resource6/end
/sys/bus/pci/devices/0000:02:00.1/resource6/flags

with one value per file.  I wasn't entirely convinced then and I'm
not convinced now.  I don't think embedding a kobject in every struct
resource is really a good idea.  However, I can see a good argument for
replacing the `resource' file with these files:

/sys/bus/pci/devices/0000:02:00.1/resource0
/sys/bus/pci/devices/0000:02:00.1/resource1
/sys/bus/pci/devices/0000:02:00.1/resource2
/sys/bus/pci/devices/0000:02:00.1/resource6

Here's the fruity bit though.  If you cat resource1, you'd get

        0x0000000010801000      0x00000000108017ff      0x0000000000000200

But if you mmaped it, you'd get the iomem from 0x10801000 to 0x108017ff
mapped into your address space.  I'm a little uneasy about having a file
which has different contents based on whether you mmap it or read/write it,
but everyone expects procfs/sysfs files to be a little bit special.  And
it's nothing compared to some of the crap we were doing in procfs ;-)

Comments?

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
