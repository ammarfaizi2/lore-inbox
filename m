Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273721AbRI3QNe>; Sun, 30 Sep 2001 12:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273724AbRI3QNY>; Sun, 30 Sep 2001 12:13:24 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:45324 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S273721AbRI3QNL>; Sun, 30 Sep 2001 12:13:11 -0400
Message-Id: <200109301613.f8UGDRY62473@aslan.scsiguy.com>
To: ookhoi@dds.nl
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac17 Adaptec AIC7XXX problems (new driver, old one works fine) (solved) 
In-Reply-To: Your message of "Sun, 30 Sep 2001 08:57:31 +0200."
             <20010930085730.G9327@humilis> 
Date: Sun, 30 Sep 2001 10:13:27 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> IIRC, the a7v is an AMD processor with VIA chipset. If you go into the
>> MB BIOS and disable all of the "Make my PCI bus go as fast as possible
>> even if this means violating the spec" options, the "new" aic7xxx
>> driver should work fine. I wish VIA would get a clue.
>
>It is indeed an AMD system with the VIA KT133 chipset.
>
>I played with the bios settings to find out with which option it would
>or would not give trouble. Under Advanced, CHIP Configuration the option
>Byte Merge has to be disabled to make the kernel boot fine with the new
>aic7xxx driver. This is with kernel 2.4.9-ac18
>
>The bios manual says:
>Byte Merge [Enabled by default]
>To optimize the data transfer on PCI, this merges a sequence of
>individual memory writes (bytes or words) into a single 32-bit block of
>data. However, byte merging may only be done when the bytes within a
>data phase are in a prefetchable address range. Configuration options:
>[Disabled] [Enabled]

The aic7xxx's register space only supports 8byte accesses.  The driver
only uses 8 byte accesses, but *may* touch consecutive registers with
consecutive accesses.  As the manual suggests, PCI only allows you to
merge these kinds of requests IFF the memory region is marked as
prefetchable.  The aic7xxx BAR register does not set the prefetchable
bit, and thus should never be placed in a prefetchable region.  If the
BIOS or Linux is putting these registers into a prefetchable region, then
that is the root of the bug.  If byte merging occurs regardless of the
type of region the registers are mapped into, then the byte merging
feature is broken.

>Why does the old driver boot fine with this enabled, and has the new
>driver troubles booting then?

The old driver issues a PCI read after every write to a register.  Writes
can be posted.  Reads cannot.  This forces the transactions to be executed
individually, but also has a tremendous performance impact (perhaps as much
as 10x the cost per write transaction).  There are times where a read is
required to synchronize state (e.g. ensure the chip has seen a write prior
to referring to some in-core data structures) and the new driver will issue
the extra reads only in that case.

--
Justin
