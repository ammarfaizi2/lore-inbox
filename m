Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267835AbUG3UhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267835AbUG3UhI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 16:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267831AbUG3Uef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 16:34:35 -0400
Received: from web14926.mail.yahoo.com ([216.136.225.84]:36995 "HELO
	web14926.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267829AbUG3Uc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 16:32:26 -0400
Message-ID: <20040730203225.81054.qmail@web14926.mail.yahoo.com>
Date: Fri, 30 Jul 2004 13:32:25 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Exposing ROM's though sysfs
To: Martin Mares <mj@ucw.cz>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20040730201052.GA5249@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Martin Mares <mj@ucw.cz> wrote:
> No, we are speaking about sysfs access to the ROM and the driver
> itself is unable to predict whether anybody will ever want to use 
> that sysfs file, so it would have to cache always.

For the 99.999% of hardware that implements full address decoding the
sysfs code will not cache the ROM contents and instead make a copy as
requested from the actual ROM.

The only time the ROM will get cached is when you load a kernel device
driver for a card that implements minimalistic PCI decoding (very few
cards) and the driver asks for it. The driver would ask for caching
since it knows that the decoder lines aren't complete.

We also don't have to cache the ROM for boot video devices since they
are already cached at C000:0 by the system BIOS.

This cache is only going to impact a few systems in the world that are
trying to run a current kernel on ten year old hardware. It also
assumes that someone is going to rewrite the device drivers for this
old hardware and ask for the caching.

> 
> Do I understand it correctly that the ROM-in-sysfs hack is intended
> only for debugging? If it is so, I do not see why we should do
> anything complicated in order to avoid root shooting himself 
> in the foot.

Reasons for ROMs in sysfs:

Secondary video cards need to have code in their ROMs run to reset
them. When an x86 PC boots it only reset the primary video device, the
secondary ones won't work until their ROMs are run.

Another group needing this is laptop suspend/resume. Some cards won't
come back from suspend until their ROM is run to reinitialize them.

A third group is undocumented video hardware where the only way to set
the screen mode is by calling INT10 in the video ROMs. (Intel
i810,830,915 for example).

Small apps are attached to the hotplug events. These apps then use vm86
or emu86 to run the ROMs. emu86 is needed for ia64 or ppc when running
x86 ROMs on them.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail is new and improved - Check it out!
http://promotions.yahoo.com/new_mail
