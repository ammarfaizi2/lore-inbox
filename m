Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVALSNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVALSNw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVALSNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:13:51 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:8651 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261252AbVALSNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:13:25 -0500
Date: Wed, 12 Jan 2005 18:12:54 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Robin Holt <holt@sgi.com>
cc: Ray Bryant <raybry@sgi.com>, Steve Longerbeam <stevel@mvista.com>,
       Andi Kleen <ak@muc.de>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
In-Reply-To: <20050112123524.GA12843@lnx-holt.americas.sgi.com>
Message-ID: <Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2005, Robin Holt wrote:
> On Tue, Jan 11, 2005 at 09:38:02AM -0600, Ray Bryant wrote:
> > Pages that are found to be swapped out would be handled as follows:
> > Add the original node id to either the swap pte or the swp_entry_t.
> > Swap in will be modified to allocate the page on the same node it
> > came from.  Then, as part of migrate_process_pages, all that would
> > be done for swapped out pages would be to change the "original node"
> > field to point at the new node.
> > 
> > However, I could probably do both steps (2) and (3) as part of the
> > migrate_process_pages() call.
> 
> I don't think we need to worry about the swap case.  Let's keep the
> changes small and build when we see problems.  The normal swap
> out/in mechanism should handle nearly all the page migration issues
> you are concerned with.

I don't think so: swapin_readahead hasn't a clue what nodes to allocate
from, swap just isn't arranged in the predictable way that the NUMA code
there currently pretends (which Andi acknowledges).

Ray's suggestion above makes sense to me, though there may be other ways.

The simplest solution, which most appeals to me, is to delete
swapin_readahead altogether - it's based on the principle "well,
if I'm going to read something from the disk, I might as well read
adjacent pages in one go, there's a ghost of a chance that some of
the others might be useful soon too, and if we're lucky, pushing
other pages out of cache to make way for these might pay off".

Which probably is a win in some workloads, but I wonder how often.
Though doing the hard work of endless research to establish the
truth doesn't appeal to me at all!

Hugh

