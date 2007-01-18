Return-Path: <linux-kernel-owner+w=401wt.eu-S932163AbXARLvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbXARLvI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 06:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbXARLvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 06:51:08 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:34170 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932163AbXARLvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 06:51:07 -0500
Date: Thu, 18 Jan 2007 12:51:05 +0100
From: Andreas Mohr <andim2@users.sourceforge.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: andi@lisas.de, davej@codemonkey.org.uk,
       kernel list <linux-kernel@vger.kernel.org>
Subject: intel-agp PM experiences (was: 2.6.20-rc5: usb mouse breaks suspend to ram)
Message-ID: <20070118115105.GA28233@rhlx01.hs-esslingen.de>
Reply-To: andi@lisas.de
References: <20070116135727.GA2831@elf.ucw.cz> <d120d5000701160608t73db4405n5d157db43899776a@mail.gmail.com> <20070116142432.GA6171@elf.ucw.cz> <d120d5000701161325h112a9299w944763b7f1032a61@mail.gmail.com> <20070117004012.GA11140@rhlx01.hs-esslingen.de> <20070117005755.GB6270@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070117005755.GB6270@elf.ucw.cz>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jan 17, 2007 at 01:57:55AM +0100, Pavel Machek wrote:
> > Especially the PCI video_state trick finally got me a working resume on
> > 2.6.19-ck2 r128 Rage Mobility M4 AGP *WITH*(!) fully enabled and working
> > (and keeping working!) DRI (3D).
> 
> Can we get whitelist entry for suspend.sf.net? s2ram from there can do
> all the tricks you described, one letter per trick :-). We even got
> PCI saving lately.

Whitelist? Let me blacklist it all the way to Timbuktu instead!

I've been doing more testing, and X never managed to come back to working
state without some of my couple intel-agp changes:
- a proper suspend method, doing a proper pci_save_state()
  or improved equivalent
- a missing resume check for my i815 chipset
- global cache flush in _configure
- restoring AGP bridge PCI config space

The remaining suspects (the other hacks alone didn't recover it)
are global cache flush and restoring of the *entire* AGP bridge PCI
config space (no, a 64-bytes-only pci_restore_state() alone doesn't help,
and it didn't help either that intel-agp doesn't do pci_save_state() anywhere
 - unless that's now done by default by PCI layer).
I'll do more testing today to isolate which change exactly fixed it.

All in all intel-agp code semi-shattered my universe.
I didn't expect to find all these issues in rather important core code
for a wide-spread chipset vendor - it doesn't even log an
"unhandled chipset: resuming may fail, please report!" message
in the resume handler in case of a missing chipset check
(although it may be debatable whether people are able to see this message
at all).
However since the new AGP code was a heroic refactoring effort
it's understandable that there are some remaining issues.

Given the myriads of resume issues we experience in general,
it may be wise to do something as simple as a code review of *all*
relevant code no matter how "complete" we expect each driver to be...
(one could e.g. start with reviewing all other AGP chipset drivers).

Andreas Mohr
