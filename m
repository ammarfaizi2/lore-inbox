Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751578AbWCCVwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWCCVwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWCCVwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:52:34 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:22250
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751526AbWCCVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:52:33 -0500
Date: Fri, 03 Mar 2006 13:52:17 -0800 (PST)
Message-Id: <20060303.135217.65983538.davem@davemloft.net>
To: hollisb@us.ibm.com
Cc: linuxppc64-dev@ozlabs.org, benh@kernel.crashing.org, torvalds@osdl.org,
       akpm@osdl.org, linux-arch@vger.kernel.org, bcrl@linux.intel.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org, mingo@redhat.com,
       jblunck@suse.de
Subject: Re: Memory barriers and spin_unlock safety
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603031518.15806.hollisb@us.ibm.com>
References: <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
	<1141419966.3888.67.camel@localhost.localdomain>
	<200603031518.15806.hollisb@us.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hollis Blanchard <hollisb@us.ibm.com>
Date: Fri, 3 Mar 2006 15:18:13 -0600

> On Friday 03 March 2006 15:06, Benjamin Herrenschmidt wrote:
> > The main problem I've had in the past with the ppc barriers is more a
> > subtle thing in the spec that unfortunately was taken to the word by
> > implementors, and is that the simple write barrier (eieio) will only
> > order within the same storage space, that is will not order between
> > cacheable and non-cacheable storage.
> 
> I've heard Sparc has the same issue... in which case it may not be a "chip 
> designer was too literal" thing, but rather it really simplifies chip 
> implementation to do it that way.

There is a "membar #MemIssue" that is meant to deal with this should
it ever matter, but for most sparc64 chips it doesn't which is why we
don't use that memory barrier type at all in the Linux kernel.

For UltraSPARC-I and II it technically could matter in Relaxed Memory
Ordering (RMO) mode which is what we run the kernel and 64-bit
userspace in, but I've never seen an issue resulting from it.

For UltraSPARC-III and later, the chip only implements the Total Store
Ordering (TSO) memory model and the manual explicitly states that
cacheable and non-cacheable memory operations are ordered, even using
language such as "there is an implicit 'membar #MemIssue' between
them".  It further goes on to say:

	The UltraSPARCIII Cu processor maintains ordering between
	cacheable and non-cacheable accesses.  The UltraSPARC III Cu
	processor maintains TSO ordering between memory references
	regardless of their cacheability.

Niagara behaves almost identically to UltraSPARC-III in this area.
