Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291923AbSBTP2h>; Wed, 20 Feb 2002 10:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291924AbSBTP21>; Wed, 20 Feb 2002 10:28:27 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:6504 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S291923AbSBTP2T>; Wed, 20 Feb 2002 10:28:19 -0500
Date: Wed, 20 Feb 2002 15:30:08 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, mingo@redhat.com,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com
Subject: Re: [RFC] Page table sharing
In-Reply-To: <E16dXZm-0001Lv-00@starship.berlin>
Message-ID: <Pine.LNX.4.21.0202201439100.1136-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2002, Daniel Phillips wrote:
> On February 19, 2002 07:11 pm, Hugh Dickins wrote:
> > 
> > It's a little worse than this, I think.  Propagating pte_dirty(pte) to
> > set_page_dirty(page) cannot be done until after the flush_tlb_cpus,
> 
> You mean, because somebody might re-dirty an already cleaned page?  Or are
> you driving at something more subtle?

You are right to press me on this.  Now I reflect upon it, I think I
was scare-mongering, and I'm sure you don't need that!  I apologize.

If the i386 pte was already marked dirty, there's no issue at all.
If the i386 pte was not already marked dirty, but another processor
has that entry in its TLB (not marked dirty), and goes to dirty it
at the wrong moment, either it does so successfully just before the
ptep_get_and_clear (and we see the dirty bit), or it tries to do so
just after the (atomic part of) the ptep_get_and_clear, finds pte
not present and faults (page not yet dirtied).  No problem.

This (one cpu invalidating pte while another is halfway through ucode
updating dirty or referenced bit) is errata territory on Pentium Pro.
But if we were going to worry about that, we should have done so
before, you're not introducing any new problem in that respect.

I'm unfamiliar with the other architectures, but I have no reason
to suppose they behave critically differently here.  Ben will have
checked this all out when he brought in tlb_remove_page(): and though
his propagation of dirty from pte to page occurs after the flush TLB,
it's irrelevant: that pte comes from ptep_get_and_clear before.

Sorry again,
Hugh

