Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751786AbWBWUNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbWBWUNC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWBWUNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:13:01 -0500
Received: from silver.veritas.com ([143.127.12.111]:57921 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751784AbWBWUNA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:13:00 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,141,1139212800"; 
   d="scan'208"; a="34813799:sNHT25653596"
Date: Thu, 23 Feb 2006 20:13:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "'David Gibson'" <david@gibson.dropbear.id.au>
cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: IA64 non-contiguous memory space bugs
In-Reply-To: <20060222234949.GB25108@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0602231956560.12069@goblin.wat.veritas.com>
References: <200602220132.k1M1Vxg09552@unix-os.sc.intel.com>
 <200602220151.k1M1pqg09761@unix-os.sc.intel.com> <20060222022558.GE23574@localhost.localdomain>
 <Pine.LNX.4.61.0602221546040.9885@goblin.wat.veritas.com>
 <20060222234949.GB25108@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Feb 2006 20:12:59.0034 (UTC) FILETIME=[8A7D47A0:01C638B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, 'David Gibson' wrote:
> 
> Consider a HPAGE_SIZE hugepage VMA starting at 4GB, and a normal page
> VMA starting at (4GB-PAGE_SIZE).  This situation is possible on
> powerpc, and is_hugepage_only_range(4GB-PAGE_SIZE, HPAGE_SIZE) will
> (and must) return true.  Therefore the free_pgtables() logic will call
> hugetlb_free_pgd_range() across the normal page VMA.

Thanks for your patience, I eventually got it.  Although (amused to
observe my own incomprehension) I couldn't actually understand your
explanation at all, realized it myself overnight, read again what
you'd written, and then found that you had explained it very well.

Yes, I was wrong to use HPAGE_SIZE in that way in free_pgtables,
and it ought to go to the trouble of testing the real end-addr 
(if we keep using is_hugepage_only_range there at all).  Though
it's nothing urgent while your hugetlb_free_pgd_range happens to
be the same as your free_pgd_range, right?  Is that changing soon?

May I plead the extenuating circumstance, that the powerpc
is_hugepage_only_range means something quite different from the ia64?
The ia64 one means "within a hugepage-only range" but the powerpc one
means "overlaps a hugepage-only range"; I don't know which came first,
and is_hugepage_only_range isn't very descriptive of either (though
matches the ia64 case much better).

(That is, I think from the "touch" naming, and from your description,
that the powerpc one means "overlaps".  After a few minutes, I gave
up trying to decipher exactly what LOW_ESID_MASK and HTLB_AREA_MASK
end up doing, and take your superior knowledge on trust.)

While is_hugepage_only_range means different things to different
architectures, I guess it'd best be avoided in common code.  That use
in get_unmapped_area: powerpc gets it right, but ia64 gets it wrong?
But I didn't notice a change to that line (or the ia64 implementaton
thereof) in your original patch.

> I can see two ways of fixing this.  The quick, hacky fix is to use
> is_vm_hugetlb_page(), and work around the problems by having
> hugetlb_free_pgd_range() be identical to free_pgd_range() in most
> cases.

I don't see that as hacky.  I did point out that is_vm_hugetlb_page
will miss out on some coalescence, but that can't be a big deal for
what are already huge areas (the optimization was intended for many
tiny adjacent areas).

Hugh
