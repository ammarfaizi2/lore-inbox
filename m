Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTDHQdk (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbTDHQdk (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:33:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:65409 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261482AbTDHQdf (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 12:33:35 -0400
Date: Tue, 8 Apr 2003 17:45:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rusty Russell <rusty@rustcorp.com.au>,
       zwane@linuxpower.ca,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hch@infradead.org
Subject: Re: SET_MODULE_OWNER?
Message-ID: <20030408164501.GA30428@mail.jlokier.co.uk>
References: <20030408035210.02D142C06E@lists.samba.org> <1049802672.8120.14.camel@dhcp22.swansea.linux.org.uk> <20030408144644.GB30142@mail.jlokier.co.uk> <20030408151226.GA30285@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408151226.GA30285@gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> No.  Because Rusty wanted to replace a "func_call()" object with a
> direct reference to a structure.  Direct struct member references is the
> big issue that we are trying to _avoid_, because they are the single
> most painful issue to deal with, WRT source back-compat.  You can ifdef
> around a function quite easily, but not a direct struct member use.
> 
> To give another concrete example, I was able to take a 2.4 PCI driver
> and make it work under 2.2 transparently, with a single exception:  The
> "driver_data" member of the new struct pci_dev.  Drivers were directly
> referencing that, which was a new addition in 2.4.x (really 2.3.x).  So,
> I created the abstraction wrappers pci_[gs]et_drvdata(), which does
> nothing but a simple C assignment (or read, for _get_).  The addition of
> this wrapper removed the need for nasty ifdefs in the drivers for 2.2
> versus 2.4, and make it possible for the kernel source to continue to be
> readable, "pretty", and ifdef-free.

I've done similar things myself.  My drivers, including network and
char devices, work on all kernels from 2.0 to 2.4 using similar
kcompat-like macros.  I've not extended any to work with 2.5, though.

If you want to write drivers that work on 2.4 and 2.2 kernels, that's
easy: #include <kcompat.h> or whatever you use, and call
SET_MODULE_OWNER in your drivers.

However, if you insist on using drivers from the 2.4 kernel tree on
2.2 kernels, that's a different matter, and you have a point.

For 3rd party drivers that I've written, I take the first approach and
write code that very nearly conforms to 2.4 style except when it is
not possible for that to be back compatible.  This occurs in certain
file operations (2.0 has different function prototypes), in mapping
device memory to user space (change from vma->vm_offset to ->vm_pgoff,
PCI configuration (lots of changes in 2.1.93 :) and a few other
things.

It is all very well to insist that SET_MODULE_OWNER() remains so you
can take 2.4 drivers and easily compile them for 2.2...  but why is
that the benchmark?  I can't take 2.4 drivers and do that, because I
want to support 2.0 as well, so I bite the bullet and make the
necessary changes for broader compatibility.

So.. back to a point.  Is 2.2 compilability (with the help of kcompat)
one of the goals to aim for in 2.5 drivers generally?  Or is this
specifically meant for the network drivers which you support?

Cheers,
-- Jamie
