Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWFTQEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWFTQEX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWFTQEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:04:22 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:23001 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751373AbWFTQEW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:04:22 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] do_no_pfn
Date: Tue, 20 Jun 2006 10:03:52 -0600
User-Agent: KMail/1.8.3
Cc: Robin Holt <holt@sgi.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, Carsten Otte <cotte@de.ibm.com>,
       bjorn_helgaas@hp.com
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <20060619224952.GA17685@lnx-holt.americas.sgi.com> <4497AB46.4000402@sgi.com>
In-Reply-To: <4497AB46.4000402@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201003.52307.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 02:01, Jes Sorensen wrote:
> Robin Holt wrote:
> > On Mon, Jun 19, 2006 at 03:06:05PM +0200, Andi Kleen wrote:
> >> The big question is - why do you have pages without struct page? 
> >> It seems ... wrong.
> ...
> Note that Bjorn Helgas has a case where he needs this as well.

I do have a case where I used pages without struct pages, but
I don't really like the implementation, and I'd love to have
someone who knows about VM tell me "no, dummy, you should do it
this way instead."

Here's the scenario:  I'm trying to implement
/sys/class/pci_bus/DDDD:BB/legacy_mem so we can run X servers
on multiple VGA cards.  The chipset (used in HP parisc and ia64
boxes) supports multiple PCI root bridges, and it routes the
VGA legacy MMIO space at 0xA0000-0xBFFFF to one of them.

This region is MMIO, so there are no struct pages for it.  I can
easily mmap the space for the first VGA device.  But to support
a second device, I have to be able to invalidate the mappings
for the first device, twiddle stuff in the chipset, and make new
mappings for the second device.  And of course I have to do the
reverse (invalidate mappings of second device, twiddle chipset,
map first device) when the first X server faults on the frame
buffer.

Basically, only one of the /sys/class/pci_bus/DDDD:BB/legacy_mem
files can have an active mmap at a time, and I haven't figured
out a good way to do the mutual exclusion.

Bjorn
