Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUGHT3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUGHT3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 15:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUGHT3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 15:29:09 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:39059 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261474AbUGHT3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 15:29:04 -0400
Date: Thu, 8 Jul 2004 21:28:45 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: Increasing IDE Channels
Message-ID: <20040708192845.GA11493@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040707225635.GA26832@dreamland.darkstar.lan> <40ED6F1A.7080101@techsource.com> <20040708182654.GA10246@dreamland.darkstar.lan> <40ED9A6F.8020506@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ED9A6F.8020506@techsource.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Jul 08, 2004 at 03:03:11PM -0400, Timothy Miller ha scritto: 
> Kronos wrote:
> >Il Thu, Jul 08, 2004 at 11:58:18AM -0400, Timothy Miller ha scritto: 
> >
> >>>Because hwifs are statically allocated, see drivers/ide/ide.c:
> >>>
> >>>ide_hwif_t ide_hwifs[MAX_HWIFS];        /* master data repository */
> >>>
> >>>Also if names are ide0..ide9, the following would be ide: and ide; (see
> >>>init_hwif_data in drivers/ide/ide.c).
> >>>
> >>
> >>Why wouldn't they be ide10 and ide11?
> >
> >
> >No:
> >
> >static void init_hwif_data(ide_hwif_t *hwif, unsigned int index)
> >{
> >        ...
> >        hwif->name[0]   = 'i';
> >        hwif->name[1]   = 'd';
> >        hwif->name[2]   = 'e';
> >        hwif->name[3]   = '0' + index;
> >
> >'0' + 10 is ':' and '0' + 11 is ';'
> >
> >Luca
> 
> 
> I understand WHY it's ':' and ';'.  I still think it's a bug.  Solaris 
> rolls from 9 to 10, 11, etc.

Ah, I didn't understand your question ;) Vanilla kernel only allows for
10 hwif, so this isn't a big issue. ->name is an array of 6 chars
though, so it possible to have ideXX without changing the struct.

Bartlomiej what about the following patch:

--- linux-2.6/drivers/ide/ide.c~	2004-06-16 18:02:11.000000000 +0200
+++ linux-2.6/drivers/ide/ide.c	2004-07-08 21:24:58.000000000 +0200
@@ -216,7 +216,12 @@
 	hwif->name[0]	= 'i';
 	hwif->name[1]	= 'd';
 	hwif->name[2]	= 'e';
-	hwif->name[3]	= '0' + index;
+	if (index < 10) {
+		hwif->name[3] = '0' + index;
+	} else {
+		hwif->name[3] = '0' + index / 10;
+		hwif->name[4] = '0' + index % 10;
+	}
 
 	hwif->bus_state	= BUSSTATE_ON;
 

Luca
-- 
Home: http://kronoz.cjb.net
Recursion n.:
	See Recursion.
