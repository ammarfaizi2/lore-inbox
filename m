Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWGFGN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWGFGN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWGFGN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:13:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2743 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030195AbWGFGNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:13:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Doug Thompson <norsk5@yahoo.com>,
       akpm@osdl.org, mm-commits@vger.kernel.org, norsk5@xmission.com,
       linux-kernel@vger.kernel.org
Subject: Re: + edac-new-opteron-athlon64-memory-controller-driver.patch added to -mm tree
References: <20060701150430.GA38488@muc.de>
	<20060703172633.50366.qmail@web50109.mail.yahoo.com>
	<20060703184836.GA46236@muc.de>
	<1151962114.16528.18.camel@localhost.localdomain>
	<20060704092358.GA13805@muc.de>
	<1152007787.28597.20.camel@localhost.localdomain>
	<20060704113441.GA26023@muc.de>
	<1152137302.6533.28.camel@localhost.localdomain>
	<20060705220425.GB83806@muc.de>
Date: Thu, 06 Jul 2006 00:12:14 -0600
In-Reply-To: <20060705220425.GB83806@muc.de> (Andi Kleen's message of "6 Jul
	2006 00:04:25 +0200, Thu, 6 Jul 2006 00:04:25 +0200")
Message-ID: <m1odw32rep.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think if this conversation is going to make headway we
need to step back a minute, and ask what makes sense to do
an where and not get caught up the details of an implementation.

The goal of the EDAC code is to report errors the hardware has
seen to upper layers of software so someone can do something with
them.    Also it is hoped we can get a moderately standard interface
so that automated tools can recognize and do something when a
problem is reported.  Is this a reasonable set of goals?

Memory errors are by far the most common kind of hardware error
and worth discussing.    For an uncorrectable memory error there
are 3 interesting pieces of information.

- Which cpu address did the error happen at.
  So we can kill the processes using that memory.
  Although simply killing the entire machine appears acceptable.

- What is the chipsets idea of which DIMM the memory error occurred on.
  For bus based memory architectures like the opteron this
  is a chip select of the DIMM rank.
  For serial memory architectures this is some kind of bus address,
  but still useful for describing individual chips.

- What is the silk screen label on the motherboard that corresponds
  to the chip selects with problems.

If you look at the memory controller, and the associated error
reporting registers (which are sometimes available in the machine check).
There has always been enough information to determine the hardware
address the memory controller knows the DIMM by.

Getting the address of the error is usually possible but not always
and not always very reliably.

Mapping between the hardware address that the memory controller
knows DIMMS by and the actual DIMMS themselves is actually
pretty easy even if you don't have any motherboard information.
It is just a matter of plugging in DIMMS in different positions
and seeing which DIMMS that the hardware currently sees.  It's
maybe half a days work on an unknown motherboard.


...

Assuming we can agree that this is sane information we want.  The
remaining question is how do we capture it.

For the mapping to the hardware address that the memory controller
knows the DIMM by requires the reading of hardware registers,
some that are not easily accessible to user space so a kernel driver
tends to make sense, just to get the information.  

Possibly we could just  export that information and let the
user space figure it out from there.   But memory is a key system
component and hardware designers are very creative so coming
up with a consistent model would be very hard.  So far we
have had to improve our helper functions every couple of chipsets
because the old models broke.  Writing a driver split halfway between
the kernel and user space sounds silly.

....

The other pieces to me seem much more fluid.  Especially since EDAC
does not yet export much if anything to user space except through
printk's in any stable kernel.

....

As for the suggestion of using DMI as best as I can determine it
suffers rather badly from the never ending creativity of the chipset
developers and does not have a model that can describe what needs
to happen for the current generation of chipset much less the bleeding
edge ones.  Which is besides the fact that the only thing that you can
usually trust in DMI tables is the motherboard manufacturer.

I do think getting the motherboard id out of DMI provides a great key
to build a memory controller hardware address to DIMM label lookup
table.   With EDAC we have been computing that information in user
space and caching it kernel side so we could generate immediately
useful print statements.  Which is handy but probably not necessary.

Eric


