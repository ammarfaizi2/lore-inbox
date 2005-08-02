Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVHBRTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVHBRTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 13:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbVHBRTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 13:19:04 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:39322 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S261683AbVHBRS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 13:18:29 -0400
Message-ID: <42EFAAD4.2090506@cs.wisc.edu>
Date: Tue, 02 Aug 2005 12:18:12 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Yusupov <dmitry_yus@yahoo.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       "David S. Miller" <davem@davemloft.net>, itn780@yahoo.com,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [ANNOUNCE 0/7] Open-iSCSI/Linux-iSCSI-5 High-Performance	Initiator
References: <429E15CD.2090202@yahoo.com> <1122744762.5055.10.camel@mulgrave>	 <20050730.125312.78734701.davem@davemloft.net>	 <1122755000.5055.31.camel@mulgrave> <1122758728.13559.4.camel@mylaptop>
In-Reply-To: <1122758728.13559.4.camel@mylaptop>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Yusupov wrote:
> On Sat, 2005-07-30 at 15:23 -0500, James Bottomley wrote:
> 
>>On Sat, 2005-07-30 at 12:53 -0700, David S. Miller wrote:
>>
>>>From: James Bottomley <James.Bottomley@SteelEye.com>
>>>Date: Sat, 30 Jul 2005 12:32:42 -0500
>>>
>>>
>>>>FIB has taken your netlink number, so I changed it to 32
>>>
>>>MAX_LINKS is 32, so there is no way this reassignment would
>>>work.
>>
>>Actually, I saw this and increased MAX_LINKS as well.  I was going to
>>query all of this on the net-dev mailing list if we'd managed to get the
>>code compileable.
>>
>>
>>>You have to pick something in the range 0 --> 32, and as is
>>>no surprise, there are no numbers available :-)
>>>
>>>Since ethertap has been deleted, 16-->31 could be made allocatable
>>>once more, but I simply do not want to do that and have the flood
>>>gates open up for folks allocating random netlink numbers.
>>>
>>>Instead, we need to take one of those netlink numbers, and turn
>>>it into a multiplexable layer that can support an arbitrary
>>>number of sub-netlink types.  Said protocol would need some
>>>shim header that just says the "sub-netlink" protocol number,
>>>something as simple as just a "u32", this gets pulled off the
>>>front of the netlink packet and then it's passed on down to the
>>>real protocol.
>>
>>I'll let the iSCSI people try this ...
>>
>>Alternatively, if they don't fancy it, I think the kobject_uevent
>>mechanism (which already has a netlink number) looks like it might be
>>amenable for use for most of the things they want to do.
> 
> 
> In fact, during design phase we've considered to use kobject_uevent() as
> well but (if i recall correctly), it didn't fit for the simple reason
> that if we want to have that much code in user-space, than we need to
> have more control on netlink socket and need to pass binary data back
> and forth.
> 

I have been trying to modify open-iscsi to use the exisitng
kobject_uevent code similar to how we tried to do this with the old
sfnet driver. Basically there are two problems. As Dimtry described
above, open-iscsi pushes a lot of iSCSI command processing to userspace.
And to accomplish this it must send at least this struct (or a one
similar) to userspace to be processed.

struct iscsi_hdr {
        uint8_t         opcode;
        uint8_t         flags;          /* Final bit */
        uint8_t         rsvd2[2];
        uint8_t         hlength;        /* AHSs total length */
        uint8_t         dlength[3];     /* Data length */
        uint8_t         lun[8];
        __be32          itt;            /* Initiator Task Tag */
        __be32          ttt;            /* Target Task Tag */
        __be32          statsn;
        __be32          exp_statsn;
        uint8_t         other[16];
};

There could also be data as part of the command too thought (like how a
SCSI read or write command has the cdb part and the payload).

For the iscsi_hdr we could encode the values of the fields into strings
and send it back and forth between userspace and the kernel using sysfs
to get the comamnd into the kernel and modifed kobject_uevent functions
(kobject_uevent would need to be modified to be able to take this extra
header info instead of just doing add, remove, etc that are predefined
uevents). This starts to get ulgy though and when you consider that we
still have some payload that also needs to go to userspace it gets uglier.

Also for the sysfs value per file rule, breaking up the iSCSI command
header into a file per field to pass commands into the kernel then using
a binary sysfs file for the data part of the command, and then
reassembling all this in the driver is not so nice. A major advantage
open-iscsi has over sfnet was that it was simple to send all the session
info for session creation and setup and iSCSI command info through a
netlink message.
