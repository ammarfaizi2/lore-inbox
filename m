Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbVF2Qez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbVF2Qez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 12:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVF2Qey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 12:34:54 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:63738 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262606AbVF2QeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 12:34:14 -0400
Date: Wed, 29 Jun 2005 11:34:08 -0500
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       long <tlnguyen@snoqualmie.dp.intel.com>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Greg KH <greg@kroah.com>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@us.ibm.com
Subject: Re: [PATCH 7/13]: PCI Err: Symbios SCSI  driver recovery
Message-ID: <20050629163408.GI28499@austin.ibm.com>
References: <20050628235919.GA6415@austin.ibm.com> <20050629030237.GB71992@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629030237.GB71992@muc.de>
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 05:02:37AM +0200, Andi Kleen was heard to remark:
> On Tue, Jun 28, 2005 at 06:59:19PM -0500, Linas Vepstas wrote:
> > 
> > pci-err-7-symbios.patch
> > 
> > Adds PCI Error recoervy callbacks to the Symbios Sym53c8xx driver.
> > Tested, seems to work well under i/o stress to one disk. Not
> > stress tested under heavy i/o to multiple scsi devices.
> 
> What does this do to the IO requests currently being processed
> by the firmware? Do they get all aborted? Is it ensured
> that they all error out properly? 

Interesting question; two replies.

>From the hardware point of view, the scsi card is soft-reset, which
wipes out all state on the card, including any command queues on the
card.  In-progress transactions, e.g. disk drives in the middle of
receiving commands or in the process of responding to reads, are lost.
The freshly rebooted scsi controller may wonder why disks are suddenly
sending it data. 

This may sound alarming, but it not much different than the existing
standard/generic SCSI bus-reset/host resest sequences, which I
beleive (hope) work correctly.  In particular, there shouldn't be 
any data corrpution; here's why:

>From the kernel point of view, file system i/o goes through the block 
device, through to scsi_dispatch_cmd(), to the symbios driver.  
Any queued requests stay queued until they are fulfilled.  Queued
requests get replayed, in a fashion similar to what would be needed
after a host reset.  In particular, there shouldn't be and (permanent)
file system corruption because any inconsistent state on the disk 
would get over-written when the queued reqeusts get re-issued.

At least, that's how i think it should work.  My testing was light ...
inject errors while doing mild single-disk i/o.  Haven't run any
full stress tests, with would e.g. write patterns to multiple disks
and then read back the patterns and bit-compare.   Someday, I hope to 
run this test :) However, if this reveals bugs, I beleive these will 
be generic bugs, rather than PCI error recovery related bugs.

FWIW, yes, I have heard of devices that "cheat", and report back that a
transaction is complete, even though it is still pending in firmware
somewhere, either  on the host or the disk.  Those devices get screwed.

No doubt, this will happen to some giant banking customer, and result
in the corruption of serious financial data.  There will be hundreds 
of airplane trips as dozens of techies will be hunched over the system 
wondering "what happened" while executives fume in the corner,
threatening billion dollar lawsuits. The net output of this will be
a one-line patch to drivers/scsi/scsi_lib.c which will be lost in the
noise of the LKML.  Shit happens.

--linas


