Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316258AbSFLKaZ>; Wed, 12 Jun 2002 06:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317392AbSFLKaY>; Wed, 12 Jun 2002 06:30:24 -0400
Received: from naxos.pdb.sbs.de ([192.109.3.5]:56774 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S316258AbSFLKaX>;
	Wed, 12 Jun 2002 06:30:23 -0400
Subject: OSB4 PATCH (was: Re: Serverworks OSB4 in impossible state)
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: osb4-bug@ide.cabal.tm,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <E17I4DK-0007Lt-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Jun 2002 12:30:39 +0200
Message-Id: <1023877839.23630.502.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mit, 2002-06-12 um 11.14 schrieb Alan Cox:
 > Entirely agreed

I propose this patch to remedy the problem.

I don't know how to test if the drive is a seagate drive, and
I think we don't want to do that, because it would end up in yet another
blacklist.

I cannot test if this behaves correctly on machines that do expose the
4-byte shift bug - it would be great if somebody could test that.

Martin

--- drivers/ide/serverworks.c.orig	Tue Jun 11 11:24:59 2002
+++ drivers/ide/serverworks.c	Wed Jun 12 12:00:36 2002
@@ -547,7 +547,13 @@
 			ide_hwif_t *hwif		= HWIF(drive);
 			unsigned long dma_base		= hwif->dma_base;
 	
-			if(inb(dma_base+0x02)&1)
+			/* If it's a disk on the OSB4, the DMA engine is still on,
+			   and the device reports no error status, we are probably
+			   facing the "4 byte shift" problem */
+			if(drive->media == ide_disk && 
+			   hwif->pci_dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE && 
+			   inb(dma_base+0x02)&1 &&
+			   OK_STAT (GET_STAT(), DRIVE_READY, BAD_STAT))
 			{
 #if 0		
 				int i;


-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





