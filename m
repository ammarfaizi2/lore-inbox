Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbVBBAgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbVBBAgJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 19:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVBBAgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 19:36:09 -0500
Received: from smtp109.mail.sc5.yahoo.com ([66.163.170.7]:28796 "HELO
	smtp109.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261973AbVBBAf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 19:35:56 -0500
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock
	in handle_mm_fault
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au>
	 <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
	 <41E5BC60.3090309@yahoo.com.au>
	 <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
	 <20050113031807.GA97340@muc.de>
	 <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
	 <20050113180205.GA17600@muc.de>
	 <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
	 <20050114043944.GB41559@muc.de>
	 <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
	 <20050114170140.GB4634@muc.de>
	 <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com>
	 <41FF00CE.8060904@yahoo.com.au>
	 <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Wed, 02 Feb 2005 11:31:36 +1100
Message-Id: <1107304296.5131.13.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-01 at 11:01 -0800, Christoph Lameter wrote:
> On Tue, 1 Feb 2005, Nick Piggin wrote:

> > A per-pte lock is sufficient for this case, of course, which is why the
> > pte-locked system is completely free of the page table lock.
> 
> Introducing pte locking would allow us to go further with parallelizing
> this but its another invasive procedure. I think parallelizing COW is only
> possible to do reliable with some pte locking scheme. But then the
> question is if the pte locking is really faster than obtaining a spinlock.
> I suspect this may not be the case.
> 

Well most likely not although I haven't been able to detect much
difference. But in your case you would probably be happy to live
with that if it meant better parallelising of an important
function... but we'll leave future discussion to another thread ;)

> > Although I may have some fact fundamentally wrong?
> 
> The unmapping in rmap.c would change the pte. This would be discovered
> after acquiring the spinlock later in do_wp_page. Which would then lead to
> the operation being abandoned.
> 

Oh yes, but suppose your page_cache_get is happening at the same time
as free_pages_check, after the page gets freed by the scanner? I can't
actually think of anything that would cause a real problem (ie. not a
debug check), off the top of my head. But can you say there _isn't_
anything?

Regardless, it seems pretty dirty to me. But could possibly be made
workable, of course.



