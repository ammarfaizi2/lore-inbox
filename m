Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269280AbRGaM0J>; Tue, 31 Jul 2001 08:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269281AbRGaM0D>; Tue, 31 Jul 2001 08:26:03 -0400
Received: from [209.226.93.226] ([209.226.93.226]:20473 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269278AbRGaMZu>; Tue, 31 Jul 2001 08:25:50 -0400
Date: Tue, 31 Jul 2001 08:25:45 -0400
Message-Id: <200107311225.f6VCPj003249@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: jeremy@classic.engr.sgi.com (Jeremy Higdon)
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
In-Reply-To: <10107310041.ZM233282@classic.engr.sgi.com>
In-Reply-To: <200107310030.f6V0UeJ13558@mobilix.ras.ucalgary.ca>
	<rgooch@ras.ucalgary.ca>
	<10107310041.ZM233282@classic.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Jeremy Higdon writes:
> With the sard patch and a 64 bit system, you start having
> trouble at around 103 configured disks, because of the following

So even without my patch, sard doesn't support the previous limit of
128 devices.

> line in sd_init() (sd.c), because kmalloc doesn't like allocating
> large chunks of memory:
> 
>         sd = kmalloc((sd_template.dev_max << 4) *
>                                           sizeof(struct hd_struct),
>                                           GFP_ATOMIC);
> 
> Without sard, you'd have problems past 512 disks.

Yes, when I was coding up the patch I noticed the use of GFP_ATOMIC in
the allocation calls. I have two questions:
- can we use GFP_KERNEL instead (why use GFP_ATOMIC)
- can we switch to vmalloc() instead of kmalloc()?

> With the sard patch, the hd_struct looks like the following:
> 
> struct hd_struct {
>         long start_sect;
>         long nr_sects;
>         devfs_handle_t de;              /* primary (master) devfs entry  */
> 
>         int number;                     /* stupid old code wastes space  */
> 
>         /* Performance stats: */
>         unsigned int ios_in_flight;
>         unsigned int io_ticks;
>         unsigned int last_idle_time;
>         unsigned int last_queue_change;
>         unsigned int aveq;
> 
>         unsigned int rd_ios;
>         unsigned int rd_merges;
>         unsigned int rd_ticks;
>         unsigned int rd_sectors;
>         unsigned int wr_ios;
>         unsigned int wr_merges;
>         unsigned int wr_ticks;
>         unsigned int wr_sectors;
> };
> 
> The caveat is that I'm looking at a patch that is a few months old (I
> couldn't find where the latest version of the kernel patch is).

Do the stats have to be kept on a per-partition basic? What about
per-device instead?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
