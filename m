Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbULaCIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbULaCIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 21:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbULaCIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 21:08:44 -0500
Received: from mail.convergence.de ([212.227.36.84]:11183 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261554AbULaCIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 21:08:41 -0500
Date: Fri, 31 Dec 2004 03:08:14 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: linux-kernel@vger.kernel.org
Cc: Bernhard Rosenkraenzer <bero@arklinux.org>,
       Gerd Knorr <kraxel@bytesex.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Current saa7134 driver breaks KNC One Tv-Station DVR (card=24)
Message-ID: <20041231020814.GA15220@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	linux-kernel@vger.kernel.org,
	Bernhard Rosenkraenzer <bero@arklinux.org>,
	Gerd Knorr <kraxel@bytesex.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412281928.05898.bero@arklinux.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer wrote:
> On Tuesday 28 December 2004 18:21, Bernhard Rosenkraenzer wrote:
> > Trying to modprobe saa7134 with this card results in a hanging modprobe
> > process.
> 
> Some more debug info (with 2.6.10-ac1):
> 
> saa7130/34: v4l2 driver version 0.2.12 loaded
> ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 17 (level, low) -> IRQ 177
> saa7134[0]: found at 0000:00:06.0, rev: 1, irq: 177, latency: 64, mmio: 0xdfff9c00
> saa7134[0]: subsystem: 1894:a006, board: KNC One TV-Station DVR [card=24,autodetected]
...
> saa7134: Loading i2c helpers<7>saa7134[0]: i2c xfer: < c0 >
> tuner: chip found at addr 0xc0 i2c-bus saa7134[0]
> tuner: type set to 38 (Philips PAL/SECAM multi (FM1216ME MK3)) by saa7134[0]
...
> tda9885/6/7: chip found @ 0x86
...
> saa7134[0]/irq: looping -- clearing PE (parity error!) enable bit
> saa7134[0]/irq[0,-227141]: r=0x20 s=0x00 PE
> [modprobe hangs]
> 
> Looks like it's hanging at request_module("saa7134-empress");

I've reported this before:
http://lkml.org/lkml/2004/11/17/275

The patch that Rusty posted doesn't seem to have it made into
module-init-tools-3.1. Bummer :-(

The Bug in saa7134-core.c doesn't seem to have been addressed yet, so
I suggest the following patch as a temporary measure:

--- linux-2.6.10/drivers/media/video/saa7134/saa7134-core.c.orig	2004-12-25 19:22:55.000000000 +0100
+++ linux-2.6.10/drivers/media/video/saa7134/saa7134-core.c	2004-12-25 19:23:31.000000000 +0100
@@ -940,12 +940,12 @@ static int __devinit saa7134_initdev(str
 		request_module("tuner");
 	if (dev->tda9887_conf)
 		request_module("tda9887");
-  	if (card_is_empress(dev)) {
-		request_module("saa7134-empress");
+	if (card_is_empress(dev)) {
+//		request_module("saa7134-empress");
 		request_module("saa6752hs");
 	}
-  	if (card_is_dvb(dev))
-		request_module("saa7134-dvb");
+//	if (card_is_dvb(dev))
+//		request_module("saa7134-dvb");
 
 	v4l2_prio_init(&dev->prio);
 

Johannes
