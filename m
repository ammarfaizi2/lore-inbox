Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268331AbUHKXwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268331AbUHKXwy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268411AbUHKXnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 19:43:32 -0400
Received: from web14925.mail.yahoo.com ([216.136.225.11]:44399 "HELO
	web14925.mail.yahoo.com") by vger.kernel.org with SMTP
	id S268354AbUHKXbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:31:49 -0400
Message-ID: <20040811233148.13248.qmail@web14925.mail.yahoo.com>
Date: Wed, 11 Aug 2004 16:31:48 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
In-Reply-To: <1092255102.18968.276.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Mer, 2004-08-11 at 20:24, Jon Smirl wrote:
> > Alan Cox had concerns about copying the ROMs for those devices that
> > don't implement full address decoding. I'm using kmalloc for
> 40-60KB.
> > Would vmalloc be a better choice? Very few drivers will use the
> copy
> > option, mostly old hardware.
> 
> As I said before you don't need to allocate big chunks of kernel
> memory for this because you don't want to store ROM copies in kernel,
> you just disallow mmap in such a case and let the user use read().
> 
> I am opposed to anything that keeps ROM copies in the kernel.
> 

How are we supposed to implement this without a copy? Once the device
driver is loaded there is never a safe way access the ROM again because
an interrupt or another CPU might use the PCI decoders to access the
other hardware and disrupt the ROM read. You have to copy the ROM when
the driver says it is safe.

I provided two calls for the driver to pick from: 1) make an in kernel
copy of the ROM and leave it visible from sysfs or 2) remove the sysfs
attribute. 

Another possible scheme could have a user space daemon that copies the
ROMs out of the kernel at boot and then holds them for later access by
other apps, but that would break the ROM attribute in sysfs model. 

Still another scheme would be to make the drivers for this class of
card implement a lock around PCI address decoder use. That would get
complex with interrupt routines.

How much trouble do we want to go to handling a case that only applies
to very few cards? I believe old QLogic disk controllers have this
problem, are there others? I'm not aware of any video cards with this
problem. 99%+ of PCI ROMs don't need the copy.

=====
Jon Smirl
jonsmirl@yahoo.com


		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
