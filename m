Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266799AbUGLL2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266799AbUGLL2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 07:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266802AbUGLL2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 07:28:48 -0400
Received: from mail.dif.dk ([193.138.115.101]:32997 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S266799AbUGLL2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 07:28:43 -0400
Date: Mon, 12 Jul 2004 13:27:17 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Roger Luethi <rl@hellgate.ch>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine breaks with recent Linus kernels : probe of 0000:00:09.0
 failed with error -5
In-Reply-To: <20040712080933.GA9221@k3.hellgate.ch>
Message-ID: <Pine.LNX.4.56.0407121317130.24721@jjulnx.backbone.dif.dk>
References: <8A43C34093B3D5119F7D0004AC56F4BC082C7F9E@difpst1a.dif.dk>
 <20040712080933.GA9221@k3.hellgate.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jul 2004, Roger Luethi wrote:

> On Mon, 12 Jul 2004 03:49:35 +0200, Jesper Juhl wrote:
> > I've noticed that with recent kernels from Linus' tree the via-rhine
> > driver that I use for my NIC seems to have broken.
> >
[snip]
> >
> > I get the following from the kernels that break:
> > Invalid MAC address for card #0
> > via-rhine: probe of 0000:00:09.0 failed with error -5
>
> I had this happen recently when I moved from rc3-bk6 to bk20. When I
> started to look into it, the problem went away and never came back.
>
> There are some subtle timing issues with chip resets and reloading the
> EEPROM. So far, it was the Rhine-I which has been more sensitive, but
> when I hit this problem Rhine-I was fine while Rhine-II and Rhine-III
> were not.
>
> You can try adding an msleep(5) before and after reload_eeprom (make
> sure you get the right one, mainline still has two ifdef'ed calls),
> or you can try switching drivers between mainline and -mm.
>

Making this change to 2.6.8-rc1 has no effect for me :

diff -uP linux-2.6.8-rc1-orig/drivers/net/via-rhine.c linux-2.6.8-rc1/drivers/net/via-rhine.c
--- linux-2.6.8-rc1-orig/drivers/net/via-rhine.c	2004-07-12 01:42:03.000000000 +0200
+++ linux-2.6.8-rc1/drivers/net/via-rhine.c	2004-07-12 13:28:22.000000000 +0200
@@ -757,14 +757,17 @@
 	wait_for_reset(dev, quirks, shortname);

 	/* Reload the station address from the EEPROM. */
+	msleep(5);
 #ifdef USE_MMIO
 	reload_eeprom(ioaddr0);
+	msleep(5);
 	/* Reloading from eeprom overwrites cfgA-D, so we must re-enable MMIO.
 	   If reload_eeprom() was done first this could be avoided, but it is
 	   not known if that still works with the "win98-reboot" problem. */
 	enable_mmio(ioaddr0, quirks);
 #else
 	reload_eeprom(ioaddr);
+	msleep(5);
 #endif

 	for (i = 0; i < 6; i++)


But, copying the driver from 2.6.7-mm7 to 2.6.8-rc1 works like a charm.


--
Jesper Juhl <juhl-lkml@dif.dk>

