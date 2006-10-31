Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423706AbWJaW0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423706AbWJaW0h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWJaW0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:26:37 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49384 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423706AbWJaW0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:26:36 -0500
Date: Tue, 31 Oct 2006 16:26:32 -0600
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-scsi@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: PCI Error Recovery: Symbios SCSI device driver
Message-ID: <20061031222631.GQ6360@austin.ibm.com>
References: <20061020180510.GN6537@austin.ibm.com> <20061031185506.GE26964@parisc-linux.org> <1162322643.13859.54.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162322643.13859.54.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 02:24:01PM -0500, James Bottomley wrote:
> 
> Just for my own edification, what happens on the dual function (dual
> channel) boards?  We have two threads there and two separate I/O
> processors.  I assume a PCI error will kill both, 

Yes.

> do we need to do
> something about this?

I'm not sure, and actually, I have not thought about 
or tested this case for the symbios. 

The answer depends on the h/w design.  On PCI
multi-function cards, the PCI reset callbacks will 
get called for each PCI function. (Each function 
gets to vote/veto how it wants te reset to proceed).

If the hardware supports completely independent scsi 
host initialization for each scsi i/o processor, 
then things should just work. 

If some part of the card init sequence needs to run 
only once, even when there are two i/o processors, then
this needs to be protected against.  I presume that
using  if(0 == PCI_FUNC(pdev->devfn)) is enough to
make sure the hardware initilization is called only once 
for the card -- i.e. by calling it only for PCI
function zero. If there needs to be some additional 
locking to make sure that the card initialization
completes before the i/o processor initialization 
starts ... well, I don't know about that.

--linas



