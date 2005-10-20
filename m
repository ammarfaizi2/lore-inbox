Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbVJTB3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbVJTB3k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 21:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbVJTB3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 21:29:39 -0400
Received: from fmr24.intel.com ([143.183.121.16]:18394 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751687AbVJTB3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 21:29:39 -0400
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
	2.6.14-rc4-git5
From: Rohit Seth <rohit.seth@intel.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, agl@us.ibm.com
In-Reply-To: <1129765996.339.138.camel@akash.sc.intel.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	 <20051018143438.66d360c4.akpm@osdl.org>
	 <1129673824.19875.36.camel@akash.sc.intel.com>
	 <20051018172549.7f9f31da.akpm@osdl.org>
	 <1129692330.24309.44.camel@akash.sc.intel.com>
	 <20051018210721.4c80a292.akpm@osdl.org>
	 <Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
	 <1129748733.339.90.camel@akash.sc.intel.com>
	 <Pine.LNX.4.61.0510192049030.10794@goblin.wat.veritas.com>
	 <20051019131907.05ea7160.akpm@osdl.org>
	 <Pine.LNX.4.61.0510192126100.11096@goblin.wat.veritas.com>
	 <1129765996.339.138.camel@akash.sc.intel.com>
Content-Type: text/plain
Organization: Intel 
Date: Wed, 19 Oct 2005 18:36:47 -0700
Message-Id: <1129772207.339.152.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2005 01:29:29.0245 (UTC) FILETIME=[B71344D0:01C5D515]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 16:53 -0700, Rohit Seth wrote:
> On Wed, 2005-10-19 at 21:28 +0100, Hugh Dickins wrote:
> > On Wed, 19 Oct 2005, Andrew Morton wrote:
> > > Hugh Dickins <hugh@veritas.com> wrote:
> > > > 
> > > >  I was forgetting that extending ftruncate wasn't supported in 2.6.14 and
> > > >  earlier, yes.  But I'm afraid the above scenario can still happen there:
> > > >  extending is done, not by ftruncate, but by (somewhere else) mmapping the
> > > >  larger size.   So your fix may still cause a tight infinite fault loop.
> > > 
> > > Will it?  Whenever we mmap a hugetlbfs file we prepopulate the entire vma
> > > with hugepages.  So I don't think there's ever any part of an address space
> > > which ia a) inside a hugepage vma and b) doesn't have a hugepage backing
> > > it.
> > 
> > The new vma, sure, will be fully populated.  But the old vma, in this
> > or some other process, which was created before the hugetlbfs file was
> > truncated down, will be left with a hole at the end.
> > 
> 
> Excellent catch.  This broken truncation thing....
> 
> And I don't know what the right solution should be for this scenario at
> this point for 2.6.14....may be to actually look at the HUGEPTE
> corresponding to the hugetlb faulting address or don't allow mmaps to
> grow the hugetlb file bigger (except the first mmap).  I understand that
> both of them don't sound too good...
> 
> Any suggestions.
> 


I would like to keep this patch.  This at least takes care of bad things
happening behind application's back by OS/HW.  If the scenario that you
mentioned happens then the application is knowingly doing unsupported
things (at this point truncate is a broken operation on hugetlb).  The
application can be killed in this case.

...trying to avoid any heavy changes at this time for 2.6.14

-rohit

