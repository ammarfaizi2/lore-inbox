Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265511AbTFVEvv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 00:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbTFVEvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 00:51:51 -0400
Received: from opersys.com ([64.40.108.71]:56583 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S265511AbTFVEvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 00:51:49 -0400
Message-ID: <3EF5398D.2000009@opersys.com>
Date: Sun, 22 Jun 2003 01:07:25 -0400
From: karim@opersys.com
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Which driver for the 3C940 / 3C2000?
References: <1056053787.2994.10.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Jurgen,

Jurgen Kramer wrote:
 > I am a bit confused about which driver a need for my onboard (Asus
 > P4C800 mobo) 3Com gigabit Ethernet controller. It should be a 3C940 but
 > sometimes it's called 3C2000. I found a driver at the asus site which
 > compiles and works with some kernel versions. Is there a proper (open
 > source) kernel driver for this chip? It seems that the tg3 driver
 > support some type of 3C940 but not mine.
 >
 > lspci -n gives:
 >
 > 02:05.0 Class 0200: 10b7:1700 (rev 12)
 >
 > This chip is also currently not defined in pci_ids.h (2.4 and 2.5)

I've got a P4C800DX-2.4GH-HT and have run into similar issues. I tried
using the 3C2000 driver shipped by ASUS on their "driver" CD, but that was
a weird experience. The driver built and installed fine with the SMP
kernel shipped with RedHat9. HOWEVER ... I could browse some web sites
and not others (I'm still trying to figure out how this could be ...)
Somehow, I could point konqueror to slashdot.org, kernel.org, motorola.com,
yahoo.com, lwn.net, etc. and see the pages, but I was unable to visit intel.com,
google.com, or amazon.com. I couldn't imagine this being a driver problem, so I
tried all sorts of different things, but still had this weird behavior. Finally, I
decided to put an 8139 with the same config, and that worked right away ... !?!

During my research about the 3C2000, I discovered that the driver
shipped with the board is actually a variant of the code in
drivers/net/sk98lin, with modified printks to display 3Com text instead of
SysKonnect information:
/* 2002 12 24 JMA begin
  * Change to 3Com names.
static const char SysKonnectFileId[] = "@(#) (C) SysKonnect GmbH.";
static const char SysKonnectBuildNumber[] =
	"@(#)SK-BUILD: 6.01 beta 01 PL: 01";

#define BOOT_STRING	"sk98lin: Network Device Driver v6.01 beta 01\n" \
			"Copyright (C) 2000-2002 SysKonnect GmbH."

#define VER_STRING	"6.01 beta 01"
*/

static const char SysKonnectFileId[] = "@(#) (C) 3Com Corporation.";
static const char SysKonnectBuildNumber[] =
	"@(#)SK-BUILD: A10 PL: 01";

#define BOOT_STRING	"3C2000: 3Com Gigabit NIC Driver Version A10\n" \
			"Copyright (C) 2003 3Com Corporation.\n" \
			"Copyright (C) 2003 Marvell."

#define VER_STRING	"A10"

Another header has:
#define SK_PCI_ISCOMPLIANT(result, pdev) {     \
     result = SK_FALSE; /* default */     \
     /* 3Com (0x10b7) */     \
     if (pdev->vendor == 0x10b7) {     \
         /* Gigabit Ethernet Adapter (0x1700) */     \
         if ((pdev->device == 0x1700)) { \
             result = SK_TRUE;     \
         }     \
     /* SysKonnect (0x1148) */     \
     } else if (pdev->vendor == 0x1148) {     \
         /* SK-98xx Gigabit Ethernet Server Adapter (0x4300) */     \
         /* SK-98xx Gigabit Ethernet Adapter (0x4320) */     \
         if ((pdev->device == 0x4300) || \
             (pdev->device == 0x4320)) { \
             result = SK_TRUE;     \
         }     \
     /* D-Link (0x1186) */     \
     } else if (pdev->vendor == 0x1186) {     \
...
And it goes on for CNET and Linksys. Apparently, all these devices rely
on the same core. However, a trivial adding of the appropriate vendor ID
and device ID to the sk98lin in 2.4.21 resulted in an ooops at load time,
so it isn't as straight forward as I would have liked it to be ...

It'd be nice that the sk98lin driver already in Linux be modified to add
support to the 3C940, albeit without the browsing weirdness ...

Karim

-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 514-812-4145

