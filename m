Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbTBDCvI>; Mon, 3 Feb 2003 21:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbTBDCvI>; Mon, 3 Feb 2003 21:51:08 -0500
Received: from ool-4351594a.dyn.optonline.net ([67.81.89.74]:51204 "EHLO
	badula.org") by vger.kernel.org with ESMTP id <S267102AbTBDCvH>;
	Mon, 3 Feb 2003 21:51:07 -0500
Date: Mon, 3 Feb 2003 22:00:37 -0500
Message-Id: <200302040300.h1430bw04813@moisil.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: "Cameron Goble" <cgoble@salud.unm.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SIS900 module detects two transceivers, picks the wrong one
In-Reply-To: <cs.lists.linux-kernel/se3e7fca.052@salud.unm.edu>
X-Newsgroups: cs.lists.linux-kernel
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i586))
X-Spam-Flag: NO
X-Spam-Score: -4.1, 7 required, EMAIL_ATTRIBUTION,IN_REP_TO,PATCH_UNIFIED_DIFF,QUOTED_EMAIL_TEXT,SIGNATURE_SHORT_DENSE,SPAM_PHRASE_00_01,USER_AGENT
X-Spam-Report: ---- Start SpamAssassin results
 
	-4.10 hits, 7 required;
 
	* -0.8 -- Found a In-Reply-To header
 
	* -0.5 -- Found a User-Agent header
 
	* -1.6 -- BODY: Contains what looks like an email attribution
 
	*  0.8 -- BODY: Spam phrases score is 00 to 01 (low)
 
	* -0.9 -- BODY: Contains what looks like a patch from diff -u
 
	* -0.8 -- BODY: Contains what looks like a quoted email text
 
	* -0.3 -- Short signature present (no empty lines)
 
	---- End of SpamAssassin results
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Feb 2003 14:42:08 -0700, Cameron Goble <cgoble@salud.unm.edu> wrote:

> I am having trouble with the SIS900 driver module v1.08.04. The module
> installs correctly and does not return an error, but ... well... 
> 
> Perhaps dmesg will explain better:
> 
> eth0: AMD79C901 HomePNA PHY transceiver found at address 2.
> eth0: AMD79C901 10BASE-T PHY transceiver found at address 3.
> eth0: using transceiver found at address 2 as default
> eth0: SiS 900 PCI Fast Ethernet at 0xec400, IRQ 11, 00:30:67:09:53:81.
> 
> So the network interface is a multi-function device, built onto the
> motherboard. The driver picks the HomePNA transceiver, but I want to use
> the 10BASE-T transceiver. Is there an option I can pass, or some code I
> can edit that force the driver to pick the 10BASE-T transceiver at
> address 3?

There is no such option, unfortunately. The driver attempts to find a 
transceiver with a link up, and uses that as a default. If it can't find
any, then it defauls to using the HomePNA (type HOME) transceiver.

So you have two choices:

1. make sure the interface is connected to a hub/switch when the driver
initializes;

or, if that doesn't work:

2. apply the following patch to the driver:

--- sis900.c.old	Mon Aug 26 14:43:22 2002
+++ sis900.c	Mon Feb  3 21:59:26 2003
@@ -513,6 +513,9 @@
 		u16 mii_status;
 		int i;
 
+		if (phy_addr == 2)
+			continue;
+
 		mii_phy = NULL;
 		for(i = 0; i < 2; i++)
 			mii_status = mdio_read(net_dev, phy_addr, MII_STATUS);

It's a crude hack, but it ought to work on your box.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
