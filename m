Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWACQhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWACQhQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWACQhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:37:16 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:11191 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751453AbWACQhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:37:15 -0500
Subject: [GIT PATCH] SCSI update for 2.6.15
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 03 Jan 2006 11:37:15 -0500
Message-Id: <1136306235.3457.11.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is pretty big, since some of these patches have been in scsi-misc
for several months.  The major update is moving sg and st over to the
block submission infrastructure.  This basically leaves only osst and an
odd call in gdth to be converted before we can eliminate scsi requests
entirely.

The patch is available from

master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

The short changelog is:

Alan Stern:
  o sd: Always do write-protect check

Andrew Vasquez:
  o qla2xxx: Resync with latest released ISP24xx firmware -- 4.00.16
  o qla2xxx: Add support for embedded ISP24xx firmware
  o qla2xxx: Add full firmware(-request) hotplug support for all ISPs

Arjan van de Ven:
  o Mark some core scsi data structures const

Brian King:
  o ipr: Driver initialization fix for kexec/kdump

Eric Moore:
  o pci_ids.h: add subclass code for SAS Controllers
  o mptfusion - bump version
  o mptfusion - mapping fixs required support for transport layers
  o mptfusion - prep for removing domain validation
  o mptfusion - bus_type, change SCSI to SPI
  o mptfusion - cleaning up xxx_probe error handling
  o mptfusion - adding = THIS_MODULE

James Bottomley:
  o 53c700: update endian processing macros
  o Fix up SCSI mismerge
  o Merge by hand (conflicts in scsi_lib.c)
  o qla2xxx: fix compile error caused by pci_dev.owner move
  o correct some dropped const compiler warnings

James Smart:
  o lpfc 8.1.1 : Change version number to 8.1.1
  o lpfc 8.1.1 : kill use of pci_read_config_xxx
  o lpfc 8.1.1 : Added code to adjust lun queue depth to avoid target overloading
  o lpfc 8.1.1 : Add polled-mode support
  o lpfc 8.1.1 : Bring model descriptions in sync with Emulex standard generic names
  o lpfc 8.1.1 : Add support for more members of the Light Pulse 11xxx (4Gb) family
  o lpfc 8.1.1 : Fixes to error handlers
  o lpfc 8.1.1 : Remove locking wrappers around error handlers
  o lpfc 8.1.1 : Adjust use of scsi_block_requests and interaction w/ FC transport
  o lpfc 8.1.1 : Fixes for short cable pulls
  o lpfc 8.1.1 : Correct some 8bit to 16bit field conversions/comparisons
  o lpfc 8.1.1: Miscellaneous Cleanups

Jens Axboe:
  o scsi_lib: stricter checks for clearing use_10_for_rw

Jesper Juhl:
  o handle scsi_add_host failure for aic7xxx and fix compiler warning
  o handle scsi_add_host failure for aic79xx and fix compiler warning

Kai Mäkisara:
  o Fix st oops with new scsi_execute infrastructure

Matthew Wilcox:
  o Missing const in sr_vendor
  o Merge sym53c8xx_comm.h and sym53c8xx_defs.h into ncr driver
  o Use spi_print_msg in ncr53c8xx driver
  o Add PPR support to spi_print_msg
  o Use ARRAY_SIZE in spi_print_msg
  o Fix printing of two-byte messages
  o Rename scsi_print_msg to spi_print_msg
  o Move scsi_print_msg to SPI class
  o Make scsi_transport_spi.h includable by itself
  o sym2: Version 2.2.2
  o sym2: Report disabled devices and LUNs more attractively
  o sym2: Allow NVRAM settings to limit speed and width
  o sym2: Use scsi_print_msg
  o sym2: Use DMA_40BIT_MASK constant
  o sym2: Remove code to handle DMA_BIDIRECTION requests
  o sym2: Manage sym_lcb properly
  o sym2: Remove last vestiges of sym_sniff_inquiry
  o sym2: Remove FreeBSD ifdefs
  o Mention scsi_scan_host() in scsi_mid_low_api.txt
  o Delete trailing full stop

