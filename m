Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVEKSW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVEKSW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVEKSW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:22:27 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:62600 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262000AbVEKSVX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:21:23 -0400
X-IronPort-AV: i="3.93,96,1115010000"; 
   d="scan'208"; a="260354112:sNHT24673496"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
Date: Wed, 11 May 2005 13:21:19 -0500
Message-ID: <367215741E167A4CA813C8F12CE0143B3ED37A@ausx2kmpc115.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
Thread-Index: AcVVvDgkGZhMd1qTRJSrHK1/Ha3AHgAju3ow
From: <Abhay_Salunke@Dell.com>
To: <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <Matt_Domsch@Dell.com>, <greg@kroah.com>
X-OriginalArrivalTime: 11 May 2005 18:21:19.0762 (UTC) FILETIME=[3A717F20:01C55656]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +
> > +			/* free this memory as we need it with in 4GB
range */
> > +			free_pages ((unsigned long)pbuf, *ordernum);
> > +
> > +			/* try allocating a new buffer from the GFP_DMA
range
> > +			   as it is with in 16MB range.*/
> > +			pbuf =(unsigned char *)__get_free_pages(GFP_DMA,
> *ordernum);
> > +
> > +			if (pbuf == NULL)
> > +				pr_debug("Failed to get memory of size
%ld using
> GFP_DMA\n", size);
> > +		}
> > +	}
> > +	return pbuf;
> > +}
> 
> What architecture is this code designed for?  On x86 a GFP_KERNEL
> allocation will never return highmem.  I guess x86_64?
> 
> I assume this code is here because the x86_64 BIOS will only access
the
> lower 4GB?  If so, a comment to that extent would be useful.
> 
> Sometime I expect that x86_64 will gain a new zone, GFP_DMA32 which
will
> be
> guaranteed to return memory below he 4GB point.  When that happens,
this
> driver should be converted to use it.
> 
This code is for all architectures but primarily is tested on x32, x64
and x86_64.

> > +	newpacket->ordernum = ordernum;
> > +
> > +	++rbu_data.num_packets;
> > +	/* initialize the newly created packet headers */
> > +	INIT_LIST_HEAD(&newpacket->list);
> > +	/* add this packet to the link list */
> > +	list_add_tail(&newpacket->list, (struct list_head
> *)&packet_data_head);
> 
> Does this list not need locking?

 create_packet is called from packetize_data which is called with lock
held.
 Will add a comment in create_packet. 

> > +/*
> > + img_update_free:
> > + Frees the buffer allocated for storing BIOS image
> > + Always called with lock held
> > +*/
> > +static void img_update_free( void)
> 
>    static void img_update_free(void)
> 
> > +{
> > +	if (rbu_data.image_update_buffer == NULL)
> > +		return;
> 
> Can this happen?
Yes, incase some one did an rmmod immediately after an insmod (without
actually updating any BIOS image)
 
> 
> > +	rbu_data.image_update_buffer = NULL;
> > +	rbu_data.image_update_buffer_size = 0;
> > +	rbu_data.bios_image_size = 0;
> > +}
> 
> Are these assignments needed?
Yes, all the variables needs to be re-initialized after calling
free_pages.

> 
> > +static int img_update_realloc(unsigned long size)
> > +{
> > +	unsigned char *image_update_buffer = NULL;
> > +	unsigned long rc;
> > +	int ordernum =0;
> > +
> > +
> > +	/* check if the buffer of sufficient size has been already
allocated
> */
> > +    if (rbu_data.image_update_buffer_size >= size) {
> > +		/* check for corruption */
> > +		if ((size != 0) && (rbu_data.image_update_buffer ==
NULL)) {
> > +			pr_debug("img_update_realloc: corruption check
> failed\n");
> > +			return -ENOMEM;
> 
> ENOMEM seems to be the wrong error to return here.
Changed to EINVAL.

> Should this feature be available for all architectures, or only for
X86 ||
> X86_64?  (If it compiles OK for other architectures then I'd leave it
> as-is, for coverage).
> 
It supports all architectures.

All the other recommended changed are being worked out and I will
resubmit the patch with the changes.

Thanks,
Abhay Salunke
Software Engineer
Dell Inc.
