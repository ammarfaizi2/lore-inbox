Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVKGVMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVKGVMJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 16:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVKGVMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 16:12:08 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:62699 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965031AbVKGVMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 16:12:06 -0500
Subject: RE: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
From: Adam Litke <agl@us.ibm.com>
To: Rohit Seth <rohit.seth@intel.com>
Cc: Andy Nelson <andy@thermo.lanl.gov>, ak@suse.de, nickpiggin@yahoo.com.au,
       akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       gmaxwell@gmail.com, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       torvalds@osdl.org
In-Reply-To: <1131396662.18176.41.camel@akash.sc.intel.com>
References: <20051107003452.3A0B41855A0@thermo.lanl.gov>
	 <1131389934.25133.69.camel@localhost.localdomain>
	 <1131396662.18176.41.camel@akash.sc.intel.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 07 Nov 2005 15:11:07 -0600
Message-Id: <1131397867.25133.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 12:51 -0800, Rohit Seth wrote:
> On Mon, 2005-11-07 at 12:58 -0600, Adam Litke wrote:
> 
> > I am currently working on an new approach to what you tried.  It
> > requires fewer changes to the kernel and implements the special large
> > page usage entirely in an LD_PRELOAD library.  And on newer kernels,
> > programs linked with the .x ldscript you mention above can run using all
> > small pages if not enough large pages are available.
> > 
> 
> Isn't it true that most of the times we'll need to be worrying about
> run-time allocation of memory (using malloc or such) as compared to
> static.

It really depends on the workload.  I've run HPC apps with 10+GB data
segments.  I've also worked with applications that would benefit from a
hugetlb-enabled morecore (glibc malloc/sbrk).  I'd like to see one
standard hugetlb preload library that handles every different "memory
object" we care about (static and dynamic).  That's what I'm working on
now.

> > For the curious, here's how this all works:
> > 1) Link the unmodified application source with a custom linker script which
> > does the following:
> >   - Align elf segments to large page boundaries
> >   - Assert a non-standard Elf program header flag (PF_LINUX_HTLB)
> >     to signal something (see below) to use large pages.
> 
> We'll need a similar flag for even code pages to start using hugetlb
> pages. In this case to keep the kernel changes to minimum, RTLD will
> need to modified.

Yes, I foresee the functionality currently in my preload lib to exist in
RTLD at some point way down the road.

> > 2) Boot a kernel that supports copy-on-write for PRIVATE hugetlb pages
> > 3) Use an LD_PRELOAD library which reloads the PF_LINUX_HTLB segments into
> > large pages and transfers control back to the application.
> > 
> 
> COW, swap etc. are all very nice (little!) features that make hugetlb to
> get used more transparently.

Indeed.  See my parallel post of a hugetlb-COW RFC :)

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

