Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbRBGUGn>; Wed, 7 Feb 2001 15:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130463AbRBGUGd>; Wed, 7 Feb 2001 15:06:33 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6665 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129250AbRBGUG3>;
	Wed, 7 Feb 2001 15:06:29 -0500
Message-ID: <3A81AAA4.318BCD4E@mandrakesoft.com>
Date: Wed, 07 Feb 2001 15:05:56 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: davej@suse.de, Alan Cox <alan@redhat.com>, becker@scyld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hamachi not doing pci_enable before reading resources
In-Reply-To: <Pine.LNX.3.95.1010207144124.1258B-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> A PCI device does not and should not be enabled to probe for resources!

Some PCI devices do not -have- resources until pci_enable_device() is
called, hence the rule.


> It is only devices that have BIOS that require the device to be enabled
> for memory I/O prior to downloading the BIOS into RAM. The BARs are
> read/writable (and are required to be), even when the Mem/I/O bits
> in the cmd/status register are clear.
> 
> This is a required condition!  You certainly don't want to write all
> ones to a decode (to find the resource length) of a live, on-line chip!
> If the chip hickups (think network chips connected to networks, on a
> warm-boot), you will trash lots of stuff in memory.

When writing 0xFFFFFFFF to a BAR to find its length, you must disable IO
and MEM decoding.  This is a ideally what we should be doing anyway.. 
But you can re-enabling decoding once region size detection is
complete.  AND.  Region sizing only occurs once, and the value is cached
in dev->resource[], so it should not be occurring all over again, even
if pci_enable_device() is called.


> It looks as though you are "fixing" drivers that are not broken and,
> in fact, are trying to do the right thing. Maybe the PCI code in the
> kernel is preventing access to resources unless the device has been
> enabled??? If so, it's broken and should be fixed, instead of all
> the drivers.

wrong, you just missed this new "rule"...  

	Jeff



-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
