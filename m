Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268021AbTBWKgy>; Sun, 23 Feb 2003 05:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268004AbTBWKgy>; Sun, 23 Feb 2003 05:36:54 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:63616 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S268021AbTBWKgv>; Sun, 23 Feb 2003 05:36:51 -0500
Message-ID: <3E58A63F.9090607@cinet.co.jp>
Date: Sun, 23 Feb 2003 19:45:19 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.0.1) Gecko/20020830
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (6/21) FS & partiton
References: <20030223092116.GA1324@yuzuki.cinet.co.jp> <20030223094325.GG1324@yuzuki.cinet.co.jp> <20030223102937.A15963@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sun, Feb 23, 2003 at 06:43:25PM +0900, Osamu Tomita wrote:
> 
>>-	if (FAT_FIRST_ENT(sb, media) != first) {
>>+	if (FAT_FIRST_ENT(sb, media) != first
>>+	    && (!pc98 || media != 0xf8 || (first & 0xff) != 0xfe))
>>+	{
> 
> 
> I think this should be made unconditionally.  There's no reason why
> non-pc98 linux machines shouldn't read fat filesystems created on pc98.
> 
> 
>>+/* #ifdef CONFIG_BLK_DEV_IDEDISK */
>>+#include <linux/ide.h>
>>+/* #endif */
>>+
>>+/* #ifdef CONFIG_BLK_DEV_SD */
>>+#include "../../drivers/scsi/scsi.h"
>>+#include "../../drivers/scsi/hosts.h"
>>+#include <scsi/scsicam.h>
>>+/* #endif */
> 
> 
> this is really ugly..
> 
> 
>>+	int g_head, g_sect;
>>+	Sector sect;
>>+	const struct nec98_partition *part;
>>+	unsigned char *data;
>>+	int sector_size = bdev_hardsect_size(bdev);
>>+	int major = major(to_kdev_t(bdev->bd_dev));
>>+	int minor = minor(to_kdev_t(bdev->bd_dev));
> 
> 
> use MAJOR/MINOR here.
> 
> 
>>+
>>+	switch (major) {
>>+#if defined CONFIG_BLK_DEV_HD_ONLY
>>+	case HD_MAJOR:
>>+	{
>>+		extern struct hd_i_struct hd_info[2];
>>+
>>+		g_head = hd_info[minor >> 6].head;
>>+		g_sect = hd_info[minor >> 6].sect;
>>+		break;
>>+	}
>>+#endif /* CONFIG_BLK_DEV_HD_ONLY */
>>+#if defined CONFIG_BLK_DEV_SD || defined CONFIG_BLK_DEV_SD_MODULE
>>+	case SCSI_DISK0_MAJOR:
>>+	case SCSI_DISK1_MAJOR:
>>+	case SCSI_DISK2_MAJOR:
>>+	case SCSI_DISK3_MAJOR:
>>+	case SCSI_DISK4_MAJOR:
>>+	case SCSI_DISK5_MAJOR:
>>+	case SCSI_DISK6_MAJOR:
>>+	case SCSI_DISK7_MAJOR:
>>+	{
>>+		int diskinfo[3] = { 0, 0, 0 };
>>+
>>+		pc98_bios_param(bdev, diskinfo);
>>+
>>+		if ((g_head = diskinfo[0]) <= 0)
>>+			g_head = 8;
>>+		if ((g_sect = diskinfo[1]) <= 0)
>>+			g_sect = 17;
>>+		break;
>>+	}
>>+#endif /* CONFIG_BLK_DEV_SD(_MODULE) */
>>+#if defined CONFIG_BLK_DEV_IDEDISK || defined CONFIG_BLK_DEV_IDEDISK_MODULE
>>+	case IDE0_MAJOR:
>>+	case IDE1_MAJOR:
>>+	case IDE2_MAJOR:
>>+	case IDE3_MAJOR:
>>+	case IDE4_MAJOR:
>>+	case IDE5_MAJOR:
>>+	case IDE6_MAJOR:
>>+	case IDE7_MAJOR:
>>+	case IDE8_MAJOR:
>>+	case IDE9_MAJOR:
>>+	{
>>+		ide_drive_t *drive;
>>+		unsigned int	h;
>>+
>>+		for (h = 0; h < MAX_HWIFS; ++h) {
>>+			ide_hwif_t  *hwif = &ide_hwifs[h];
>>+			if (hwif->present && major == hwif->major) {
>>+				unsigned unit = minor >> PARTN_BITS;
>>+				if (unit < MAX_DRIVES) {
>>+					drive = &hwif->drives[unit];
>>+					if (drive->present) {
>>+						g_head = drive->head;
>>+						g_sect = drive->sect;
>>+						goto found;
>>+					}
>>+				}
>>+				break;
>>+			}
>>+		}
>>+	}
>>+#endif /* CONFIG_BLK_DEV_IDEDISK(_MODULE) */
>>+	default:
>>+		printk(" unsupported disk (major = %u)\n", major);
>>+		return 0;
>>+	}
> 
> 
> This is horribly ugly.  Just do an inkernel ioctl instead.  Something
> like the following (untested!):
> 
> 	struct hd_geometry geo;
> 	int err;
> 
> 	err = ioctl_by_bdev(bdev, HDIO_GETGEO, &geo);
> 	if (err)
> 		return err;
> 
> 	g_head = geo.heads;
> 	g_sect = geo.sectors;
> 	

Thank very much. I didn't know inkernel ioctl. I'll try it.

-- 
Osamu Tomita



