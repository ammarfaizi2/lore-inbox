Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263159AbUKTTMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUKTTMd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 14:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbUKTTLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 14:11:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:26284 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263155AbUKTTLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 14:11:10 -0500
Date: Sat, 20 Nov 2004 11:10:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Len Brown <len.brown@intel.com>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411201048470.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe>
 <20041120124001.GA2829@stusta.de> <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Nov 2004, Linus Torvalds wrote:
> 
> In particular, the code will disable irq12 (mouse interrupt), so the mouse
> has no chance of working.

Btw, looking closer still, this all will most likely vary wildly according
to southbridge (and BIOS setups). At least some SB's seem to put the
legacy interrupts totally separately from the PIRQ stuff, in which case
the PIRQ disable will not matter one whit - the legacy interrupt is
inserted "after" the PIRQ gating/translation anyway. This seems to be
especially common for controllers for keyboard/mouse/i2c etc that are
actually on the southbridge itself.

But the basic notion remains: disabling a PIRQ line is valid only if you
know it's only used by PCI devices. There might be other special devices
on the board that don't show up as PCI devices, eg things like the Sony
programmable I/O thing that doesn't show up as a PCI device at all, it's
just "invisibly" connected to the bus (it just hijacks port 0x66 or
something - the range 0-0x3ff is generally reserved for "motherboard
devices").

These kinds of things hopefully aren't all that common (there can't be a 
lot of extra hw required to follow the PCI spec _properly_), but if I were 
a hw designer, I'd connect such a chip to the PIRQ input, and just make 
the BIOS enable it automatically.

			Linus
