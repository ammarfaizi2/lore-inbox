Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290424AbSAXWix>; Thu, 24 Jan 2002 17:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290425AbSAXWiq>; Thu, 24 Jan 2002 17:38:46 -0500
Received: from CPE-203-51-24-223.nsw.bigpond.net.au ([203.51.24.223]:46853
	"EHLO front.ozlabs.ibm.com") by vger.kernel.org with ESMTP
	id <S290424AbSAXWif>; Thu, 24 Jan 2002 17:38:35 -0500
Date: Thu, 24 Jan 2002 18:02:41 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: maneesh@in.ibm.com
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        dipankar@in.ibm.com, Paul.McKenney@us.ibm.com, viro@math.psu.edu,
        anton@samba.org, andrea@suse.dec, tytso@mit.edu
Subject: Re: [RFC] Peeling off dcache_lock
Message-Id: <20020124180241.4d266b3e.rusty@rustcorp.com.au>
In-Reply-To: <20020121174039.D8289@in.ibm.com>
In-Reply-To: <20020121174039.D8289@in.ibm.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002 17:40:39 +0530
Maneesh Soni <maneesh@in.ibm.com> wrote:

> Hi All,
> 
> We have been doing experiments with dcache_lock to provide some relief from it.
> Though dcache_lock is not a very hot lock in comparision to BKL but on higher
> end machines it becomes quite contentious. We would like to have feedbacks,
> comments about the approach taken and guidance on how to improve this further.

Hi Maneesh!

	Fantastic work!  A couple of questions, and a trivial patch:

 o Would DCACHE_DEFERRED_FREE be better called DCACHE_UNLINKED?  If I
   understand correctly, it's only and always set when someone has deleted
   (unhashed) the dentry.

 o Am I correct in asserting that you could change all the
   "list_empty(dentry->dhash)" tests to
   "dentry->d_vfs_flags & DCACHE_DEFERRED_FREE" tests, and hence change the
   list_del_init() to list_del() in unhash, and thus remove the d_nexthash
   field altogether?

 o d_lookup looks like it can return an DCACHE_DEFERRED_FREE dentry: this
   seems wrong: shouldn't it loop here?

 o Were you planning on changing d_count to a non-atomic?  It seems overkill
   to have it protected by the lock, but ALSO atomic for other places.
   Could be a performance loss as well.

 o Minor nitpick: unhash() in dcache.h is plainer implemented in terms of
   __unhash().

Any chance of you making it to http://linux.conf.au next month BTW?

Thanks for the cool patch!
Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
