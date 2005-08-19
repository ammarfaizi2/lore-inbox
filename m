Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVHSQak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVHSQak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbVHSQak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:30:40 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:39052 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965015AbVHSQaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:30:39 -0400
Date: Fri, 19 Aug 2005 11:30:30 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Add pci_walk_bus function to PCI core (nonrecursive)
Message-ID: <20050819163030.GA15648@austin.ibm.com>
References: <17156.3965.483826.692623@cargo.ozlabs.ibm.com> <1124341108.8849.75.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124341108.8849.75.camel@gaston>
User-Agent: Mutt/1.5.9i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 18, 2005 at 02:58:28PM +1000, Benjamin Herrenschmidt was heard to remark:
> On Thu, 2005-08-18 at 14:33 +1000, Paul Mackerras wrote:
> > This patch adds a
> > function to the PCI core that traverses all the PCI devices on a PCI
> > bus and under any PCI-PCI bridges on that bus (and so on), calling a
> > given function for each device.  

Paul, thanks, I'll use this in the next version, which I'm trying to
assemble now.

> Note that it's racy vs. removal of devices, 

...

> The whole idea that list*_safe routines pay you

OK, well, that makes me feel better, as I've stared at that code before, 
and wondered what magic made it work.

> I wonder if it's finally time to implement proper race free list
> iterators in the kernel. Not that difficult... A small struct iterator
> with a list head and the current elem pointer, and the "interated" list
> containing the list itself, a list of iterators and a lock. Iterators
> can then be "fixed" up on element removal with a fine grained lock on
> list structure access.

Wow. A list of iterators to be fixed up ... I get the idea, but it does
add a fair amount of complexity.  

Would it be easier (and simpler to maintain/debug) to "get" all items
on the list first, before iterating on them, and only then iterate?
This should work, as long as removing an item doesn't trash its "next" 
pointer.  The "next" pointer gets whacked only when the use-count goes 
to zero.

The idea is that while traversing the list, its OK if the "next" pointer
is pointing to a node that has removed from the list; in fact, its OK to
traverse to that node; eventually, traversing will eventually lead back
to a valid head.

I know that the above sounds crazy, but I think it could work, and be 
a relatively low-tech but capable solution.  It does presume that elems
have generic get/put routines.

--linas
