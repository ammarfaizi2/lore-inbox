Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbUDAXLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 18:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUDAXLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 18:11:36 -0500
Received: from fmr03.intel.com ([143.183.121.5]:50053 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263308AbUDAXLX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 18:11:23 -0500
Message-Id: <200404012309.i31N9MF14696@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, "Ray Bryant" <raybry@sgi.com>,
       "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Cc: <anton@samba.org>, <sds@epoch.ncsc.mil>, <ak@suse.de>,
       <lse-tech@lists.sourceforge.net>, <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Date: Thu, 1 Apr 2004 15:09:22 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQYLqqKMNWgG5hLRRKRyk3MvsB2WAADF5+Q
In-Reply-To: <184253487.1080857742@[192.168.0.89]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andy Whitcroft wrote on Thu, April 01, 2004 1:16 PM
> --On 31 March 2004 00:51 -0800 "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:
>
> > Under common case, worked perfectly!  But there are always corner cases.
> >
> > I can think of two ugliness:
> > 1. very sparse hugetlb file.  I can mmap one hugetlb page, at offset
> >    512 GB.  This would account 512GB + 1 hugetlb page as committed_AS.
> >    But I only asked for one page mapping.  One can say it's a feature,
> >    but I think it's a bug.
> >
> > 2. There is no error checking (to undo the committed_AS accounting) after
> >    hugetlb_prefault(). hugetlb_prefault doesn't always succeed in allocat-
> >    ing all the pages user asked for due to disk quota limit.  It can have
> >    partial allocation which would put the committed_AS in a wedged state.
>
> O.k. Here is the latest version of the hugetlb commitment tracking patch
> (hugetlb_tracking_R4).  This now understands the difference between shm
> allocated and mmap allocated and handles them differently.  This should
> fix 1.
>
> diff -X /home/apw/lib/vdiff.excl -rupN reference/arch/i386/mm/hugetlbpage.c current/arch/i386/mm/hugetlbpage.c
> --- reference/arch/i386/mm/hugetlbpage.c	2004-04-01 13:37:14.000000000 +0100
> +++ current/arch/i386/mm/hugetlbpage.c	2004-04-01 21:54:54.000000000 +0100
> @@ -355,30 +357,38 @@ int hugetlb_prefault(struct address_spac
>  			+ (vma->vm_pgoff >> (HPAGE_SHIFT - PAGE_SHIFT));
>  		page = find_get_page(mapping, idx);
>  		if (!page) {
> -			/* charge the fs quota first */
> +			/* charge against commitment */
> +			ret = hugetlb_charge_page(vma);
> +			if (ret)
> +				goto out;
> +			/* charge the fs quota */
>  			if (hugetlb_get_quota(mapping)) {
>  				ret = -ENOMEM;
> -				goto out;
> +				goto undo_charge;
>  			}
>  			page = alloc_hugetlb_page();


committed_AS accounting is done at fault time?  Doesn't that defeat the purpose
of overcommit checking at mmap time for on-demand paging?

I thought someone mentioned it since day one of this discussion: strict over-
commit is near impossible with current infrastructure in the multi-thread,
multi-process environment.  I can have random number of processes mmap random
number of ranges and randomly commit each page in the future.  There are just
no structure out there to keep track what will be mapped or no robust way to
find what has been mapped and how much will be needed at mmap time.

Can we just RIP this whole hugetlb page overcommit?

- Ken


