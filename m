Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWB1UfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWB1UfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbWB1UfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:35:21 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:37035 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932481AbWB1UfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:35:20 -0500
Date: Tue, 28 Feb 2006 22:38:12 +0200 (EET)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Douglas Gilbert <dougg@torque.net>
cc: Mark Rustad <mrustad@mac.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
In-Reply-To: <4404AA2A.5010703@torque.net>
Message-ID: <Pine.LNX.4.63.0602282216220.6272@kai.makisara.local>
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Douglas Gilbert wrote:

> Mark Rustad wrote:
> > We have encountered some kind of sg regression with kernel 2.6.16-rc5 
> > relative to 2.6.15. We have a small program that demonstrates the 
> > failure. On 2.6.15 it produces the output:
> > 
> > Alloced dataptr 0 -> 0xb7d07008
> > IOS: 0
> > ios 100
> > 
> > indicating that it did 100 operations successfully. On 2.6.16-rc5, it 
> > produces the output:
> > 
> > Alloced dataptr 0 -> 0xa7d10008
> > SG_IO ioctl error 12 Cannot allocate memory
> > ios 0
> > 
> > indicating that it did 0 operations successfully. This program is 
> > attempting to do 1MB reads on a SCSI device.
> 
> Mark,
> You can stop right there with the 1 MB reads. Welcome
> to the new, blander sg driver which now shares many
> size shortcomings with the block subsystem.
> 
> In lk 2.6.15 the sg driver (and the st driver) did its
> own scatter gather list allocations. The sg driver
> used 32 KB segments (8 times the normal page size)
> in each scatter gather element. The maximum number
> of scatter gather elements depends on the LLD but
> can be no more than 256. That meant the sg driver
> allowed a maximum single IO size of 8 MB. There was
> also a define in sg.h (SG_SCATTER_SZ and it is still
> there) that allowed the 32KB per segment to be increased
> allowing larger single command transfers (then 8 MB).
> 
This is still possible but it needs some changes to most SCSI HBA drivers. 
The big requests are split into bios supporting 256 pages. For 4 kB pages, 
this limits i/o to 1 MB. The scsi_execute_async() path used by st and sg 
can chain bios and this enables large request at the ULD level. At lower 
level, the request consists of pages and now we hit the s/g list maximum 
length _unless_ the HBA driver enables clustering. In this case the 
adjacent pages are coalesced and the large requests fit into the HBA s/g 
limits. Well, now we hit another limit: the max_sectors default for SCSI 
drivers is 1024 and this limits requests to 512 kB _unless_ the HBA driver 
increases max_sectors.

The aic79xx driver enables clustering but does not increase max_sectors. 
This makes the maximum request size 512 kB. If it is possible to set

	.max_sectors = 0xFFFF,

in linux/drivers/scsi/aic7xxx/aic79xx_osm.c without breaking the driver, 
this should enable requests up to 8 MB - 256 B. (I don't have the hardware 
to test this.)

Several SCSI HBA drivers currently have similar problems.

>  We get the failure both  on
> > an aic79xx parallel SCSI and on aic94xx SAS. With both types of 
> > devices, it works fine on the 2.6.15 kernel. We have also seen this 
> > problem on the 2.6.16-rc4 kernel. In all cases we were running on an 
> > Intel Xeon-based system.
> 
> Well this is broken by design. If you and others
> talk to the management it may be reversed or a
> better solution may be found.
> 
> Here is an example of the sg driver in lk 2.6.15-rc5.
> The number of bytes each SCSI READ command is trying
> to fetch is 'bs * bpt'. Note that it works for 256 KB
> per SCSI READ but fails for anything bigger:
> 
> # modprobe scsi_debug
> # modprobe sg
> # sg_dd if=/dev/sg0 of=. bs=512 bpt=512
> 16384+0 records in
> 16384+0 records out
> # sg_dd if=/dev/sg0 of=. bs=512 bpt=513
> sg_read failed, try reducing bpt, at or after lba=0 [0x0]
> Some error occurred,  remaining block count=16384
> 0+0 records in
> 0+0 records out
> # sg_dd if=/dev/sg0 of=. bs=512 bpt=1024
> sg_read failed, try reducing bpt, at or after lba=0 [0x0]
> Some error occurred,  remaining block count=16384
> 0+0 records in
> 0+0 records out
> 
I tested this with my SCSI disk and the sym53c8xx_2 driver with the patch 
I sent to linux-scsi recently (enables clustering and sets max_sectors to 
0xFFFF). The 1 MB transfers seem to work:

kai:/data # sg_dd if=/dev/sg0 of=pup bs=512 bpt=2048 count=10240
10240+0 records in
10240+0 records out

-- 
Kai
