Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751994AbWCFTdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbWCFTdv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 14:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWCFTdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 14:33:51 -0500
Received: from canuck.infradead.org ([205.233.218.70]:60550 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751661AbWCFTdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 14:33:50 -0500
Message-ID: <440C8E60.6020005@torque.net>
Date: Mon, 06 Mar 2006 14:32:48 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Move SG_GET_SCSI_ID from sg to scsi
References: <Pine.LNX.4.58.0603061133070.2997@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0603061133070.2997@be1.lrz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> I suggest moving the SG_GET_SCSI_ID ioctl from sg to scsi, since it's 
> generally usefull and the alternative function SCSI_IOCTL_GET_IDLUN
> is limited in range (in-kernel data types may be larger) and 
> functionality (type, ...).

Bodo,
ioctls, especially new ones, have become very unpopular
in the linux kernel. Whoever implemented the SG_IO ioctl
in the block layer moved just enough other sg ioctls to
fool cdrecord that it was talking to the sg driver. The
SG_GET_SCSI_ID ioctl didn't make the cut, probably because
cdrecord didn't use it.

Mind you, I think it is correct to (try and) move
SG_GET_SCSI_ID to the SCSI subsystem rather than
the block layer. Otherwise we would not be able
to use your proposed ioctl on non-block, sg visible
only devices (e.g. a SCSI enclosure (SES protocol)).

> However, I have some questions about that ioctl:
> 
> - There is the concept of 8-Byte-LUNs: Are they mapped to integer LUNs?
> Should the extra space in the struct sg_scsi_id be used for that?
> Or should I abandon the idea and create a new IOCTL instead?

Yes, the SG_GET_SCSI_ID ioctl should allow for 8 byte
LUNs and that is a flaw in the current design. It is
no excuse that the rest of the SCSI subsystem has a
similar shortcoming.

In linux there is also a move away from the host_number,
channel_number, target_identifier and LUN tuple used
traditionally by many Unix SCSI subsystems (most do not
have the second component: channel_number). At least the
LUN is not controversial (as long as it is 8 byte!). The
target_identifier is actually transport dependent (but
could just be a simple enumeration). The host_number is
typically an enumeration over PCI addresses but some
other type of computer buses (e.g. microchannel) could be
involved.

> - The original IOCTL will check for sdp->detached. If the moved-to-scsi 
> ioctl is called, the check will be done before chaining from sg, but what
> will I need to check if it's called on a non-sg device?

That should not be needed as the open file descriptor
to the SCSI device should be sufficient to keep the
relevant objects alive even if the device was just hot
unplugged.

> - Are there any (planned) changes that will conflict with this patch?

There is this thing called sysfs which is advertised
as an ioctl replacement. However if a routine is given
an open device node and you want to find its identity
an ioctl does have some advantages over a procfs followed
by a sysfs trawl. Just like ioctl related structures,
sysfs also changes, frustrating applications built on
it. Sysfs might even change more often than a well designed
ioctl since sysfs is often tightly bound to the driver
software architecture which may change without impacting
interfaces.

Lets see if this post gets a response.

Doug Gilbert


