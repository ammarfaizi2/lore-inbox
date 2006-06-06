Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWFFSHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWFFSHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750858AbWFFSHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:07:10 -0400
Received: from rtr.ca ([64.26.128.89]:8103 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750851AbWFFSHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:07:08 -0400
Message-ID: <4485C446.2040203@rtr.ca>
Date: Tue, 06 Jun 2006 14:07:02 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: usb device problem
References: <44859A9B.6080202@gmail.com> <4485A299.7070007@rtr.ca> <4485A855.1020602@gmail.com>
In-Reply-To: <4485A855.1020602@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Mark Lord napsal(a):
>> Jiri Slaby wrote:
>>> Hello,
>>>
>>> I get this with 2.6.17-rc5-mm3 kernel:
>> ..
>>> usb-storage: device found at 10
>>> usb-storage: waiting for device to settle before scanning
>>>   Vendor:           Model:                   Rev:
>>>   Type:   Direct-Access                      ANSI SCSI revision: 00
>>> SCSI device sdb: 245920 512-byte hdwr sectors (126 MB)
>> ..
>>> now read and write and sync or umount, then:
>>> ---
>>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>>> end_request: I/O error, dev sdb, sector 1575
>>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>>> end_request: I/O error, dev sdb, sector 1583
>>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>>> end_request: I/O error, dev sdb, sector 1591
>>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>>> end_request: I/O error, dev sdb, sector 1599
>>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>>> end_request: I/O error, dev sdb, sector 1607
>>> sd 10:0:0:0: SCSI error: return code = 0x10070000
>>> end_request: I/O error, dev sdb, sector 1615
>>> ... and so on. data are maybe there, but it takes so long to write a
>>> meg file.
>>> sometimes
>> ..
>>
>> This *looks* like maybe the drive reported a sector read error,
>> and the standard "fail the whole request one block at a time"
>> error mechanism from sd.c has kicked in.
> 
> Do you mean something like seek error, i.e. error in hardware, or how to call
> this? This is brand new minisd card, it is possible to be waster, but it's
> rather something bad in the software (writing by the device itself is perfomed
> and data are ok). The error occurs accurately every 8 sectors...

The "every 8 sectors" corresponds to the Linux page size (32-bit) of 4KBytes,
which is the basic block I/O unit in real life.

The 0x1007000 is broken down as:

07 == "host byte"   = DID_ERROR = "internal error"
10 == "driver byte" = SUGGEST_RETRY

So it could just be some kind of internal soft error within the device driver.
The messages certainly lack end-user clarity, though.

>> I have a patch to fix this behaviour (in sd.c), but it has not yet
>> been decided whether to go upstream with it or not.
> 
> Could you post me a copy, please?

Probably tomorrow.  I haven't ported it forward yet (from a much older kernel).
But I don't think it will help here now, as these errors
don't really look like bad media -- gotta look inside the usb-storage code to find out.

Cheers

