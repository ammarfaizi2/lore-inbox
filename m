Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbVJNFMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbVJNFMT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Oct 2005 01:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVJNFMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Oct 2005 01:12:19 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15341 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751050AbVJNFMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Oct 2005 01:12:19 -0400
Subject: Re: [Lhms-devel] Re: [PATCH 5/8] Fragmentation Avoidance V17:
	005_fallback
From: Dave Hansen <haveblue@us.ibm.com>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Mel Gorman <mel@csn.ul.ie>, Mike Kravetz <kravetz@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <434D47FF.1000602@austin.ibm.com>
References: <20051011151221.16178.67130.sendpatchset@skynet.csn.ul.ie>
	 <20051011151246.16178.40148.sendpatchset@skynet.csn.ul.ie>
	 <20051012164353.GA9425@w-mikek2.ibm.com>
	 <Pine.LNX.4.58.0510121806550.9602@skynet> <434D47FF.1000602@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 22:12:00 -0700
Message-Id: <1129266720.22903.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-12 at 12:29 -0500, Joel Schopp wrote:
> > In reality, no and it would only happen if a caller had specified both
> > __GFP_USER and __GFP_KERNRCLM in the call to alloc_pages() or friends. It
> > makes *no* sense for someone to do this, but if they did, an oops would be
> > thrown during an interrupt. The alternative is to get rid of this last
> > element and put a BUG_ON() check before the spinlock is taken.
> > 
> > This way, a stupid caller will damage the fragmentation strategy (which is
> > bad). The alternative, the kernel will call BUG() (which is bad). The
> > question is, which is worse?
> > 
> 
> If in the future we hypothetically have code that damages the fragmentation 
> strategy we want to find it sooner rather than never.  I'd rather some kernels 
> BUG() than we have bugs which go unnoticed.

It isn't a bug.  It's a normal
let-the-stupid-user-shoot-themselves-in-the-foot situation.  Let's
explicitly document the fact that you can't pass both flags, then maybe
add a WARN_ON() or another printk.  Or, we just fail the allocation.  

Failing the allocation seems like the simplest and most effective
solution.  A developer will run into it when they're developing, it
won't be killing off processes or locking things up like a BUG(), and it
doesn't ruin any of the fragmentation strategy.  It also fits with the
current behavior if someone asks the allocator do do something silly
like give them memory from a non-present zone.

-- Dave

