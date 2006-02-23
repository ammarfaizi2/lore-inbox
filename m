Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWBWRWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWBWRWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWBWRWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:22:12 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:6369 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932078AbWBWRWK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:22:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QkGnbUCwpA7VCI7cVz/T+UD7ptRisfX4ohsZMqKiik0mp3iQwM2miyLBJfr7VtrIaH2c9R9BCSNT2nukURxQuL37NBvI8Dupnqy6Dvndj9N9VdqWLS8rqaM43pJuP/d43YeucKRjOBrtBVTJxxBd7h7lc8WUdqHtX2t9bbj0xUE=
Message-ID: <311601c90602230922i3a429d5cp98a4f4142a37ba1a@mail.gmail.com>
Date: Thu, 23 Feb 2006 10:22:08 -0700
From: "Eric D. Mudama" <edmudama@gmail.com>
To: sander@humilis.net
Subject: Re: 2.6.16-rc3 - sata_mv - Assertion failed!
Cc: "Jeff Garzik" <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
In-Reply-To: <20060217093705.GA20320@favonius>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060217093705.GA20320@favonius>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

50/01 is the reset signature FIS.  Is it possible that under load you
aren't supplying enough power to the drives, your 5V or 12V droops too
much, and the voltage protection circuitry on the drive causes it to
power cycle?

--eric

