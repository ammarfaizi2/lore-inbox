Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264344AbUE2QtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264344AbUE2QtG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 12:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUE2QtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 12:49:06 -0400
Received: from wasp.conceptual.net.au ([203.190.192.17]:4584 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S264344AbUE2QtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 12:49:03 -0400
Message-ID: <40B8BF05.9020703@wasp.net.au>
Date: Sat, 29 May 2004 20:49:09 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: libata regression 2.6.6-rc1 -> 2.6.6-rc2 located
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I managed to narrow it down to a diff between 2.6.6-rc1 and 2.6.6-rc2

2.6.6-rc1 works fine and 2.6.6-rc2 exhibits the lockup on the third card.

Reverting this hunk makes everything happy again.
I also tested this against 2.6.7-rc1-bk4 and it solves the problem.
I don't pretend to understand why, just did the donkey testing to locate it.


diff -urN linux-2.6.5-a/drivers/scsi/sata_promise.c linux-2.6.5-b/drivers/scsi/sata_promise.c
--- linux-2.6.5-a/drivers/scsi/sata_promise.c   2004-05-29 19:53:40.000000000 +0400
+++ linux-2.6.5-b/drivers/scsi/sata_promise.c   2004-05-29 19:41:47.000000000 +0400
@@ -1180,14 +1180,14 @@

  static void pdc_tf_load_mmio(struct ata_port *ap, struct ata_taskfile *tf)
  {
-       if (tf->protocol != ATA_PROT_DMA)
+       if (tf->protocol == ATA_PROT_PIO)
                 ata_tf_load_mmio(ap, tf);
  }


  static void pdc_exec_command_mmio(struct ata_port *ap, struct ata_taskfile *tf)
  {
-       if (tf->protocol != ATA_PROT_DMA)
+       if (tf->protocol == ATA_PROT_PIO)
                 ata_exec_command_mmio(ap, tf);
  }


Hope this helps shed some light.. Still don't understand why it works perfectly with only 2 cards 
however.

Regards,
Brad
