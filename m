Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269277AbUJFPOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269277AbUJFPOL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269290AbUJFPOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:14:10 -0400
Received: from mail0.lsil.com ([147.145.40.20]:25053 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S269277AbUJFPNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:13:34 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57036623EC@exa-atlanta>
From: "Ju, Seokmann" <sju@lsil.com>
To: "'OHKUBO Katsuhiko '" 
	<IMCEAMAILTO-ohkubo-k+40suri+2Eco+2Ejp@atl1.se.lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: SCSI cache flush will be lack under some circumstances??
Date: Wed, 6 Oct 2004 11:13:28 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There are two different cache involved in your concern.
One is cache in each HDD to enhance write performance of it. The other one
is cache in RAID controller.
When you set cache to 'write back' using utility for RAID controller, it
towards to cache in RAID controller.
So, even though kernel doesn't flush SCSI cache, MegaRAID driver will make
sure data consistency including data on both cache through driver's shutdown
entry-point and F/W that controls each physical disk as well.

I hope this helps you.

Regards,


Seokmann


-----Original Message-----
From: OHKUBO Katsuhiko [mailto:ohkubo-k@suri.co.jp]
Sent: Friday, October 01, 2004 5:38 AM
To: linux-kernel@vger.kernel.org
Subject: SCSI cache flush will be lack under some circumstances??

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
