Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317647AbSGJWOs>; Wed, 10 Jul 2002 18:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGJWOr>; Wed, 10 Jul 2002 18:14:47 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:31752
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317647AbSGJWOn>; Wed, 10 Jul 2002 18:14:43 -0400
Date: Wed, 10 Jul 2002 15:01:10 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
cc: "'Jens Axboe'" <axboe@suse.de>,
       Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: RE: (RE:  using 2.5.25 with IDE) On sparc64.....
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A7B86@nocmail101.ma.tmpw.net>
Message-ID: <Pine.LNX.4.10.10207101459060.16921-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The locking code is broken because the port forward fail to carry all
issues.

On Wed, 10 Jul 2002, Holzrichter, Bruce wrote:

> 
> > Bruce,
> > 
> > I checked in your previous patch already. Care to really forward port
> > asm-sparc64/ide.h from 2.4.19-pre10-rc2 and send me an incremental
> > patch?
> > 
> 
> I have done some Preliminary work on this, but not had a lot of time to look
> at it.  In comparing the sparc64 old/new to i386, I replaced a couple of the
> #define's with the static __inline__ that were in the 2.4.19 sparc64
> version.  
> 
> At this point, I say Preliminary, as it DOESN'T work yet on sparc64, and
> this is the first IDE code I've really looked at.  It will compile, but
> right now, it's falling down at the partition check still, but displaying
> "unknown partition" and also a "bad csum" for the sun label. 
> 
> Jen's can you take a quick look at this, and let me know what your thoughts
> are on this patch?  Again, it doesn't do much right now...
> 
> This is an interim diff against your updated ide24 bk tree...
> 
> --- spideclean/include/asm-sparc64/ide.h	Wed Jul 10 13:44:03 2002
> +++ sparctest/include/asm-sparc64/ide.h	Wed Jul 10 12:18:54 2002
> @@ -182,19 +182,132 @@
>  #endif
>  }
>  
> -#define ide_request_irq(irq,hand,flg,dev,id)
> request_irq((irq),(hand),(flg),(dev),(id))
> -#define ide_free_irq(irq,dev_id)		free_irq((irq), (dev_id))
> -#define ide_check_region(from,extent)		check_region((from),
> (extent))
> -#define ide_request_region(from,extent,name)	request_region((from),
> (extent), (name))
> -#define ide_release_region(from,extent)	release_region((from),
> (extent))
> +#if defined(CONFIG_IDE_24)
> +static __inline__ void ide_fix_driveid(struct hd_driveid *id)
> +{
> +        int i;
> +        u16 *stringcast;
> +
> +        id->config         = __le16_to_cpu(id->config);
> +        id->cyls           = __le16_to_cpu(id->cyls);
> +        id->reserved2      = __le16_to_cpu(id->reserved2);
> +        id->heads          = __le16_to_cpu(id->heads);
> +        id->track_bytes    = __le16_to_cpu(id->track_bytes);
> +        id->sector_bytes   = __le16_to_cpu(id->sector_bytes);
> +        id->sectors        = __le16_to_cpu(id->sectors);
> +        id->vendor0        = __le16_to_cpu(id->vendor0);
> +        id->vendor1        = __le16_to_cpu(id->vendor1);
> +        id->vendor2        = __le16_to_cpu(id->vendor2);
> +        stringcast = (u16 *)&id->serial_no[0];
> +        for (i = 0; i < (20/2); i++)
> +                stringcast[i] = __le16_to_cpu(stringcast[i]);
> +        id->buf_type       = __le16_to_cpu(id->buf_type);
> +        id->buf_size       = __le16_to_cpu(id->buf_size);
> +        id->ecc_bytes      = __le16_to_cpu(id->ecc_bytes);
> +        stringcast = (u16 *)&id->fw_rev[0];
> +        for (i = 0; i < (8/2); i++)
> +                stringcast[i] = __le16_to_cpu(stringcast[i]);
> +        stringcast = (u16 *)&id->model[0];
> +        for (i = 0; i < (40/2); i++)
> +                stringcast[i] = __le16_to_cpu(stringcast[i]);
> +        id->dword_io       = __le16_to_cpu(id->dword_io);
> +        id->reserved50     = __le16_to_cpu(id->reserved50);
> +        id->field_valid    = __le16_to_cpu(id->field_valid);
> +        id->cur_cyls       = __le16_to_cpu(id->cur_cyls);
> +        id->cur_heads      = __le16_to_cpu(id->cur_heads);
> +        id->cur_sectors    = __le16_to_cpu(id->cur_sectors);
> +        id->cur_capacity0  = __le16_to_cpu(id->cur_capacity0);
> +        id->cur_capacity1  = __le16_to_cpu(id->cur_capacity1);
> +        id->lba_capacity   = __le32_to_cpu(id->lba_capacity);
> +        id->dma_1word      = __le16_to_cpu(id->dma_1word);
> +        id->dma_mword      = __le16_to_cpu(id->dma_mword);
> +        id->eide_pio_modes = __le16_to_cpu(id->eide_pio_modes);
> +        id->eide_dma_min   = __le16_to_cpu(id->eide_dma_min);
> +        id->eide_dma_time  = __le16_to_cpu(id->eide_dma_time);
> +        id->eide_pio       = __le16_to_cpu(id->eide_pio);
> +        id->eide_pio_iordy = __le16_to_cpu(id->eide_pio_iordy);
> +        for (i = 0; i < 2; i++)
> +                id->words69_70[i] = __le16_to_cpu(id->words69_70[i]);
> +        for (i = 0; i < 4; i++)
> +                id->words71_74[i] = __le16_to_cpu(id->words71_74[i]);
> +        id->queue_depth    = __le16_to_cpu(id->queue_depth);
> +        for (i = 0; i < 4; i++)
> +                id->words76_79[i] = __le16_to_cpu(id->words76_79[i]);
> +        id->major_rev_num  = __le16_to_cpu(id->major_rev_num);
> +        id->minor_rev_num  = __le16_to_cpu(id->minor_rev_num);
> +        id->command_set_1  = __le16_to_cpu(id->command_set_1);
> +        id->command_set_2  = __le16_to_cpu(id->command_set_2);
> +        id->cfsse          = __le16_to_cpu(id->cfsse);
> +        id->cfs_enable_1   = __le16_to_cpu(id->cfs_enable_1);
> +        id->cfs_enable_2   = __le16_to_cpu(id->cfs_enable_2);
> +        id->csf_default    = __le16_to_cpu(id->csf_default);
> +        id->dma_ultra      = __le16_to_cpu(id->dma_ultra);
> +        id->word89         = __le16_to_cpu(id->word89);
> +        id->word90         = __le16_to_cpu(id->word90);
> +        id->CurAPMvalues   = __le16_to_cpu(id->CurAPMvalues);
> +        id->word92         = __le16_to_cpu(id->word92);
> +        id->hw_config      = __le16_to_cpu(id->hw_config);
> +        id->acoustic       = __le16_to_cpu(id->acoustic);
> +        for (i = 0; i < 5; i++)
> +                id->words95_99[i]  = __le16_to_cpu(id->words95_99[i]);
> +        id->lba_capacity_2 = __le64_to_cpu(id->lba_capacity_2);
> +        for (i = 0; i < 22; i++)
> +                id->words104_125[i]   = __le16_to_cpu(id->words104_125[i]);
> +        id->last_lun       = __le16_to_cpu(id->last_lun);
> +        id->word127        = __le16_to_cpu(id->word127);
> +        id->dlf            = __le16_to_cpu(id->dlf);
> +        id->csfo           = __le16_to_cpu(id->csfo);
> +        for (i = 0; i < 26; i++)
> +                id->words130_155[i] = __le16_to_cpu(id->words130_155[i]);
> +        id->word156        = __le16_to_cpu(id->word156);
> +        for (i = 0; i < 3; i++)
> +                id->words157_159[i] = __le16_to_cpu(id->words157_159[i]);
> +        id->cfa_power      = __le16_to_cpu(id->cfa_power);
> +        for (i = 0; i < 14; i++)
> +                id->words161_175[i] = __le16_to_cpu(id->words161_175[i]);
> +        for (i = 0; i < 31; i++)
> +                id->words176_205[i] = __le16_to_cpu(id->words176_205[i]);
> +        for (i = 0; i < 48; i++)
> +                id->words206_254[i] = __le16_to_cpu(id->words206_254[i]);
> +        id->integrity_word  = __le16_to_cpu(id->integrity_word);
> +}
> +
> +static __inline__ int ide_request_irq(unsigned int irq,
> +                                      void (*handler)(int, void *, struct
> pt_regs *),
> +                                      unsigned long flags, const char
> *name, void *devid)
> +{
> +        return request_irq(irq, handler, SA_SHIRQ, name, devid);
> +}
> +
> +static __inline__ void ide_free_irq(unsigned int irq, void *dev_id)
> +{
> +        free_irq(irq, dev_id);
> +}
> +
> +static __inline__ int ide_check_region(ide_ioreg_t base, unsigned int size)
> +{
> +        return check_region(base, size);
> +}
> +
> +static __inline__ void ide_request_region(ide_ioreg_t base, unsigned int
> size,
> +                                          const char *name)
> +{
> +        request_region(base, size, name);
> +}
> +
> +static __inline__ void ide_release_region(ide_ioreg_t base, unsigned int
> size)
> +{
> +        release_region(base, size);
> +}
>  
>  /*
>   * The following are not needed for the non-m68k ports
>   */
>  #define ide_ack_intr(hwif)		(1)
> -#define ide_fix_driveid(id)		do {} while (0)
>  #define ide_release_lock(lock)		do {} while (0)
>  #define ide_get_lock(lock, hdlr, data)	do {} while (0)
> +
> +#endif /* CONFIG_IDE_24 */
>   
>  #endif /* __KERNEL__ */
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

