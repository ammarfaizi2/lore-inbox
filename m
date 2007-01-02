Return-Path: <linux-kernel-owner+w=401wt.eu-S1753571AbXABQbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753571AbXABQbs (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 11:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754887AbXABQbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 11:31:47 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:45857 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbXABQbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 11:31:47 -0500
Message-ID: <459A88F1.70706@s5r6.in-berlin.de>
Date: Tue, 02 Jan 2007 17:31:45 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Kyuma Ohta <whatisthis@jcom.home.ne.jp>, Andreas Schwab <schwab@suse.de>,
       linux-kernel@vger.kernel.org,
       Linux1394-devel ML <linux1394-devel@lists.sourceforge.net>
Subject: Re: 2.6.20-rc2: kernel BUG at include/asm/dma-mapping.h:110!
References: <je7iwa1l8a.fsf@sykes.suse.de>	<1167550089.12593.11.camel@melchior>  <jey7oowgdo.fsf@sykes.suse.de> <1167708109.12382.26.camel@melchior> <459A800E.3010604@s5r6.in-berlin.de>
In-Reply-To: <459A800E.3010604@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(list address corrected, and a question added...)

On 1/2/2007 4:53 PM, I wrote:
> Kyuma Ohta wrote:
> ...
>> Now,I'm testing 2.6.20-rc3 for x86_64, submitted patch for this issue;
>> "Fault has happened  in 'cleanuped' sbp2/1394 module in *not 32bit*
>> architecture hardwares ."
>> 
>> As result of, sbp2 driver in 2.6.20-rc3 is seems to running 
>> w/o any faults,but communication both host and harddrive(s) 
>> was seems to be unstable yet :-(
>> Sometimes confuse packets,such as *very* older 1394 driver :-(
> 
> That is, sbp2 on 2.6.20-rc3 works less stable for you than on 2.6.19? Or
> which previous kernel is the basis of your comparison? Are there any log
> messages or other diagnostics? And what hardware do you have?
> 
> If you can tell which kernel was good for you, I could create a set of
> patches for you which allows to revert sbp2 while keeping the rest of
> the kernel at the level of 2.6.20-rc3, so that you could find the
> destabilizing change (if it happened in sbp2, not somewhere else).
> 
> Although there was a certain volume of changes to sbp2 between 2.6.19
> and 2.6.20-rc{1,3}, none of them should change the behavior except for:
> 
>  - commit 0b885449ac6fab42cd6808c9ea8d6e456e0e65b7 "ieee1394: sbp2:
>    remove duplicate code" modifying the extremely unlikely case that
>    a bus reset occurs right after completion status of an unsuccessfully
>    completed command came in,
> 
>  - commit 23077f1d72d279244536f11db51258fc4759c81a "ieee1394: sbp2:
>    slightly reorder sbp2scsi_abort" which improves a SCSI error handler,
>    mostly relevant if a command timed out.
> 
>  - commit b2bb550c4a10c44e99fe469cfaee81e2e3109994 "ieee1394: sbp2: pass
>    REQUEST_SENSE through to the target" which exposes targets to a SCSI
>    command which was previously blocked out. But this command is either
>    never issued by stock Linux SCSI drivers to SBP-2 targets anyway
>    because they provide autosense data, or has to be be properly
>    supported by SBP-2 targets if targets don't send autosense data.
>    (This is also about error handling, unless special application
>    software is explicitly generating this command.)
> 
> The DMA mapping patch did only change behavior because it was just
> faulty. After its correction in 2.6.20-rc3, it really is a trivial 1:1
> conversion from the pci_dma_ API to the generic dma_ API. I neither
> added nor removed anything from the mapping operations and they should
> behave exactly the same as before with PCI FireWire controllers.
> 
> Or could there have been some hidden mistake in sbp2's old pci_dma_
> usage which now turns into real problems after 1:1 conversion to the
> dma_API?
> 
> Or are there any DMA related properties of hardware that the DMA mapping
> infrastructure cannot figure out from the generic device (contained in a
> pci_device) compared to the pci_device?

Or are there some restrictions implicit in mappings via pci_dma_ API
which are lifted when using mappings via dma_ API?
-- 
Stefan Richter
-=====-=-=== ---= ---=-
http://arcgraph.de/sr/
