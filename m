Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbREQFhW>; Thu, 17 May 2001 01:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbREQFhM>; Thu, 17 May 2001 01:37:12 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:49169 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261356AbREQFg7>;
	Thu, 17 May 2001 01:36:59 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105170536.f4H5aZe459258@saturn.cs.uml.edu>
Subject: Re: ((struct pci_dev*)dev)->resource[...].start
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 17 May 2001 01:36:35 -0400 (EDT)
Cc: Vassilii.Khachaturov@comverse.com (Khachaturov Vassilii),
        linux-kernel@vger.kernel.org (LINUX Kernel)
In-Reply-To: <3B02F30F.5D05C77E@mandrakesoft.com> from "Jeff Garzik" at May 16, 2001 05:37:19 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> "Khachaturov, Vassilii" wrote:

>> Can someone please confirm if my assumptions below are correct:
>> 1) Unless someone specifically tampered with my driver's device
>> since the OS bootup, the mapping of the PCI base address registers
>> to virtual memory will remain the same (just as seen in /proc/pci,
>> and as reflected in <subj>)? If not, is there a way to freeze it
>> for the time I want to access it?
>
> This is not a safe assumption, because the OS may reprogram the
> PCI BARs at certain times.  The rule is:  ALWAYS read from
> dev->resource[] unless you are a bus driver (PCI bridges, for
> example, need to assign resources).

Well, I have a bus driver. Just how do I get a bus number?
My hardware comes up as a regular device, then mutates into
a bridge when I flip a bit in a config register. The header
even changes from type 1 to type 2. The class code is always
the same, a bridge device, but not PCI-to-PCI. It's kind of
like hot-plug PCI over a network, with all sorts of extra
alignment restrictions on address space allocation.

So maybe this card is on bus 42. I need a secondary bus number,
plus a few more in case there are more bridges downstream.
I can't just grab 42..44 because they might be used elsewhere,
and I can't just grab 253..255 either because that upsets the
whole system of bus number assignment being done by carving up
the space granted to upstream bridges.

BTW, is there any reason why the primary bus register of a
bridge would have to be set correctly? I have to set mine equal
to the secondary bus register to keep the hardware happy.

> Further, access to PCI BARs -and- dev->resource[] in a driver is
> wrong until you have called pci_enable_device.  Resource and IRQ
> assignment potentially occurs at pci_enable_device time, so BAR
> is [potentially] undefined before then.

Hmmm. I can use device-specific config space registers to change
the size of a BAR. (or limit & base, whatever) Say I want to have
512 MB, but the bridge upstream only has 128 MB allotted to it.
How do I fix this?


