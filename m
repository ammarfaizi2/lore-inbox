Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268334AbUHQQz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268334AbUHQQz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUHQQz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:55:26 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:34433 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S268334AbUHQQzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:55:21 -0400
Message-ID: <41223AE0.9020106@shadowconnect.com>
Date: Tue, 17 Aug 2004 19:05:36 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Warren Togami <wtogami@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
References: <411F37CC.3020909@redhat.com> <20040817125303.A21238@infradead.org> <412208A6.7020104@shadowconnect.com> <20040817161742.B22892@infradead.org>
In-Reply-To: <20040817161742.B22892@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Christoph Hellwig wrote:
> On Tue, Aug 17, 2004 at 03:31:18PM +0200, Markus Lidel wrote:
>>>Now to i2o_scsi:
>>> - the logic of "demand-allocating" Scsi_Hosts looks rather bad to me,
>>>   life would be much simpler with a Scsi_Host per i2o device.
>>But wouldn't it be a waste of resources to allocate a Scsi_Host 
>>structure for every I2O device? Note that the i2o_scsi "sees" all disks 
>>even if they are in a RAID array, so in most cases there are at least 3 
>>Scsi_Host adapters...
> I wouldn't wasted ressources but it seems Alan found another problem.

What problem do you mean?

>>We also now know which disk is on which controller, this information is 
>>lost with your approach...
> You could still keep that information in your data structure.  But what
> do you actually need it for?

Okay, it's not that it is crucial, but why should we throw this 
information over board? What will we gain, if we throw it over board, 
and use a single Scsi_Host for each I2O device?

>>> - the slave_configure/i2o_scsi_probe_dev logical is quite horriblebut
>>>   fortunately with the suggestion above it would just go away
>>Yep, i know that it would be better to extend scsi_add_device, so it's 
>>possible to pass a pointer to i2o_scsi_slave_alloc. This is only a 
>>workaround, which breaks as soon as things are done in parallel :-(
> Just keep some lookup data structure so you can find the device data
> by host/target/lun numbers.

We already had this, but we don't need it at all... This structure would 
take unnecessary resources, and what is the benefit? We don't need the 
mapping table after initialization anymore. IMHO it's better to add a 
parameter to scsi_add_device, which will be passed to scsi_slave_alloc 
afterwords, or do it the same way like the Scsi_Host structure...

>>> - the global list of hosts and wlaking it on exit is a very bad design,
>>>   that's something the ->remove callback should do on per-device basis
>>But what if the I2O device isn't removed?
> you're using the driver model, and that calls ->remove and every device
> when the driver is unregistered.

Okay, i don't remember why i added this, but i will try to get rid of it 
  if it is possible (i agree with you, that it is ugly)...

> Okay, some brainstorming to get the data structures and lookup right:
> 
> What really seems to miss in your model is a callback to i2o_scsi
> from the main i2o code when a new i2o_controller is found, if you implemented
> that we'd allocate/deallocate the Scsi_Host in that callback and
> ->probe/->remove could be sure it'd always have it.

Okay, sounds very good to me! This also solves the problem, when a new 
controller is added at runtime :-)

I'll look at the PCI driver to do it the same way...

> Anyway, I think we could live without that.
> i2o_scsi_get_host would get inlined into i2o_scsi_probe.
> i2o_scsi_remove basically needs a full rewrite, you need to find a way
> to store a scsi_device ini i2o_dev and it becomes completely trivial.

Okay, will look at it...

Thanks again for your help!



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
