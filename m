Return-Path: <linux-kernel-owner+w=401wt.eu-S932410AbWLLVnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWLLVnM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 16:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbWLLVnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 16:43:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:44101 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932410AbWLLVnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 16:43:11 -0500
Date: Tue, 12 Dec 2006 13:42:52 -0800
From: Greg KH <gregkh@suse.de>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2]: Renumber PCI error enums to start at zero
Message-ID: <20061212214252.GC2580@suse.de>
References: <20061212195524.GG4329@austin.ibm.com> <20061212203543.GA4991@suse.de> <20061212213542.GK4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212213542.GK4329@austin.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 03:35:42PM -0600, Linas Vepstas wrote:
> On Tue, Dec 12, 2006 at 12:35:43PM -0800, Greg KH wrote:
> > On Tue, Dec 12, 2006 at 01:55:24PM -0600, Linas Vepstas wrote:
> > > 
> > > Subject: [PATCH 1/2]: Renumber PCI error enums to start at zero
> > > 
> > > Renumber the PCI error enums to start at zero for "normal/online".
> > > This allows un-initialized pci channel state (which defaults to zero)
> > > to be interpreted as "normal".  Add very simple routine to check
> > > state, just in case this ever has to be fiddled with again.
> > 
> > No, as you have a specific type for this state, never test it against
> > "zero".  That just defeats the whole issue of having a special type for
> > this state.
> 
> Yes, well, I guess that was my initial thinking, which is why it got
> coded that way. But "in real life", the value in the struct isn't
> initialized (thus taking a value of zero). Its not initialized 
> in deference to the traditional idea that "just saying bzero() 
> should be enough".  

Then properly initialize the thing.

> However, that turned the test for error into a dorky double test:
> if(pdev->error_state && pdev->error_state != pci_channel_io_normal)
> which struck me as lame. 

Again, don't test an explicit enumerated type against "0", that's just
foolish.  Why have the explicit type if you are going to do that?  Does
sparse complain about it?  It should if it doesn't...

> So, I'll ask: is it better to test for (state!=0 && state!=1) or,
> to initialize pdev->error_state = pci_channel_io_normal; in the driver 
> probe code?

Initialize the state in the probe.  Then check against the enumerated
type, not an integer value.  Sparse should complain if you try to do
that.

Or, if you really want to test against integers, rip out those types,
otherwise they are useless as you keep trying to go around them...

thanks,

greg k-h
