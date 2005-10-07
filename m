Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbVJGPXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbVJGPXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbVJGPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 11:23:13 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35806 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030328AbVJGPXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 11:23:12 -0400
Date: Fri, 7 Oct 2005 10:23:05 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] ppc64: EEH Avoid racing reports of errors
Message-ID: <20051007152305.GY29826@austin.ibm.com>
References: <20050930004800.GL29826@austin.ibm.com> <20050930010038.GF6173@austin.ibm.com> <17219.47007.44643.148022@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17219.47007.44643.148022@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 09:23:11PM +1000, Paul Mackerras was heard to remark:
> Linas writes:
> 
> > 06-eeh-report-race.patch
> 
> Shouldn't you pass in pe_dn->child here, or
> alternatively rearrange __eeh_mark_slot to do the node you give it
> plus its children (recursively)?

Yes; that's right; this gets fixed in a later patch in the series. 
I guess this one snuck by while I was trying to sync up all the
different patches I was carrying :-/

> Two other comments about __eeh_mark_slot: (1) despite the comment, the
> function doesn't do anything to any pci_dev or pci_driver 

The comment is also a "back port" of function that shows up in a later
patch, and so indeed is inappropriate for this patch. Again, my excuse 
is that I got sloppy while juggling all of these patchlets. Sorry.

> (not that it
> should be touching any pci_driver), 

One problem I was seeing was that after getting an EEH error, 
some device drivers would start spinning in thier interrupt handlers.
I tried to break out of this spin-loop by adding a call to a
function that asked "am I the victim of an EEH event"?  
Unfortunately, the first implementation of this call was not 
interrupt safe (pci_device_to_OF_node calls traverse_pci_devices).
While scratching my head on to how to best fix this, I decided that 
the best thing to do would be to mark up the pci driver with a flag;
that way, the driver can look up te EEH state without any further ado.

One might be able to get rid of this state in pci_driver, 
although it seemed generically useful to have.  For example,
later on, I futzed with a version that disabled the irq line 
for that adapter "as soon as possible", and that seems to also 
work, at least on an SMP machine. On a non-SMP machine, there 
is still the danger that the device driver is spinning with 
interrupts disabled, waiting on a status regiser to change, 
that will never change. (And because of the deadlock, the 
code to disable a given irq line never runs).  Its all
depends on how the device driver got written.

> and (2) a recursive function can't
> really be inline 

Well, no, but at least the first level call can be inlined; I assumed 
that gcc would do at least that, but didn't check.

--linas

