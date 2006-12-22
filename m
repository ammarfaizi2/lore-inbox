Return-Path: <linux-kernel-owner+w=401wt.eu-S1945905AbWLVCR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945905AbWLVCR5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 21:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945911AbWLVCR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 21:17:57 -0500
Received: from ozlabs.org ([203.10.76.45]:43470 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945905AbWLVCR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 21:17:57 -0500
Date: Fri, 22 Dec 2006 12:17:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, libhugetlbfs-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, William Lee Irwin <wli@holomorphy.com>,
       linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [powerpc] Fix bogus BUG_ON() in in hugetlb_get_unmapped_area()
Message-ID: <20061222011706.GA27396@localhost.localdomain>
Mail-Followup-To: Segher Boessenkool <segher@kernel.crashing.org>,
	Andrew Morton <akpm@osdl.org>,
	libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	William Lee Irwin <wli@holomorphy.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
References: <20061221222303.GA6418@localhost.localdomain> <E5477CAE-3FE8-4441-9225-570DD0679765@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E5477CAE-3FE8-4441-9225-570DD0679765@kernel.crashing.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 01:31:26AM +0100, Segher Boessenkool wrote:
> > +	if (len > TASK_SIZE)
> > +		return -ENOMEM;
> 
> Shouldn't that be addr+len instead?  The check looks incomplete
> otherwise.  And you meant ">=" I guess?

No.  Have a look at the other hugetlb_get_unmapped_area()
implementations.  Because this is in the get_unmapped_area() path,
'addr' is just a hint, so checking addr+len would give bogus
failures.  This test is, I believe, essentially an optimization - if
it fails, we're never going to find a suitable addr, so we might as
well give up now.

> > -		/* Paranoia, caller should have dealt with this */
> > -		BUG_ON((addr + len) > 0x100000000UL);
> > -
> 
> Any real reason to remove the paranoia check?  If it's trivially
> always satisfied, the compiler will get rid of it for you :-)

Yes - this is the very bug on which was causing crashes - the "caller
should have dealt with this" comment is wrong.  The test has been
moved into htlb_check_hinted_area() and now simply fails (and so falls
back to searching for a suitable address), rather than BUG()ing.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
