Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTCCPeK>; Mon, 3 Mar 2003 10:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbTCCPeK>; Mon, 3 Mar 2003 10:34:10 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:10730 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S266224AbTCCPeI>;
	Mon, 3 Mar 2003 10:34:08 -0500
Date: Mon, 3 Mar 2003 16:44:24 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Nicholas Wourms <nwourms@netscape.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Incorrect 80 wire detection with amd 760mpx & 2.4.21-pre4-ac7
Message-ID: <20030303164424.A6078@ucw.cz>
References: <3E615645.4010206@netscape.net> <1046571368.24901.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1046571368.24901.2.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Mar 02, 2003 at 02:16:08AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2003 at 02:16:08AM +0000, Alan Cox wrote:
> On Sun, 2003-03-02 at 00:54, Nicholas Wourms wrote:
> > FYI:
> > I suspect that: 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=104619727013220&w=2
> > is related to my problem.
> > 
> > Anyhow, I'm using a UDMA5 WesternDigital drive on a ASUS 
> > K7M266-D motherboard.  With a plain, stock 2.4.20 kernel, 
> > the viper driver properly recognizes which channel has the 
> 
> Yep. I'll apply the obvious fix if Vojtech doesn't. Its on the known
> list

Obvious fix attached.

-- 
Vojtech Pavlik
SuSE Labs

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="obvious-fix.diff"

--- linux-2.4.20-pre4-ac/drivers/ide/pci/amd74xx.c	Fri Feb 28 17:05:25 2003
+++ linux-2.4.20-pre4-amd8111/drivers/ide/pci/amd74xx.c	Fri Feb 28 17:19:37 2003
@@ -1,5 +1,5 @@
 /*
- * Version 2.9
+ * Version 2.10
  *
  * AMD 755/756/766/8111 and nVidia nForce IDE driver for Linux.
  *
@@ -103,7 +103,7 @@
 
 	amd_print("----------AMD BusMastering IDE Configuration----------------");
 
-	amd_print("Driver Version:                     2.9");
+	amd_print("Driver Version:                     2.10");
 	amd_print("South Bridge:                       %s", bmide_dev->name);
 
 	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
@@ -309,7 +309,8 @@
 
 		case AMD_UDMA_100:
 			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
-			amd_80w = ((u & 0x3) ? 1 : 0) | ((u & 0xc) ? 2 : 0);
+			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
+			amd_80w = ((t & 0x3) ? 1 : 0) | ((t & 0xc) ? 2 : 0);
 			for (i = 24; i >= 0; i -= 8)
 				if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
 					printk(KERN_WARNING "AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.\n");

--MGYHOYXEY6WxJCY8--
