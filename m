Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262958AbTC1LAo>; Fri, 28 Mar 2003 06:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbTC1LAo>; Fri, 28 Mar 2003 06:00:44 -0500
Received: from bi-01pt1.bluebird.ibm.com ([129.42.208.186]:27295 "EHLO
	bigbang.in.ibm.com") by vger.kernel.org with ESMTP
	id <S262958AbTC1LAm>; Fri, 28 Mar 2003 06:00:42 -0500
Date: Fri, 28 Mar 2003 16:44:34 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dipankar@in.ibm.com, Paul.McKenney@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] real_lookup fix
Message-ID: <20030328111434.GB1127@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030328104043.GA1127@in.ibm.com> <20030328025131.3363ef37.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328025131.3363ef37.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 02:51:31AM -0800, Andrew Morton wrote:
> Maneesh Soni <maneesh@in.ibm.com> wrote:
> >
> > Hi Andrew,
> > 
> > Here is a patch to use seqlock for real_lookup race with d_lookup as suggested
> > by Linus. The race condition can result in duplicate dentry when d_lookup
> > fails due concurrent d_move in some unrelated directory. 
> 
> I was not aware of this race.  Could you please explain it in more detail?
> 

Sometime back, Linus has pointed a race regading d_lookup and concurrent
d_move (rename). If lookup moves to a different bucket due to d_move, it may
fail the lookup. rename in the same directory is protected by parent's i_sem
but rename in some unrelated directory on the same hash chain can have
this problem. This can result in real_lookup allocating a new dentry for an
existing one.

Now, similar problem is there with lookup_hash()->cached_lookup(), where
lookup_hash() ends up in allocating a duplicate dentry.

Linus, actually fixed the race in real_lookup using dcache_lock around the
d_lookup call. The patch I posted replaces this with seqlock and also fixes
the cached_lookup() case.

Regards,
Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
