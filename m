Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264108AbUESGz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbUESGz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 02:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUESGzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 02:55:41 -0400
Received: from pop.gmx.de ([213.165.64.20]:16843 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264085AbUESGz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 02:55:29 -0400
X-Authenticated: #1049660
Message-ID: <40AB0557.9080705@bitclown.de>
Date: Wed, 19 May 2004 08:57:27 +0200
From: Grischa Jacobs <grischa@bitclown.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniele Venzano <webvenza@libero.it>
CC: Dominik Karall <dominik.karall@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Sis900 bug fixes 0/4
References: <20040518120237.GC23565@picchio.gall.it> <200405181539.32595.dominik.karall@gmx.net>
In-Reply-To: <200405181539.32595.dominik.karall@gmx.net>
Content-Type: multipart/mixed;
 boundary="------------090308090307050109050409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090308090307050109050409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dominik Karall wrote:
> I applied all 4 patches, but the wrong PHY transceiver is used now again.
> Here is the dmesg output:
> 
> sis900.c: v1.08.07 11/02/2003
> eth0: Unknown PHY transceiver found at address 0.
> eth0: Realtek RTL8201 PHY transceiver found at address 1.
> eth0: Unknown PHY transceiver found at address 2.
<snip>
> eth0: Unknown PHY transceiver found at address 31.
> eth0: Using transceiver found at address 31 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xdc00, IRQ 19, 00:10:dc:8f:a9:ac.
> 
> greets,
> dominik
> -

Hi

I had the same messages about unknown PHY transceivers and very poor 
transfer rates. I figured that all but one of the transceivers had the 
status bit MII_STAT_FAULT set. Selecting that one solved my problems.

I posted this and the patch already a while ago but didn't get any 
response. It would be nice if a few people could check whether this 
fixes/breaks it for them.

I just checked it with 2.6.6-rc3 and the problem is still there and gets 
solved by the attached patch.


Grischa

--------------090308090307050109050409
Content-Type: text/plain;
 name="patch-2.6.3-bc-sis900"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.3-bc-sis900"

--- linux-2.6.3/drivers/net/sis900.c	2004-03-08 20:50:05.000000000 +0100
+++ linux-2.6.3-bc/drivers/net/sis900.c	2004-02-20 14:56:00.000000000 +0100
@@ -18,6 +18,7 @@
    preliminary Rev. 1.0 Jan. 18, 1998
    http://www.sis.com.tw/support/databook.htm
 
+               Jan.  7 2004 Grischa Jacobs - Skip mii's with MII_STAT_FAULT set
    Rev 1.08.07 Nov.  2 2003 Daniele Venzano <webvenza@libero.it> add suspend/resume support
    Rev 1.08.06 Sep. 24 2002 Mufasa Yang bug fix for Tx timeout & add SiS963 support
    Rev 1.08.05 Jun.  6 2002 Mufasa Yang bug fix for read_eeprom & Tx descriptor over-boundary
@@ -541,6 +542,10 @@
 			/* the mii is not accessible, try next one */
 			continue;
 		
+		if (mii_status & MII_STAT_FAULT)
+			/* ignore mii with the fault bit set */
+			continue;
+
 		if ((mii_phy = kmalloc(sizeof(struct mii_phy), GFP_KERNEL)) == NULL) {
 			printk(KERN_INFO "Cannot allocate mem for struct mii_phy\n");
 			mii_phy = sis_priv->first_mii;

--------------090308090307050109050409--
