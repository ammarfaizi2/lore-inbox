Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUAGTWa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265618AbUAGTWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:22:30 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:6889 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265552AbUAGTWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:22:24 -0500
Message-ID: <3FFC5BD2.F995A824@us.ibm.com>
Date: Wed, 07 Jan 2004 11:19:46 -0800
From: badari <pbadari@us.ibm.com>
Organization: IBM
X-Mailer: Mozilla 4.72 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Berkley Shands <berkley@cs.wustl.edu>
CC: gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple map/unmaps
References: <200401071535.i07FZIX0000020986@mudpuddle.cs.wustl.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Andi Kleen reworked pci-gart code.
Would you try Andi's x86-64 patch and see if the problems still exist ?

ftp://ftp.x86-64.org/pub/linux/v2.6/x86_64-2.6.1rc2-1.bz2

And also, Can you try with "iommu=noforce,nomerge" ?

Fixing the sg-list in the upperlayer (by re-creating) it in case of retry
worked for me. I am still not sure why you are running into "len==0"
panics.

Thanks,
Badari

Berkley Shands wrote:

>         Running with the force segment merge OFF panics the processor after
> about 1000 scsi retries. the error given, also in pci-gart.c, is
> pci_map_area overflow 4096 bytes
> So a brain dead repair kills the kernel. Someone clearly needs to figure
> out where to correct the merge of the sg lists. A bit of doc on the iommu
> and the 4096 byte limit would be nice too :-)
>
> I see that is is the aborting of an SCB that causes the sg list halt.
>
> Jan  7 09:18:32 typhoon kernel: DevQ(0:6:0): 0 waiting
> Jan  7 09:18:32 typhoon kernel: (scsi0:A:2:0): SCB 0x46 - timed out
> Jan  7 09:18:32 typhoon kernel: Recovery SCB completes
> Jan  7 09:18:32 typhoon kernel: scsi0: Issued Channel A Bus Reset. 3 SCBs aborted
> Jan  7 09:18:46 typhoon kernel: Did it again, boss 0000:01:03.0
>
> Since the sg list merges into one i/o list, simply adding s->length = 4096
> back into the list seems to keep the kernel up. a better if slightly less
> stupid fix is to add up the remaining sg list lengths, and ajust
> the sg[0] entry to sum to the correct value.
>
> /*              BUG_ON(s->length == 0); */
> if (! s->length)
>    {
>    unsigned long zero = sg[0].length;
>    unsigned long remain = 0;
>    int t = 0;
>
>    BUG_ON(i != 1);              /* some other error here */
>
>    for (t = i + 1; t < nents; t++)
>       remain += sg[t].length;   /* collect remaining sizes */
>    zero -= remain;              /* deduct what is left on the list */
>    sg[0].length = zero / 2;
>    sg[1].length = zero / 2;     /* allocate uniformly */
>    size = zero / 2;             /* reduce oversize first entry */
>    printk(KERN_WARNING "Did it again, boss %s\n", dev->slot_name);
>    }
>
> The better solution is to have the upper layer fix the sg list, or
> have some marker that the list was diddled, and save the old entries
> to put it back.
>
> berkley

