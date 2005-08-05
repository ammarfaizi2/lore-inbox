Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263065AbVHEQnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263065AbVHEQnA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263021AbVHEQm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 12:42:58 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:26850 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S263085AbVHEQmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 12:42:24 -0400
Subject: Re: [RFC] Demand faulting for large pages
From: Adam Litke <agl@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, christoph@lameter.com, dwg@au1.ibm.com
In-Reply-To: <20050805155307.GV8266@wotan.suse.de>
References: <1123255298.3121.46.camel@localhost.localdomain>
	 <20050805155307.GV8266@wotan.suse.de>
Content-Type: text/plain
Organization: IBM
Message-Id: <1123259847.3121.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 05 Aug 2005 11:37:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 10:53, Andi Kleen wrote:
> On Fri, Aug 05, 2005 at 10:21:38AM -0500, Adam Litke wrote:
> > Below is a patch to implement demand faulting for huge pages.  The main
> > motivation for changing from prefaulting to demand faulting is so that
> > huge page allocations can follow the NUMA API.  Currently, huge pages
> > are allocated round-robin from all NUMA nodes.   
> 
> I think matching DEFAULT is better than having a different default for
> huge pages than for small pages.

I am not exactly sure what the above means.  Is 'DEFAULT' a system
default numa allocation policy?

> In general more programs are happy with local memory than remote memory.

I totally agree.

> Also it makes it consistent.
> 
> > 
> > The default behavior in SLES9 for i386 is to use demand faulting with
> > NUMA policy-aware allocations.  To my knowledge, this continues to work
> 
> Not sure what you're trying to say here. All allocations are NUMA policy aware.

Sorry, I really wasn't clear.  That statement referred to huge pages
specifically.  I was trying to point out that numa policy-aware huge
page allocation combined with demand faulting in SLES9/i386 has been a
success.

> > well in practice.  Thanks to consolidated hugetlb code, switching the
> > behavior requires changing only one fault handler.  The bulk of the
> > patch just moves the logic from hugelb_prefault() to
> > hugetlb_pte_fault().
> 
> Are you sure you fixed get_user_pages to handle this properly? It doesn't
> like it.

Unless I am missing something, the call to follow_hugetlb_page() in
get_user_pages() is just an optimization.  Removing it means
follow_page() will be called individually for each PAGE_SIZE page in the
huge page.  We can probably do better but I didn't want to cloud this
patch with that logic.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

