Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933263AbWKNAbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933263AbWKNAbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933264AbWKNAbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:31:31 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32948
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S933263AbWKNAba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:31:30 -0500
Date: Mon, 13 Nov 2006 16:31:38 -0800 (PST)
Message-Id: <20061113.163138.98554015.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, anton@samba.org,
       airlied@gmail.com, idr@us.ibm.com, paulus@samba.org
Subject: Re: [PATCH/RFC] powerpc: Fix mmap of PCI resource with hack for X
From: David Miller <davem@davemloft.net>
In-Reply-To: <1163405790.4982.289.camel@localhost.localdomain>
References: <1163405790.4982.289.camel@localhost.localdomain>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 13 Nov 2006 19:16:30 +1100

> The powerpc version of pci_resource_to_user() and associated hooks
> used by /proc/bus/pci and /sys/bus/pci mmap have been broken for some
> time on machines that don't have a 1:1 mapping of devices (basically
> on non-PowerMacs) and have PCI devices above 32 bits.
> 
> This attempts to fix it as well as possible. 
> 
> The rule is supposed to be that pci_resource_to_user() always converts
> the resources back into a BAR values since that's what the /proc
> interface was supposed to deal with. However, for X to work on platforms
> where PCI MMIO is not mapped 1:1, it became a habit of platforms like
> sparc or powerpc to pass "fixed up" values there sinve X expects to
> be able to use values from /proc/bus/pci/devices as offsets to mmap
> of /dev/mem...

Not on Sparc.  /dev/mem mmap()'s are basically verbotten on Sparc,
period.

That's the whole reason I created /proc/bus/pci mmap().  So that
X could simply read a BAR, open /proc/bus/pci/${DEVICE} and
mmap() with some range within the BAR as the offset/size tuple.

If an application wants all of I/O space (to poke at VGA addresses for
a domain, for example), it finds the root bridge for that domain and
you can mmap()'s it's I/O space that way on platforms the implement
I/O space via memory accesses.

The only thing X was (unfortunately) still using the "devices" file
for is device existence, and this is obviously broken because there is
zero domain information in that procfs file so it's impossible to use
correctly. :-)

> X is still broken when built 32 bits on machines where PCI MMIO can be
> above 32 bits space unfortunately. It looks like somebody (DaveM ?)
> hacked a fix in X to handle long long resources and had the good idea
> to wrap it in #ifdef __sparc__ :-(

Sorry, it was the only 32/64 platform at the time that old X code was
written and the X maintainers at the time were unbelievably anal :-/

So the gist of your change is that X isn't obtaining BAR values
in the correct context on powerpc, and so you're going to hack up
the "devices" files output to "help" X out.

This doesn't sound sane to me.

What sounds better to me is that X does the right thing, which is
obtain the BAR from the PCI config space to determine what values to
pass in to /proc/bus/pci mmap() calls.  And if it wants raw addresses
to pass in to /dev/mem mmap()'s on platforms where that works (ie. not
Sparc, to begin with) it should obtain those values from the "devices"
file which must be values suitable as /dev/mem offsets.

I strongly look forward to Ian's new X code, that is for sure :-)
