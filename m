Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269729AbUJAJh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269729AbUJAJh7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 05:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269730AbUJAJh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 05:37:59 -0400
Received: from mail.suri.co.jp ([61.194.3.174]:23561 "EHLO mail.suri.co.jp")
	by vger.kernel.org with ESMTP id S269729AbUJAJh4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 05:37:56 -0400
Date: Fri, 01 Oct 2004 18:37:53 +0900
From: OHKUBO Katsuhiko <ohkubo-k@suri.co.jp>
To: linux-kernel@vger.kernel.org
Subject: SCSI cache flush will be lack under some circumstances??
Message-Id: <20041001183610.8DB5.OHKUBO-K@suri.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.11.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear developers,

I am using Linux 2.6.8.1 with megaraid card.
At boot time, I saw drive cache type was assumed to be 'write through'.

------
megaraid cmm: 2.20.2.0 (Release Date: Thu Aug 19 09:58:33 EDT 2004)
megaraid: 2.20.3.1 (Release Date: Tue Aug 24 09:43:35 EDT 2004)
megaraid: probe new device 0x1000:0x1960:0x1028:0x0520: bus 1:slot 2:func 0
megaraid: fw version:[3.41] bios version:[1.06]
scsi0 : LSI Logic MegaRAID driver
scsi[0]: scanning scsi channel 0 [Phy 0] for non-raid devices
  Vendor: SDR       Model: GEM318P           Rev: 1
  Type:   Processor                          ANSI SCSI revision: 02
scsi[0]: scanning scsi channel 1 [virtual] for logical drives
  Vendor: MegaRAID  Model: LD0 RAID5 79796R  Rev: 3.41
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: MegaRAID  Model: LD1 RAID5     4R  Rev: 3.41
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 573022208 512-byte hdwr sectors (293387 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
...
------

If kernel cannot get cache type, write cache type (sdkp->WCE) is set
to 'write through' mode (=0) in sd_read_cache_type() at drivers/scsi/sd.c.
sdkp->WCE is only reffered in sd_shutdown() to decide
whether SCSI cache flush is necessary or not.
SCSI cache is flushed only at 'write back' mode (sdkp->WCE is 1).

On such behavior, even if I configure my RAID card to 'write back' mode,
Linux kernel assumes it is 'write through' mode because kernel cannot get
write type, so kernel doesn't flush SCSI cache in sd_shutdown().
I think it will be a disk consistency problem.

To avoid such problem, I think write cache type must be assumed to be
'write back' if kernel cannot get write cache type.

--- drivers/scsi/sd.c.old       2004-10-01 17:32:06.000000000 +0900
+++ drivers/scsi/sd.c   2004-10-01 17:32:31.000000000 +0900
@@ -1251,9 +1251,9 @@
        }

 defaults:
-       printk(KERN_ERR "%s: assuming drive cache: write through\n",
+       printk(KERN_ERR "%s: assuming drive cache: write back\n",
               diskname);
-       sdkp->WCE = 0;
+       sdkp->WCE = 1;
        sdkp->RCD = 0;
 }


If RAID card is configured to 'write through' mode, and if kernel assumes
it is 'write back' mode, unnecessary cache flush request (no data to flush)
will be done.


Thanks in advance for any help, OHKUBO Katsuhiko.

