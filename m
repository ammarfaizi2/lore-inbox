Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbTDEBlT (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 20:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbTDEBlT (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 20:41:19 -0500
Received: from to-telus.redhat.com ([207.219.125.105]:44526 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S261715AbTDEBlS (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 20:41:18 -0500
Date: Fri, 4 Apr 2003 20:52:48 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, mingo@elte.hu, hugh@veritas.com,
       dmccr@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: objrmap and vmtruncate
Message-ID: <20030404205248.C21819@redhat.com>
References: <Pine.LNX.4.44.0304041453160.1708-100000@localhost.localdomain> <20030404105417.3a8c22cc.akpm@digeo.com> <20030404214547.GB16293@dualathlon.random> <20030404150744.7e213331.akpm@digeo.com> <20030405000352.GF16293@dualathlon.random> <20030404163154.77f19d9e.akpm@digeo.com> <20030405013143.GJ16293@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030405013143.GJ16293@dualathlon.random>; from andrea@suse.de on Sat, Apr 05, 2003 at 03:31:43AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 05, 2003 at 03:31:43AM +0200, Andrea Arcangeli wrote:
> Also consider this significant factor: the larger the shmfs the smaller
> the nonlinear 1G window will be and the higher the trashing. With 32G of
> bigpages the remap_file_pages will trash like crazy generating an order
> of mangnitude more of "window misses". I mean 32bit are just pushed at
> the limit today regardless the lack of remap_file_pages. Example, if
> you don't use largepages going past 16G of shm is going to be derimental.
> The cost of the mmap doesn't sounds like the showstopper.

You're guessing here.  At least for oracle, that behaviour is dependant on 
the locality of accesses.  Given that each user has their own process you 
can bet there is a fair amount of locality to their transactions.

> you could try to avoid the need of the sysctl by teaching the vm to
> unmap such vma, but I don't think it worth and I'm sure those apps
> prefers to have the stuff pinned anyways w/o the risk of sigbus and w/o
> the need of mlock and it looks cleaner to me to avoid any mess with the
> vm and long term nobody will care about this sysctl since 64bit will run
> so much fatster w/o any remap_file_pages and tlb flush running at all

It is still useful for things outside of the pure databases on 32 bits 
realm.  Consider a fast bochs running 32 bit apps on a 64 bit machine -- 
should it have to deal with the overhead of zillions of vmas for emulating 
page tables?

If anything, I think we should be moving in the direction of doing more 
along the lines of remap_file_pages: things like executables might as well 
keep their state in page tables since we never discard them and instead 
toss the vma out the window.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
