Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVBFPKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVBFPKB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 10:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVBFPKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 10:10:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58586 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261165AbVBFPJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 10:09:22 -0500
Message-ID: <42063312.8090606@pobox.com>
Date: Sun, 06 Feb 2005 10:09:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Reply-To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [SATA] libata-dev queue updated, status report
Content-Type: multipart/mixed;
 boundary="------------040108020600060305030601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040108020600060305030601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

libata-dev-2.6, the development queue for the Linux SATA driver libata, 
has been updated.  See attachment for BK info, patch URL, and full list 
of changes.

Here is a quick summary of the goodies lurking in libata-dev, and also 
the Reason Why It's Not Upstream (RWINU):


1) ATA passthru.  Arbitrary ATA command execution.  Provides SMART and 
hdparm support, among other things.

RWINU:  SCSI T10 committee will not standardize the opcodes for this 
until March 2005.  The "set transfer mode" command must be 
special-cased, since it requires additional per-controller work to 
reconfigure DMA timings and such.


2) Turn on ATAPI.

RWINU:  Needs some more testing, and need to resolve discrepancy between 
ATA/ATAPI-4 and ATA/ATAPI-7 for ATAPI DMA host state machine.


3) Detect PATA devices attached to SATA controllers (via a bridge), and 
adjust settings to limit udma mode and maximum number of sectors, due to 
  problems with certain bridge/controller combinations and issues 
reported in the field.

RWINU: Not certain that the hueristic reliably detects a PATA device 
attached to a SATA controller.


4) Cleanup:  Remove 'execute device diagnostic' reset support, making 
code smaller.

RWINU: Need to make sure no out-of-tree drivers are using it.


5) hdparm 'get identity' ioctl support.

RWINU: Bart had some objections that warranted attention (but I forget 
what those objections were, alas).


Additional hardware support
---------------------------

1) New driver:  Promise 2027x (PATA)

RWINU:  Need to plan a good strategy for users who wish to use this 
driver, versus the PATA driver in drivers/ide.  Also applies to other 
PATA drivers people will eventually port to libata.


2) New driver:  ADMA.  Supports several Pacific Digital controllers, 
among others.

RWINU: Never tested on real hardware; needs testing.


3) New driver:  VIA VT6421.

RWINU: Never tested on real hardware; needs testing.


4) Support for PATA port on Promise SATA controllers.

RWINU:  I'm not sure whether the API change necessary for this is the 
correct one.  Need to ponder.  Comments welcome.


5) Support for Promise PDC20619 (a.k.a. TX4000) PATA controller.

RWINU:  Needs additional testing.  Need to rename 'sata_promise' to 
'ata_promise', then create a method of aliasing the old module name, to 
avoid breaking existing setups.  2.6.x has the MODULE_ALIAS() method, 
2.4.x needs a Makefile rule to build an additional module.


6) core libata PATA support.

RWINU:  PATA is working, but needs a few missing pieces filled in.   CHS 
support is one (Albert Lee just started on this, posting the first 
patches to linux-ide last night), DMA blacklist is another (done; 
upstream soon), and a few other details.  Also the issues mentioned in 
"#1 Promise PDC2027x" (above).


--------------040108020600060305030601
Content-Type: text/plain;
 name="libata-dev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libata-dev.txt"

BK users:

	bk pull bk://gkernel.bkbits.net/libata-dev-2.6

Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.11-rc3-bk2-libata-dev1.patch.bz2

This will update the following files:

 drivers/scsi/Kconfig         |   18 -
 drivers/scsi/Makefile        |    2 
 drivers/scsi/ahci.c          |    2 
 drivers/scsi/ata_adma.c      |  636 ++++++++++++++++++++++++++++++++++++
 drivers/scsi/libata-core.c   |  361 +++++++++++---------
 drivers/scsi/libata-scsi.c   |  444 ++++++++++++++++++++++++-
 drivers/scsi/libata.h        |    6 
 drivers/scsi/pata_pdc2027x.c |  742 +++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/sata_nv.c       |   45 +-
 drivers/scsi/sata_promise.c  |   98 +++++
 drivers/scsi/sata_sil.c      |    1 
 drivers/scsi/sata_via.c      |  202 ++++++++---
 include/linux/ata.h          |    3 
 include/linux/libata.h       |    6 
 include/scsi/scsi.h          |    3 
 15 files changed, 2305 insertions(+), 264 deletions(-)

through these ChangeSets:

<andyw:pobox.com>:
  o [libata scsi] support 12-byte passthru CDB
  o [libata scsi] passthru CDB check condition processing
  o T10/04-262 ATA pass thru - patch

<erikbenada:yahoo.ca>:
  o [libata sata_promise] support PATA ports on SATA controllers

<jpaana:s2.org>:
  o [libata sata_promise] add PCI ID for new SATAII TX2 card

<mkrikis:yahoo.com>:
  o libata: fix ata_piix on ICH6R in RAID mode

<syntax:pa.net>:
  o [libata sata_sil] add another Seagate drive to blacklist

Adam J. Richter:
  o ata_pci_remove_one used freed memory

Albert Lee:
  o [libata] SCSI-to-ATA translation fixes
  o pdc2027x timing register bug fix
  o [libata pdc2027x] fix incorrect pio and mwdma masks
  o [libata pdc2027x] remove quirks and ROM enable
  o [libata] add driver for Promise PATA 2027x

Andrew Chew:
  o sata_nv: enable generic class support for future NVIDIA SATA

Brad Campbell:
  o libata basic detection and errata for PATA->SATA bridges

Brett Russ:
  o [libata scsi] verify cmd bug fixes/support

Jeff Garzik:
  o [libata ahci] Add support for ULi M5288
  o [libata] turn on ATAPI support
  o [libata sata_promise] merge Tobias Lorenz' pdc20619 patch, part 2
  o [libata] small cleanups
  o [libata] remove unused execute-device-diagnostic reset method
  o [libata sata_promise] support Promise SATAII TX2/TX4 cards
  o [libata] Remove CDROM drive from PATA DMA blacklist
  o [libata] add DMA blacklist
  o [libata] add new driver ata_adma
  o [libata sata_via] add support for VT6421 SATA
  o [libata sata_via] minor cleanups
  o [libata pdc2027x] update for upstream struct device conversion
  o [libata sata_promise] fix merge bugs
  o [libata] fix build breakage
  o [libata] fix SATA->PATA bridge detect compile breakage
  o [libata] fix printk warning

John W. Linville:
  o libata: SMART support via ATA pass-thru

Pete Zaitcev:
  o [libata] fix probe object allocation bugs

Tobias Lorenz:
  o [libata sata_promise] pdc20619 (PATA) support
  o libata-scsi: get-identity ioctl support


--------------040108020600060305030601--
