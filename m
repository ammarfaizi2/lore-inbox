Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932772AbVHTAL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932772AbVHTAL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 20:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932773AbVHTAL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 20:11:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:42211 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932772AbVHTAL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 20:11:26 -0400
Subject: Re: [PATCH]  Add pci_walk_bus function to PCI core (nonrecursive)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050819163030.GA15648@austin.ibm.com>
References: <17156.3965.483826.692623@cargo.ozlabs.ibm.com>
	 <1124341108.8849.75.camel@gaston>  <20050819163030.GA15648@austin.ibm.com>
Content-Type: text/plain
Date: Sat, 20 Aug 2005 10:10:30 +1000
Message-Id: <1124496631.5197.96.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Wow. A list of iterators to be fixed up ... I get the idea, but it does
> add a fair amount of complexity.  

Not that much, been there done that, it's actually quite simple :)

> Would it be easier (and simpler to maintain/debug) to "get" all items
> on the list first, before iterating on them, and only then iterate?

How do you protect against change of your "next" pointer ? by taking a
global lock, peeking at it, getting it, unlocking ? That would work in
that case I suppose ...

> This should work, as long as removing an item doesn't trash its "next" 
> pointer.  The "next" pointer gets whacked only when the use-count goes 
> to zero.

A fine grained lock used when adding/removing items and when "peeking"
at next might work there..

> The idea is that while traversing the list, its OK if the "next" pointer
> is pointing to a node that has removed from the list; in fact, its OK to
> traverse to that node; eventually, traversing will eventually lead back
> to a valid head.

It's just making the race less likely to happen, but it's still there.
Once the object you are peeking (or your next object, whatever) is
unhooked from the list, that means that the next point it contains is
crap. At any  time while you are playing with it, somebody may free the
"next" object, and since you are unhooked form the list, your own "next"
pointer will not be updated -> kaboom.

> I know that the above sounds crazy, but I think it could work, and be 
> a relatively low-tech but capable solution.  It does presume that elems
> have generic get/put routines.
> 
> --linas

