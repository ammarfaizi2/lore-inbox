Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWCAM3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWCAM3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 07:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWCAM3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 07:29:39 -0500
Received: from the.earth.li ([193.201.200.66]:59873 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S1030202AbWCAM3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 07:29:39 -0500
Date: Wed, 1 Mar 2006 12:29:37 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Ben Dooks <ben-mtd@fluff.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make nand block functions use provided byte/word helpers.
Message-ID: <20060301122937.GL14749@earth.li>
References: <20060228205903.GZ14749@earth.li> <20060228221243.GC25880@home.fluff.org> <20060228222559.GC14749@earth.li> <20060301115020.GD25880@home.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301115020.GD25880@home.fluff.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 11:50:20AM +0000, Ben Dooks wrote:
> On Tue, Feb 28, 2006 at 10:25:59PM +0000, Jonathan McDowell wrote:
> > On Tue, Feb 28, 2006 at 10:12:43PM +0000, Ben Dooks wrote:
> > > On Tue, Feb 28, 2006 at 08:59:03PM +0000, Jonathan McDowell wrote:
> > > > I've been writing a NAND driver for the flash on the Amstrad E3.
> > > > One of the peculiarities of this device is that the write & read
> > > > enable lines are on a latch, rather than strobed by the act of
> > > > reading/writing from the data latch. As such I've got custom
> > > > read_byte/write_byte functions defined. However the nand_*_buf
> > > > functions in drivers/mtd/nand/nand_base.c are all appropriate,
> > > > except for the fact they call readb/writeb themselves, instead
> > > > of using this->read_byte or this->write_byte. The patch below
> > > > changes them to use these functions, meaning a driver just needs
> > > > to define read_byte and write_byte functions and gains all the
> > > > nand_*_buf functions free.
> > > 
> > > Why not make life easier on everyone else by over-riding the
> > > functions for read/write buffer (etc) in the nand driver... less
> > > intrusive into the core code!
> > 
> > If the patch is deemed too intrusive then that's what I'll do; I
> > nearly did so originally but when I caught myself cut and pasting
> > the code from nand_base I thought my patch was the cleaner way.
> > 
> > The patch shouldn't cause any extra work for anyone that I can see
> > and I don't think it's intrusive at all; I submitted it because I
> > figured it might save someone else some work down the line as well.
> 
> Well, a small iritation is that it adds work for the read and write
> byte function, as a function call adds instructions to the path.

Well, the _buf functions rather than the read/write_byte functions, but
yes, there will be extra instructions in the path.

> Also, do you want to check that it dosen't break any existing drivers?

Hard to do without the hardware, but I did check out the existing
drivers (from mtd-snapshot-20060222 mtd/drivers/mtd/nand/):

at91_nand.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
au1550nd.c
	Overrides the _buf functions, unaffected.
autcpu12.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
diskonchip.c
	Overrides the _buf functions, unaffected.
edb7312.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
h1910.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
rtc_from4.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
s3c2410.c
	Overrides the _buf functions, unaffected.
sharpsl.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
spia.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
toto.c
	Doesn't override any of the _buf functions, will end up being
	hit by the extra instructions in the path.
tx4925ndfmc.c
	Overrides the _buf functions.
tx4938ndfmc.c
	Overrides the _buf functions.

So 8 drivers that will have the extra instructions in the call path, 5
that already provide their own. Nothing overrides the
read_byte/write_byte functions that doesn't also override the _buf
functions that I can see, so there should be no change in behaviour.

> Secondly, you'll probably have a better piece of code for the E3
> driver if you did the block calls with only one setup for the r/w
> enable lines per block, instead of checking them for every byte done.
> You may even want to use readsb/writesb or DMA to accelerate the
> operation.

It's not a case of checking the lines; the problem is that all of NCE,
NWE and NRE are hooked up to a latch, rather than processor control
lines. My understanding is that NCE or NWE/NRE need pulled high between
writes/reads and the only way to do this is output to the control latch.
As such I don't think readsb/writesb or DMA are able to help me out?

J.

-- 
Web [            noodles is almost too good to be true             ]
site: http:// [                                          ]       Made by
www.earth.li/~noodles/  [                      ]         HuggieTag 0.0.23
