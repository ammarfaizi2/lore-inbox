Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265936AbUAKRTf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 12:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265940AbUAKRTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 12:19:35 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:50421 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S265936AbUAKRTe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 12:19:34 -0500
Date: Sun, 11 Jan 2004 12:27:36 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Piotr Kaczuba <pepe@attika.ath.cx>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: tulip driver: errors instead TX packets?
Message-ID: <20040111122736.A16869@mail.kroptech.com>
References: <20040110144831.GA16080@orbiter.attika.ath.cx> <400035F5.3040300@pobox.com> <4000607D.1020102@attika.ath.cx> <20040110222038.A4817@mail.kroptech.com> <40013E83.6070108@attika.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40013E83.6070108@attika.ath.cx>; from pepe@attika.ath.cx on Sun, Jan 11, 2004 at 01:16:03PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 01:16:03PM +0100, Piotr Kaczuba wrote:
>
> Here is the output of dmesg after setting TULIP_DEBUG to 4 and starting 
> pppd (eth0 is used by PPPoE). I agree that the code looks okay but 

<snip>

> eth0: Transmit error, Tx status 1a078c80.

That would be heartbeat failure, no carrier, and loss of carrier. It's
interesting that you seem to be able to get valid packets on the wire
because the latter two errors are usually quite fatal. I suspect either
the Comet is just buggy and those error bits aren't to be trusted or
there is something wrong with the PHY config. I don't have docs on the
Comet PHY so there's not much I can do.

On whim, does the patch below change anything for you?

--Adam


--- linux-2.6.1/drivers/net/tulip/tulip_core.c.orig	Sun Jan 11 12:06:34 2004
+++ linux-2.6.1/drivers/net/tulip/tulip_core.c	Sun Jan 11 12:09:13 2004
@@ -438,7 +438,7 @@
 		/* Enable automatic Tx underrun recovery. */
 		outl(inl(ioaddr + 0x88) | 1, ioaddr + 0x88);
 		dev->if_port = tp->mii_cnt ? 11 : 0;
-		tp->csr6 = 0x00040000;
+		tp->csr6 = 0x000C0000;
 	} else if (tp->chip_id == AX88140) {
 		tp->csr6 = tp->mii_cnt ? 0x00040100 : 0x00000100;
 	} else

