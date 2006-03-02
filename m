Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752073AbWCBXO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbWCBXO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWCBXO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:14:58 -0500
Received: from ozlabs.org ([203.10.76.45]:7316 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751729AbWCBXO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:14:57 -0500
Date: Fri, 3 Mar 2006 10:00:54 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Hugh Dickins'" <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       William Irwin <wli@holomorphy.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: hugepage: Fix hugepage logic in free_pgtables()
Message-ID: <20060302230054.GA23766@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	'Hugh Dickins' <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	William Irwin <wli@holomorphy.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0603022002500.23669@goblin.wat.veritas.com> <200603022129.k22LTog14318@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603022129.k22LTog14318@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 01:29:50PM -0800, Chen, Kenneth W wrote:
> Hugh Dickins wrote on Thursday, March 02, 2006 12:27 PM
> > But the first part, || instead of && in is_hugepage_only_range, looks
> > insufficient: the start and end of the range might each fall in a
> > non-huge region, but the range still cross a huge region.
> > 
> > Ah, does RGN_HPAGE nestle up against the TASK_SIZE roof, so any range
> > already tested against TASK_SIZE (as get_unmapped_area has) cannot
> > cross RGN_HPAGE?  If so, perhaps it deserves a comment there.  And
> > if that is so, and can be relied upon, is_hugepage_only_range need
> > only be testing REGION_NUMBER(addr+len-1) - but it does seem fragile.
> 
> There are many address range check before we hit get_unmapped area.
> ia64 can never have a vma range that crosses region boundary.  David
> pointed out earlier that shmat and mremap can still slip through the
> crack and he has a patch that fixed it. But yes, this patch is making
> that assumption (or relying on checks being done properly beforehand).

In fact with that other patch, which ensures that no region-crossing
ranges get through, simply (REGION_NUMBER(addr) == RGN_HPAGE) would be
sufficient; either both start and end are in the hugepage region, or
they're both in the same different region.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
