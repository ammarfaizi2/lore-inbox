Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317602AbSGYHv4>; Thu, 25 Jul 2002 03:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSGYHv4>; Thu, 25 Jul 2002 03:51:56 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39358 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317602AbSGYHvz>;
	Thu, 25 Jul 2002 03:51:55 -0400
Date: Thu, 25 Jul 2002 09:54:48 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
Message-ID: <20020725095448.B21541@ucw.cz>
References: <20020724225826.GF25038@holomorphy.com> <1027559111.6456.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1027559111.6456.34.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Jul 25, 2002 at 02:05:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 02:05:11AM +0100, Alan Cox wrote:

> > I don't have one of these, and I'm not even sure what it is. But here's
> > a wild guess at a fix.
> 
> These must be locked against any other PCI access so it needs to share
> the lock with arch/i386/kernel/pci*.c. The code is also wrong for other
> reasons and there are some fixes in the 2.4.19-ac tree to those
> functions that affect the locking and maybe should be merged too.
> 
> What is going on here is that we have to probe the CMD640 PCI either via
> PCI conf1 or PCI conf2. We cannot use the kernel default functions
> because they may trigger a bug in the CMD640 hardware.

> get_cmd640_reg_pci[12] are basically reimplementations of the
> pci_read_config bits for type 1/type 2 PCI configurations. The register
> and lock are thus the same as the core. This lock also needs to match
> the same lock on non x86 platforms so the pci config lock name should be
> unified now before the brown and sticky impacts on the rotating
> propellor blades

The kernel functions are OK. The problem is that the kernel can use
PCIBIOS calls to set the registers. And certain old buggy BIOSes which
violate the PCI spec can use wrong size data transfers to set the
registers, which the CMD640 doesn't like.

IMHO the best workaround here would be either to disable PCIBIOS calls
and revert to conf1 or conf2 in the PCI code if a CMD640 is present, or
just panic() in the CMD640 code and suggest to the user to use
"pci=nobios" on the kernel command line. I'd actually prefer the later.

-- 
Vojtech Pavlik
SuSE Labs
