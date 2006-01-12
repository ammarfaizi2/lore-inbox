Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWALTIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWALTIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161185AbWALTIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:08:35 -0500
Received: from fmr24.intel.com ([143.183.121.16]:43181 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S964790AbWALTIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:08:34 -0500
Message-Id: <200601121907.k0CJ7og16283@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Adam Litke'" <agl@us.ibm.com>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: RE: [PATCH 2/2] hugetlb: synchronize alloc with page cache insert
Date: Thu, 12 Jan 2006 11:07:50 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYXngZO7WuqSj4STUaDo+N0mNpxVAACxkaw
In-Reply-To: <1137086766.9672.40.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Litke wrote on Thursday, January 12, 2006 9:26 AM
> On Wed, 2006-01-11 at 17:05 -0800, William Lee Irwin III wrote:
> > On Wed, Jan 11, 2006 at 04:40:37PM -0800, Chen, Kenneth W wrote:
> > > What if two processes fault on the same page and races with find_lock_page(),
> > > both find page not in the page cache.  The process won the race proceed to
> > > allocate last hugetlb page.  While the other will exit with SIGBUS.
> > > In theory, both processes should be OK.
> > 
> > This is supposed to fix the incarnation of that as a preexisting
> > problem, but you're right, there is no fallback or retry for the case
> > of hugepage queue exhaustion. For some reason I saw a phantom page
> > allocator fallback in the hugepage allocator changes.
> > 
> > Looks like back to the drawing board for this pair of patches, though
> > I'd be more than happy to get a solution to this.
> 
> I still think patch 1 (delayed zeroing) is a good thing to have.  It
> will definitely improve performance for multi-threaded hugetlb
> applications by avoiding unnecessary hugetlb page zeroing.  It also
> shrinks the race window we have been talking about to a tiny fraction of
> what it was.  This should ease the problem while we figure out a way to
> handle the "last free page" case.

Sorry, I don't think patch 1 by itself is functionally correct.  It opens
a can of worms with race window all over the place.  It does more damage
than what it is trying to solve.  Here is one case:

1 thread fault on hugetlb page, allocate a non-zero page, insert into the
page cache, then proceed to zero it.  While in the middle of the zeroing,
2nd thread comes along fault on the same hugetlb page.  It find it in the
page cache, went ahead install a pte and return to the user.  User code
modify some parts of the hugetlb page while the 1st thread is still
zeroing.  A potential silent data corruption.

The scenario could be even worst that after 1st thread finish zeroing, find
a pte in the page table is already instantiated and then it proceed to back
out that newly allocated hugetlb page.

What is needed here is the code that does find-alloc-insert should be one
atomic step under corner cases.  I was thinking using a semaphore to
protect the code sequence. But I haven't come up with a reasonable
solution yet.

- Ken



