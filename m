Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbVJMQEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbVJMQEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 12:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbVJMQEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 12:04:12 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:18410 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751594AbVJMQEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 12:04:11 -0400
Date: Thu, 13 Oct 2005 11:03:39 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 15/22] ppc64: PCI Error Recovery: PPC64 core recovery routines
Message-ID: <20051013160339.GT29826@austin.ibm.com>
References: <20051006232032.GA29826@austin.ibm.com> <20051006234742.GP29826@austin.ibm.com> <17228.56384.469138.175618@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17228.56384.469138.175618@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2005 at 07:49:52PM +1000, Paul Mackerras was heard to remark:
> Linas writes:
> 
> > +	/* We might not have a pci device, if it was a config space read
> > +	 * that failed.  Find the pci device now.  */
> > +	if (!dev) {
> > +		while ((dev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
> > +			if (pci_device_to_OF_node(dev) == event->dn)
> > +				break;
> > +		}
> > +	}
> 
> Couldn't we just use PCI_DN(event->dn)->pcidev here?  Is there some
> reason why this would not work in some circumstances?  It would be
> nice to avoid this linear search.

Funny tha you mention this, I just chopped this out yesterday; its cruft
left over from back-when.

The reason I chopped this out is due to a bug regarding the handling 
of multi-function devices with the "new style" firmware interfaces.

With the new interfaces (i.e. those using ibm,get-config-addr-info),
every function on a pci card is labelled as a "partitionable endpoint".
By contrast, the current code assumes a "PE" is associated with a pci
card. As a result of this mismatch, the handling of multi-function
cards on systems with the new-style firmware is flubbed. (In particular,
the setup and use of config-space is muffed, resulting in crashes due
to access of i/o space that wasn't correctly set up). 

I'm trying several different approaches to fixing this.

1) consolidating multiple pci functions (multiple PE's) into a single 
   "pci card" and treating the thing as a unit.

2) Treating each PE as completely distinct, and handling each distinctly.

Each approach seems to have problems. Cross my fingers, hope to have 
something working later today; however, I'm irritated that I even need 
to solve his problem.

--linas
