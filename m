Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVIFQrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVIFQrL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 12:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVIFQrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 12:47:11 -0400
Received: from touchdown.wvpn.de ([212.227.64.97]:60148 "EHLO mail.wvpn.de")
	by vger.kernel.org with ESMTP id S1750760AbVIFQrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 12:47:10 -0400
Message-ID: <431DC80C.8030706@maintech.de>
Date: Tue, 06 Sep 2005 18:47:08 +0200
From: "Thomas Kleffel (LKML)" <lkml@maintech.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: B.Zolnierkiewicz@elka.pw.edu.pl
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: [PATCH] Make ide-cs work for hardware with 8-bit CF-Interface
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

it is technically possible to access a CF-Card with an 8-bit width bus.

The problem with the current code is that the IDE code does a 16 (or 32) 
bit read on the IDE data register. If the bus interface for a 8-bit bus 
would then do two reads to offsets 0 and 1.

The second read (to offset 1) then reads the error register instead of 
the data register's odd byte.

To fix this problem I've changed the ide-cs code to use the duplicated 
data registers at offset 8 and 9 which are not overlapped with anything.

According to the specs, those registers should be there in every CF 
card. I've tested this with a couple of CFs, including SanDisk, 
Microdrive and several NoNames.

The specific architechture I'm using this on is a AT91RM9200 with kernel 
2.6.13 and the patches from http://maxim.org.za/AT91RM9200/2.6/.

For more information on the overlapped / non-overlapped registers see 
http://www.compactflash.org/cfspc3_0.pdf - page 96

The following patch is against vanilla 2.6.13.

ldiff -uprN a/drivers/ide/legacy/ide-cs.c b/drivers/ide/legacy/ide-cs.c
--- a/drivers/ide/legacy/ide-cs.c       2005-08-08 15:30:35.000000000 +0200
+++ b/drivers/ide/legacy/ide-cs.c       2005-09-05 02:09:47.000000000 +0200
@@ -186,7 +186,8 @@ static int idecs_register(unsigned long
  {
      hw_regs_t hw;
      memset(&hw, 0, sizeof(hw));
-    ide_init_hwif_ports(&hw, io, ctl, NULL);
+    ide_std_init_ports(&hw, io, ctl);
+    hw.io_ports[IDE_DATA_OFFSET] = io + 0x08;
      hw.irq = irq;
      hw.chipset = ide_pci;
      return ide_register_hw_with_fixup(&hw, NULL, ide_undecoded_slave);


Signed-off-by: Thomas Kleffel <tk@maintech.de>


Best regards,

Thomas
