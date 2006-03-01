Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWCACL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWCACL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932651AbWCACL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:11:58 -0500
Received: from smtpout.mac.com ([17.250.248.89]:44014 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932648AbWCACL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:11:57 -0500
X-PGP-Universal: processed;
	by AlPB on Tue, 28 Feb 2006 20:11:42 -0600
In-Reply-To: <Pine.LNX.4.63.0602282216220.6272@kai.makisara.local>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <Pine.LNX.4.63.0602282216220.6272@kai.makisara.local>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4DF08E5C-8503-4EEE-AD96-2F847674080D@mac.com>
Cc: Douglas Gilbert <dougg@torque.net>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Mark Rustad <mrustad@mac.com>
Subject: Re: sg regression in 2.6.16-rc5
Date: Tue, 28 Feb 2006 20:08:19 -0600
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 28, 2006, at 2:38 PM, Kai Makisara wrote:

> On Tue, 28 Feb 2006, Douglas Gilbert wrote:
>
>> Mark,
>> You can stop right there with the 1 MB reads. Welcome
>> to the new, blander sg driver which now shares many
>> size shortcomings with the block subsystem.
>>
>> In lk 2.6.15 the sg driver (and the st driver) did its
>> own scatter gather list allocations. The sg driver
>> used 32 KB segments (8 times the normal page size)
>> in each scatter gather element. The maximum number
>> of scatter gather elements depends on the LLD but
>> can be no more than 256. That meant the sg driver
>> allowed a maximum single IO size of 8 MB. There was
>> also a define in sg.h (SG_SCATTER_SZ and it is still
>> there) that allowed the 32KB per segment to be increased
>> allowing larger single command transfers (then 8 MB).
>
> This is still possible but it needs some changes to most SCSI HBA  
> drivers.
> The big requests are split into bios supporting 256 pages. For 4 kB  
> pages,
> this limits i/o to 1 MB. The scsi_execute_async() path used by st  
> and sg
> can chain bios and this enables large request at the ULD level. At  
> lower
> level, the request consists of pages and now we hit the s/g list  
> maximum
> length _unless_ the HBA driver enables clustering. In this case the
> adjacent pages are coalesced and the large requests fit into the  
> HBA s/g
> limits. Well, now we hit another limit: the max_sectors default for  
> SCSI
> drivers is 1024 and this limits requests to 512 kB _unless_ the HBA  
> driver
> increases max_sectors.
>
> The aic79xx driver enables clustering but does not increase  
> max_sectors.
> This makes the maximum request size 512 kB. If it is possible to set
>
> 	.max_sectors = 0xFFFF,
>
> in linux/drivers/scsi/aic7xxx/aic79xx_osm.c without breaking the  
> driver,
> this should enable requests up to 8 MB - 256 B. (I don't have the  
> hardware
> to test this.)

Indeed, this seems to work fine, at least with the hardware we have.  
Gotta love those one-line patches.

> Several SCSI HBA drivers currently have similar problems.

Yes. Now that I know about this, it is no problem. I'm not allergic  
to patches.

Thanks to both of you for your responses. I would submit a patch for  
this except that I know I don't know that it won't cause problems for  
configurations and targets that I can't test.

-- 
Mark Rustad, MRustad@mac.com

