Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbUDOGrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 02:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUDOGrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 02:47:15 -0400
Received: from ozlabs.org ([203.10.76.45]:15063 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263852AbUDOGqr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 02:46:47 -0400
Date: Thu, 15 Apr 2004 16:42:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       lse-tech@lists.sourceforge.net, raybry@sgi.com,
       "'Andy Whitcroft'" <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [0/3]
Message-ID: <20040415064259.GD25560@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
	lse-tech@lists.sourceforge.net, raybry@sgi.com,
	'Andy Whitcroft' <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
References: <200404132317.i3DNH4F21162@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404132317.i3DNH4F21162@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 04:17:04PM -0700, Chen, Kenneth W wrote:
> In addition to the hugetlb commit handling that we've been working on
> off the list, Ray Bryant of SGI and I are also working on demand paging
> for hugetlb page.  Here are our final version that has been heavily
> tested on ia64 and x86.  I've broken the patch into 3 pieces so it's
> easier to read/review, etc.
> 
> 1. hugetlb_fix_pte.patch - with demand paging, we can not unconditionally
>    assume valid pmd/pte.  Fix it up in arch specific huge_pge_offset()
>    and have all caller check the return value.
> 
> 2. hugetlb_demand_generic.patch - this handles bulk of hugetlb demand
>    paging for generic portion of the kernel.  I've put hugetlb fault
>    handler in mm/hugetlbpage.c since the fault handler is *exactly* the
>    same for all arch, but that requires opening up huge_pte_alloc() and
>    set_huge_pte() functions in each arch.  If people object where it
>    should live.  It takes me less than a minute to delete the common
>    code and replicate it in each of the 5 arch that supports hugetlb.
>    Just let me know if that's the case.
> 
> 3. hugetlb_demand_arch.patch - this adds additional arch specific fixes
>    for x84 and ia64 when generic demand paging is turned on.  Also bulk
>    of the patch is to clean up with functions that no longer needed.
> 
> Some caveats:  I don't have sh and sparc64 hardware to test.  But hugetlb
> code in these two arch looked like a triplet twin of x86 code.  So I'm
> pretty sure it will work right out of box.  I've monkeyed around with
> ppc64 code and after a while I realized it should be left for the experts.
> I'm sure there are plenty ppc64 developers out there that can get it done
> in no time.

To the extent that I understand your patches, it shouldn't be that
hard to adapt for ppc64, with one caveat: on ppc64, unlike the other
hugepage archs, the format of hugepage PTEs is not identical to the
format of normal PTEs.  So to do this for ppc64, the generic parts of
your code will need to use a hugepte_t instead of pte_t - it can be
typedeffed to pte_t on archs other than ppc64.  Likewise there will
need to be hugepte_none() and so forth macros.

However, there seem to be some changes in your patches that aren't
directly related to doing demand-paging (though they might be a good
thing for other reasons).  Further comments in reply to the actual
patches.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
