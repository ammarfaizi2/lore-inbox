Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTCEHdX>; Wed, 5 Mar 2003 02:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTCEHdX>; Wed, 5 Mar 2003 02:33:23 -0500
Received: from users.linvision.com ([62.58.92.114]:10881 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S264730AbTCEHdV>; Wed, 5 Mar 2003 02:33:21 -0500
Date: Wed, 5 Mar 2003 08:43:33 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Matthew Wilcox <willy@debian.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Proposal: Eliminate GFP_DMA
Message-ID: <20030305084332.B22193@bitwizard.nl>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73heao7ph2.fsf@amdsimf.suse.de> <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk> <1046445897.16599.60.camel@irongate.swansea.linux.org.uk> <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk> <1046447737.16599.83.camel@irongate.swansea.linux.org.uk> <20030304185616.A9527@bitwizard.nl> <1046819369.12226.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1046819369.12226.34.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 11:09:30PM +0000, Alan Cox wrote:
> On Tue, 2003-03-04 at 17:56, Rogier Wolff wrote:
> > All the modifier flags on kmalloc and GFP should be "memory allocation
> > descriptors".
> > A DMA pool descriptor will only point to pools that have that
> > capability.
> 
> Much much too simple. DMA to what from where for example ? Post 2.6 its
> IMHO a case of making the equivalent of pci_alloc_* pci_map_* work with
> generic device objects now we have them.

I can't think of a case that doesn't fit my model. So, if you're
saying that it's simple, that's good.

          dev1      +----------+        dev2
           |        |  CPU /   |         |
   --------+--------+  BRIDGE  +---------+--------
           |        |  ---->   |         |
          mem1      +----------+        mem2

If for example, there are two PCI busses, and a memory controller on
both of them, but no DMA cpability in one direction through the PCI 
bridge (embedded CPU) then there should be two memory pools. 

In the picture above: dev1 can reach mem2, but dev2 can't reach mem1.

PCI devices on the restricted PCI bus (dev2) will have to pass a 
memory allocation descriptor that describes just the memory on 
that PCI bus,  the other one (dev1) can pass a descriptor that 
prefers the non-shared memory, (leaving as much as possible for 
the devices on the other bus (bus2)), but
reverts to the memory that the other devices can handle as well. 

But if we end up "reading" from dev1, and writing the same data
to dev2 we're better off DMAing it to "mem2". So, how to tell
the dev1 driver that allocing off the allocation descriptor 
"mem1, then mem2", is not a good a good idea, and that it should
use "mem2, then mem1" is a problem that remains to be solved... 


But if I'm missing a case that can't be modelled, please enlighten
me as to what I'm missing.... 

			Roger.


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
