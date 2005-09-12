Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVILUIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVILUIS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbVILUIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:08:18 -0400
Received: from magic.adaptec.com ([216.52.22.17]:21638 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932187AbVILUIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:08:17 -0400
Message-ID: <4325E02A.1060400@adaptec.com>
Date: Mon, 12 Sep 2005 16:08:10 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>, ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com> <1126368081.4813.46.camel@mulgrave> <4325997D.3050103@adaptec.com> <20050912162739.GA11455@us.ibm.com>
In-Reply-To: <20050912162739.GA11455@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 20:08:16.0115 (UTC) FILETIME=[B61C4430:01C5B7D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/05 12:27, Patrick Mansfield wrote:
> On Mon, Sep 12, 2005 at 11:06:37AM -0400, Luben Tuikov wrote:
> 
> 
>>>We have an infrastructure in the mid-layer for doing report lun scans.
>>>You have a parallel one in your code.  In my book, that's duplication.
>>
>>This infrastructure is broken.  Its interface is broken.  It is a horrible
>>excuse of LUN scanning written initially to support a certain hardware.
> 
> 
> That is not true of the report lun support, it was written initially for
> support of any hardware. Of course it was tested on certain hardware, but
> that was not the goal.

Hi Patrick,

The intention was very noble, I agree.

However the representation (not necessarily your code) falls
short to represent actual entities of the SCSI domain.

Curiously, I know you'll appreciate this, take a look in the
SAS code how LU "scanning" is done, only via REPORT LUN,
and the _survivability_ of that code, that is if all else
fails, assume LU 0 exists. (that is, we're optimistic)

Yes, there is a need for LU "scanning" of braindead devices,
in older protocols, but in SAS, I really *do not expect devices*
to support more than one LU and _not_ to support REPORT LUNS.

>>And secondly, the routine which I've written is NOT duplication.
>>It is the _correct_ way to do it, while the one in SCSI Core
>>is *crap*, thus there is no duplication.
> 
> 
> What is wrong with the one in scsi core?

Representation + see above.

> Your implementation has problems for large numbers of LU the secondary
> kmalloc() will always fail. I do not see how it handles transient failures

How large? More than 16384?  Yes, but this is limited by kmalloc(),
_not_ by the code.

While SCSI Core's lun scan is limited by 1. kmalloc() and
2. by a module parameter.

> either, or (per below discussion) devices that return bogus data.

Ah, yes, I've not seen any such SAS device.  If you know of one,
please let me know.

Also, it is well known the tricks and games storage vendors
did in order to support more than one LUN for their devices.
SCSI Core's LU scanning is a _product_ of this.

Most importantly it is the representation of storage objects.
SCSI Core is very SPI centric.

>>I've run this code on pre-pre-pre-.... firmware and it handles
>>really broken REPORT LUNS devices.  It works *without the need* for
>>a blacklist lookup table.
> 
> 
> There could (will?) be bridges from SAS to anything (like existing SPI to
> IDE bridges, or FC to SPI bridges), so it is likely it will have to
> handle not-so-new and potentially brain dead storage devices.

It will be cheaper to get new hardware and copy over data
than build such bridges.  This will be dictated by the consumer.

>>Second, I did ask for REPORT LUNS mechanism into SCSI Core before it
>>was there.
> 
> That code was not written because anyone asked for it.

Yes, I'm not saying otherwise.

> At least tell us what is wrong with it, I know it does not have well known
> LUN support, and we already know about 8 byte LUN support.

Plus the representation of the storage objects.

You want to send REPORT LUNS to the domain device (whichever device
server it goes to by default), not to an HCIL tuple.

> IMO adding well known LUNs at this point to the standard added nothing of
> value, the target firmware has to check for special paths no matter what,
> adding a well known LUN does not change that. And most vendors will
> (likely) have support for use without a well known LUN. (This does not
> mean we should not support it in linux, I just don't know why this went
> into the standard.)
> 
> Using well known LUNs will be another code path that will have to live
> alongside existing ones, and will likely require further black listing
> (similar to REPORT LUN vs scanning for LUNs).

And as you can see in the SAS code there is no blacklisting -- just
probing and surviving.  Devices who do not support REPORT LUNS, but
have a device server on LU 0, work fine with that code.

	Luben



