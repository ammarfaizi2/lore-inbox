Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270627AbUJUJBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270627AbUJUJBA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 05:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbUJUI7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:59:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1235 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268819AbUJUI5d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:57:33 -0400
Message-ID: <417779ED.6040403@pobox.com>
Date: Thu, 21 Oct 2004 04:57:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linus Torvalds <torvalds@osdl.org>, John Cherry <cherry@osdl.org>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Linux v2.6.9... (compile stats)
References: <1098196575.4320.0.camel@cherrybomb.pdx.osdl.net> <20041019161834.GA23821@one-eyed-alien.net> <1098310286.3381.5.camel@cherrybomb.pdx.osdl.net> <20041020224106.GM23987@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0410201710370.2317@ppc970.osdl.org> <41770307.5060304@pobox.com> <20041021015522.GH23987@parcelfarce.linux.theplanet.co.uk> <41771813.8090204@pobox.com> <20041021022442.GI23987@parcelfarce.linux.theplanet.co.uk> <417720D6.1030908@pobox.com> <20041021043557.GK23987@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041021043557.GK23987@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Oct 20, 2004 at 10:37:10PM -0400, Jeff Garzik wrote:
> 
>>viro@parcelfarce.linux.theplanet.co.uk wrote:
>>
>>>IDGI.  Why do you insist on releasing these guys in library code?  Even
>>
>>Because there are two distinct and separate models of port mapping/usage:
>>
>>1) A bunch of separate IO address spaces (PIO).  The "mapping" is 
>>currently done in ata_pci_init_native_mode() and ata_pci_init_legacy_mode()
>>
>>2) One single linear address space (MMIO).  The mapping is done in the 
>>low-level driver.
>>
>>#1 is in the library because the logic is duplicated _precisely_, across 
>>multiple host controllers, according to a hardware specification.
>>
>>Thus, if the mapping is done in the library core, so should the unmapping.
> 
> 
> Not really.  You are making the case for having a helper that would unmap
> for case 1 and having it in the library, just as we do for mapping in that

Sure:  libata is a library, so all functions are helpers.  It's just one 
more helper function.


> case.  What you have is different, though - it's a single function that does
> entire ->remove() for all (AFAICS) SATA drivers.

That's intentional, see below.


> And that's where the problem is - decision on releasing resource should belong
> to the driver; sure, it can and should use library helper, just as it did
> when it was grabbing these resources.




> Note, BTW, that current ata_pci_remove_one() is begging for trouble - for
> one thing, it does iounmap() before we get to ata_scsi_release(), i.e.
> ata_host_remove(), i.e. ->port_stop().   And the first look at the drivers
> that provide ->port_stop() shows that ahci_port_stop() does readl()/writel()
> on the ->mmio_base.  Oops...

Ah the perils of an undocumented API :)  You're misunderstanding 
->port_stop.

That's a bug in ahci:  port_stop should never touch the hardware. 
port_stop is only for releasing per-driver resources like kmalloc or DMA 
memory.

Note...  another thing to keep in mind is that all libata drivers use 
ata_pci_remove_one() because that makes it possible to smooth over the 
differences between 2.4 and 2.6 scsi drivers.

> And that's where the problem is - decision on releasing resource should belong
> to the driver; sure, it can and should use library helper, just as it did
> when it was grabbing these resources.
[...]
> free_irq() also looks fishy, BTW.  How about moving all that group past the
> point where you are done with individual ports and merging it (and any other
> unmapping we might want to do) into a single callback?  Depending on whether
> ->host_stop() is really needed early we might use ->host_stop for that...

I don't see any problems, given what I just wrote above.

Just the annoyance of individually mapping and unmapping 4 or 5 PCI 
BARs, and mixing 4 ranges of ISA legacy ioports for good measure.


Now...  addressing the overall theme of your message...  eventually 
libata wants to move to a strict port_{start,stop}, host_{start,stop} 
mechanism where the driver does more of the heavy lifting [by providing 
hooks that call libata helpers, rather than a helper calling hooks as 
ata_pci_remove_one does now].

But to get there will take _many_ iterations, since two things get in 
the way there:
* 2.4 compat
* the necessity to issue several ATA commands before we can respond to 
-any- SCSI commands

	Jeff


