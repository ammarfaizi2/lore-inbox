Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267812AbRHFJtp>; Mon, 6 Aug 2001 05:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbRHFJtZ>; Mon, 6 Aug 2001 05:49:25 -0400
Received: from vaio.tp1.ruhr-uni-bochum.de ([134.147.240.21]:18948 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267713AbRHFJtS>; Mon, 6 Aug 2001 05:49:18 -0400
Date: Mon, 6 Aug 2001 11:49:10 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8-pre4, lots of compile warnings
In-Reply-To: <848.997076771@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.33.0108061138040.9237-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Keith Owens wrote:

> As part of stress testing kbuild 2.5, I built a 2.4.8-pre4 ix86 kernel
> with almost every option turned on, the .config is at the end.  It got
> a lot of warnings, I hope that the maintainers will do something about
> these.  Do not send patches to me, send them to the list or the
> maintainer.

> drivers/isdn/hisax/config.c:1720: warning: `hisax_pci_tbl' defined but not used
> drivers/isdn/avmb1/b1pci.c:31: warning: `b1pci_pci_tbl' defined but not used
> drivers/isdn/avmb1/t1pci.c:34: warning: `t1pci_pci_tbl' defined but not used
> drivers/isdn/avmb1/c4.c:39: warning: `c4_pci_tbl' defined but not used

[lots of similar warnings in non-ISDN code skipped]

This warning is seen a lot when compiling drivers into the kernel which 
have not been adapted to the new pci infrastructure yet.

This drivers contain the device table only for informational purposes, 
i.e. it's not referenced in a struct pci_driver, but only as 
MODULE_DEVICE_TABLE.

When compiling built-in, MODULE_DEVICE_TABLE is a no-op and thus the
device table is not referenced.

I can think of multiple ways to fix this:

o Move drivers to the new pci infrastructure. This is of course the
  best solution in the long run, but in many cases not appropriate for 
  2.4.
o Add an __attribute__((unused)) to the definition of the table. Ugly.
o Add an #ifdef MODULE around the definition of the table. Ugly.
o Make MODULE_DEVICE_TABLE reference the table also in the built-in case.
  Wastes space, as it really is never used, but not a lot of it.
o Live with the warnings.
o [fill in you suggestion]

If we can agree on how to handle this in a generic way, I can surely come 
up with a patch.

--Kai

