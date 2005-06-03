Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVFDPCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVFDPCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVFDPCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:02:46 -0400
Received: from webmail.topspin.com ([12.162.17.3]:42220 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261375AbVFDPCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:02:44 -0400
To: Greg KH <gregkh@suse.de>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
X-Message-Flag: Warning: May contain useful information
References: <20050603224551.GA10014@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 03 Jun 2005 16:36:17 -0700
In-Reply-To: <20050603224551.GA10014@kroah.com> (Greg KH's message of "Fri,
 3 Jun 2005 15:45:51 -0700")
Message-ID: <524qcft3m6.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Jun 2005 15:02:43.0632 (UTC) FILETIME=[75CA5B00:01C56916]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> In talking with a few people about the MSI kernel code, they
    Greg> asked why we can't just do the pci_enable_msi() call for
    Greg> every pci device in the system (at somewhere like
    Greg> pci_enable_device() time or so).  That would let all drivers
    Greg> and devices get the MSI functionality without changing their
    Greg> code, and probably make the api a whole lot simpler.

    Greg> Now I know the e1000 driver would have to specifically
    Greg> disable MSI for some of their broken versions, and possibly
    Greg> some other drivers might need this, but the downside seems
    Greg> quite small.

This was discussed the first time around when MSI patches were first
posted, and the consensus then was that it should be an "opt in"
system for drivers.  However, perhaps things has matured enough now
with PCI Express catching on, etc.

I think the number of devices truly compliant with the MSI spec is
quite tiny.  Probably just about every driver for a device that
actually has an MSI capability in its PCI header will need code to
work around some breakage, or will just end up disabling MSI entirely
because it never works.  Also I don't know how many PCI host bridges
implement MSI correctly.  For example we have a quirk for AMD 8131,
but who knows how many other chipsets are broken (and some bugs may be
much more subtle than the way the AMD 8131 breaks, which is to never
deliver interrupts).

Also, there needs to be a way for drivers to ask for multiple MSI-X
vectors.  For example the mthca InfiniBand driver gets a nice
performance boost by using separate interrupts for different types of
events.  I'm also planning on adding support for having one completion
interrupt per CPU, to help SMP scalability.

With all that said this might be a good idea, as long as there's a way
for drivers to enable MSI-X cleanly and a way for people to disable
the whole thing (eg a boot option).

 - R.
