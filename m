Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265548AbUAGTCN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 14:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbUAGTCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 14:02:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50868 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265548AbUAGTCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 14:02:08 -0500
Date: Wed, 7 Jan 2004 19:02:06 +0000
From: Matthew Wilcox <willy@debian.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       jeremy@sgi.com
Subject: Re: [RFC] Relaxed PIO read vs. DMA write ordering
Message-ID: <20040107190206.GK17182@parcelfarce.linux.theplanet.co.uk>
References: <20040107175801.GA4642@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107175801.GA4642@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 09:58:02AM -0800, Jesse Barnes wrote:
> I've already talked with Grant a little about this, but I'm having
> second thoughts about the approach we discussed.  PCI-X allows PIO read
> responses to 'pass' DMA writes to system memory when the relaxed
> ordering bit is set in the PCI-X command word _and_ the transaction has
> the relaxed ordering bit set (so called "Relaxed Read Ordering" in
> section 11.2 of the PCI-X addendum).  This effectively 'unserializes'
> PIO vs. DMA transactions so that PIO reads doesn't get stuck behind an
> unrelated DMA writes from the same device; something which can
> potentially take awhile since cacheline ownership has to be acquired,
> etc.

So we want a pci_set_relaxed() macro / function() to set this bit
(otherwise dozens of drivers will start to try to set the bit themselves,
badly).  If this bit *isn't* set, setting the bit in the transaction will have
no effect, right?

> The proposal I gave to Grant added a new readX() variant,
> readX_relaxed(), that drivers could use when they don't need strict
> ordering semantics (this may actually be the majority of cases, but it's
> safer to be strict by default than create a read_ordered and open a
> window for data corruption).  It might be confusing, however, to add yet
> another readX() routine, and there are other ways we might go about it.
> One suggestion was to overload the pci_sync_* calls so that they'd
> explicitly flush DMA writes to system memory, implying that all reads on
> some platforms would use relaxed semantics, but that we'd have to modify
> drivers to add in pci_sync_* calls where needed.

How about always setting the bit in readb() and having a readb_ordered()
which doesn't set the bit in the transaction?  That way, drivers which
call pci_set_relaxed() have the responsibility to verify they're not
relying on these semantics and use readb_ordered() in any places that
they are.

No doubt you're going to smack this idea down by telling me what SN2
firmware currently does ...

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
