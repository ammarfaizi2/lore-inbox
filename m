Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266780AbUAWXll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266784AbUAWXll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:41:41 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36288 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266780AbUAWXli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:41:38 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Glenn Wurster <gwurster@scs.carleton.ca>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] ide-dma.c, ide.c, ide.h, kernel 2.4.24
Date: Sat, 24 Jan 2004 00:45:56 +0100
User-Agent: KMail/1.5.3
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, andre@linux-ide.org
References: <20040123183245.GB853@desktop> <20040123213329.GH22615@devserv.devel.redhat.com> <20040123220958.GA891@desktop>
In-Reply-To: <20040123220958.GA891@desktop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401240045.56966.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Friday 23 of January 2004 23:09, Glenn Wurster wrote:
> > > Brief Synopsis:
> > >
> > > IDE initialization on non-DMA controllers causes OOPS during boot
> > > due to dereference of null function pointers.
> >
> > Linus - I am ok with this but for 2.6 Bart needs to look at it I guess
>
> I tried out the 2.6.1 kernel quickly and it did not exhibit the same
> obvious problems oopsing with dma and the ide controller as the latest
> 2.4 kernels (on my hardware at least).  It booted up nicely without a
> problem on unmodified source.  Whether or not the problem occurs for
> other types of hardware I can't say.

Hi,

[ Sorry for delay. ]

Glenn, your patch hides potential problems - these functions shouldn't be
called if host doesn't support DMA.  However there is one place when
->ide_dma_host_off() shouldn't be called unconditionally, here is a patch.
It is not pretty but at least consistent - we check hwif->ide_dma_check
to see if DMA is supported in other places too.  Does it fix the problem?
 
Are you sure that it doesn't happen on 2.6.1?  Maybe you've used a bit
different config (ie. compiled without DMA support)?

Cheers,
--bart

--- ide-iops.c.orig	2003-12-06 17:47:27.000000000 +0100
+++ ide-iops.c	2004-01-24 00:17:32.129567576 +0100
@@ -912,7 +912,8 @@
 //		ide_delay_50ms();
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	hwif->ide_dma_host_off(drive);
+	if (hwif->ide_dma_check)	/* check if host supports DMA */
+		hwif->ide_dma_host_off(drive);
 #endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
 
 	/*

