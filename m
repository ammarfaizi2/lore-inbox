Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUHZHEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUHZHEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 03:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUHZHEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 03:04:22 -0400
Received: from mfep3.odn.ne.jp ([143.90.131.181]:24513 "EHLO t-mta3.odn.ne.jp")
	by vger.kernel.org with ESMTP id S267681AbUHZHEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 03:04:20 -0400
Date: Thu, 26 Aug 2004 16:04:17 +0900
From: Aric Cyr <acyr@alumni.uwaterloo.ca>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Len Brown <len.brown@intel.com>
Subject: Re: ACPI + Floppy detection problem in 2.6.8.1-mm4
Message-ID: <20040826070417.GA8898@alumni.uwaterloo.ca>
References: <20040825002220.4867cd17.akpm@osdl.org> <200408251028.08180.bjorn.helgaas@hp.com> <200408251424.43575.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408251424.43575.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 02:24:43PM -0600, Bjorn Helgaas wrote:
> > > inserting floppy driver for 2.6.8.1-mm4
> > > acpi_floppy_resource: 6 ioports at 0x3f0
> > > acpi_floppy_resource: 1 ioports at 0x3f7
> > > floppy: controller ACPI FDC0 at I/O 0x3f0-0x3f5, 0x3f7-0x3f7 irq 6 dma channel 2
> > > Floppy drive(s): fd0 is 1.44M
> > > floppy0: no floppy controllers found
> 
> Aric and Petr, can you give this patch a try?  It's a replacement for the
> one currently in 2.6.8.1-mm4.  I adopted Petr's strategy of just clearing
> the low three bits of the first I/O port region, and also his module
> unload fixes.

Great! Seems to work now:

[-snip-]
inserting floppy driver for 2.6.8.1-mm4
floppy: controller ACPI FDC0 at I/O 0x3f0-0x3f5, 0x3f7 irq 6 dma
channel 2
floppy: FDC0 _CRS erroneously includes 0x3f0
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
[-snip-]

I'm not sure if that warning is really necessary or not, but for debug
purposes it is not a problem.  As such, might want to consider change
that message to a KERNEL_DEBUG.  Not really a big issue though I
guess.  I just don't like the word "erroneously" in my kernel logs
each time I boot :)

> I also added a couple validity checks (for firmware that doesn't
> report 0x3f7 or reports 0x3f0 or 0x3f6), and made them ignore the
> device altogether if "acpi=strict".  Any comments on that, Len?

I have to remove the acpi_strict code that you added in order to get
the driver to load.  I am using it as a module, and the acpi_strict
symbol does not seem to be exported by the kernel.  Since I am not
using the acpi=strict flag anyways, I just killed the related 6 lines
from your patch before applying it.  I'm sure it would have been fine
had I compiled the driver into the kernel, but as it stands now the
acpi_strict variable would need to be exported I guess.

-- 
Aric Cyr <acyr at alumni dot uwaterloo dot ca>    (http://acyr.net)
gpg fingerprint: 943A 1549 47AC D766 B7F8  D551 6703 7142 C282 D542
