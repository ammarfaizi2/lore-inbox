Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbVKRUwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVKRUwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVKRUwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:52:32 -0500
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:9814 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S964806AbVKRUwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:52:31 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, tom.l.nguyen@intel.com,
       Greg KH <gregkh@suse.de>
Subject: Re: PCI MSI: the new interrupt routing headache
X-Message-Flag: Warning: May contain useful information
References: <437C18AF.7050508@pobox.com>
From: Roland Dreier <rolandd@cisco.com>
Date: Fri, 18 Nov 2005 12:52:22 -0800
In-Reply-To: <437C18AF.7050508@pobox.com> (Jeff Garzik's message of "Thu, 17
 Nov 2005 00:44:15 -0500")
Message-ID: <52acg14r21.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Nov 2005 20:52:23.0119 (UTC) FILETIME=[F98645F0:01C5EC81]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jeff> What needs to be done, to detect working PCI message
    Jeff> signalled interrupts such that pci_enable_msi() fails
    Jeff> properly?

There are two things that cause MSIs not to work.  First, the PCI host
bridge may not have working MSI support.  To handle this, we have the
"msi_quirk" which is set by the PCI quirk code.  For example, this is
used on systems with AMD-8131 PCI-X bridges.  (As I've noted
elsewhere, this is actually too crude a method -- actual systems exist
with e.g. both AMD-8131 and Nforce4 PCI bridges, so that MSI works for
PCIe devices but not devices below the AMD-8131)

Second, there are PCI devices that have an MSI capability but which
don't have working MSI support.  Most revisions of the e1000 fall into
this category.  In this case, it is up to the driver to know when it's
safe to try to enable MSI.

However, given that MSI/MSI-X is not in wide use, there is undoubtedly
much more broken hardware (both chipsets and devices) that we don't
know about and need to add quirks or driver workarounds for.

Hence, in the interest of discovering this hardware and also in
getting less cryptic bug reports, it's a good idea to add a test that
interrupts actually work in any driver that tries to enable MSI or
MSI-X.  Since it requires knowledge of a device to know how to get the
device to trigger an interrupt, this test has to be done in each
driver and can't be centralized.

 - R.
