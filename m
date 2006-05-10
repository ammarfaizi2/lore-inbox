Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWEJVpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWEJVpo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 17:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbWEJVpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 17:45:44 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41674 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965035AbWEJVpn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 17:45:43 -0400
Subject: Re: [RFC] Hugetlb demotion for x86
From: Adam Litke <agl@us.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060510204928.GA31315@infradead.org>
References: <1147287400.24029.81.camel@localhost.localdomain>
	 <20060510200516.GA30346@infradead.org>
	 <1147293156.24029.95.camel@localhost.localdomain>
	 <20060510204928.GA31315@infradead.org>
Content-Type: text/plain
Organization: IBM
Date: Wed, 10 May 2006 16:45:35 -0500
Message-Id: <1147297535.24029.114.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 21:49 +0100, Christoph Hellwig wrote:
> On Wed, May 10, 2006 at 03:32:36PM -0500, Adam Litke wrote:
> > By smart fallback do you mean we should convert the hugetlb fault code
> > back to using VM_FAULT_SIGBUS and writing userspace sighandlers to do
> > the same thing I am, but in userspace?  FWIW I did implement that in
> > libhugetlbfs to try it out, but that seems much dirtier to me than
> > handling faults in the kernel.
> 
> Umm, why do these faults happen at all?  When all the hugetlb code went
> in it we allocated at mmap time.  Later it was converted to demand faulting
> but under the premise that we keep the strict overcommit accounting.  When
> did that part go away aswell?  With strict overcommit handling for huge
> pages no fault should happen when the pool is exausted.

Strict overcommit is there for shared mappings.  When private mapping
support was added, people agreed that full overcommit should apply to
private mappings for the same reasons normal page overcommit is desired.
For one: an application using lots of private huge pages should not be
prohibited from forking if it's likely to just exec a small helper
program.

"These faults" are happening in two cases when MAP_PRIVATE huge pages
are being used:
1) Fault on an uninstantiated huge page: This can happen when numerous
users of huge pages in the system are competing for a finite number of
huge pages.  Even if the process checks for free huge pages before
mmaping the area, another process is free to "steal" those pages out
from under the careful process.

2) COW fault on an instantiated huge page:  Happens in child processes
who inherit a private hugetlb region and write to it.

Both of these cases are non-deterministic and should be handled in some
way.  Just killing the process doesn't seem like a permanent solution to
me.

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

