Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbSKLAbE>; Mon, 11 Nov 2002 19:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbSKLAbE>; Mon, 11 Nov 2002 19:31:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26893 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265725AbSKLAbD>; Mon, 11 Nov 2002 19:31:03 -0500
Date: Tue, 12 Nov 2002 00:37:43 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flush_cache_page while pte valid
Message-ID: <20021112003743.A968@flint.arm.linux.org.uk>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <3DD01F1E.2040705@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD01F1E.2040705@colorfullife.com>; from manfred@colorfullife.com on Mon, Nov 11, 2002 at 10:20:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 10:20:30PM +0100, Manfred Spraul wrote:
> > 	/* Nuke the page table entry. */
> >+	flush_cache_page(vma, address);
> > 	pte = ptep_get_and_clear(ptep);
> > 	flush_tlb_page(vma, address);
> >-	flush_cache_page(vma, address);
> > 
> 
> Is it correct that this are 3 arch hooks that must appear back to back?
> What about one hook with all parameters?
> 
> 	pte = ptep_get_and_clear_and_flush(ptep, vma, address);
> 
> The current implementation just asks for such errors.

Its actually a very simple rule.  The sequence must be:

- flush cache for area
- change pte entries in area
- flush tlb for area

Anything else is just buggy, and may very well be racy.  Think about the
race when you flush the tlb entry before changing the pte.

Rather than creating a new interface that's only useful for 10% of the
cases, I'd prefer to keep the rule personally.  The smaller the number
of functions each with their own particular set of behaviours doing
almost the same job, the less chance of getting the wrong function.
And, IMHO, the easier it is to audit the code.

grep -4 ptep_get_and_clear mm/*.c

vs

"Is this the right function here?"

PS, I see one place where "ptep_get_and_clear_and_flush" would be useful
out of 6 uses.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

