Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVGMWqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVGMWqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbVGMWn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:43:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:12978 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262779AbVGMWms
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:42:48 -0400
Date: Wed, 13 Jul 2005 17:42:44 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH 2.6.13-rc1 03/10] IOCHK interface for I/O error handling/detecting
Message-ID: <20050713224244.GM26607@austin.ibm.com>
References: <42CB63B2.6000505@jp.fujitsu.com> <42CB664E.1050003@jp.fujitsu.com> <20050712195120.GE26607@austin.ibm.com> <1121213938.31924.406.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1121213938.31924.406.camel@gaston>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Yes, but ...

On Wed, Jul 13, 2005 at 10:18:57AM +1000, Benjamin Herrenschmidt was heard to remark:
> 
> > Are you assuming that a device driver will use an iochk_read() for
> > every DMA operation? for every MMIO to the card?  
> > 
> > For high performance devices, it seems to me that this will cause
> > a rather large performance burden, especially if its envisioned that
> > all architectures will do something similar.
> > 
> > My concern is that (at least on ppc64) the call pci_read_config_word()
> > requires a call into "firmware" aka "BIOS", which takes thousands upon
> > thousands of cpu cycles.  There are hundreds of cycles of gratuitous
> > crud just to get into the firmware, and then lord-knows-what the
> > firmware does while its in there; probably doing all sorts of crazy
> > math to compute bus addresses and other arcane things.  I would imagine
> > that most architectures, includig ia64, are similar.
> > 
> > Thus, one wouldn't want to perform an iochk_read() in this way unless
> > one was already pretty sure that an error had already occured ... 
> > 
> > Am I misunderstanding something?
> 
> I would expect pSeries not to use the "default" error checking (that
> tests the status register) but rather use EEH.


OK, it wasn't clear to me if every possible case of the "detected parity
error" bit being set on the pci adapter is converted into an EEH error.
I had the impression that the adapter can set the bit, but not signal a 
#PERR, adn thus have no EEH event.   I am investigating this now.

If a given device driver is expecting iochk_read() to catch this situation, 
then we'd be screwed.

--linas
