Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUAHRhb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 12:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265784AbUAHRha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 12:37:30 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:18166 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265783AbUAHRhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 12:37:08 -0500
Date: Thu, 8 Jan 2004 09:36:55 -0800
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-kernel@vger.kernel.org, jeremy@sgi.com,
       Matthew Wilcox <willy@debian.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       Jame.Bottomley@steeleye.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040108173655.GA11168@sgi.com>
Mail-Followup-To: Grant Grundler <grundler@parisc-linux.org>,
	linux-kernel@vger.kernel.org, jeremy@sgi.com,
	Matthew Wilcox <willy@debian.org>,
	linux-pci@atrey.karlin.mff.cuni.cz, Jame.Bottomley@steeleye.com
References: <20040107175801.GA4642@sgi.com> <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk> <20040107222142.GB14951@colo.lackof.org> <20040107230712.GB6837@sgi.com> <20040108063829.GC22317@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108063829.GC22317@colo.lackof.org>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:38:29PM -0700, Grant Grundler wrote:
> ....maybe it would be better if more folks read the PCI-X spec.
> This quote is from v1.0a PCI-X Addendum to PCI Local Bus Spec,
> "Appendix 11 - Use Of Relaxed Ordering" (bottom of page 221):
> 
> | In general, read and write transactions to or from I/O devices are
> | classified as payload or control. (PCI 2.2 Appendix E refers to payload
> | as Data and control as Flag and Status.) If the payload traffic requires
> | multiple data phases or multiple transactions, such payload traffic
> | rarely requires ordered transactions. That is, the order in which the
> | bytes of the payload arrive is inconsequential, if they all arrive before
> | the corresponding control traffic. However, control traffic generally does
> | require ordered transactions. I/O devices that follow this programming
> | model could use this distinction to set the Relaxed Ordering attribute
> | in hardware with no device driver intervention.
> 
> Read that last sentence again.
> It suggests using readb() variants are the wrong approach.

Yep, you're right.  Adding readX() would definitely be the wrong thing
to do if we want to support PCI-X RO correctly.

> I'll assert SN2 is non-coherent with RO enabled.
> "mostly coherent" is probably the right level of fuzziness.
> But linux doesn't have a "mostly coherent" DMA API. :^)

I'll buy that.

> [ James (Bottomley) - I couldn't find a definition of "non-consistent
>   memory machine" in DMA-ABI.txt. Was that intentional or could you
>   include a variant of the above definition?
>   I guess if one needed to include a definition, then the reader
>   shouldn't be using the interfaces described in Part II.
>   But this is a key distinction from DMA-mapping.txt. ]
> 
> 
> > Right, that's another option--adding a pci_sync_consistent() call.
> 
> yes - something like this would be my preference mostly because it's
> less intrusive to the drivers, less confusing for driver writers,
> and can be a complete NOP on most platforms.
> 
> BTW, Jesse, did you look at part II of Documentation/DMA-ABI.txt?

I remember seeing discussion of the new API, but haven't read that doc
yet.  Since most drivers still use the pci_* API, we'd have to add a
call there, but we may as well make the two APIs as similar as possible
right?

Jesse
