Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbUCSHI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 02:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUCSHI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 02:08:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:8232 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261426AbUCSHIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 02:08:24 -0500
Date: Fri, 19 Mar 2004 07:08:26 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
In-Reply-To: <20040319024251.GA31498@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Andrea Arcangeli wrote:
> On Thu, Mar 18, 2004 at 11:21:07PM +0000, Hugh Dickins wrote:
> > +	if (!spin_trylock(&mm->page_table_lock))
> > +		return 1;
> > +
> [..]
> > +	if (down_trylock(&mapping->i_shared_sem))
> > +		return 1;
> > +	
> 
> those two will hang your kernel in the workload I posted to the list a
> few days ago.

I missed the actual workload, will search the archives later.
Fear I won't reproduce it exactly, and more anxious to plug
the mremap-move and non-linear holes.

> With previous kernels the above didn't matter, but starting with
> 2.6.5-rc1 it does matter, if we cannot know if it's referenced or not,
> we must assume it's not and return 0 or it lives locks hard with all
> tasks stuck and one must click reboot.

I don't much care whether we return 1 or 0 in that case, be happy to
make the change if we understand _why_ it's suddenly become necessary.
I don't remember seeing an explanation from you (and fair enough, you
didn't want to get stuck on that detail) or anyone else.

> I recommend you to share my objrmap patch, the objrmap should be exactly
> the same for both of us.

I can't take its mm/mmap.c (and if Martin keeps that page_table_lock
avoidance in his tree, then I think he shouldn't have followed your
advice to skip Dave's mmap_sem in unuse_process).  But of course,
I could have started from exactly yours and then a patch to change
those back.  Just so long as we're aware they're not identical.

Hmm, where's page_test_and_clear_dirty gone in your final objrmap.c?

There's a lot that could be shared between the two approaches.
Nice if we kept to the same struct page layout: I put int mapcount
after atomic_t count because almost all arches have atomic_t as an
int, so won't that placing save us 4 bytes on the 64-bit arches?

Hugh

