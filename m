Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbSLFCNC>; Thu, 5 Dec 2002 21:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbSLFCNC>; Thu, 5 Dec 2002 21:13:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38929 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267524AbSLFCM6>;
	Thu, 5 Dec 2002 21:12:58 -0500
Message-ID: <3DF00951.1070104@pobox.com>
Date: Thu, 05 Dec 2002 21:20:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: ali15x3 on alpha dies in 2.4.21-BK
Content-Type: multipart/mixed;
 boundary="------------020309010405020702040406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020309010405020702040406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

IDE on this alpha ds10 is totally dead:

attached is the manually-transcribed console messages, patch I did to 
get it to build [thanks Alan], and the IDE section of my .config.

This alpha boots and runs just fine on stock 2.4.20.

--------------020309010405020702040406
Content-Type: text/plain;
 name="alpha-ide-dead.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-ide-dead.txt"

Uniform multi-platform eide driver revision: 7.00beta-2.4
ide: assuming 33mhz system buys speed for pio modes; override with idebus=xx
hda: compaq cdr-8435, atapi cd/dvd-rom drive
hdc: fujitsu mpd3108AT, ata disk drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hdc: 19541088 sectors (10005 MB) w/ 512KiB cache, CHS=19386/16/63
hda: atapi 32x cd-rom driver, 128kB cache
uniform cd-rom driver revision: 3.12
partition check:
 hdc: hdc1 hdc2 hdc3
ali15x3: ide controller at PCI slot 00:0d.0
ali15x3: chipset revision 193
ali15x3: not 100% native mode, will probe irqs later
  ide0: bm-dma at 0x8420-0x8427, bios settings: hda:pio, hdb:pio
  ide1: bm-dma at 0x8428-0x842f, bios settings: hdc:pio, hdd:pio
hdc:hdc: status timeout: status=0xff {busy}

hdc: drive not ready for command

ide1:reset timed-out, status=0xff
hdc: status timeout: status=0xff {busy}
hdc: drive not ready for command
[...stuff scrolls off screen too fast to read...]
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 8
end_request: I/O error, dev 16:00 (hdc), sector 10
end_request: I/O error, dev 16:00 (hdc), sector 12
end_request: I/O error, dev 16:00 (hdc), sector 14
end_request: I/O error, dev 16:00 (hdc), sector 0
end_request: I/O error, dev 16:00 (hdc), sector 2
end_request: I/O error, dev 16:00 (hdc), sector 4
end_request: I/O error, dev 16:00 (hdc), sector 6
end_request: I/O error, dev 16:00 (hdc), sector 8
end_request: I/O error, dev 16:00 (hdc), sector 10
end_request: I/O error, dev 16:00 (hdc), sector 12
end_request: I/O error, dev 16:00 (hdc), sector 14
 unable to read partition table
[...continues with unrelated stuff, then panics due to no root fs...]

--------------020309010405020702040406
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== include/asm-alpha/system.h 1.4 vs edited =====
--- 1.4/include/asm-alpha/system.h	Tue Feb  5 02:49:34 2002
+++ edited/include/asm-alpha/system.h	Thu Dec  5 20:28:28 2002
@@ -310,11 +310,13 @@
 #define __save_flags(flags)	((flags) = rdps())
 #define __save_and_cli(flags)	do { (flags) = swpipl(IPL_MAX); barrier(); } while(0)
 #define __restore_flags(flags)	do { barrier(); setipl(flags); barrier(); } while(0)
+#define __save_and_sti(flags)   do { (flags) = swpipl(IPL_MIN); barrier(); } while(0)
 
 #define local_irq_save(flags)		__save_and_cli(flags)
 #define local_irq_restore(flags)	__restore_flags(flags)
 #define local_irq_disable()		__cli()
 #define local_irq_enable()		__sti()
+#define local_irq_set(flags)		__save_and_sti(flags)
 
 #ifdef CONFIG_SMP
 

--------------020309010405020702040406
Content-Type: text/plain;
 name="alpha-config.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alpha-config.txt"

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
# CONFIG_IDEDISK_MULTI_MODE is not set
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
CONFIG_BLK_DEV_ALI15X3=y
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NFORCE is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

--------------020309010405020702040406--

