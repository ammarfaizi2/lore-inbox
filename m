Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266221AbUHNWKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266221AbUHNWKU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 18:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUHNWKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 18:10:20 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:28804 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266221AbUHNWKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 18:10:10 -0400
Date: Sun, 15 Aug 2004 00:10:10 +0200
From: Martin Mares <mj@ucw.cz>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040814221010.GA18592@ucw.cz>
References: <20040814094700.GA662@ucw.cz> <20040814141705.43723.qmail@web14930.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040814141705.43723.qmail@web14930.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> That's why it works right now without the assign_resource. The BIOS has
> already set everything up.

Yes, it happens on some machines, but by far not on all.

> The code that accesses the ROM runs very early, before anything else is
> loaded. The only conflict I can think of is from the on-board BIOS of a
> disk cotroller with partial decoding. But I'm not sure if a care like
> that exists.

No, conflict can happen whenever the ROM and the BAR's are enabled
at the same time. The BAR's are usually already enabled when your code runs.

You either should disable the BAR's for a while or, much better, avoid
touching the ROM base register until somebody explicitly requests it.

I know the devices with shared decoders are rare, but I still prefer
a kernel which, given such a device, works fine if you don't touch
the sysfs files, to a kernel, which crashes during boot under such
circumstances.

Hence it is much better to avoid scanning the ROM for the real size
unless you are copying it. Using the size of the resource for the
sysfs file doesn't hurt anybody as the file itself shouldn't eat up
any space.

> If a card like this exists, I need to make the code use the BIOS SHADOW
> copy of the ROM.

Beware, such a copy needn't exist, you need to create your own shadow copy.

> The system shadow copy is one of the main motivators for this code. On
> some laptop the system and video ROMs are compressed. On these systems
> the boot ROM decompresses these ROM into the shadow memory at
> C0000-100000.

Is there any reliable way to find the address and size of such a shadow
image or we need to stick with the 0xc0000 + 256KB range?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
A Bash poem: time for echo in canyon; do echo $echo $echo; done
