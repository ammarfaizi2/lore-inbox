Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287863AbSA2AdK>; Mon, 28 Jan 2002 19:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287946AbSA2AdA>; Mon, 28 Jan 2002 19:33:00 -0500
Received: from [202.135.142.194] ([202.135.142.194]:29201 "EHLO
	haven.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S287863AbSA2Acp>; Mon, 28 Jan 2002 19:32:45 -0500
Date: Tue, 29 Jan 2002 11:33:19 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: maneesh@in.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Paul.McKenney@us.ibm.com,
        viro@math.psu.edu, anton@samba.org, andrea@suse.de, tytso@mit.edu,
        riel@conectiva.com.br
Subject: Re: [RFC] Peeling off dcache_lock
Message-Id: <20020129113319.6b3a33af.rusty@rustcorp.com.au>
In-Reply-To: <20020125150000.B1782@in.ibm.com>
In-Reply-To: <20020121174039.D8289@in.ibm.com>
	<20020125150000.B1782@in.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002 15:00:00 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> Since there has been speculation about the throughput #s for lower end,
> I have put up the comparison graph in the same page 
> (http://lse.sf.net/locking/dcache/dcache_lock.html).

Have you thought about getting rid of the lru list altogether, and
traverse one chain at a time in prune_dcache, using the referenced bit as
a straight clock algorithm:

	spin_lock(&dentry->d_lock);
	if (atomic_read(dentry->dcount) == 0) {
		if (dentry->d_vfs_flags & DCACHE_REFERENCED)
			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
		else
			prune_one_dentry(dentry);
	}
	spin_unlock(&dentry->d_lock);

This can be optimized by doing a dcount check outside the loop, and the
global dcache lock can be dropped between each hash chain, and we can
store the last traversed hash chain in a static var, protected by the
global lock.

I'm just not sure how much the "semi" LRU wins us...
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
