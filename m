Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWB1TyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWB1TyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 14:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932538AbWB1TyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 14:54:17 -0500
Received: from canuck.infradead.org ([205.233.218.70]:64184 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S932476AbWB1TyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 14:54:16 -0500
Message-ID: <4404AA2A.5010703@torque.net>
Date: Tue, 28 Feb 2006 14:53:14 -0500
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Rustad <mrustad@mac.com>
CC: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com>
In-Reply-To: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rustad wrote:
> We have encountered some kind of sg regression with kernel 2.6.16-rc5 
> relative to 2.6.15. We have a small program that demonstrates the 
> failure. On 2.6.15 it produces the output:
> 
> Alloced dataptr 0 -> 0xb7d07008
> IOS: 0
> ios 100
> 
> indicating that it did 100 operations successfully. On 2.6.16-rc5, it 
> produces the output:
> 
> Alloced dataptr 0 -> 0xa7d10008
> SG_IO ioctl error 12 Cannot allocate memory
> ios 0
> 
> indicating that it did 0 operations successfully. This program is 
> attempting to do 1MB reads on a SCSI device.

Mark,
You can stop right there with the 1 MB reads. Welcome
to the new, blander sg driver which now shares many
size shortcomings with the block subsystem.

In lk 2.6.15 the sg driver (and the st driver) did its
own scatter gather list allocations. The sg driver
used 32 KB segments (8 times the normal page size)
in each scatter gather element. The maximum number
of scatter gather elements depends on the LLD but
can be no more than 256. That meant the sg driver
allowed a maximum single IO size of 8 MB. There was
also a define in sg.h (SG_SCATTER_SZ and it is still
there) that allowed the 32KB per segment to be increased
allowing larger single command transfers (then 8 MB).

 We get the failure both  on
> an aic79xx parallel SCSI and on aic94xx SAS. With both types of 
> devices, it works fine on the 2.6.15 kernel. We have also seen this 
> problem on the 2.6.16-rc4 kernel. In all cases we were running on an 
> Intel Xeon-based system.

Well this is broken by design. If you and others
talk to the management it may be reversed or a
better solution may be found.

Here is an example of the sg driver in lk 2.6.15-rc5.
The number of bytes each SCSI READ command is trying
to fetch is 'bs * bpt'. Note that it works for 256 KB
per SCSI READ but fails for anything bigger:

# modprobe scsi_debug
# modprobe sg
# sg_dd if=/dev/sg0 of=. bs=512 bpt=512
16384+0 records in
16384+0 records out
# sg_dd if=/dev/sg0 of=. bs=512 bpt=513
sg_read failed, try reducing bpt, at or after lba=0 [0x0]
Some error occurred,  remaining block count=16384
0+0 records in
0+0 records out
# sg_dd if=/dev/sg0 of=. bs=512 bpt=1024
sg_read failed, try reducing bpt, at or after lba=0 [0x0]
Some error occurred,  remaining block count=16384
0+0 records in
0+0 records out


Doug Gilbert
