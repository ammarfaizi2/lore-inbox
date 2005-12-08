Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbVLHQ0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbVLHQ0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVLHQ0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:26:44 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:31139 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S932196AbVLHQ0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:26:43 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: uart_match_port() question
Date: Thu, 8 Dec 2005 09:26:37 -0700
User-Agent: KMail/1.8.2
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1133050906.7768.66.camel@gaston> <200512071636.33901.bjorn.helgaas@hp.com> <1134001049.7168.97.camel@gaston>
In-Reply-To: <1134001049.7168.97.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512080926.37497.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 December 2005 5:17 pm, Benjamin Herrenschmidt wrote:
> On Wed, 2005-12-07 at 16:36 -0700, Bjorn Helgaas wrote:
> > On Wednesday 07 December 2005 4:13 pm, Benjamin Herrenschmidt wrote:
> > > ...  Part of the problem here is for example PIO. There is no such
> > > thing as PIO on a PowerPC, it's purely a PCI abstraction, thus inX/outX
> > > will only work once the PCI host briges have been discovered and their
> > > IO space mapped (setup_arch() time, but I definitely want my early
> > > console earlier).
> > 
> > ia64 has a similar problem, but it's a bit easier because firmware
> > configures and tells us about the legacy (0-64K) I/O port space.
> > So we do have to look up the MMIO base where those I/O ports get
> > mapped, but that's basically the first thing in setup_arch().  We
> > don't do much before that, so it hasn't been worthwhile to make
> > the console work earlier.
> 
> Oh, that's what I do too, that is, I have a mecanism now to walk the
> firmware device-tree and get the MMIO, my problem was with matching that
> MMIO address with the PIO one that 8250 gets later on. It seems that you
> solved that problem so it looks like I really need to look more closely
> at what you are doing :)

Well, don't get your hopes up too much...  ia64 uses the same addresses
early and late, i.e., if 8250_pci discovers a PIO port, the early code
also uses a PIO address.  We never use an MMIO address early and a PIO
address later.

The PIO -> MMIO translation is hidden inside our inb/outb functions
(see __ia64_mk_io_addr()).  The firmware tells us where the legacy
0-64K I/O ports are mapped, so we can set up io_space[0].mmio_base
very early, without enumerating the PCI bridges.
