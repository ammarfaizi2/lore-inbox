Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSFXMlZ>; Mon, 24 Jun 2002 08:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSFXMlY>; Mon, 24 Jun 2002 08:41:24 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:65442 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S313087AbSFXMlX>; Mon, 24 Jun 2002 08:41:23 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 24 Jun 2002 04:42:45 -0700
Message-Id: <200206241142.EAA04136@adam.yggdrasil.com>
To: davem@redhat.com
Subject: Re: RFC: turn scatterlist into a linked list, eliminate bio_vec
Cc: akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: "David S. Miller" <davem@redhat.com>
>Date: Sun, 23 Jun 2002 23:24:16 -0700 (PDT)

>>  	/* Let's assume the new pci_map_sg will free unused scatterlists. */
>>  	while (sg != NULL && count--) {
>>  		sg->driver_priv = mempool_alloc(q->sgpriv_pool, GFP_KERNEL);
>>  
>>  		sg->driver_priv_dma =
>>  			pci_map_single(req->dma_map_dev, sg->driver_priv, len,
>>  				       PCI_DMA_TODEVICE);
>>  			if (sg_dma->dma_add_priv == 0);
>>  				failed = fail_value;
>>  		}
>>  	}

>Driver descriptors are not supposed to be done using pci_map_*()
>and friends.  You are supposed to use consistent DMA memory for
>this purpose.  Please read DMA-mapping.txt a few more times Adam :-)

	Sorry if I was not clear enough about the purpose of of
the new scatterlist->driver_priv field.  It is a "streaming" data
structure to use the terminology of DMA-maping.txt (i.e., one that
would typically only be allocated for a few microseconds as an IO is
built up and sent).  Its purpose is to hold the hardware-specific
gather-scatter segment descriptor, which typically look something like this:

		struct foo_corporation_scsi_controller_sg_element {
			u64	data_addr;
			u64	next_addr;
			u16	data_len;
			u16	reserved;
			u32	various_flags;
		}
		
	I probably should not have mentioned adding sg->driver_priv{,_dma}
in my proposal, because it is largely independent.  The reason that
it is related is that it should allow the "mid-layer" device driver code
(scsi.c, usb.c, etc.) to do all of the streaming DMA mapping for
typical DMA-based device drivers.

	Come to think of it, my use of pci_map_single is incorrect
after all, because the driver has not yet filled in that data structure
at that point.  Since the data structures are being allocated from a
single contiguous block that spans a couple of pages that is being used
only for this purpose, perhaps I would be fastest to pci_alloc_consistent
the whole memory pool for those little descriptors at initialization time
and then change that loop to do the following.

		sg->driver_priv = mempool_alloc(q->sgpriv_pol, GFP_KERNEL);
		sg->driver_priv_dma = (sg->driver_priv - q->driver_priv_start)+
				sg->driver_priv_start_dma_addr;


>Also, this while loop never terminates :-)

	Oops!  Sorry.  The bottom of that loop needs

		sg = sg->next;



Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
