Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUHQNSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUHQNSQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268222AbUHQNSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:18:16 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:29834 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S266218AbUHQNSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:18:02 -0400
Message-ID: <412208A6.7020104@shadowconnect.com>
Date: Tue, 17 Aug 2004 15:31:18 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Warren Togami <wtogami@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
References: <411F37CC.3020909@redhat.com> <20040817125303.A21238@infradead.org>
In-Reply-To: <20040817125303.A21238@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Christoph Hellwig wrote:
> On Sun, Aug 15, 2004 at 12:15:40AM -1000, Warren Togami wrote:
>>This is a request to please merge the I2O patches currently in Andrew 
>>Morton's -mm tree into the mainline kernel.  They resolve all known 
>>reported issues with I2O RAID devices.  If they can be included soon, it 
>>would be possible to implement and test direct installation before FC3 
>>Test2 freeze.
> I've looked over it and except for the i2o_scsi driver it looks sane.
> Cosmetic fixups I'd like to see done befoee merging to mainline:
>  - run the code through Lindent

Okay, will do it...

>  - stop the needless file renaming.  Splitting up i2o_core.c into multiple
>    files is fine, but please don' rename the other drivers for the sake of
>    it

just wanted to be consistent with the other files, but it shouldn't be a 
problem to rename them to the original name...

> Now to i2o_scsi:
>  - the logic of "demand-allocating" Scsi_Hosts looks rather bad to me,
>    life would be much simpler with a Scsi_Host per i2o device.

But wouldn't it be a waste of resources to allocate a Scsi_Host 
structure for every I2O device? Note that the i2o_scsi "sees" all disks 
even if they are in a RAID array, so in most cases there are at least 3 
Scsi_Host adapters...

We also now know which disk is on which controller, this information is 
lost with your approach...

>  - the slave_configure/i2o_scsi_probe_dev logical is quite horriblebut
>    fortunately with the suggestion above it would just go away

Yep, i know that it would be better to extend scsi_add_device, so it's 
possible to pass a pointer to i2o_scsi_slave_alloc. This is only a 
workaround, which breaks as soon as things are done in parallel :-(

>  - the global list of hosts and wlaking it on exit is a very bad design,
>    that's something the ->remove callback should do on per-device basis

But what if the I2O device isn't removed?

>  - the completely lack of SCSI EH in this driver scares me, does the firmware
>    really handle all EH?

The i2o_scsi driver is not used to access the disks, it is only for 
monitoring. The i2o_block driver handles disk access. So if you reset 
the SCSI channel in the i2o_scsi driver, commands which are transfered 
by the i2o_block driver will be aborted (this is the reason, why the I2O 
subsystem didn't work for users, which compiled in i2o_scsi and 
i2o_block into the kernel)...

> cosemtic stuff in here:
>  - <asm/*.h> after <linux/*.h>.
>  - please include scsi headers using <scsi/*.h> (after linux and asm headers)
>  - please use the standard pr_Debug instead of DBG

This is what i searched for the whole time :-) Thanks for the hint!

>  - please reorder the functions a little so you don't need forward-declarations

most of the forward-declarations are not needed at all, should i remove 
unneeded completely?


Thanks for taking time to review my changes!


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
