Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTDJNjQ (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 09:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264044AbTDJNjQ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 09:39:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:45451 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264043AbTDJNjO (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 09:39:14 -0400
Date: Thu, 10 Apr 2003 14:52:49 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>, Dave McCracken <dmccr@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix obj vma sorting
In-Reply-To: <Pine.LNX.4.44.0304092007040.2595-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0304101433420.1705-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Apr 2003, Hugh Dickins wrote:
> On Wed, 9 Apr 2003, Martin J. Bligh wrote:
> > 
> > Here's the diffprofile for just your patch ... where it's positive,
> > that's the increase in the number of ticks by applying your patch.
> > Where it's negative, that's the decrease. The %age is the change from
> > the first to the second profile:
> > 
> > larry:/var/bench/results# diffprofile 2.5.67-mjb0.2{-nosort,}/sdetbench/64/profile
> >       7148    24.9% total
> >       6482    37.7% default_idle
> >       1466   842.5% __down
> >        442   566.7% __wake_up
> >        435   378.3% schedule
> >        251     0.0% move_vma_start
> >        149   876.5% __vma_link
> >         72    40.2% remove_shared_vm_struct
> >         46    35.1% copy_mm
> >         20    60.6% vma_link
> > 
> > Note the massive increase in down() (and some of the vma ops).
> 
> Thanks for all the info, I'm sorry, I must rush away now.
> I'll try another think later, but hope someone can do better.

I've not reproduced this in testing myself (I don't have SDET);
but the conclusion I've come to is that the length of your vma lists
(for one or probably more files) was such that they were already
dangerously extending the hold of i_shared_sem with Dave's linear-
search-to-sort patch, and my additional downs in move_vma_start
then just pushed it over the edge into a thrash of collisions.

Clearly I was wrong to suppose that move_vma_start would scarcely be
called: even in my testing it showed up ~50% higher than __vma_link,
the other user of __vma_link_file.  But we cannot avoid i_shared_sem
there (can probably avoid page_table_lock and I did try doing without
that, just in case my up before spin_unlock had some hideous effect,
but apparently not).

I believe you've done the right thing in 2.5.67-mjb1: chucked out
both my patch and the vma list sorting: it's just too expensive on
the fast path, and you've shown that vividly.

Hugh

