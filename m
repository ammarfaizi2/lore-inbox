Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262970AbVHERFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262970AbVHERFA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 13:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVHERE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 13:04:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:16856 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262979AbVHEREx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 13:04:53 -0400
Subject: Re: [RFC] Demand faulting for large pages
From: Adam Litke <agl@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, christoph@lameter.com, dwg@au1.ibm.com
In-Reply-To: <20050805164702.GY8266@wotan.suse.de>
References: <1123255298.3121.46.camel@localhost.localdomain>
	 <20050805155307.GV8266@wotan.suse.de>
	 <1123259847.3121.91.camel@localhost.localdomain>
	 <20050805164702.GY8266@wotan.suse.de>
Content-Type: text/plain
Organization: IBM
Message-Id: <1123261200.3121.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 05 Aug 2005 12:00:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 11:47, Andi Kleen wrote:
> On Fri, Aug 05, 2005 at 11:37:27AM -0500, Adam Litke wrote:
> > On Fri, 2005-08-05 at 10:53, Andi Kleen wrote:
> > > On Fri, Aug 05, 2005 at 10:21:38AM -0500, Adam Litke wrote:
> > > > Below is a patch to implement demand faulting for huge pages.  The main
> > > > motivation for changing from prefaulting to demand faulting is so that
> > > > huge page allocations can follow the NUMA API.  Currently, huge pages
> > > > are allocated round-robin from all NUMA nodes.   
> > > 
> > > I think matching DEFAULT is better than having a different default for
> > > huge pages than for small pages.
> > 
> > I am not exactly sure what the above means.  Is 'DEFAULT' a system
> > default numa allocation policy?
> 
> It's one of the four numa policies: DEFAULT, PREFERED, INTERLEAVE, BIND
> 
> It just means allocate on the local node if possible, otherwise fall back.
> 
> You said you wanted INTERLEAVE by default, which i think is a bad idea.
> It should be only optional like in all other allocations.

I tried to say that allocations are _currently_ INTERLEAVE (aka
round-robin) but that I want it to be configurable.  So I think we are
in agreement here.

> > > > patch just moves the logic from hugelb_prefault() to
> > > > hugetlb_pte_fault().
> > > 
> > > Are you sure you fixed get_user_pages to handle this properly? It doesn't
> > > like it.
> > 
> > Unless I am missing something, the call to follow_hugetlb_page() in
> > get_user_pages() is just an optimization.  Removing it means
> > follow_page() will be called individually for each PAGE_SIZE page in the
> > huge page.  We can probably do better but I didn't want to cloud this
> > patch with that logic.
> 
> The problem is that get_user_pages needs to handle the case of a large
> page not yet being faulted in properly. The SLES9 implementation did
> some changes for this.
> 
> You don't change it at all, so I'm suspect it doesn't work yet.

What about:
--- reference/mm/memory.c
+++ current/mm/memory.c
@@ -933,11 +933,6 @@ int get_user_pages(struct task_struct *t
 				|| !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
-		if (is_vm_hugetlb_page(vma)) {
-			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
-			continue;
-		}
 		spin_lock(&mm->page_table_lock);
 		do {
 			struct page *page;

> It's a common case - think people doing raw IO on huge pages shared memory.

My Direct IO test seemed to work fine, but I'll give this a closer look
to make sure follow_huge_{addr|pmd} never return a page for an unfaulted
hugetlb page.  Thanks for your close scrutiny and comments. 

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

