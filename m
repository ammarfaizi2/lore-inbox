Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264530AbUHaRAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbUHaRAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUHaRAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:00:30 -0400
Received: from users.linvision.com ([62.58.92.114]:32475 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264530AbUHaRAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:00:17 -0400
Date: Tue, 31 Aug 2004 19:00:16 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@harddisk-recovery.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: Driver retries disk errors.
Message-ID: <20040831170016.GF17261@harddisk-recovery.com>
References: <20040830163931.GA4295@bitwizard.nl> <1093952715.32684.12.camel@localhost.localdomain> <20040831135403.GB2854@bitwizard.nl> <1093961570.597.2.camel@localhost.localdomain> <20040831155653.GD17261@harddisk-recovery.com> <1093965233.599.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093965233.599.8.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 04:13:54PM +0100, Alan Cox wrote:
> On Maw, 2004-08-31 at 16:56, Erik Mouw wrote:
> > The SCSI disk driver has been doing a single retry for quite some time
> > and it hasn't really bitten people. Why would the IDE disk driver be
> > different? The only case I can imagine a retry would be OK, is when we
> > get an UDMA CRC error (caused by bad cables).
> 
> Retries also pop up in other less obvious cases and conveniently paper
> over a wide variety of timeouts, power management quirks and drives just
> having a random fit. Eight is probably excessive in all cases.

There are indeed all sorts of other retries in various layers, the
worst one when the kernel tries to read-ahead a couple of blocks on an
IDE disk(1). You can work around them with raw IO or O_DIRECT.

> For non hard disk cases many devices do want and need retry.

And many others do not. CompactFlash readers are usually implemented as
a USB storage device, which on its turn is implemented as a SCSI
"disk". So far I haven't seen a CompactFlash which could be "fixed" by
retries.

iSCSI appliances can also make things worse: when the target machine is
implemented as a simple "pass everything to the real SCSI disk" device,
it's not really different from a directly connected SCSI disk. However,
when the iSCSI target interprets the SCSI commands and has its own way
to deal with bad blocks (i.e.: it retries the blocks), things can get
very bad when the kernel also uses a couple of retries.

In my experience it would be good if the IDE disk driver would behave
like the SCSI disk driver: no retries on a bad block. I agree that it
would be a good idea to make it configurable through the block layer to
avoid code duplication (blockdev --getretries/--setretries).


Erik

(1) Imagine an application doing a linear read on a file with an 8
block read ahead and the last block being bad. The kernel will try to
read that bad block 16 times, but because the IDE driver also has 8
retries, the kernel will try to read that bad block *64* times. It
usually takes an IDE drive about 2 seconds to figure out a block is
bad, so the application gets stuck for 2 minutes in that single bad
block.

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
