Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWCACGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWCACGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWCACGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:06:30 -0500
Received: from canuck.infradead.org ([205.233.218.70]:43932 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932651AbWCACG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:06:29 -0500
Message-ID: <4405013D.1050407@torque.net>
Date: Tue, 28 Feb 2006 21:04:45 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
CC: Mark Rustad <mrustad@mac.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <Pine.LNX.4.63.0602282216220.6272@kai.makisara.local>
In-Reply-To: <Pine.LNX.4.63.0602282216220.6272@kai.makisara.local>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Makisara wrote:
> On Tue, 28 Feb 2006, Douglas Gilbert wrote:
> 
> 
>>Mark Rustad wrote:
>>
>>>We have encountered some kind of sg regression with kernel 2.6.16-rc5 
>>>relative to 2.6.15. We have a small program that demonstrates the 
>>>failure. On 2.6.15 it produces the output:
>>>
>>>Alloced dataptr 0 -> 0xb7d07008
>>>IOS: 0
>>>ios 100
>>>
>>>indicating that it did 100 operations successfully. On 2.6.16-rc5, it 
>>>produces the output:
>>>
>>>Alloced dataptr 0 -> 0xa7d10008
>>>SG_IO ioctl error 12 Cannot allocate memory
>>>ios 0
>>>
>>>indicating that it did 0 operations successfully. This program is 
>>>attempting to do 1MB reads on a SCSI device.
>>
>>Mark,
>>You can stop right there with the 1 MB reads. Welcome
>>to the new, blander sg driver which now shares many
>>size shortcomings with the block subsystem.
>>
>>In lk 2.6.15 the sg driver (and the st driver) did its
>>own scatter gather list allocations. The sg driver
>>used 32 KB segments (8 times the normal page size)
>>in each scatter gather element. The maximum number
>>of scatter gather elements depends on the LLD but
>>can be no more than 256. That meant the sg driver
>>allowed a maximum single IO size of 8 MB. There was
>>also a define in sg.h (SG_SCATTER_SZ and it is still
>>there) that allowed the 32KB per segment to be increased
>>allowing larger single command transfers (then 8 MB).
>>
> 
> This is still possible but it needs some changes to most SCSI HBA drivers. 
> The big requests are split into bios supporting 256 pages. For 4 kB pages, 
> this limits i/o to 1 MB. The scsi_execute_async() path used by st and sg 
> can chain bios and this enables large request at the ULD level. At lower 
> level, the request consists of pages and now we hit the s/g list maximum 
> length _unless_ the HBA driver enables clustering. In this case the 
> adjacent pages are coalesced and the large requests fit into the HBA s/g 
> limits. Well, now we hit another limit: the max_sectors default for SCSI 
> drivers is 1024 and this limits requests to 512 kB _unless_ the HBA driver 
> increases max_sectors.
> 
> The aic79xx driver enables clustering but does not increase max_sectors. 
> This makes the maximum request size 512 kB. If it is possible to set
> 
> 	.max_sectors = 0xFFFF,
> 
> in linux/drivers/scsi/aic7xxx/aic79xx_osm.c without breaking the driver, 
> this should enable requests up to 8 MB - 256 B. (I don't have the hardware 
> to test this.)
> 
> Several SCSI HBA drivers currently have similar problems.

Kai,
I applied the above changes to my scsi_debug (plus
extended .sg_tablesize to SG_ALL (it was 64)) and
my single command READs topped out at 4 MB exactly
(bs=512 bpt=8192). When I tried bpt=8193 the
SG_IO ioctl (via a sg device) yielded ENOMEM which
is much more informative than EIO.

That is an improvement.

Doug Gilbert
