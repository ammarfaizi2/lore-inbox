Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbWEBW1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbWEBW1n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 18:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEBW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 18:27:42 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:24783 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S965013AbWEBW1m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 18:27:42 -0400
Message-ID: <4457DC97.3010807@ru.mvista.com>
Date: Wed, 03 May 2006 02:26:31 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Fix the case of multiple HPT3xx chips present
References: <444B3BDE.1030106@ru.mvista.com>
In-Reply-To: <444B3BDE.1030106@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------070300070105070509070906"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070300070105070509070906
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    init_chipset_hpt366() modifies some fields of the ide_pci_device_t 
structure depending on the chip's revision, so pass it a copy of the structure 
to avoid issues when multiple different chips are present.
    Should apply on top of the hotswap fix.

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------070300070105070509070906
Content-Type: text/plain;
 name="HPT3xx-fix-case-of-multiple-chips.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-fix-case-of-multiple-chips.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -73,6 +73,8 @@
  *   really for 50 MHz; switch to using HPT372 tables for HPT374...
  * - fix the hotswap code:  it caused RESET- to glitch when tristating the bus,
  *   and for HPT36x the obsolete HDIO_TRISTATE_HWIF handler was called instead
+ * - pass to init_chipset() handlers a copy of the IDE PCI device structure as
+ *   they tamper with its fields
  *		<source@mvista.com>
  *
  */
@@ -1621,13 +1623,16 @@ static ide_pci_device_t hpt366_chipsets[
  *
  *	Called when the PCI registration layer (or the IDE initialization)
  *	finds a device matching our IDE device tables.
+ *
+ *	NOTE: since we'll have to modify some fields of the ide_pci_device_t
+ *	structure depending on the chip's revision, we'd better pass a local
+ *	copy down the call chain...
  */
- 
 static int __devinit hpt366_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	ide_pci_device_t *d = &hpt366_chipsets[id->driver_data];
+	ide_pci_device_t d = hpt366_chipsets[id->driver_data];
 
-	return d->init_setup(dev, d);
+	return d.init_setup(dev, &d);
 }
 
 static struct pci_device_id hpt366_pci_tbl[] = {



--------------070300070105070509070906--
