Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbULJVZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbULJVZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbULJVZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:25:32 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:18325 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261200AbULJVZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:25:16 -0500
Date: Fri, 10 Dec 2004 21:24:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Lameter <clameter@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, <linux-mm@kvack.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: pfault V12 : correction to tasklist rss
In-Reply-To: <Pine.LNX.4.58.0412101150490.9169@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.44.0412102054190.32422-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Dec 2004, Christoph Lameter wrote:
> On Thu, 9 Dec 2004, Hugh Dickins wrote:
> 
> > Updating current->rss in do_anonymous_page, current->anon_rss in
> > page_add_anon_rmap, is not always correct: ptrace's access_process_vm
> > uses get_user_pages on another task.  You need check that current->mm ==
> > mm (or vma->vm_mm) before incrementing current->rss or current->anon_rss,
> > fall back to mm (or vma->vm_mm) in rare case not (taking page_table_lock
> > for that).  You'll also need to check !(current->flags & PF_BORROWED_MM),
> > to guard against use_mm.  Or... just go back to sloppy rss.
> 
> Use_mm can simply attach the kernel thread to the mm via mm_add_thread
> and will then update mm->rss when being detached again.

True.  But please add and remove mm outside of the task_lock,
there's no need to nest page_table_lock within it, is there?

> The issue with ptrace and get_user_pages is a bit thorny. I did the check
> for mm = current->mm in the following patch. If mm != current->mm then
> do the sloppy thing and increment mm->rss without the page table lock.
> This should be a very special rare case.

I don't understand why you want to avoid taking mm->page_table_lock
in that special rare case.  I do prefer the sloppy rss approach, but if
you're trying to be exact then it's regrettable to leave sloppy corners.

Oh, is it because page_add_anon_rmap is usually called with page_table_lock,
but without in your do_anonymous_page case?  You'll have to move the
anon_rss incrementation out of page_add_anon_rmap to its callsites
(I was being a little bit lazy when I sited it in that one place,
it's probably better to do it near mm->rss anyway.)

> One could also set current to the target task in get_user_pages but then
> faults for the actual current task may increment the wrong counters. Could
> we live with that?

No, "current" is not nearly so easy to play with as that.
See i386.  Even if it were, you might get burnt for heresy.

> Or simply leave as is. The pages are after all allocated by the ptrace
> process and it should be held responsible for it.

No.

> My favorite rss solution is still just getting rid of rss and
> anon_rss and do the long loops in procfs. Whichever process wants to
> know better be willing to pay the price in cpu time and the code for
> incrementing rss can be removed from the page fault handler.

We all seem to have different favourites.  Your favourite makes
quite a few people very angry.  We've been there, we've done that,
we've no wish to return.  It'd be fine if just the process which
wants to know paid the price; but it's every other that has to pay.

> We have no  real way of establishing the ownership of shared pages
> anyways. Its counted when allocated. But the page may live on afterwards
> in another process and then not be accounted for although its only user is
> the new process.

I didn't understand that bit.

> IMHO vm scans may be the only way of really getting an accurate count.
> 
> But here is the improved list_rss patch:

Not studied in depth, but... am I going mad, or is your impressive
RCUing the wrong way round?  While we're scanning the list of tasks
sharing the mm, there's no danger of the mm vanishing, but there is
a danger of the task vanishing.  Isn't it therefore the task which
needs to be freed via RCU, not the mm?

Hugh

