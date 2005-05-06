Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVEFIOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVEFIOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 04:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVEFIOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 04:14:04 -0400
Received: from portal.cramer.co.uk ([193.130.83.209]:2834 "EHLO
	S2.cramer.co.uk") by vger.kernel.org with ESMTP id S261177AbVEFIN6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 04:13:58 -0400
Message-ID: <3E116F19B784CD47A7CE7F923A436499014C8E39@s2.cramer.co.uk>
From: James Dingwall <james.dingwall@cramer.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc: Andries.Brouwer@cwi.nl, "'Chris Wright'" <chrisw@osdl.org>
Subject: RE: Bug: 2.6.11.8 msdos.c
Date: Fri, 6 May 2005 09:12:55 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> * James Dingwall (james.dingwall@cramer.com) wrote:
> > Using vanilla 2.6.11.8 I get a "Cannot open initial 
> console" on boot,
> > 2.6.11.7 was fine.  I have removed the patches to 
> fs/partitions/msdos.c and
> > this has fixed my problem.  I've read the discussion on 
> this patch but it
> > doesn't indicate that this problem may occur so there is no 
> suggested
> > solution.  I have attached my .config and my partition 
> layout is below, I
> > can provide any other information that might be useful.  
> I'm not on the list
> > so plase Cc, I will follow the thread in the archives too.
> 
> Thanks for the report James.  To be clear, you simply backed out the
> following: (I ask partly because this got merged in as part of the i2c
> sysfs ChangeSet, odd)
> 
> ===== fs/partitions/msdos.c 1.26 vs 1.27 =====
> --- 1.26/fs/partitions/msdos.c	2004-11-09 12:43:17 -08:00
> +++ 1.27/fs/partitions/msdos.c	2005-03-07 20:41:42 -08:00
> @@ -114,6 +114,9 @@ parse_extended(struct parsed_partitions 
>  		 */
>  		for (i=0; i<4; i++, p++) {
>  			u32 offs, size, next;
> +
> +			if (SYS_IND(p) == 0)
> +				continue;
>  			if (!NR_SECTS(p) || is_extended_partition(p))
>  				continue;
>  
> @@ -430,6 +433,8 @@ int msdos_partition(struct parsed_partit
>  	for (slot = 1 ; slot <= 4 ; slot++, p++) {
>  		u32 start = START_SECT(p)*sector_size;
>  		u32 size = NR_SECTS(p)*sector_size;
> +		if (SYS_IND(p) == 0)
> +			continue;
>  		if (!size)
>  			continue;
>  		if (is_extended_partition(p)) {

Yes, this is the patch that I backed out.

> > 
> > Disk /dev/hda: 30.0 GB, 30020272128 bytes
> > 255 heads, 63 sectors/track, 3649 cylinders
> > Units = cylinders of 16065 * 512 = 8225280 bytes
> > 
> >    Device Boot      Start         End      Blocks   Id  System
> > /dev/hda1   *           1        1797    14434371   83  Linux
> > /dev/hda2            1798        3649    14876190    5  Extended
> > /dev/hda5            1798        1860      506016    0  Empty
> > /dev/hda6            1861        1892      257008+  83  Linux
> > /dev/hda7            1893        1924      257008+  83  Linux
> > /dev/hda8            1925        2049     1004031   82  
> Linux swap / Solaris
> > /dev/hda9            2050        2112      506016    0  Empty
> > /dev/hda10           2113        2611     4008186   83  Linux
> > /dev/hda11           2612        2861     2008093+  83  Linux

Andries' hint about changing the partition types to !0 is a fix for the
problem.

Thanks,
James
