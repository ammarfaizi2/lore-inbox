Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUCRUZY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbUCRUZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:25:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:46753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262932AbUCRUZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:25:13 -0500
Date: Thu, 18 Mar 2004 12:25:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: anton@samba.org, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory
 machines.......
Message-Id: <20040318122524.3904db7d.akpm@osdl.org>
In-Reply-To: <37640233.1079550324@42.150.104.212.access.eclipse.net.uk>
References: <40528383.10305@sgi.com>
	<20040313034840.GF4638@wotan.suse.de>
	<20040313184547.6e127b51.akpm@osdl.org>
	<20040314040634.GC19737@krispykreme>
	<37640233.1079550324@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> --On 14 March 2004 15:06 +1100 Anton Blanchard <anton@samba.org> wrote:
> 
> > Hmm what a coincidence, I was chasing a problem where large page
> > allocations would fail even though I clearly had enough large page memory
> > free.
> >
> > It turns out we were tripping the overcommit logic in do_mmap. I had
> > 30GB of large page and 2GB of small pages and of course
> > cap_vm_enough_memory was looking at the small page pool. Setting
> > overcommit to 1 fixed it.
> >
> > It seems we can solve both problems by having a separate hugetlb
> > overcommit policy. Make it strict and you wont have OOM problems on large
> > pages and I wont hit my 30GB / 2GB problem.
> 
> Been following this thread and it seems that fixing this overcommit
> miss-handling problem would logically be the first step.  From my reading
> it seems that once we have initialised hugetlb we have two independent and
> non-overlapping 'page' pools from which we can allocate pages and against
> which we wish to handle commitments.  Looking at the current code base we
> effectivly have only a single 'accounting domain' and so when we attempt to
> allocate hugetlb pages we incorrectly account them against the small page
> pool.
> 
> I believe we need to add support for more than one page 'accounting domain'
> each with its own policy and with its own commitments.  The attached patch
> is my attempt at this first step.  I have created the concept of an
> accounting domain, against which pages are to be accounted.  In this
> implementation there are two domains VM_AD_DEFAULT which is used to account
> normal small pages in the normal way and VM_AD_HUGETLB which is used to
> select and identify VM_HUGETLB pages.  I have not attempted to add any
> actual accounting for VM_HUGETLB pages, as currently they are prefaulted
> and thus there is always 0 outstanding commitment to track.  Obviously, if
> hugetlb was also changed to support demand paging that would need to be
> implemented.

Seems reasonable, although "vm_enough_acctdom" makes my eyes pop.  Why not
keep the "vm_enough_memory" identifier?

I've asked Stephen for comment - assuming he's OK with it I'd ask you to
finish this off please.

