Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317651AbSGOVeg>; Mon, 15 Jul 2002 17:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317657AbSGOVef>; Mon, 15 Jul 2002 17:34:35 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:3247 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S317651AbSGOVed>;
	Mon, 15 Jul 2002 17:34:33 -0400
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.24 IDE 96
References: <Pine.SOL.4.30.0207022341410.18786-200000@mion.elka.pw.edu.pl>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 15 Jul 2002 22:09:13 +0200
In-Reply-To: <Pine.SOL.4.30.0207022341410.18786-200000@mion.elka.pw.edu.pl>
Message-ID: <m3ptxog3di.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.5.25-dj2 with IDE 97 and there are two problems with it
when running it all as modules, here's some info:

[root@lapper root]# lsmod | grep ide
ide-scsi                7936   0  (unused)
scsi_mod               97944   1  [ide-scsi]
ide-cd                 29376   0 
cdrom                  31904   0  [ide-cd]
ide-disk               10880   4 
ide-mod                79152 -12  [ide-scsi ide-cd ide-disk]
[root@lapper root]# 

and,

[root@lapper root]# grep _IDE /home/alexh/src/linux/linux-2.5-misc/.config
CONFIG_IDE=m
# CONFIG_IDE_24 is not set
CONFIG_IDE_25=y
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
CONFIG_BLK_DEV_IDECS=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDETAPE=m
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEDMA_ONLYDISK=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDE_TCQ_DEFAULT is not set
CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_CD_NO_IDESCSI is not set
[root@lapper root]# 

The two problems are:

1. devices.c doesn't export two symbols, so depmod -a will not resolv
   all symbols after compile, patch for it is here:

--- linux-2.5-clean/drivers/ide/device.c	Wed Jun 19 04:11:52 2002
+++ linux-2.5-misc/drivers/ide/device.c	Mon Jul 15 09:29:20 2002
@@ -79,6 +79,8 @@
 		ch->maskproc(drive);
 }
 
+EXPORT_SYMBOL(ata_mask);
+
 /*
  * Spin until the drive is no longer busy.
  *
@@ -232,6 +234,8 @@
 	OUT_BYTE(rf->high_cylinder, ch->io_ports[IDE_HCYL_OFFSET]);
 }
 
+EXPORT_SYMBOL(ata_out_regfile);
+
 /*
  * Input a complete register file.
  */

2. From above, refcounting of module use is rather b0rken. ide-mod is
   used -12 times for example.

Apart from that, the machines disk system will lock solid after about
2-3 hrs of up uptime, I'm trying to get some logs from that, but I
need to sort out the laptop keyboard to get to the SysRq key :)

mvh,
A

Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> writes:

> Ok, this should fix some pending issues...
> 
> Tue Jul  2 21:27:44 CEST 2002 ide-clean-96
> 
> - revert to previous (2.4.x + channel->lock) locking scheme
> 
> - bring back ide__sti() calls
> 
> - fix bug introduced in IDE 63 in ide_do_drive_cmd(), if action is ide_end
>   request should be added to end of queue not next to current request,
>   fortunately it is used only by ide-tape which is broken anyway
> 
> - fix bug introduced in IDE 94 in idedisk_do_request(), removal of
>   rq->special = ar; probably needed by PMAC and TCQ
> 
> - fix bug introduced in IDE 94 in do_request(), always setting IDE_BUSY
>   bit could lead to deadlock
> 
> - in check_crc_errors() do strict checking for UDMA modes
> 
> - clean double setting handler/timer hack
> 
> - remove CAP_SYS_ADMIN check from HDIO_GET* ioctls
> 
> 

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
