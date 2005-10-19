Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVJSUTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVJSUTw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVJSUTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:19:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751285AbVJSUTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:19:51 -0400
Date: Wed, 19 Oct 2005 13:19:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: rohit.seth@intel.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       agl@us.ibm.com
Subject: Re: [PATCH]: Handling spurious page fault for hugetlb region for
 2.6.14-rc4-git5
Message-Id: <20051019131907.05ea7160.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0510192049030.10794@goblin.wat.veritas.com>
References: <20051018141512.A26194@unix-os.sc.intel.com>
	<20051018143438.66d360c4.akpm@osdl.org>
	<1129673824.19875.36.camel@akash.sc.intel.com>
	<20051018172549.7f9f31da.akpm@osdl.org>
	<1129692330.24309.44.camel@akash.sc.intel.com>
	<20051018210721.4c80a292.akpm@osdl.org>
	<Pine.LNX.4.61.0510191623220.7586@goblin.wat.veritas.com>
	<1129748733.339.90.camel@akash.sc.intel.com>
	<Pine.LNX.4.61.0510192049030.10794@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
>  On Wed, 19 Oct 2005, Rohit Seth wrote:
>  > On Wed, 2005-10-19 at 16:48 +0100, Hugh Dickins wrote:
>  > > 
>  > > What happens when the hugetlb file is truncated down and back up after
>  > > the mmap?  Truncating down will remove a page from the mmap and flush TLB.
>  > > Truncating up will let accesses to the gone page pass the valid...off test.
>  > > But we've no support for hugetlb faulting in this version: so won't it get
>  > > get stuck in a tight loop?
>  > 
>  > First of all, there is currently no support of extending the hugetlb
>  > file size using truncate in 2.6.14. (I agree that part is broken).  So
>  > the above scenario can not happen.
> 
>  I was forgetting that extending ftruncate wasn't supported in 2.6.14 and
>  earlier, yes.  But I'm afraid the above scenario can still happen there:
>  extending is done, not by ftruncate, but by (somewhere else) mmapping the
>  larger size.   So your fix may still cause a tight infinite fault loop.

Will it?  Whenever we mmap a hugetlbfs file we prepopulate the entire vma
with hugepages.  So I don't think there's ever any part of an address space
which ia a) inside a hugepage vma and b) doesn't have a hugepage backing
it.
