Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266531AbRGDHxr>; Wed, 4 Jul 2001 03:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266532AbRGDHxh>; Wed, 4 Jul 2001 03:53:37 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:63496 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S266531AbRGDHx1>;
	Wed, 4 Jul 2001 03:53:27 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15170.51921.425104.939067@tango.paulus.ozlabs.org>
Date: Wed, 4 Jul 2001 17:50:41 +1000 (EST)
To: David T Eger <eger@cc.gatech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: readl() / writel() on PowerPC
In-Reply-To: <Pine.SOL.4.21.0107022017370.23357-100000@oscar.cc.gatech.edu>
In-Reply-To: <Pine.SOL.4.21.0106180852480.16027-100000@oscar.cc.gatech.edu>
	<Pine.SOL.4.21.0107022017370.23357-100000@oscar.cc.gatech.edu>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David T Eger writes:

> Am I missing something?  Is there some reason that readl() and
> writel() should byte-swap by default?

readl()/writel() are defined to access PCI memory space in units of 32
bits.  PCI is by definition little-endian, PowerPC is (natively at
least) big-endian, hence the byte-swap.  Same for inl/outl etc., but
not insl/outsl - they don't swap because they are typically used for
transferring arrays of bytes, just doing it 4 bytes at a time (2 at a
time for insw/outsw).

You can use __raw_readl/__raw_writel if you don't want byte-swapping,
but they also don't give you any barriers.  Thus if you do

	__raw_writel(v, addr);
	x = __raw_readl(addr);

it is quite possible for the read to hit the device before the write.
If you want to prevent that you need to put an iobarrier_rw() call in
between the read and the write.  You don't need a barrier between
successive writes unless you want to prevent any potential
store-gathering from happening, because PowerPC's don't reorder writes
to I/O regions.

Paul.
