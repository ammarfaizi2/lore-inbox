Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266232AbUBDFJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 00:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266239AbUBDFJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 00:09:21 -0500
Received: from web9704.mail.yahoo.com ([216.136.129.140]:9615 "HELO
	web9704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266232AbUBDFJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 00:09:16 -0500
Message-ID: <20040204050915.59866.qmail@web9704.mail.yahoo.com>
Date: Tue, 3 Feb 2004 21:09:15 -0800 (PST)
From: Alok Mooley <rangdi@yahoo.com>
Subject: Re: Active Memory Defragmentation: Our implementation & problems
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <1075843615.28252.17.camel@nighthawk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dave Hansen <haveblue@us.ibm.com> wrote:

> 
> On Mon, 2004-02-02 at 20:46, Alok Mooley wrote:
> > 	/*
> > 	 * See that page is not file backed & flags are
> as desired.
> > 	 * PG_lru , PG_direct (currently) must be set
> > 	 */
> > 	if(!page->mapping && (flags==0x10020 ||
> flags==0x10024 || 
> > flags==0x10060 || 
> > flags==0x10064) && page_count(page))
> > 		return 1;
> > 	/*Page is not movable*/
> > 	return 0;
> 
> Why are these flags hard-coded?  

Will use the macros. Thanks.

> 
> > static void update_to_ptes(struct page *to)
> > ...
> >         pgprot.pgprot = (pte->pte_low) &
> (PAGE_SIZE-1);
> 
> You probably want to wrap this up in a macro for
> each arch.  I couldn't
> find an analagous one that exists.  
> 
> > static void free_allocated_page(struct page *page)
> 
> Is this really necessary?  Why don't the regular
> buddy allocator
> functions work?
> 
 The regular buddy freeing function also increases the
number of free pages. Since we are not actually
freeing pages (we are just moving them), we do not
want the original freeing function. But then we could 
decrease the number of free pages by the same number &
use the buddy freeing function. Will do. Thanks.

> > /*
> > * Flush the cache and tlb entries corresponding to
> the pte for the
> > * 'from' page
> > * Flush the tlb entries corresponding to the given
> page and not the 
> > whole
> > * tlb.
> > */
> > static void flush_from_caches(pte_addr_t paddr)
> > {
> 
> How does this function compare to
> try_to_unmap_one()?  Can you use that
> instead?  It looked like you cut and pasted some
> code from there.

 Yes we have cut & pasted some code from there. But,
try_to_unmap_one also does lots of other stuff like
           /*
            * Store the swap location in the pte.
            * See handle_pte_fault() ...
            */
which we don't want. Hence we use a separate function.

> 
> I'll stop there for now.  There seems to be a lot of
> code in the file
> that's one-off from current kernel code.  I think a
> close examination of
> currently available kernel functions could drasticly
> reduce the size of
> your module.  
Will try to reduce the code. Thanks.


Could you also please comment & advise us on our
problems which are as below: -

We want to broaden our definition of a movable
page, & consider kernel
pages & file-backed pages also for movement (currently
we consider only userspace anonymous pages as
movable). Do
file-backed pages also obey the
3GB rule? In order to move such pages, we will have to
patch macros like "virt_to_phys"
& other related macros, so that the address
translation for pages moved by us will take place
vmalloc style, i.e., via page tables, instead of
direct +-3GB. Is it worth introducing such
an overhead for address translation (vmalloc does
it!)? If no, then is there another
way out, or is it better to stick to our current
definition of a movable page?
Identifying pages moved by us may involve introducing
a new page-flag. A new page-flag 
for per-cpu pages would be great, since we have to
traverse the per-cpu hot & cold lists
in order to identify if a page is on the pcp lists. 

As of now, we have adopted a failure based approach,
i.e, we defragment only when 
a higher order allocation failure has taken place
(just before kswapd starts swapping). 
We now want to defragment based on thresholds kept for
each allocation order. 
Instead of a daemon kicking in on a threshold 
violation (as proposed by Mr. Daniel Phillips), we
intend to capture idle cpu cycles
by inserting a new process just above the idle
process. Now, when we are scheduled,
we are sure that the cpu is idle, & this is when we
check for threshold violation & defragment.
One problem with this would be when to reschedule
ourselves (allow our preemption)? 
We do not want the memory state to change beneath us,
so right now we are not 
allowing our preemption.
This will ofcourse hog the cpu, & we may not be able
to reschedule just by checking
the need_resched flag. Any advice or suggestions
regarding this problem? Also, will
the idle cpu approach be better or will the daemon
based approach be better?

We will be thankful for any suggestions,advice &
comments. 

Thanking you,
-Alok & project group




__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
