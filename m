Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUBXQrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 11:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262297AbUBXQrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 11:47:47 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:9918 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262292AbUBXQr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 11:47:26 -0500
Subject: RE: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug 
	fix)
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Mukker, Atul" <Atulm@lsil.com>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3DA@exa-atlanta.se.lsil.com>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3DA@exa-atlanta.se.lsil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Feb 2004 10:47:11 -0600
Message-Id: <1077641233.1804.145.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 10:04, Mukker, Atul wrote:
> Wow! That's a lot of no-no. But we'll let the code speak for itself. The
> major driving force behind the unified design is support for MPT raid
> controllers and also a single code base, with a very small footprint patch -
> if at all required, to support various kernels.

I didn't say "no".  I'm just warning you that you've chosen a hard road
to hoe, particularly with the limited life of 2.4.

> In this driver, the base kernel is assumed to be a lk 2.6.x with appropriate
> APIs added for lk 2.4.x.
> 
> I recommend reading the concise design document, mraid_hotplug.doc, which
> explains the overall layout of the driver and some design concerns. This
> document is part of the driver package.

OK, I read it.

This is worrying:

"Even though the use of pure hotplug APIs is very appealing, I want to
propose
some deviation from this approach. If drivers rely on the PCI framework
to
discover adapters, we lose flexibility of registering controllers in a
particular order with the operating system."

Anything relying on discovery ordering in 2.6 is broken.

And so is this:

"An important MegaRAID feature is to be able to boot from any logical
drive on
any controller. Since persistent device naming is not prevalent in Linux
world
as of this writing, the order in which the devices are discovered is
very
important. We would like to continue to give users flexibility to
designate
any logical drive on any controller as the boot drive. As long as the
BIOS on
this controller is enabled, and only on this one :-), the chosen disk
would be
exported to the OS before any other disk."

If you require this functionality in 2.6, you should look at plugging
into the udev infrastructure.

> Obviously we are open to all suggestions and ready to modify the code if
> there is a general feeling in that direction. Also, this driver would
> required to sit in a directory because of a split in files

Well, I cast a brief glance over it, the #ifdef structure is horrible
(and basically a product of trying to support 2.4).

This is unacceptable:

#if defined (__x86_64__)
		/*
		 * Register the 32-bit ioctl conversion
		 */
		register_ioctl32_conversion(MEGAIOCCMD, sys_ioctl)
#endif

The best thing to do would be to design the API to be 32/64 agnostic,
but if you can't do that, at least use the CONFIG_COMPAT infrastructure
that already exists.

James


