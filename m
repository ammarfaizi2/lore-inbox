Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbVHRICr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVHRICr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 04:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVHRICr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 04:02:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:12497 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932130AbVHRICq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 04:02:46 -0400
Subject: Re: [PATCH]  Add pci_walk_bus function to PCI core (nonrecursive)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
       linux-kernel@vger.kernel.org, linas@austin.ibm.com,
       Patrick Mochel <mochel@digitalimplant.org>
In-Reply-To: <20050818051301.GB29301@kroah.com>
References: <17156.3965.483826.692623@cargo.ozlabs.ibm.com>
	 <1124341108.8849.75.camel@gaston>  <20050818051301.GB29301@kroah.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 18:02:33 +1000
Message-Id: <1124352154.5182.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 22:13 -0700, Greg KH wrote:
> On Thu, Aug 18, 2005 at 02:58:28PM +1000, Benjamin Herrenschmidt wrote:
> > I wonder if it's finally time to implement proper race free list
> > iterators in the kernel. Not that difficult... A small struct iterator
> > with a list head and the current elem pointer, and the "interated" list
> > containing the list itself, a list of iterators and a lock. Iterators
> > can then be "fixed" up on element removal with a fine grained lock on
> > list structure access.
> 
> Pat tried to do that with klist, but people seem to think it's still
> racy in some corner cases.  Have you looked at them?

Not specifically... I used that type of construct in a distant past and
I'm pretty sure my stuff back them was quite solid but it's all old
memories. You have to be careful about a few things, like properly
getting() the current pointed object under the lock, and that sort of
thing, but it's not that complicated. I don't know of any other mecanism
to iterate lists in a safe way without taking global locks, which we
want to avoid as that would open us to all sorts of deadlocks...

The case of trees like PCI is fine provided parents aren't removed
before all childs are removed, and thus all iterators properly
invalidated.

Now, maybe I missed something ... but in any case, it seems a lot of our
current iterating constucts are racy.

Ben.


