Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTE2ULx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 16:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTE2ULx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 16:11:53 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:43937 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262627AbTE2ULw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 16:11:52 -0400
Date: Thu, 29 May 2003 13:24:39 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@digeo.com, hch@infradead.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Avoid vmtruncate/mmap-page-fault race
Message-ID: <20030529202439.GA1515@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Pine.LNX.4.44.0305291723310.1800-100000@localhost.localdomain> <200305291915.22235.phillips@arcor.de> <200305291939.47451.phillips@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305291939.47451.phillips@arcor.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 07:39:47PM +0200, Daniel Phillips wrote:
> On Thursday 29 May 2003 19:15, Daniel Phillips wrote:
> > On Thursday 29 May 2003 18:33, you wrote:
> > > Me?  I much preferred your original, much sparer, nopagedone patch
> > > (labelled "uglyh as hell" by hch).
> >
> > "me too".
> 
> Oh wait, I mispoke... there is another formulation of the patch that hasn't 
> yet been posted for review.  Instead of having the nopagedone hook, it turns 
> the entire do_no_page into a hook, per hch's suggestion, but leaves in the 
> ->nopage hook, which makes the patch small and obviously right.  I need to 
> post that version for comparison, please bear with me.
> 
> IMHO, it's nicer than the ->nopagedone form.

I put together something like this, but the problem with it is that
do_anonymous_page() needs the mm->page_table_lock held, but the
->nopage functions want this lock not to be held.  One could require
that all the lock be held on entry to all ->nopage functions, but
this would require almost all ->nopage functions to drop the lock
immediately upon entry.  This seemed error-prone to me, but could
certainly be done...

Thoughts?  Me, I don't care as long as there is some reasonable
way for distributed filesystems to safely resolve the race between
page faults and invalidation requests from other nodes.  ;-)

						Thanx, Paul
