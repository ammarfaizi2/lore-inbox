Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSHJS3L>; Sat, 10 Aug 2002 14:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317189AbSHJS3L>; Sat, 10 Aug 2002 14:29:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7275 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317182AbSHJS3J>; Sat, 10 Aug 2002 14:29:09 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Daniel Phillips <phillips@arcor.de>, frankeh@watson.ibm.com,
       davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, wli@holomorpy.com,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
References: <E17dBZN-0001Ng-00@starship>
	<Pine.LNX.4.44.0208090854001.1547-100000@home.transmeta.com>
	<3D543645.8EBD2C36@zip.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Aug 2002 12:20:06 -0600
In-Reply-To: <3D543645.8EBD2C36@zip.com.au>
Message-ID: <m1ofcar2y1.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:
> 
> The other worry is the ZONE_NORMAL space consumption of pte_chains.
> We've halved that, but it will still make high sharing levels
> unfeasible on the big ia32 machines.  We are dependant upon large
> pages to solve that problem.  (Resurrection of pte_highmem is in
> progress, but it doesn't work yet).

There is a second method to address this.  Pages can be swapped out
of the page tables and still remain in the page cache, the virtual
scan does this all of the time.  This should allow for arbitrary
amounts of sharing.  There is some overhead, in faulting the pages
back in but it is much better than cases that do not work.  A simple
implementation would have a maximum pte_chain length.

For any page that is not backed by anonymous memory we do not need to
keep the pte entries after the page has been swapped of the page
table.  Which should show a reduction in page table size.  In a highly
shared setting with anonymous pages it is likely worth it to promote
those pages to being posix shared memory.

All of the above should allow us to keep a limit on the amount of
resources that go towards sharing, reducing the need for something
like pte_highmem, and keeping memory pressure down in general.

For the cases you describe I have trouble seeing pte_highmem as
anything other than a performance optimization.  Only placing shmem
direct and indirect entries in high memory or in swap can I see as
limit to feasibility.

Eric
