Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSLTSm7>; Fri, 20 Dec 2002 13:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264766AbSLTSm7>; Fri, 20 Dec 2002 13:42:59 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:42247 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264729AbSLTSmx>; Fri, 20 Dec 2002 13:42:53 -0500
Date: Fri, 20 Dec 2002 21:50:29 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
Message-ID: <20021220215029.A22996@jurassic.park.msu.ru>
References: <15874.58889.846488.868570@napali.hpl.hp.com> <Pine.LNX.4.44.0212200849090.2035-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0212200849090.2035-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 20, 2002 at 09:05:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2002 at 09:05:53AM -0800, Linus Torvalds wrote:
> One solution in the long term may be to not even probe the BAR's at all in
> generic code, and only do it in the pci_enable_dev() stuff. That way it
> would literally only be done by the driver, who can hopefully make sure
> that the device is ok with it.

I don't think that generic BAR probing is ever avoidable - too often
it's the only way to build a consistent resource tree. Without that
the driver cannot know whether the BAR setting is safe or there is a
conflict with something else.
Anyway, in the short term we could give the architecture ability to use its
own probing code, something like this:

In include/linux/pci.h:

#include <asm/pci.h>

+#ifndef HAVE_ARCH_PCI_BAR_PROBE
+#define pcibios_read_bases(dev, n, rom)	0
+#endif

In drivers/pci/probe.c:

static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
{
	unsigned int pos, reg, next;
	u32 l, sz;
	struct resource *res;

+	if (pcibios_read_bases(dev, howmany, rom))
+		return;
+
	for(pos=0; pos<howmany; pos = next) {
	...

Ivan.