(sorry if this got sent twice, I think VGER bounced my "richly
formatted" gmail message)

On 2/17/06, Sander <sander@humilis.net> wrote:
> Hi Jeff and others,
>
> I get some error messages while using a raid5 over nine Maxtor 500GB
> disks.
>
> The first three disks are connected to the onboard nForce4, and six to a
> MV88SX6081 8-port SATA II PCI-X Controller (rev 09)
>
> I made a 25GB partition on each disk, and create raid5 over them:
>
> mdadm -C -l5 -n9 /dev/md1 /dev/sda2 /dev/sdb2 /dev/sdc2 \
> /dev/sdd2 /dev/sde2 /dev/sdf2 /dev/sdg2 /dev/sdh2 /dev/sdi2
>
> When the recovery is finished, I create an ext3 filesystem, and mount
> it:
>
> mke2fs -j -m1 /dev/md1
> mount -o data=writeback /dev/md1 /mnt
>
> Then I execute the following:
>
> for i in `seq 10`
> do dd if=/dev/zero of=bigfile.$i bs=1024k count=10000
> done
> md5sum bigfile.*
> rm bigfile.*
>
> This time, the system was building another raid5 on other partitions at
> the same time, generating some extra load. The system spits out error
> messages (via netconsole), and responds _very_ slow on disks activity.
>
> I rebuilded 2.6.16-rc3 with ATA_DEBUG and ATA_VERBOSE_DEBUG defined, but
> that kernel hangs when I try to create the raid5. I'll try again with
> only ATA_DEBUG enabled.
>
> I'll also have a look at the firmware version in the Marvell controller,
> and upgrade it if it is not the latest.
>
> Any more I can do? More info I can provide? Is this due to the sata_mv
> driver being beta? If so, I love to test any patches. All disks passed
> badblocks in write mode, fwiw.
>
>         Sander
>
>
> [    0.000000] Linux version 2.6.16-rc3 (root@elisha) (gcc version 4.0.3 20060104 (prerelease) (Debian 4.0.2-6)) #1 SMP Wed Feb 15 17:07:29 CET 2006
>
> [cut]
>
> [   78.285313] ata2: SATA link down (SStatus 0)
> [   78.285361] scsi1 : sata_nv
> [   78.285495]   Vendor: ATA       Model: Maxtor 7H500F0    Rev: HA43
> [   78.286242]   Type:   Direct-Access                      ANSI SCSI revision: 05
> [   78.286795] ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 22
> [   78.286846] GSI 20 sharing vector 0xD1 and IRQ 20
> [   78.286894] ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 22 (level, high) -> IRQ 20
> [   78.287266] ata3: SATA max UDMA/133 cmd 0x1458 ctl 0x144E bmdma 0x1420 irq 20
> [   78.287344] ata4: SATA max UDMA/133 cmd 0x1450 ctl 0x144A bmdma 0x1428 irq 20
> [   78.505038] ata3: SATA link up 3.0 Gbps (SStatus 123)
> [   78.704878] ata3: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> [   78.705922] nv_sata: Primary device added
> [   78.705926] ata3: dev 0 configured for UDMA/133
> [   78.705929] scsi2 : sata_nv
> [   78.706065] nv_sata: Primary device removed
> [   78.706110] nv_sata: Secondary device added
> [   78.706154] nv_sata: Secondary device removed
> [   78.924512] ata4: SATA link up 3.0 Gbps (SStatus 123)
> [   79.114363] ata4: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> [   79.115391] nv_sata: Primary device added
> [   79.115394] ata4: dev 0 configured for UDMA/133
> [   79.115396] scsi3 : sata_nv
> [   79.115520] nv_sata: Primary device removed
> [   79.115564] nv_sata: Secondary device added
> [   79.115609] nv_sata: Secondary device removed
> [   79.115725]   Vendor: ATA[   80.033304] ata6: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> [   80.034353] ata6: dev 0 configured for UDMA/133
> [   80.034397] scsi5 : sata_mv
> [   80.492731] ata7: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> [   80.493771] ata7: dev 0 configured for UDMA/133
> [   80.493815] scsi6 : sata_mv
> [   80.952151] ata8: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> [   80.953186] ata8: dev 0 configured for UDMA/133
> [   80.953231] scsi7 : sata_mv
> [   81.411574] ata9: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> [   81.412605] ata9: dev 0 configured for UDMA/133
> [   81.412650] scsi8 : sata_mv
> [   81.880985] ata10: dev 0 ATA-7, max UDMA/133, 976773168 sectors: LBA48
> [   81.882022] ata10: dev 0 configured for UDMA/133
> [   81.882066] scsi9 : sata_mv
> [   81.940725] ata11: no device found (phy stat 00000000)
> [   81.940773] scsi10 : sata_mv
> [   81.990662] ata12: no device found (phy stat 00000000)
> [   81.990709] scsi11 : sata_mv
> [   81.990839]   Vendor: ATA       Model: Maxtor 7H500F0    Rev: HA43
> [   81.991587]   Type:   Direct-Access                      ANSI SCSI revision: 05
> [   81.991795]   Vendor: ATA       Model: Maxtor 7H[   82.879567] Driver 'w83627hf' needs updating - please use bus_type methods
>
> [cut]
>
> [ 2071.503963] ata5: translated ATA stat/err 0xd0/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> [ 2071.504017] ata5: status=0xd0 { Busy }
> [ 2101.475022] ata5: Entering mv_eng_timeout
> [ 2101.475059] mmio_base ffffc20000080000 ap ffff81013b4a5480 qc ffff81013b4a59b8 scsi_cmnd ffff810116d70b40 &cmnd ffff810116d70bb0
> [ 2101.538621] ata5: no device found (phy stat 00000100)
> [ 2101.601492] ata5: status=0x50 { DriveReady SeekComplete }
> [ 2101.601540] ata5: error=0x01 { AddrMarkNotFound }
> [ 2101.601578] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3623
> [ 2101.601637] ata5: status=0x50 { DriveReady SeekComplete }
> [ 2101.601675] ata5: error=0x01 { AddrMarkNotFound }
> [ 2101.601713] sdd: Current: sense key=0x0
> [ 2101.601742]     ASC=0x0 ASCQ=0x0
> [ 2101.601856] Assertion failed! ((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1073
> [ 2131.567227] ata5: Entering mv_eng_timeout
> [ 2131.567259] mmio_base ffffc20000080000 ap ffff81013b4a5480 qc ffff81013b4a59b8 scsi_cmnd ffff81010b7489c0 &cmnd ffff81010b748a30
> [ 2131.651702] ata5: no device found (phy stat 00000100)
> [ 2131.693584] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3623
> [ 2131.693640] ata5: status=0x50 { DriveReady SeekComplete }
> [ 2131.693677] ata5: error=0x01 { AddrMarkNotFound }
> [ 2131.693712] sdd: Current: sense key=0x0
> [ 2131.693741]     ASC=0x0 ASCQ=0x0
> [ 2131.693856] Assertion failed! ((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1073
> [ 2161.689415] ata5: Entering mv_eng_timeout
> [ 2161.689447] mmio_base ffffc20000080000 ap ffff81013b4a5480 qc ffff81013b4a59b8 scsi_cmnd ffff81010b7489c0 &cmnd ffff81010b748a30
> [ 2161.773886] ata5: no device found (phy stat 00000100)
> [ 2161.815776] ata5: status=0x50 { DriveReady SeekComplete }
> [ 2161.815823] ata5: error=0x01 { AddrMarkNotFound }
> [ 2161.815859] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3623
> [ 2161.815917] ata5: status=0x50 { DriveReady SeekComplete }
> [ 2161.815954] ata5: error=0x01 { AddrMarkNotFound }
> [ 2161.815989] sdd: Current: sense key=0x0
> [ 2161.816018]     ASC=0x0 ASCQ=0x0
> [ 2161.816122] Assertion failed! ((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1073
> [ 2191.781622] ata5: Entering mv_eng_timeout
> [ 2191.781654] mmio_base ffffc20000080000 ap ffff81013b4a5480 qc ffff81013b4a59b8 scsi_cmnd ffff810116d70b40 &cmnd ffff810116d70bb0
> [ 2191.866094] ata5: no device found (phy stat 00000100)
> [ 2191.907980] ata5: status=0x50 { DriveReady SeekComplete }
> [ 2191.908020] ata5: error=0x01 { AddrMarkNotFound }
> [ 2191.908056] Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_qc_complete,line=3623
> [ 2191.908115] ata5: status=0x50 { DriveReady SeekComplete }
> [ 2191.908151] ata5: error=0x01 { AddrMarkNotFound }
> [ 2191.908188] sdd: Current: sense key=0x0
> [ 2191.908217]     ASC=0x0 ASCQ=0x0
> [ 2191.908305] Assertion failed! ((in_ptr >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK) == ((readl(port_mmio + EDMA_REQ_Q_OUT_PTR_OFS) >> EDMA_REQ_Q_PTR_SHIFT) & MV_MAX_Q_DEPTH_MASK),drivers/scsi/sata_mv.c,mv_qc_issue,line=1073
> [ 2221.873842] ata5: Entering mv_eng_timeout
> [ 2221.877167] mmio_base ffffc20000080000 ap ffff81013b4a5480 qc ffff81013b4a59b8 scsi_cmnd ffff81010b7489c0 &cmnd ffff81010b748a30
>
> [cut the same over and over]
>
> --
> Humilis IT Services and Solutions
> http://www.humilis.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
