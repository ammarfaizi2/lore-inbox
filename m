Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263803AbUACTDr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 14:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263836AbUACTDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 14:03:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:55174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263803AbUACTCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 14:02:50 -0500
Date: Sat, 3 Jan 2004 10:57:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Tram Lux <daniel@starbattle.com>
cc: Rob Love <rml@ximian.com>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       steve@drifthost.com, James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set released
In-Reply-To: <3FF6A612.90708@starbattle.com>
Message-ID: <Pine.LNX.4.58.0401031024090.20823@home.osdl.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org> 
 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>  <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
  <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>  <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
  <1072823015.4350.40.camel@fur>  <Pine.LNX.4.58.0312301452370.2065@home.osdl.org>
 <1072825101.4350.55.camel@fur> <3FF6A612.90708@starbattle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 3 Jan 2004, Daniel Tram Lux wrote:
>
> I tried setting the timeout up as a first fix, it also decreased the 
> frequency of the error,
> however it did not get rid of the error.

That is scary beyond belief.

Basically you doubled your timeout, and you certainly _should_ have seen 
at least one more status read from the extra 50 msec you waited. And since 
your patch (which fixes it) only adds _one_ status read, that implies that 
the extra 50 msec timeout didn't get a single time through the loop.

> The device the error occurs with is a cf card. The error also occurs
> much more frequently in 2.4.23 than in 2.4.20 (but it can be provoked in
> 2.4.20). Neither use the preemption patch and both are from kernel.org.
> The platform is based on an AMD Elan processor which is a 486 compatible
> processor, running at 133 Mhz. The IDE subsytem does not use any extra
> drivers and is not a PCI ide chipset.

Yes, that path is only used for PIO writes, so it's clearly not a 
high-performance IDE setup. Adn yes, I guess with a slow enough CPU and 
enough interrupt load, you literally could spend 50ms just handling irqs. 
Still, that is pretty damn scary. But I guess the load:

>  ... there is a flood ping running and the machine is being 
> flood pinged + there is traffic on three serial ports (RS485).

is pretty extreme.

> I saw two possibilities, either disabeling the interrupts while first
> reading the status and then checking the timeout, after which the
> interrupts would be enabled again. Or to just make one extra check after
> the timout has expired because that is cheaper than returning, failing
> and then resetting the drive. After I applied my patch (using the
> 5*HZ/100 timeout) my test ran for a full weekend without giving the
> timeout error.

Ok, I think I'm convinced. That loop and the IDE usage of interrupt
enables is just crap. I don't think your addition is very pretty, but the 
alternative is to rewrite the loop to be sane, which isn't going to happen 
in a stable kernel.

How about a slightly more minimal patch, though? Ie does this work for 
you?

		Linus

----
===== drivers/ide/ide-iops.c 1.18 vs edited =====
--- 1.18/drivers/ide/ide-iops.c	Wed Jun 11 18:23:09 2003
+++ edited/drivers/ide/ide-iops.c	Sat Jan  3 10:54:21 2004
@@ -647,6 +647,15 @@
 		timeout += jiffies;
 		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
 			if (time_after(jiffies, timeout)) {
+				/*
+				 * One last read after the timeout in case
+				 * heavy interrupt load made us not make any
+				 * progress during the timeout..
+				 */
+				stat = hwif->INB(IDE_STATUS_REG);
+				if (!(stat & BUSY_STAT))
+					break;
+
 				local_irq_restore(flags);
 				*startstop = DRIVER(drive)->error(drive, "status timeout", stat);
 				return 1;
