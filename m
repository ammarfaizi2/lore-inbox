Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUAGPff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266200AbUAGPff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:35:35 -0500
Received: from cliff.cse.wustl.edu ([128.252.166.5]:7837 "EHLO
	cliff.cse.wustl.edu") by vger.kernel.org with ESMTP id S265612AbUAGPfX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:35:23 -0500
From: Berkley Shands <berkley@cs.wustl.edu>
Date: Wed, 7 Jan 2004 09:35:18 -0600 (CST)
Message-Id: <200401071535.i07FZIX0000020986@mudpuddle.cs.wustl.edu>
To: gibbs@scsiguy.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, pbadari@us.ibm.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple map/unmaps
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Running with the force segment merge OFF panics the processor after
about 1000 scsi retries. the error given, also in pci-gart.c, is
pci_map_area overflow 4096 bytes
So a brain dead repair kills the kernel. Someone clearly needs to figure
out where to correct the merge of the sg lists. A bit of doc on the iommu
and the 4096 byte limit would be nice too :-)

I see that is is the aborting of an SCB that causes the sg list halt.

Jan  7 09:18:32 typhoon kernel: DevQ(0:6:0): 0 waiting
Jan  7 09:18:32 typhoon kernel: (scsi0:A:2:0): SCB 0x46 - timed out
Jan  7 09:18:32 typhoon kernel: Recovery SCB completes
Jan  7 09:18:32 typhoon kernel: scsi0: Issued Channel A Bus Reset. 3 SCBs aborted
Jan  7 09:18:46 typhoon kernel: Did it again, boss 0000:01:03.0

Since the sg list merges into one i/o list, simply adding s->length = 4096
back into the list seems to keep the kernel up. a better if slightly less
stupid fix is to add up the remaining sg list lengths, and ajust
the sg[0] entry to sum to the correct value.

/*   		BUG_ON(s->length == 0); */
if (! s->length)
   {
   unsigned long zero = sg[0].length;
   unsigned long remain = 0;
   int t = 0;
   
   BUG_ON(i != 1);		/* some other error here */
   
   for (t = i + 1; t < nents; t++)
      remain += sg[t].length;	/* collect remaining sizes */
   zero -= remain;		/* deduct what is left on the list */
   sg[0].length = zero / 2;
   sg[1].length = zero / 2;	/* allocate uniformly */
   size = zero / 2;		/* reduce oversize first entry */
   printk(KERN_WARNING "Did it again, boss %s\n", dev->slot_name);
   }

The better solution is to have the upper layer fix the sg list, or
have some marker that the list was diddled, and save the old entries
to put it back.

berkley
