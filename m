Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269462AbTCDRqB>; Tue, 4 Mar 2003 12:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbTCDRqB>; Tue, 4 Mar 2003 12:46:01 -0500
Received: from users.linvision.com ([62.58.92.114]:15842 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S269462AbTCDRp6>; Tue, 4 Mar 2003 12:45:58 -0500
Date: Tue, 4 Mar 2003 18:56:16 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030304185616.A9527@bitwizard.nl>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk> <1046447737.16599.83.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046447737.16599.83.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2003 at 03:55:37PM +0000, Alan Cox wrote:
> On Fri, 2003-02-28 at 14:34, Matthew Wilcox wrote:
> > umm.  are you volunteering to convert drivers/net/macmace.c to the pci_*
> > API then?  also, GFP_DMA is used on, eg, s390 to get memory below 2GB and
> > on ia64 to get memory below 4GB.

> The ia64 is a fine example of how broken it is. People have to hack
> around with GFP_DMA meaning different things on ia64 to everything
> else. It needs to die.

All the modifier flags on kmalloc and GFP should be "memory allocation
descriptors".

A memory allocation descriptor is a linked list of something like: 
	<memory pool pointer>
	<function to call when out of memory on this pool> 
	<next memory pool> 

An "atomic" modifier will not have a function pointer that waits for
memory when "out of memory".

A DMA pool descriptor will only point to pools that have that
capability.

Drivers will eventually have to start specifying what they really
need: GFP_1M, GFP_16M, GFP_2G, GFP_4G, GFP_36G, GFP_ATOMIC.

The 16M allocation descriptor will also point "back" to the 1M 
allocation descriptor. Thus drivers requesting memory "below 16M"
will prefer to use memory between 1M and 16M because that's first
on the list. 

I think that this will simplify things in the long run. 

				Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