Mike Christie:
  o seperate max_sectors from max_hw_sectors
  o convert st to use scsi_execute_async
  o convert sg to scsi_execute_async
  o add kmemcache for scsi_io_context
  o complete the whole command when it is REQ_BLOCK_PC
  o add retries field to request for REQ_BLOCK_PC use
  o Convert SCSI mid-layer to scsi_execute_async
  o export blk layer functions needed for blk_execute_rq_nowait
  o iscsi: check header digests for mgmt tasks
  o iscsi: update version
  o iscsi: lower queue depth
  o iscsi: data digest calculation fix
  o iscsi: iscsi response fix
  o iscsi: redirect fix
  o iscsi: opcode check fix

Seokmann Ju:
  o megaraid_{mbox,mm} : remove PCI Id overlaping between megaraid_legacy and megaraid_{mbox,mm}
  o megaraid_legacy: removed PCI ID overlap from the driv er

and the diffstat:

 b/Documentation/scsi/ChangeLog.megaraid   |   35 
 b/Documentation/scsi/scsi_mid_low_api.txt |   37 
 b/block/ll_rw_blk.c                       |   40 
 b/block/scsi_ioctl.c                      |    2 
 b/drivers/md/dm-table.c                   |    2 
 b/drivers/message/fusion/mptbase.c        |   14 
 b/drivers/message/fusion/mptbase.h        |   34 
 b/drivers/message/fusion/mptctl.c         |    4 
 b/drivers/message/fusion/mptfc.c          |   24 
 b/drivers/message/fusion/mptsas.c         |   55 
 b/drivers/message/fusion/mptscsih.c       |  968 +-
 b/drivers/message/fusion/mptscsih.h       |    2 
 b/drivers/message/fusion/mptspi.c         |   24 
 b/drivers/scsi/53c700.c                   |    6 
 b/drivers/scsi/53c700.h                   |   22 
 b/drivers/scsi/53c7xx.c                   |    7 
 b/drivers/scsi/Kconfig                    |   13 
 b/drivers/scsi/NCR5380.c                  |    7 
 b/drivers/scsi/aha152x.c                  |    7 
 b/drivers/scsi/aic7xxx/aic79xx_osm.c      |   11 
 b/drivers/scsi/aic7xxx/aic7xxx_osm.c      |   18 
 b/drivers/scsi/arm/Kconfig                |    1 
 b/drivers/scsi/arm/acornscsi.c            |    7 
 b/drivers/scsi/atari_NCR5380.c            |    7 
 b/drivers/scsi/ch.c                       |    4 
 b/drivers/scsi/constants.c                |  118 
 b/drivers/scsi/ipr.c                      |   17 
 b/drivers/scsi/ipr.h                      |    5 
 b/drivers/scsi/iscsi_tcp.c                |  121 
 b/drivers/scsi/iscsi_tcp.h                |    3 
 b/drivers/scsi/lpfc/lpfc.h                |   14 
 b/drivers/scsi/lpfc/lpfc_attr.c           |   92 
 b/drivers/scsi/lpfc/lpfc_crtn.h           |    3 
 b/drivers/scsi/lpfc/lpfc_disc.h           |    2 
 b/drivers/scsi/lpfc/lpfc_els.c            |    4 
 b/drivers/scsi/lpfc/lpfc_hbadisc.c        |   18 
 b/drivers/scsi/lpfc/lpfc_hw.h             |   40 
 b/drivers/scsi/lpfc/lpfc_init.c           |  183 
 b/drivers/scsi/lpfc/lpfc_nportdisc.c      |   67 
 b/drivers/scsi/lpfc/lpfc_scsi.c           |  295 
 b/drivers/scsi/lpfc/lpfc_sli.c            |  217 
 b/drivers/scsi/lpfc/lpfc_version.h        |    2 
 b/drivers/scsi/megaraid.c                 |   27 
 b/drivers/scsi/megaraid/Kconfig.megaraid  |    2 
 b/drivers/scsi/megaraid/megaraid_mbox.c   |   82 
 b/drivers/scsi/megaraid/megaraid_mbox.h   |    4 
 b/drivers/scsi/ncr53c8xx.c                |  749 +
 b/drivers/scsi/ncr53c8xx.h                | 1263 +++
 b/drivers/scsi/qla2xxx/Kconfig            |   69 
 b/drivers/scsi/qla2xxx/Makefile           |    5 
 b/drivers/scsi/qla2xxx/ql2400.c           |  111 
 b/drivers/scsi/qla2xxx/ql2400_fw.c        |12376 ++++++++++++++++++++++++++++++
 b/drivers/scsi/qla2xxx/qla_attr.c         |    2 
 b/drivers/scsi/qla2xxx/qla_def.h          |   24 
 b/drivers/scsi/qla2xxx/qla_gbl.h          |    4 
 b/drivers/scsi/qla2xxx/qla_init.c         |  248 
 b/drivers/scsi/qla2xxx/qla_os.c           |  196 
 b/drivers/scsi/raid_class.c               |    2 
 b/drivers/scsi/scsi_devinfo.c             |    5 
 b/drivers/scsi/scsi_error.c               |   47 
 b/drivers/scsi/scsi_lib.c                 |  262 
 b/drivers/scsi/scsi_priv.h                |    4 
 b/drivers/scsi/scsi_scan.c                |    2 
 b/drivers/scsi/scsi_sysfs.c               |    4 
 b/drivers/scsi/scsi_transport_fc.c        |    8 
 b/drivers/scsi/scsi_transport_spi.c       |  136 
 b/drivers/scsi/sd.c                       |    6 
 b/drivers/scsi/sg.c                       |  680 -
 b/drivers/scsi/sr.c                       |    4 
 b/drivers/scsi/sr_vendor.c                |    4 
 b/drivers/scsi/st.c                       |  279 
 b/drivers/scsi/st.h                       |   14 
 b/drivers/scsi/sun3_NCR5380.c             |    7 
 b/drivers/scsi/sym53c8xx_2/sym_defs.h     |    2 
 b/drivers/scsi/sym53c8xx_2/sym_fw.c       |   18 
 b/drivers/scsi/sym53c8xx_2/sym_fw.h       |    6 
 b/drivers/scsi/sym53c8xx_2/sym_fw1.h      |   48 
 b/drivers/scsi/sym53c8xx_2/sym_fw2.h      |   52 
 b/drivers/scsi/sym53c8xx_2/sym_glue.c     |  117 
 b/drivers/scsi/sym53c8xx_2/sym_glue.h     |    2 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.c     |  164 
 b/drivers/scsi/sym53c8xx_2/sym_hipd.h     |  104 
 b/drivers/scsi/sym53c8xx_2/sym_malloc.c   |    4 
 b/drivers/scsi/sym53c8xx_2/sym_nvram.c    |   29 
 b/drivers/scsi/sym53c8xx_2/sym_nvram.h    |    4 
 b/fs/bio.c                                |   38 
 b/include/linux/bio.h                     |    2 
 b/include/linux/blkdev.h                  |    9 
 b/include/linux/pci_ids.h                 |    1 
 b/include/scsi/scsi_cmnd.h                |    2 
 b/include/scsi/scsi_dbg.h                 |    1 
 b/include/scsi/scsi_device.h              |   12 
 b/include/scsi/scsi_transport_spi.h       |    4 
 drivers/scsi/sym53c8xx_comm.h             |  792 -
 drivers/scsi/sym53c8xx_defs.h             | 1320 ---
 95 files changed, 17442 insertions(+), 4467 deletions(-)

(big qla fw update again ... hopefully for the last time)

James


