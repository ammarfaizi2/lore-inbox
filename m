Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135840AbRDYK1U>; Wed, 25 Apr 2001 06:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135841AbRDYK1L>; Wed, 25 Apr 2001 06:27:11 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:29191 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S135840AbRDYK0z>;
	Wed, 25 Apr 2001 06:26:55 -0400
Date: Wed, 25 Apr 2001 12:26:50 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Possible off-by-one errors in CDROM handling code
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3AE6A66A.A43DCFBA@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There seem to be some off-by-one errors in the cdrom/ide-cd driver,
where CD capacity is handled in the redhat kernel-source-2.4.1-0.1.9
and also in kernel-2.4.3 )

>From the file linux/drivers/ide/ide-cd.c :
(My comments start with '#')

static int cdrom_read_capacity(ide_drive_t *drive, unsigned *capacity,
                               struct request_sense *sense)
{
        struct {
                __u32 lba;
                __u32 blocklen;
        } capbuf;

        int stat;
        struct packet_command pc;

        memset(&pc, 0, sizeof(pc));
        pc.sense = sense;

        pc.c[0] = GPCMD_READ_CDVD_CAPACITY;
        pc.buffer = (char *)&capbuf;
        pc.buflen = sizeof(capbuf);

        stat = cdrom_queue_packet_command(drive, &pc);
        if (stat == 0)
                *capacity = 1 + be32_to_cpu(capbuf.lba); # this seems correct , the CD reports the
                                                         # address of the last sector , sectors are counted from 0

        return stat;
}

...

in function static int cdrom_read_toc() :

        /* Now try to get the total cdrom capacity. */
        minor = (drive->select.b.unit) << PARTN_BITS;
        dev = MKDEV(HWIF(drive)->major, minor);
        stat = cdrom_get_last_written(dev, (long *)&toc->capacity); # this returns the last sector number , 
                                                                    # should add one to get capacity !!!
        if (stat)
                stat = cdrom_read_capacity(drive, &toc->capacity, sense); # this returns the correct capacity
        if (stat)
                toc->capacity = 0x1fffff;

        HWIF(drive)->gd->sizes[drive->select.b.unit << PARTN_BITS] = (toc->capacity * SECTORS_PER_FRAME) >> (BLOCK_SIZE_BITS - 9);
        drive->part[0].nr_sects = toc->capacity * SECTORS_PER_FRAME;
...

-------------------------

from linux/drivers/cdrom/cdrom.c :

/* return the last written block on the CD-R media. this is for the udf
   file system. */
int cdrom_get_last_written(kdev_t dev, long *last_written)
{       
        struct cdrom_device_info *cdi = cdrom_find_device(dev);
        struct cdrom_tocentry toc;
        disc_information di;
        track_information ti;
        __u32 last_track;
        int ret = -1;

        if (!CDROM_CAN(CDC_GENERIC_PACKET))
                goto use_toc;

        if ((ret = cdrom_get_disc_info(dev, &di)))
                goto use_toc;

        last_track = (di.last_track_msb << 8) | di.last_track_lsb;
        if ((ret = cdrom_get_track_info(dev, last_track, 1, &ti)))
                goto use_toc;

        /* if this track is blank, try the previous. */
        if (ti.blank) {
                last_track--;
                if ((ret = cdrom_get_track_info(dev, last_track, 1, &ti)))
                        goto use_toc;
        }

        /* if last recorded field is valid, return it. */
        if (ti.lra_v) {
                *last_written = be32_to_cpu(ti.last_rec_address);    # seems OK
        } else {
                /* make it up instead */
                *last_written = be32_to_cpu(ti.track_start) +      # on a two sector CD ( sectors 0 and 1 ), this returns :
                                be32_to_cpu(ti.track_size);        # 0 + 2 = 2 , instead of 1 !!!
                if (ti.free_blocks)
                        *last_written -= (be32_to_cpu(ti.free_blocks) + 7);  # no idea what this does ,
                                                                             # maybe it fixes the previous error
        }
        return 0;

        /* this is where we end up if the drive either can't do a
           GPCMD_READ_DISC_INFO or GPCMD_READ_TRACK_RZONE_INFO or if
           it fails. then we return the toc contents. */
use_toc:
        toc.cdte_format = CDROM_MSF;
        toc.cdte_track = CDROM_LEADOUT;
        if (cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc))
                return ret;
        sanitize_format(&toc.cdte_addr, &toc.cdte_format, CDROM_LBA);
        *last_written = toc.cdte_addr.lba;                              # seems OK
        return 0;
}




-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
