Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbUCOR2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 12:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbUCOR2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 12:28:53 -0500
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:4818 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S262624AbUCOR2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 12:28:50 -0500
Message-Id: <200403151728.i2FHSHgu021955@ginger.cmf.nrl.navy.mil>
To: Peter Daum <gator@cs.tu-berlin.de>
cc: linux-kernel@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
       davem@redhat.com
Subject: Re: [Linux-ATM-General] NICSTAR_USE_SUNI broken in 2.6.3+ 
In-Reply-To: Message from Peter Daum <gator@cs.tu-berlin.de> 
   of "Sat, 13 Mar 2004 10:54:29 +0100." <Pine.LNX.4.30.0403131045040.3568-100000@swamp.bayern.net> 
Date: Mon, 15 Mar 2004 12:28:19 -0500
From: "chas williams (contractor)" <chas@cmf.nrl.navy.mil>
X-Spam-Score: () hits=-2.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.30.0403131045040.3568-100000@swamp.bayern.net>,Peter Dau
m writes:
>I have a bunch of machines with Forerunner LE ATM NICs.
>Starting with kernel version 2.6.3 the kernel crashes at
>boot time (see dump below) when CONFIG_ATM_NICSTAR_USE_SUNI
>
>EIP; c0252650 <suni_start+35/17d>   <=====

this points directly to suni.c:236, in particular the PRIV(dev)->dev
bit.  it looks like gcc3 fixups from akpm inadvertently converted PRIV()
to dev_data instead of phy_data.

the following patch should get things running again.

dave, can you apply to 2.6?  thanks!

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1603  -> 1.1604 
#	  drivers/atm/suni.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/15	chas@relax.cmf.nrl.navy.mil	1.1604
# [ATM]: [suni] dev_data should really by phy_data
# --------------------------------------------
#
diff -Nru a/drivers/atm/suni.c b/drivers/atm/suni.c
--- a/drivers/atm/suni.c	Mon Mar 15 12:23:09 2004
+++ b/drivers/atm/suni.c	Mon Mar 15 12:23:09 2004
@@ -230,7 +230,7 @@
 	unsigned long flags;
 	int first;
 
-	if (!(dev->dev_data = kmalloc(sizeof(struct suni_priv),GFP_KERNEL)))
+	if (!(dev->phy_data = kmalloc(sizeof(struct suni_priv),GFP_KERNEL)))
 		return -ENOMEM;
 
 	PRIV(dev)->dev = dev;

