Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWETImb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWETImb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 04:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbWETImb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 04:42:31 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:40392 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S932249AbWETIma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 04:42:30 -0400
Message-ID: <446ED636.4000905@ru.mvista.com>
Date: Sat, 20 May 2006 12:41:26 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] HPT37x: read f_CNT saved by BIOS from port
References: <444B3BDE.1030106@ru.mvista.com> <4457DC97.3010807@ru.mvista.com> <445A5A1B.60903@ru.mvista.com>
In-Reply-To: <445A5A1B.60903@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------010806010505080003010008"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010806010505080003010008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

    The undocumented register BIOS uses for saving f_CNT seems to only be
mapped to I/O space while all the other HPT3xx regs are dual-mapped. Looks
like another HighPoint's dirty trick.
    With this patch, the deadly kernel oops on the cards having the modern
HighPoint BIOSes is now at last gone!

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>


--------------010806010505080003010008
Content-Type: text/plain;
 name="HPT37x-read-f_CNT-from-port.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT37x-read-f_CNT-from-port.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -1016,14 +1016,14 @@ static void __devinit hpt37x_clocking(id
 	 * First try reading the register in which the HighPoint BIOS
 	 * saves f_CNT value before  reprogramming the DPLL from its
 	 * default setting (which differs for the various chips).
+	 * NOTE: This register is only accessible via I/O space.
+	 *
 	 * In case the signature check fails, we'll have to resort to
 	 * reading the f_CNT register itself in hopes that nobody has
 	 * touched the DPLL yet...
 	 */
-	pci_read_config_dword(dev, 0x70, &temp);
+	temp = inl(pci_resource_start(dev, 4) + 0x90);
 	if ((temp & 0xFFFFF000) != 0xABCDE000) {
-		int i;
-
 		printk(KERN_WARNING "HPT37X: no clock data saved by BIOS\n");
 
 		/* Calculate the average value of f_CNT */



--------------010806010505080003010008--
