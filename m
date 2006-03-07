Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWCGSsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWCGSsu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 13:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWCGSsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 13:48:50 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:36102 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751485AbWCGSst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 13:48:49 -0500
Message-ID: <440DD5D4.2080403@tmr.com>
Date: Tue, 07 Mar 2006 13:49:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: dougg@torque.net
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: Move SG_GET_SCSI_ID from sg to scsi
References: <Pine.LNX.4.58.0603061133070.2997@be1.lrz> <440C8E60.6020005@torque.net>
In-Reply-To: <440C8E60.6020005@torque.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Douglas Gilbert wrote:
> Bodo Eggert wrote:
>> I suggest moving the SG_GET_SCSI_ID ioctl from sg to scsi, since it's 
>> generally usefull and the alternative function SCSI_IOCTL_GET_IDLUN
>> is limited in range (in-kernel data types may be larger) and 
>> functionality (type, ...).
> 
> Bodo,
> ioctls, especially new ones, have become very unpopular
> in the linux kernel. Whoever implemented the SG_IO ioctl
> in the block layer moved just enough other sg ioctls to
> fool cdrecord that it was talking to the sg driver. The
> SG_GET_SCSI_ID ioctl didn't make the cut, probably because
> cdrecord didn't use it.
> 
> Mind you, I think it is correct to (try and) move
> SG_GET_SCSI_ID to the SCSI subsystem rather than
> the block layer. Otherwise we would not be able
> to use your proposed ioctl on non-block, sg visible
> only devices (e.g. a SCSI enclosure (SES protocol)).
> 
>> However, I have some questions about that ioctl:
>>
>> - There is the concept of 8-Byte-LUNs: Are they mapped to integer LUNs?
>> Should the extra space in the struct sg_scsi_id be used for that?
>> Or should I abandon the idea and create a new IOCTL instead?
> 
> Yes, the SG_GET_SCSI_ID ioctl should allow for 8 byte
> LUNs and that is a flaw in the current design. It is
> no excuse that the rest of the SCSI subsystem has a
> similar shortcoming.
> 
> In linux there is also a move away from the host_number,
> channel_number, target_identifier and LUN tuple used
> traditionally by many Unix SCSI subsystems (most do not
> have the second component: channel_number). At least the
> LUN is not controversial (as long as it is 8 byte!). The
> target_identifier is actually transport dependent (but
> could just be a simple enumeration). The host_number is
> typically an enumeration over PCI addresses but some
> other type of computer buses (e.g. microchannel) could be
> involved.

In real SCSI systems that usually maps to card, bus/cable, ID and LUN 
and allows some correspondence between physical and logical space. Handy 
to trouble shoot, if you see a lot of errors on the same cable yo have a 
clue that it may be common cause.
> 
>> - The original IOCTL will check for sdp->detached. If the moved-to-scsi 
>> ioctl is called, the check will be done before chaining from sg, but what
>> will I need to check if it's called on a non-sg device?
> 
> That should not be needed as the open file descriptor
> to the SCSI device should be sufficient to keep the
> relevant objects alive even if the device was just hot
> unplugged.
> 
>> - Are there any (planned) changes that will conflict with this patch?
> 
> There is this thing called sysfs which is advertised
> as an ioctl replacement. However if a routine is given
> an open device node and you want to find its identity
> an ioctl does have some advantages over a procfs followed
> by a sysfs trawl. Just like ioctl related structures,
> sysfs also changes, frustrating applications built on
> it. Sysfs might even change more often than a well designed
> ioctl since sysfs is often tightly bound to the driver
> software architecture which may change without impacting
> interfaces.
> 
> Lets see if this post gets a response.

Good to see you still around and posting about the relevant technical 
details.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
