Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVBFRQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVBFRQQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVBFROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:14:04 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:57104 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261228AbVBFRLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:11:50 -0500
To: Marco Rogantini <marco.rogantini@supsi.ch>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] pcmcia: Add support TI PCI4510 CardBus bridge
References: <Pine.LNX.4.62.0502051818370.4821@rost.dti.supsi.ch>
	<87wttmg77p.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.62.0502052052560.6832@rost.dti.supsi.ch>
	<87y8e266pu.fsf@devron.myhome.or.jp>
	<87u0oq66ab.fsf@devron.myhome.or.jp>
	<Pine.LNX.4.62.0502061530550.24476@rost.dti.supsi.ch>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 07 Feb 2005 02:11:33 +0900
In-Reply-To: <Pine.LNX.4.62.0502061530550.24476@rost.dti.supsi.ch> (Marco
 Rogantini's message of "Sun, 6 Feb 2005 15:38:30 +0100 (CET)")
Message-ID: <87hdkptxyy.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Rogantini <marco.rogantini@supsi.ch> writes:

>> +#define PCI_DEVICE_ID_TI_4510		0xac44
>> +	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4510, TI12XX),
>
> :-) It solved the problem! However I still must use the 'disable_clkrun'
> parameter to get the bridge working correctly.

Great! Thanks. I checked the datasheet, and added zoom_video
support. New patch is attached.

Andrew, could you apply this patch to your tree for testing?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



This does setup PCI4510 properly, and supports the "disable_clkrun" option.

1) Add PCI_DEVICE_ID_TI_4510 to pci_id.h.
2) Add PCI4510 to yenta_table (that uses TI12XX handlers).
3) Add zoom_video handler support.

TI12XX handlers can disable CLKRUN feature with "disable_clkrun" option.
Some devices or bridge itself seems to be needing this option as workaround.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 drivers/pcmcia/ti113x.h       |    1 +
 drivers/pcmcia/yenta_socket.c |    1 +
 include/linux/pci_ids.h       |    1 +
 3 files changed, 3 insertions(+)

diff -puN drivers/pcmcia/ti113x.h~yenta-pci4510-support drivers/pcmcia/ti113x.h
--- linux-2.6.11-rc3/drivers/pcmcia/ti113x.h~yenta-pci4510-support	2005-02-07 01:46:12.000000000 +0900
+++ linux-2.6.11-rc3-hirofumi/drivers/pcmcia/ti113x.h	2005-02-07 01:46:12.000000000 +0900
@@ -262,6 +262,7 @@ static void ti_set_zv(struct yenta_socke
 			case PCI_DEVICE_ID_TI_1220:
 			case PCI_DEVICE_ID_TI_1221:
 			case PCI_DEVICE_ID_TI_1225:
+			case PCI_DEVICE_ID_TI_4510:
 				socket->socket.zoom_video = ti_zoom_video;
 				break;	
 			case PCI_DEVICE_ID_TI_1250:
diff -puN drivers/pcmcia/yenta_socket.c~yenta-pci4510-support drivers/pcmcia/yenta_socket.c
--- linux-2.6.11-rc3/drivers/pcmcia/yenta_socket.c~yenta-pci4510-support	2005-02-07 01:46:12.000000000 +0900
+++ linux-2.6.11-rc3-hirofumi/drivers/pcmcia/yenta_socket.c	2005-02-07 01:46:12.000000000 +0900
@@ -1105,6 +1105,7 @@ static struct pci_device_id yenta_table 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4410, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4450, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4451, TI12XX),
+	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4510, TI12XX),
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_4520, TI12XX),
 
 	CB_ID(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1250, TI1250),
diff -puN include/linux/pci_ids.h~yenta-pci4510-support include/linux/pci_ids.h
--- linux-2.6.11-rc3/include/linux/pci_ids.h~yenta-pci4510-support	2005-02-07 01:46:12.000000000 +0900
+++ linux-2.6.11-rc3-hirofumi/include/linux/pci_ids.h	2005-02-07 01:46:12.000000000 +0900
@@ -753,6 +753,7 @@
 #define PCI_DEVICE_ID_TI_1251B		0xac1f
 #define PCI_DEVICE_ID_TI_4410		0xac41
 #define PCI_DEVICE_ID_TI_4451		0xac42
+#define PCI_DEVICE_ID_TI_4510		0xac44
 #define PCI_DEVICE_ID_TI_4520		0xac46
 #define PCI_DEVICE_ID_TI_1410		0xac50
 #define PCI_DEVICE_ID_TI_1420		0xac51
_
