Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUEYPfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUEYPfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 11:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264928AbUEYPfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 11:35:14 -0400
Received: from janus.foobazco.org ([198.144.194.226]:13186 "EHLO
	mail.foobazco.org") by vger.kernel.org with ESMTP id S264912AbUEYPfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 11:35:07 -0400
Date: Tue, 25 May 2004 08:35:01 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, Andrea Arcangeli <andrea@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525153501.GA19465@foobazco.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 07:48:24AM -0700, Linus Torvalds wrote:

> > > the equivalent. You can always do it with a simple compare-and-exchange 
> > > loop, something any SMP-capable architecture should have.
> 
> The race is:
>  - one CPU sets the dirty bit (possibly with a hardware walker, but I 
>    guess on PA it's probably done in sw)
>  - the other CPU sets the accessed bit in sw as part of the 
>    "handle_pte_fault()" processing.
> 
> Right now we set the accessed bit with a simple "ptep_establish()", which 
> will use "set_pte()", which is just a regular write. So setting the 
> accessed bit will basically be a nonatomic sequence of
> 
>  - read pte entry
>  - entry = pte_mkyoung(entry)
>  - set_pte(entry)
> 
> which is all done under the mm->page_table_lock, but which does NOT 
> protect against any hardware page-table walkers or any asynchronous sw 
> walkers (if anybody does them).

Some sparc32 CPUs are also vulnerable to this race; in fact the
supersparc manual describes it specifically and even outlines the
compare-exchange loop using our rotten swap instruction.  In our case,
the race is with a hardware walker.

-- 
Keith M Wesolowski
