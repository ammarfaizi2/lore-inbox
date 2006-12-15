Return-Path: <linux-kernel-owner+w=401wt.eu-S1753162AbWLOSpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbWLOSpt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbWLOSpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:45:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:18938 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbWLOSps (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:45:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=A0DLGuzmJ4yUgc9qPpuCOrRPibnlpYwMB8B8GkkfP4/WGiEx/Bp1cB+J6N0yen6SMgGhahF1rk7pb2Rk7hT1U1v17GAoHbyaeivAo3mE8Bs9+hJcGYHnzHZOm2dU24xtdvyGdIL5hzIGRxJZc3NdqyKbQjxlTymGozvguzrercA=
Date: Fri, 15 Dec 2006 21:45:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: andersen@codepoet.org, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support HDIO_GET_IDENTITY in libata
Message-ID: <20061215184543.GA6626@martell.zuzino.mipt.ru>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <4581AEA0.3040708@garzik.org> <20061214202608.GA2313@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214202608.GA2313@codepoet.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 01:26:08PM -0700, Erik Andersen wrote:
> On Thu Dec 14, 2006 at 03:05:52PM -0500, Jeff Garzik wrote:
> > FWIW, libata generally follows a "implement it, if enough people care
> > about it" policy for the old HDIO_xxx ioctls.
>
> I personally care about HDIO_GET_IDENTITY and find it terribly
> useful to quickly find out about a drive.  Perhaps enough other
> people care about this ioctl that it might make it into the official
> libata tree.  Well tested with a number of months of use.

> --- orig/drivers/ata/libata-scsi.c
> +++ linux-2.6.18/drivers/ata/libata-scsi.c
> @@ -303,6 +303,172 @@
>  	return rc;
>  }
>
> +static void ide_fixstring (u8 *s, const int bytecount)
> +{
> +	u8 *p = s, *end = &s[bytecount & ~1]; /* bytecount must be even */
> +
> +#ifndef __BIG_ENDIAN
> +# ifdef __LITTLE_ENDIAN
> +	/* convert from big-endian to host byte order */
> +	for (p = end ; p != s;) {
> +		unsigned short *pp = (unsigned short *) (p -= 2);
> +		*pp = ntohs(*pp);
> +	}
> +# else
> +#  error "Please fix <asm/byteorder.h>"
> +# endif
> +#endif

Ugly. ntohs() will work on BE arches also.

> +static void ide_fix_driveid (struct hd_driveid *id)
> +{
> +#ifndef __LITTLE_ENDIAN
> +# ifdef __BIG_ENDIAN

Ditto.

> +	int i;
> +	u16 *stringcast;
> +
> +	id->config         = __le16_to_cpu(id->config);
> +	id->cyls           = __le16_to_cpu(id->cyls);
> +	id->reserved2      = __le16_to_cpu(id->reserved2);
> +	id->heads          = __le16_to_cpu(id->heads);
> +	id->track_bytes    = __le16_to_cpu(id->track_bytes);
> +	id->sector_bytes   = __le16_to_cpu(id->sector_bytes);
> +	id->sectors        = __le16_to_cpu(id->sectors);
> +	id->vendor0        = __le16_to_cpu(id->vendor0);
> +	id->vendor1        = __le16_to_cpu(id->vendor1);
> +	id->vendor2        = __le16_to_cpu(id->vendor2);
> +	stringcast = (u16 *)&id->serial_no[0];
> +	for (i = 0; i < (20/2); i++)
> +		stringcast[i] = __le16_to_cpu(stringcast[i]);
> +	id->buf_type       = __le16_to_cpu(id->buf_type);
> +	id->buf_size       = __le16_to_cpu(id->buf_size);
> +	id->ecc_bytes      = __le16_to_cpu(id->ecc_bytes);
> +	stringcast = (u16 *)&id->fw_rev[0];
> +	for (i = 0; i < (8/2); i++)
> +		stringcast[i] = __le16_to_cpu(stringcast[i]);
> +	stringcast = (u16 *)&id->model[0];
> +	for (i = 0; i < (40/2); i++)
> +		stringcast[i] = __le16_to_cpu(stringcast[i]);
> +	id->dword_io       = __le16_to_cpu(id->dword_io);
> +	id->reserved50     = __le16_to_cpu(id->reserved50);
> +	id->field_valid    = __le16_to_cpu(id->field_valid);
> +	id->cur_cyls       = __le16_to_cpu(id->cur_cyls);
> +	id->cur_heads      = __le16_to_cpu(id->cur_heads);
> +	id->cur_sectors    = __le16_to_cpu(id->cur_sectors);
> +	id->cur_capacity0  = __le16_to_cpu(id->cur_capacity0);
> +	id->cur_capacity1  = __le16_to_cpu(id->cur_capacity1);
> +	id->lba_capacity   = __le32_to_cpu(id->lba_capacity);
> +	id->dma_1word      = __le16_to_cpu(id->dma_1word);
> +	id->dma_mword      = __le16_to_cpu(id->dma_mword);
> +	id->eide_pio_modes = __le16_to_cpu(id->eide_pio_modes);
> +	id->eide_dma_min   = __le16_to_cpu(id->eide_dma_min);
> +	id->eide_dma_time  = __le16_to_cpu(id->eide_dma_time);
> +	id->eide_pio       = __le16_to_cpu(id->eide_pio);
> +	id->eide_pio_iordy = __le16_to_cpu(id->eide_pio_iordy);
> +	for (i = 0; i < 2; ++i)
> +		id->words69_70[i] = __le16_to_cpu(id->words69_70[i]);
> +	for (i = 0; i < 4; ++i)
> +		id->words71_74[i] = __le16_to_cpu(id->words71_74[i]);
> +	id->queue_depth    = __le16_to_cpu(id->queue_depth);
> +	for (i = 0; i < 4; ++i)
> +		id->words76_79[i] = __le16_to_cpu(id->words76_79[i]);
> +	id->major_rev_num  = __le16_to_cpu(id->major_rev_num);
> +	id->minor_rev_num  = __le16_to_cpu(id->minor_rev_num);
> +	id->command_set_1  = __le16_to_cpu(id->command_set_1);
> +	id->command_set_2  = __le16_to_cpu(id->command_set_2);
> +	id->cfsse          = __le16_to_cpu(id->cfsse);
> +	id->cfs_enable_1   = __le16_to_cpu(id->cfs_enable_1);
> +	id->cfs_enable_2   = __le16_to_cpu(id->cfs_enable_2);
> +	id->csf_default    = __le16_to_cpu(id->csf_default);
> +	id->dma_ultra      = __le16_to_cpu(id->dma_ultra);
> +	id->trseuc         = __le16_to_cpu(id->trseuc);
> +	id->trsEuc         = __le16_to_cpu(id->trsEuc);
> +	id->CurAPMvalues   = __le16_to_cpu(id->CurAPMvalues);
> +	id->mprc           = __le16_to_cpu(id->mprc);
> +	id->hw_config      = __le16_to_cpu(id->hw_config);
> +	id->acoustic       = __le16_to_cpu(id->acoustic);
> +	id->msrqs          = __le16_to_cpu(id->msrqs);
> +	id->sxfert         = __le16_to_cpu(id->sxfert);
> +	id->sal            = __le16_to_cpu(id->sal);
> +	id->spg            = __le32_to_cpu(id->spg);
> +	id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);
> +	for (i = 0; i < 22; i++)
> +		id->words104_125[i]   = __le16_to_cpu(id->words104_125[i]);
> +	id->last_lun       = __le16_to_cpu(id->last_lun);
> +	id->word127        = __le16_to_cpu(id->word127);
> +	id->dlf            = __le16_to_cpu(id->dlf);
> +	id->csfo           = __le16_to_cpu(id->csfo);
> +	for (i = 0; i < 26; i++)
> +		id->words130_155[i] = __le16_to_cpu(id->words130_155[i]);
> +	id->word156        = __le16_to_cpu(id->word156);
> +	for (i = 0; i < 3; i++)
> +		id->words157_159[i] = __le16_to_cpu(id->words157_159[i]);
> +	id->cfa_power      = __le16_to_cpu(id->cfa_power);
> +	for (i = 0; i < 14; i++)
> +		id->words161_175[i] = __le16_to_cpu(id->words161_175[i]);
> +	for (i = 0; i < 31; i++)
> +		id->words176_205[i] = __le16_to_cpu(id->words176_205[i]);
> +	for (i = 0; i < 48; i++)
> +		id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
> +	id->integrity_word  = __le16_to_cpu(id->integrity_word);
> +# else
> +#  error "Please fix <asm/byteorder.h>"
> +# endif
> +#endif

