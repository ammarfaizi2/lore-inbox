Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267869AbTAMGNv>; Mon, 13 Jan 2003 01:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267874AbTAMGNv>; Mon, 13 Jan 2003 01:13:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:35735 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267869AbTAMGNu>; Mon, 13 Jan 2003 01:13:50 -0500
Date: Mon, 13 Jan 2003 11:55:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, viro@math.psu.edu,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: 2.5.56-mm1
Message-ID: <20030113062503.GA14996@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200301111443.08527.akpm@digeo.com> <20030111225756.GA13330@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111225756.GA13330@gtf.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:00:38PM +0000, Jeff Garzik wrote:
> On Sat, Jan 11, 2003 at 02:43:08PM -0800, Andrew Morton wrote:
> > - dcache-RCU.
> > 
> >   This was recently updated to fix a rename race.  It's quite stable.  I'm
> >   not sure where we stand wrt merging it now.  Al seems to have disappeared.
> 
> I talked to him in person last week, and this was one of the topics of
> discussion.  He seemed to think it was fundamentally unfixable.  He
> proceed to explain why, and then explained the scheme he worked out to
> improve things.  Unfortunately my memory cannot do justice to the
> details.

The rename race is fixed now. Yes, it was unfixable using *existing* RCU
techniques, but one has to invent new tricks when the old bag of
tricks is empty :)

Fundamentally what happens is that rename may be *two* updates - delete
from one hash chain and insert into another hash chain. In order for
lockfree traversal to work correctly, you must have a grace period after
each update. If we do a grace period between these two updates in a rename,
it slows down renames to unacceptable levels. So we had a problem there.

The solution lies in the dcache itself - it has a fast path (cached_lookup)
and a slow path (real_lookup). So all we had to do was to detect that a
rename had happened to the dentry while we looked it up lockfree. This
is done by a generation counter (d_move_count) in the dentry and is
protected by the per-dentry spinlock which we take during rename and
a successful cache lookup. 

Two things can happen due to the rename race - lookup incorrectly succeeds
or lookup incorrectly fails. The success case is easily handled by 
the lockfree lookup code that looks like this -

for the dentries in the hash chain {
	... More stuff....
	move_count = dentry->d_move_count;
	if (dentry name matches) {
		/* lookup succeeds */
		spin_lock(&dentry->d_lock);
		if (move_count != dentry->d_move_count) {
			/* 
			 * A rename happened while looking up lockfree and 
			 * we now cannot gurantee
			 * that the lookup is correct
			 */
			spin_unlock(&dentry->d_lock);
			return slow_lookup();
		}
		....
		....
	}
	... More stuff....
}

If the lookup fails due to rename race, then there will anyway be a
slow real_lookup which is serialized with rename.

Maneesh did a lot of testing using many ramfs and many millions of renames
with millions of lookups going on at the same time and slow path was hit only
100 times or so. For practical workloads, this should have absolutely no
performance impact.

Thanks
Dipankar
