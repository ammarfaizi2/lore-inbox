Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261857AbUEKFZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUEKFZw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 01:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUEKFZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 01:25:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:34212 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261857AbUEKFZq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 01:25:46 -0400
Date: Tue, 11 May 2004 10:56:58 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, dipankar@in.ibm.com,
       manfred@colorfullife.com, torvalds@osdl.org, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20040511105658.F31521@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org> <20040508204239.GB6383@in.ibm.com> <409DDDAE.3090700@colorfullife.com> <20040509153316.GE4007@in.ibm.com> <20040509221712.GA17014@parcelfarce.linux.theplanet.co.uk> <20040509152720.039f759a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040509152720.039f759a.akpm@osdl.org>; from akpm@osdl.org on Sun, May 09, 2004 at 03:27:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 03:27:20PM -0700, Andrew Morton wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> >
> > On Sun, May 09, 2004 at 09:03:16PM +0530, Dipankar Sarma wrote:
> >  
> > > Actually, what may happen is that since the dentries are added
> > > in the front, a double move like that would result in hash chain
> > > traversal looping. Timing dependent and unlikely, but d_move_count
> > > avoided that theoritical possibility. It is not about skipping
> > > dentries which is safe because a miss would result in a real_lookup()
> > 
> > Not really.  A miss could result in getting another dentry allocated
> > for the same e.g. directory, which is *NOT* harmless at all.
> 
> The d_bucket logic does look a bit odd.
> 
> 		dentry = hlist_entry(node, struct dentry, d_hash);
> 
> 		/* if lookup ends up in a different bucket 
> 		 * due to concurrent rename, fail it
> 		 */
> 		if (unlikely(dentry->d_bucket != head))
> 			break;
> 
> 		/*
> 		 * We must take a snapshot of d_move_count followed by
> 		 * read memory barrier before any search key comparison 
> 		 */
> 		move_count = dentry->d_move_count;
> 
> There is a window between the d_bucket test and sampling of d_move_count. 
> What happens if the dentry gets moved around in there?
> 
> Anyway, regardless of that, it is more efficient to test d_bucket _after_
> performing the hash comparison.  And it seems saner to perform the d_bucket
> check when things are pinned down by d_lock.
> 

This should be fine. Earlier d_bucket check was done before "continue" as the 
lookup used to loop infinetly. The reason for infinite looping was that lookup 
going to a different hash bucket due to concurrent d_move and not finding
the list head from where it started.

After introduction of hlist, there is less chance of lookup looping
infinitely even if it is moved to a different hash bucket as hlist ends with 
NULL.


But I still see theoritical possibilty of increased looping. Double rename can 
keep putting lookup back at the head of hash chain and hlist end is never seen.



-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
