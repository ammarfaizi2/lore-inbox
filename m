Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVHRFB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVHRFB0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbVHRFB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:01:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:3024 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750825AbVHRFBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:01:25 -0400
Subject: Re: [PATCH]  Add pci_walk_bus function to PCI core (nonrecursive)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>, linux-pci@vger.kernel.org,
       linux-kernel@vger.kernel.org, linas@austin.ibm.com
In-Reply-To: <17156.3965.483826.692623@cargo.ozlabs.ibm.com>
References: <17156.3965.483826.692623@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 14:58:28 +1000
Message-Id: <1124341108.8849.75.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 14:33 +1000, Paul Mackerras wrote:
> The PCI error recovery infrastructure needs to be able to contact all
> the drivers affected by a PCI error event, which may mean traversing
> all the devices under a given PCI-PCI bridge.  This patch adds a
> function to the PCI core that traverses all the PCI devices on a PCI
> bus and under any PCI-PCI bridges on that bus (and so on), calling a
> given function for each device.  This provides a way for the error
> recovery code to iterate through all devices that are affected by an
> error event.

 .../...

Note that it's racy vs. removal of devices, but I suspect a good bunch
of the PCI code is. The whole idea that list*_safe routines pay you
anything in that regard need to be shot. Afaik, they are only safe about
the caller removing the current element.

I wonder if it's finally time to implement proper race free list
iterators in the kernel. Not that difficult... A small struct iterator
with a list head and the current elem pointer, and the "interated" list
containing the list itself, a list of iterators and a lock. Iterators
can then be "fixed" up on element removal with a fine grained lock on
list structure access.

Ben.


