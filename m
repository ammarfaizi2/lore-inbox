Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVA2Q4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVA2Q4U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 11:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbVA2Q4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 11:56:20 -0500
Received: from alg138.algor.co.uk ([62.254.210.138]:47839 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262939AbVA2Q4M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 11:56:12 -0500
Date: Sat, 29 Jan 2005 16:52:02 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       Philippe Robin <Philippe.Robin@arm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Re: flush_cache_page()
Message-ID: <20050129165202.GA15046@linux-mips.org>
References: <20050111223652.D30946@flint.arm.linux.org.uk> <Pine.LNX.4.58.0501111605570.2373@ppc970.osdl.org> <20050129113707.B2233@flint.arm.linux.org.uk> <1107008962.4535.8.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107008962.4535.8.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2005 at 08:29:22AM -0600, James Bottomley wrote:

> On Sat, 2005-01-29 at 11:37 +0000, Russell King wrote:
> > Thanks for the response.  However, apart from Ralph, Paul and yourself,

Who are you talking about ;-)

> > it seems none of the other architecture maintainers care about this
> > patch - the original mail was BCC'd to the architecture list.  Maybe
> > that's an implicit acceptance of this patch, I don't know.
> 
> Well, OK, I'll try to answer for parisc, since we have huge VIPT
> aliasing caches as well.
> 
> Right now, we have a scheme in flush_cache_page to make sure it's only
> called when necessary (cache flushes are expensive for us and show up as
> the primary cpu consumer in all of our profiles).  Our scheme is to see
> if a translation exists for the page and skip the flush if it doesn't.
> 
> Obviously, like MIPS, we're also walking the page tables without
> locking...

VIPT caches on MIPS R4000-class processors will perform an address
translation using the TLB to obtain the physical address that will be
compared against the cache tags.  This may result in TLB reloads which are
an ugly case to deal with if the flush is being performed for a mm other
than current->mm.  Since a long time the flush_cache_page implementation
assumes getting this right is too hard but I suppose it's an optimization
that should be attempted and which would require pagetable lookups.

The current implementation actually does lookups as an optimization (and
I'm just asking myself if that is still correct) by looking at the present
bit of the pte to deciede if data from that page may have entered the cache
at all so we can avoid the flush entirely.

> Looking at the callers of this, it seems it would be very unlikely to
> call this with a missing translation, in that case, we can use the pfn
> to flush the page through a temporary alias space instead and just take
> the odd hit if no translation exists.  

That would be the MIPS optimization for the case of flushing on behalf of
another process.

  Ralf

PS: Don't get me started on PIVT caches ...
