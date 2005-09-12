Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVILWja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVILWja (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbVILWj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:39:29 -0400
Received: from magic.adaptec.com ([216.52.22.17]:47785 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750876AbVILWj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:39:29 -0400
Message-ID: <43260399.3000405@adaptec.com>
Date: Mon, 12 Sep 2005 18:39:21 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
 (end devices)
References: <1126308304.4799.45.camel@mulgrave> <20050910024454.20602.qmail@web51613.mail.yahoo.com> <20050911094656.GC5429@infradead.org>
In-Reply-To: <20050911094656.GC5429@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2005 22:39:27.0582 (UTC) FILETIME=[D52047E0:01C5B7EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/05 05:46, Christoph Hellwig wrote:
> On Fri, Sep 09, 2005 at 07:44:54PM -0700, Luben Tuikov wrote:
> 
>>>this one completely duplicates the
>>>mid-layer infrastructure for handling devices with Logical Units.
>>
>>No, it does *not*.  James, you have _stop_ spreading FUD, relying
>>that other people have not read the SCSI Core code.
>>
>>See here:
>>    SCSI Core has *no representation* of a SCSI Device with a
>>SCSI Target Port.
> 
> 
> struct scsi_target
> 
> 
>>I've _clearly_ outlined that in the comments of the code,
>>which you _conveniently_ did _not_ cut and paste here.
> 
> 
>  * Discover logical units present in the SCSI device.  I'd like this
>  * to be moved to SCSI Core, but SCSI Core has no concept of a "SCSI
>  * device with a SCSI Target port".  A SCSI device with a SCSI Target
>  * port is a device which the _transport_ found, but other than that,
>  * the transport has little or _no_ knowledge about the device.
>  * Ideally, a LLDD would register a "SCSI device with a SCSI Target
>  * port" with SCSI Core and then SCSI Core would do LU discovery of
>  * that device.
> 
> So what does this mean except "Luben tries to impress everyone with
> standards gibberish, at the same time ignoring we soluitions that
> work despite maybe not 100% elegant".

Yes, that "maybe not 100% elegant" is what makes code survive
long years, being maintainable and not spaghetti like (as new
functionality is added).

> Sure, we'd like to move away from needing the ->id target id specifier.
> But right now we need it, even you're code sets it in over-complicated

It is not "over-complicated".  The functionality which is there Christoph,
is there for a reason.  Mainly this is experience and knowlege, but
you canot _shortcut_ code, since you're eliminating an abstraction
layer: one thing is done at a time at a logical layer.  When
all tasks are done at a logical layer, then we move onto the next.

E.g. an SES device may want to do something before you transition
from one stage to the next, to all devices on the same level as
that SES device. (This is a topic for another thread, no intentions
to mention it.)

> ways.  But if you send a nice patch to get rid everyone will be happy.

You and I share the same passion: to improve SCSI Core.

I'm not sure that a patch to get rid of id in the current SCSI Core
is quite possible without major heart-attacks of quite a few
LLDDs, etc.

Instead, maybe, we should write a few new functions in SCSI Core which
could accomodate new, improved "standards gibberish" as you call
it, behaviour.

Newer code would use those new functions.  Older one, would use
old ones.

As SPI is slowly dying away, there'd be less and less need and support
for the current SCSI Core, and the "new" one will emerge.  Granted,
in the beginning that "new" one would be one or two functions, but
a start nevertheless.

E.g. create a new scsi_domain_device structure and just move
sas_do_lu_discovery(struct domain_device *) into SCSI Core
as scsi_do_lu_discovery(struct scsi_domain_device *).

Note the declaration of this new function: the decision to call
it is done by the transport _layer_ since it knows whether a
target port is supported or not.  Then it will send a task
to the scsi_domain_device, which the LLDD knows how to
address.  Etc.

	Luben

