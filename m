Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283715AbRLEDXl>; Tue, 4 Dec 2001 22:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283712AbRLEDXa>; Tue, 4 Dec 2001 22:23:30 -0500
Received: from bitmover.com ([192.132.92.2]:40423 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S283715AbRLEDXS>;
	Tue, 4 Dec 2001 22:23:18 -0500
Date: Tue, 4 Dec 2001 19:23:17 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011204192317.N7439@work.bitmover.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
	Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
	lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com> <2457910296.1007480257@mbligh.des.sequent.com> <20011204163646.M7439@work.bitmover.com> <20011204.183601.22018455.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011204.183601.22018455.davem@redhat.com>; from davem@redhat.com on Tue, Dec 04, 2001 at 06:36:01PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:36:01PM -0800, David S. Miller wrote:
>    From: Larry McVoy <lm@bitmover.com>
>    Date: Tue, 4 Dec 2001 16:36:46 -0800
>    
>    OK, so start throwing stones at this.  Once we have a memory model that
>    works, I'll go through the process model.
> 
> What is the difference between your messages and spin locks?
> Both seem to shuffle between cpus anytime anything interesting
> happens.
> 
> In the spinlock case, I can thread out the locks in the page cache
> hash table so that the shuffling is reduced.  In the message case, I
> always have to talk to someone.

Two points: 

a) if you haven't already, go read the Solaris doors paper.  Now think about
   a cross OS instead of a cross address space doors call.  They are very
   similar.  Think about a TLB shootdown, it's sort of a doors style cross
   call already, not exactly the same, but do you see what I mean?

b) I am not claiming that you will have less threading in the page cache.
   I suspect it will be virtually identical except that in my case 90%+
   of the threading is in the ccCluster file system, not the generic code.
   I do not want to get into a "my threading is better than your threading"
   discussion.  I'll even go so far as to say that this approach will have
   more threading if that makes you happy, as long as we agree it is outside
   of the generic part of the kernel.  So unless I have CONFIG_CC_CLUSTER,
   you pay nothing or very, very little.

   Where this approach wins big is everywhere except the page cache.  Every
   single data structure in the system becomes N-way more parallel -- with
   no additional locks -- when you boot up N instances of the OS.  That's
   a powerful statement.  Sure, I freely admit that you'll add a few locks
   to deal with cross OS synchronization but all of those are configed out
   unless you are running a ccCluster.  There is absolutely zero chance that
   you can get the same level of scaling with the same number of locks using
   the traditional approach.  I'll go out on a limb and predict it is at
   least 100x as many locks.  Think about it, there are a lot of things that
   are threaded simply because of some corner case that happens to show up
   in some benchmark or workload.  In the ccCluster case, those by and large
   go away.  Less locks, less deadlocks, less memory barriers, more reliable,
   less filling, tastes great and Mikey likes it :-)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
