Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbVCNFjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVCNFjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 00:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVCNFjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 00:39:37 -0500
Received: from stark.xeocode.com ([216.58.44.227]:32903 "EHLO
	stark.xeocode.com") by vger.kernel.org with ESMTP id S261397AbVCNFjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 00:39:18 -0500
To: Greg Stark <gsstark@MIT.EDU>
Cc: Andrew Morton <akpm@osdl.org>, Greg Stark <gsstark@mit.edu>,
       s0348365@sms.ed.ac.uk, linux-kernel@vger.kernel.org,
       pmcfarland@downeast.net
Subject: Re: OSS Audio borked between 2.6.6 and 2.6.10
References: <87u0ng90mo.fsf@stark.xeocode.com>
	<200503130152.52342.pmcfarland@downeast.net>
	<874qff89ob.fsf@stark.xeocode.com>
	<200503140103.55354.s0348365@sms.ed.ac.uk>
	<87sm2y7uon.fsf@stark.xeocode.com>
	<20050313200753.20411bdb.akpm@osdl.org>
	<87br9m7s8h.fsf@stark.xeocode.com>
In-Reply-To: <87br9m7s8h.fsf@stark.xeocode.com>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 14 Mar 2005 00:39:08 -0500
Message-ID: <87zmx66b2b.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark <gsstark@MIT.EDU> writes:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > Are you able to narrow it down to something more fine grained than "between
> > 2.6.6 and 2.6.9-rc1"?
> 
> Er, I suppose I would have to build some more kernels. Ugh. Is there a good
> place to start or do I have to just do a binary search?

Oof. I just skimmed the Changelogs. It looks like the i810 OSS drivers got
quite a rototilling in 2.6.7 and 2.6.8. It also kind of sounds like they
needed it though.

>From the look of this I doubt the 2.6.6 drivers will build or load into
2.6.10.




2.6.7:

<jdgaston@snoqualmie.dp.intel.com>
	[PATCH] I2C: ICH6/6300ESB i2c support
	
	This patch adds DID support for ICH6 and 6300ESB to i2c-i801.c(SMBus).
	In order to add this support I needed to patch pci_ids.h with the SMBus
	DID's.  To keep things orginized I renumbered the ICH6 and ESB entries
	in pci_ids.h.  I then patched the piix IDE and i810 audio drivers to
	reflect the updated #define's.  I also removed an error from irq.c;
	there was a reference to a 6300ESB DID that does not exist.

<jgarzik@redhat.com>
	[sound/oss i810] pci id cleanups
	
	The driver defined its own PCI id constants.  Kill the majority,
	which were redundant, and move the rest to include/linux/pci_ids.h.
	
	Also, move open-coded tests for "new ICH" audio chips to a single
	helper function.  These tests were being patched with each new
	ICH motherboard from Intel, resulting in each new PCI id being added
	to several places in the driver.
	
	Note that, even though this should be a harmless patch, there
	exists the remote possibility that I mis-matched some of the
	PCI ids, as I only tested ICH5.

<herbert@gondor.apana.org.au>
	[sound/oss i810] fix wait queue race in drain_dac
	
	This particular one fixes a textbook race condition in drain_dac
	that causes it to timeout when it shouldn't.
<herbert@gondor.apana.org.au>
	[sound/oss i810] fix race
	
	This patch fixes the value of swptr in case of an underrun/overrun.
	
	Overruns/underruns probably won't occur at all when the driver is
	fixed properly, but this doesn't hurt.

<herbert@gondor.apana.org.au>
	[sound/oss] remove bogus CIV_TO_LVI
	
	This patch removes a pair of bogus LVI assignments.  The explanation in
	the comment is wrong because the value of PCIB tells the hardware that
	the DMA buffer can be processed even if LVI == CIV.
	
	Setting LVI to CIV + 1 causes overruns when with short writes
	(something that vmware is very fond of).

<herbert@gondor.apana.org.au>
	[sound/oss i810] clean up with macros
	
	This patch adds a number macros to clean up the code.

<herbert@gondor.apana.org.au>
	[sound/oss i810] fix partial DMA transfers
	
	This patch fixes a longstanding bug in this driver where partial fragments
	are fed to the hardware.  Worse yet, those fragments are then extended
	while the hardware is doing DMA transfers causing all sorts of problems.

<herbert@gondor.apana.org.au>
	[sound/oss i810] fix playback SETTRIGGER
	
	This patch fixes SETTRIGGER with playback so that the LVI is always
	set and the DAC is always started.

<herbert@gondor.apana.org.au>
	[sound/oss i810] fix OSS fragments
	
	This patch makes userfragsize do what it's meant to do: do not start
	DAC/ADC until a full fragment is available.

<herbert@gondor.apana.org.au>
	[sound/oss i810] remove divides on playback
	
	This patch removes a couple of divides on the playback path.

<herbert@gondor.apana.org.au>
	[sound/oss i810] fix drain_dac loop when signals_allowed==0
	
	This patch fixes another bug in the drain_dac wait loop when it is
	called with signals_allowed == 0.

<herbert@gondor.apana.org.au>
	[sound/oss i810] fix reads/writes % 4 != 0
	
	This patch removes another bogus chunk of code that breaks when
	the application does a partial write.
	
	In particular, a read/write of x bytes where x % 4 != 0 will loop forever.

<herbert@gondor.apana.org.au>
	[sound/oss i810] fix deadlock in drain_dac
	
	This patch fixes a typo in a previous change that causes the driver
	to deadlock under SMP.



2.6.8:


<linville@redhat.com>
	[sound/oss i810] add MMIO DSP support
	
	Enclosed is a patch for the i810_audio OSS driver to support using
	memory-mapped I/O for those chipsets that support it.
	
	 o Added a family of macros -- I810_IOREADx() and I810_IOWRITEx() -- that
	key off the existing card->use_mmio flag to select between using readx/writex
	or inx/outx for I/O operations.
	
	 o Converted existing inx/outx invocations to use
	I810_IOREADx/I810_IOWRITEx instead.
	
	 o Changed GET_CIV(), GET_LVI, and CIV_TO_LVI() not only to use
	I810_IOREADx/I810_IOWRITEx but also to take "card" (i.e. struct i810_card)
	paramter.
	
	 o Removed check for "Pure MMIO interfaces" in i810_probe() -- replaced w/
	(relocated) check for no I/O resources available.

<linville@redhat.com>
	[sound/oss i810] misc small changes
	
	Attached is a second patch to account for (most of) Herbert Xu's
	comments.
	
	I have left-out the part about changing state->card to a
	local variable where it is used a lot.  Unfortunately, that usage is
	somewhat pervasive and I would prefer to make those changes in a separate
	patch -- after I have had a chance to do some testing.
	
	If you'd prefer one patch to account for the original plus these
	changes, let me know and I'll be happy to provide it.






-- 
greg

