Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVLOWGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVLOWGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVLOWGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:06:49 -0500
Received: from fmr21.intel.com ([143.183.121.13]:15554 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751140AbVLOWGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:06:48 -0500
Date: Thu, 15 Dec 2005 14:06:40 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org
Subject: Re: [patch 2/2] /dev/mem validate mmap requests
Message-ID: <20051215220640.GA8967@agluck-lia64.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0531E4BB@scsmsx401.amr.corp.intel.com> <200512140848.56570.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512140848.56570.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 08:48:56AM -0700, Bjorn Helgaas wrote:
> > I think you may need a more complex checker that does aggregation
> > of adjacent efi memory descriptors with the same attributes.
> 
> We could, but I don't think it's worth it at this point.  We've
> been using the same simple-minded scheme for validating /dev/mem
> read & write requests for quite a while with no problems, and I
> don't want to over-engineer this.

Here's the spot in the efi memory map that worried me:

4000000 - 4a54000 type=2 attr=b
4a54000 - ff80000 type=7 attr=b

The first of these two blocks is the space that Elilo allocated
to hold the kernel, the second is the remainder of memory in
the block of same-attribute memory.  In this case the boundary
is on a 16K boundary, so all is well.  But is this guaranteed
to work?

Booting a kernel with a 64K pagesize, I see:
4000000 - 4aa0000 type=2 attr=b
4aa0000 - ff80000 type=7 attr=b

So perhaps this is ok ... maybe the size of the kernel
will always come out as a whole number of pages?

But looking further down the map (on the 64K boot) I see:

180000000 - 1fedfa000 type=7 attr=b
1fedfa000 - 1fee00000 type=2 attr=b
1fee00000 - 1fee01000 type=7 attr=b
1fee01000 - 1fef56000 type=2 attr=b
1fef56000 - 1fefae000 type=1 attr=b
1fefae000 - 1fefb8000 type=2 attr=b
1fefb8000 - 1feffe000 type=1 attr=b
1feffe000 - 1ff454000 type=7 attr=b
1ff454000 - 1ff801000 type=4 attr=b
1ff801000 - 1ff8cc000 type=7 attr=b
1ff8cc000 - 1ff904000 type=4 attr=b
1ff904000 - 1ff908000 type=7 attr=b
1ff908000 - 1ff90a000 type=4 attr=b

Now these EFI areas all have the same attributes, but the boundaries
are not neatly aligned to kernel page size.

-Tony
