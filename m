Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269234AbTCBQMJ>; Sun, 2 Mar 2003 11:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269235AbTCBQMJ>; Sun, 2 Mar 2003 11:12:09 -0500
Received: from [195.208.223.237] ([195.208.223.237]:29824 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S269234AbTCBQMH>; Sun, 2 Mar 2003 11:12:07 -0500
Date: Sun, 2 Mar 2003 19:22:15 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: David Brownell <david-b@pacbell.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI and MWI
Message-ID: <20030302192215.A645@localhost.park.msu.ru>
References: <3E4622B0.7040201@pobox.com> <20030210151813.B12043@jurassic.park.msu.ru> <3E47DF75.20801@pacbell.net> <3E5B1C08.6030906@pacbell.net> <3E5C2368.6010502@pobox.com> <20030226160403.A15729@jurassic.park.msu.ru> <3E600281.2050805@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3E600281.2050805@pacbell.net>; from david-b@pacbell.net on Fri, Feb 28, 2003 at 04:44:49PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 04:44:49PM -0800, David Brownell wrote:
> It worked for me on K7/Tbred and P6/Coppermine.  No more messages
> at driver init about nassty stupd BIOS, or new problems.

Fine. :-)

> But I think the arch code is wrong for CPUs like i386 and i486;

No.

> I recall at least one of them having 16 byte cachelines.  PCI
> gets used with those, yes?

Right, but 32 byte PCI cacheline is fine for those. It's perfectly ok
for the PCI cacheline size to be multiple of the CPU one, but not vice
versa. Actually, we could use 128 for all x86s (to respect P4), but
it would be an obvious overkill.

>  I wonder if it might not be best to
> have cpuinfo_x86 store that value; people don't really expect
> to see cpu-specific logic in the pci code.

Don't know. The cpuinfo_x86 is per-CPU thing, while pci_cache_line_size
is definitely system-wide.

> One minor curiousity:  a multifunction device seemed to share
> PCI_CACHE_LINE_SIZE between the enabled/active function and ones
> without a driver.  Makes sense, the values can never legally
> differ, but some more troublesome devices don't do that...

Hmm, we treat each function as an independent PCI device, as per PCI
spec. Sharing the config space between functions sounds like a severe
hardware bug. Do you have any examples?

> Re Jeff's suggestion to merge this to 2.5 ASAP, sounds right
> to me if all the arch code gets worked out up front.  I have
> no problem with the idea of enabling it as done here (when
> the device is enabled) rather than waiting to enable DMA,
> though I'd certainly pay attention to people who know about
> devices broken enough to get indigestion that way.

Well, in 2.4 on Alpha and ARM we still have pdev_enable_device() thing
which is the mostly __init-only variant of the pci_enable_device(),
but it also forces correct cacheline size and reasonable (more or less)
latency timer for *all* devices. Nobody had problems with it over the last
2 years, so I believe that setting cacheline size in pci_enable_device()
rather than in pci_set_master() is the right thing (and agrees with the
spec better).

Ivan.
