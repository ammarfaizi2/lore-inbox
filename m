Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUBXXt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbUBXXt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:49:26 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51136 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262499AbUBXXtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:49:21 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Greg KH <greg@kroah.com>, marcel cotta <mc123@mail.ru>
Subject: Re: 2.6.3 - Badness in pci_find_subsys at drivers/pci/search.c:167
Date: Wed, 25 Feb 2004 00:55:10 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <403B7627.6080805@mail.ru> <20040224223043.GA2455@kroah.com>
In-Reply-To: <20040224223043.GA2455@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402250055.10084.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 of February 2004 23:30, Greg KH wrote:
> On Tue, Feb 24, 2004 at 05:04:55PM +0100, marcel cotta wrote:
> > i came across this while playing with hdparm
> >
> > Call Trace:
> >  [<c0264128>] pci_find_subsys+0xe8/0xf0
> >  [<c026415f>] pci_find_device+0x2f/0x40
> >  [<c02e5d89>] ide_system_bus_speed+0x69/0x90
> >  [<c02e528e>] ali15x3_tune_drive+0x1e/0x250
>
> Ugh, this is due to calling system_bus_clock() from within an interrupt.
> Is there any good reason to do this?  Can't we just cache the bus speed
> in the local device structure if we really have to do this from within
> an interrupt?

ide_init() always initializes system_bus_speed variable
so system_bus_clock() should never call ide_system_bus_speed()
and no driver is calling ide_system_bus_speed() directly.

Bug was that if no IDE kernel parameter was given during boot
system_bus_speed will be zeroed in init_ide_data().

This patch should fix the problem
(as a bonus -> no need to zero these variables they are static).

 linux-2.6.3-bk6-root/drivers/ide/ide.c |    3 ---
 1 files changed, 3 deletions(-)

diff -puN drivers/ide/ide.c~ide_bus_speed drivers/ide/ide.c
--- linux-2.6.3-bk6/drivers/ide/ide.c~ide_bus_speed	2004-02-25 00:47:39.467793088 +0100
+++ linux-2.6.3-bk6-root/drivers/ide/ide.c	2004-02-25 00:48:44.319934064 +0100
@@ -302,9 +302,6 @@ static void __init init_ide_data (void)
 	initializing = 1;
 	ide_init_default_hwifs();
 	initializing = 0;
-
-	idebus_parameter = 0;
-	system_bus_speed = 0;
 }
 
 /*

_

