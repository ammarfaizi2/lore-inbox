Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266422AbUAIHOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 02:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266423AbUAIHOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 02:14:08 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:55372 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266422AbUAIHOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 02:14:05 -0500
Date: Thu, 8 Jan 2004 23:13:47 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jesse Barnes <jbarnes@sgi.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, James.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040109071347.GB343099@sgi.com>
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040108063829.GC22317@colo.lackof.org> <20040108173655.GA11168@sgi.com> <20040108184406.GA29210@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108184406.GA29210@colo.lackof.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 11:44:06AM -0700, Grant Grundler wrote:
> On Thu, Jan 08, 2004 at 09:36:55AM -0800, Jesse Barnes wrote:
> > > BTW, Jesse, did you look at part II of Documentation/DMA-ABI.txt?
> > 
> > I remember seeing discussion of the new API, but haven't read that doc
> > yet.  Since most drivers still use the pci_* API, we'd have to add a
> > call there, but we may as well make the two APIs as similar as possible
> > right?
> 
> That would be my preference too.
> 
> I haven't studied "part II" closely enough to figure out if adding
> pci_sync_consistent() would outright replace much of the DMA-API
> interface. The main issue is cacheline ownership.
> 
> pci_sync_consistent() needs to indicate CPU wants ownership of outstanding
> cachelines vs IO device wanting to own them.
> SN2 doesn't care about the latter case since it's "mostly coherent".
> SN2 just needs to flush in-flight DMA and it's coherent again.
> But older non-coherent platforms do care.


What if the host/bridge sets the RO bit on a PIO read?  That would
allow a PIO read response to bypass a DMA write.  Now, maybe that
doesn't make much sense with respect to PCI-X.  I think it's possible,
though.  Or can the RO bit only be set by a device?

In any case, if we can do a PIO read to one address space that flushes
DMA ahead of it or another address space that does not, then you would
need a separate version of readX, rather than an extra call to sync
after the read.

In theory, such a distinction would be useful for any platform that
uses separate paths for PIO read responses and DMA writes.  Perhaps
there is only one platform that has that feature?

jeremy
