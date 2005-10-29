Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVJ3PHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVJ3PHr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJ3PHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:07:47 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:6816 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750781AbVJ3PHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:07:46 -0500
From: Manfred Scherer <manfred.scherer.mhm@t-online.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: PATCH for promise ide controllers
Date: Sat, 29 Oct 2005 16:18:05 +0200
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510291618.06127.manfred.scherer.mhm@t-online.de>
X-ID: Z4x2AeZOQehpc9+Mn6QOJ20Lk8YIXh0oByg2aPrMnSGYI12VFbCgZj
X-TOI-MSGID: dba2bfee-a050-4e63-873a-34503f6e2303
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
while read data from the hard disk and a read error
occurs as reported below, the kernel will hang in ide-io.c
in the function try_to_flush_leftover_data()
in the statement hwif->INSW(IDE_DATA_REG, buffer, wcount<<1).

On the console 10 appears this messages:
hde: dma_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hde: dma_intr: error=0x01 { AddrMarkNot Found }, LBAsect=1253209, high=0, low=1253209, sector=1252805


This strange behaviour seems to be a special issue with promise controllers
especially with the models ID_PROMISE_20268 (thats was my personal test case)
and ID_PROMISE_20269 as reported years ago in the internet.

My suggestion is to leave off try_to_flush_leftover_data() for
promise controllers.

Unfortunately it is hard to reproduce this test case if you don't have
such a disk controller and such a disk fault.

---------------------------------------------------------------------------
--- ./linux-2.6.13/drivers/ide/ide-io.c.ORIG    2005-08-29 01:41:01.000000000 +0200
+++ ./linux-2.6.13/drivers/ide/ide-io.c 2005-10-12 15:50:20.000000000 +0200
@@ -445,10 +445,44 @@
                        /* help it find track zero */
                        rq->errors |= ERROR_RECAL;
                }
+               /* 2005/09/10 --ms, this case was left here */
+               else if (err & MARK_ERR) {
+                       /* retry because AddrMarkNotFound */
+                       rq->errors |= ERROR_RECAL;
+                }
        }

        if ((stat & DRQ_STAT) && rq_data_dir(rq) == READ)
-               try_to_flush_leftover_data(drive);
+               /* 2005-09-10 --ms
+                * To avoid a system hang in hwif->INSW(IDE_DATA_REG, buffer, wcount<<1),
+                * possibly caused by a bug in the disk controller, hence we check
+                * here the disk controller model.
+                */
+               switch(HWIF(drive)->pci_dev->device) {
+                       // case PCI_DEVICE_ID_PROMISE_20277:
+                       // case PCI_DEVICE_ID_PROMISE_20276:
+                       // case PCI_DEVICE_ID_PROMISE_20275:
+                       // case PCI_DEVICE_ID_PROMISE_20271:
+                       // case PCI_DEVICE_ID_PROMISE_20270:
+                       case PCI_DEVICE_ID_PROMISE_20269:
+                       case PCI_DEVICE_ID_PROMISE_20268:       // my pci device
+                               printk(KERN_WARNING "%s: ide_ata_error, PROMISE_202*\n", drive->name);
+                               /* try_to_flush_leftover_data() will hang in various cases like:
+                                * ABRT_ERR     DriveStatusError
+                                * ICRC_ERR     BadCRC BadSector
+                                * ECC_ERR      UncorrectableError (will hang too)
+                                * ID_ERR       SectorIdNotFound
+                                * TRK0_ERR     TrackZeroNotFound
+                                * MARK_ERR     AddrMarkNotFound (this was my actual testcase)
+                                */
+                               if (!(err & (ABRT_ERR | ICRC_ERR | ECC_ERR | ID_ERR | TRK0_ERR | MARK_ERR)))
+                                       try_to_flush_leftover_data(drive);
+
+                               break;
+                       default:
+                               try_to_flush_leftover_data(drive);
+               }
+

        if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT))
                /* force an abort */
---------------------------------------------------------------------------
--- ./linux-2.6.13/drivers/ide/ide-iops.c.ORIG  2005-08-29 01:41:01.000000000 +0200
+++ ./linux-2.6.13/drivers/ide/ide-iops.c       2005-10-12 16:02:44.000000000 +0200
@@ -1103,7 +1103,8 @@
                if (drive->current_speed >= XFER_SW_DMA_0)
                        (void) HWIF(drive)->ide_dma_on(drive);
        } else
-               (void)__ide_dma_off(drive);
+               // (void)__ide_dma_off(drive);
+               return; // 2005-09-10 --ms, no crc-error, leave speed as it is!
 #endif
 }

---------------------------------------------------------------------------
Signed-off-by: Manfred Scherer <manfred.scherer.mhm@t-online.de>
-------------------------------------------------------------------------
BTW I think the 2.4 kernel will have the same problem.
-------------------------------------------------------------------------
Manfred Scherer

