Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSJPXX4>; Wed, 16 Oct 2002 19:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbSJPXX4>; Wed, 16 Oct 2002 19:23:56 -0400
Received: from pizda.ninka.net ([216.101.162.242]:38069 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261521AbSJPXXy>;
	Wed, 16 Oct 2002 19:23:54 -0400
Date: Wed, 16 Oct 2002 16:22:27 -0700 (PDT)
Message-Id: <20021016.162227.87213412.davem@redhat.com>
To: manand@us.ibm.com
Cc: akpm@digeo.com, hartner@austin.ibm.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net, mkanand@linux.ibm.com
Subject: Re: [Lse-tech] Re: Skb initialization patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFD5DE9802.84A266C1-ON87256C54.007E4D9D@boulder.ibm.com>
References: <OFD5DE9802.84A266C1-ON87256C54.007E4D9D@boulder.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Mala Anand" <manand@us.ibm.com>
   Date: Wed, 16 Oct 2002 18:20:48 -0500

   Are you saying that the skbs do not migrate between the per cpu
   pools (hotlist) if you have enough skbs in the hotlist/slab cache.
   There is always going to be migration of objects between CPUs
   even if you have enough objects per cpu pool.  There are other
   elements come into picture such as memory reclaim etc.,
   Moreover there is no guarantee that once a skb is allocated from
   cpu 0 pool, it would be freed to cpu 0 pool.
   
Your original claim was that moving the initialization from "free
time" to "alloc time" reduces inter-cpu cache activity.

You are arguing now that, after allocation, the object can move from
one cpu to another.

This new argument is incompatible with the argument that touching
the dirty data at "alloc time" improves performance, in fact it
should reduce performance in some cases.

   If the per cpu SLAB pool is depleted, it goes to the general
   slab pool. As I pointed out earlier you cannot eliminate this
   completely.
   
No, but you can make it happen much less often.  I really believe
the effort belongs here, because it helps everyone using SLAB
with constructors.

If the SLAB problem is "unsolvable", then we should just kill
constructor/destructor facility of SLAB because, as per your
arguments, it deteriorates performance on SMP if actually used.

   BTW SLAB is where I started the investigation, I will go back
   to that later. We can modify SLAB cache to hold more objects
   per cpu, but that won't eliminate the migration of objects.
   
And I argue that your patch cannot improve locality for the bad
inter-cpu SKB movement cases which occur post-allocation.

   I am working on the problem I posted yesterday. This skb init patch
   was done long time ago. I just collected data on new kernels.
   
Hmmm, you said data was with 2.5.38 kernel.  Were these SKB init tests
done with something more recent?
