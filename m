Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbVHLEil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVHLEil (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 00:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVHLEil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 00:38:41 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:7801 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750834AbVHLEik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 00:38:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=s8qo81xoBn92j4X/e3/zhpiIQZvZydMCRidhchsrn+ooO/Pm02FUTqndWrF4961ZMa09F2E8isg184tYqEhMSI52AZ6MJ1bV6f69DvVYASqu2NXxI9o+Fpo9A2pqRQAu8YGRILTkxj7A/7lmOpJsQ8gmP4FKin043UKDW833f5M=  ;
Subject: Re: [patch 5/7] radix-tree: lockless readside
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: paulmck@us.ibm.com
Cc: Paul McKenney <paul.mckenney@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050812013703.GP1300@us.ibm.com>
References: <42FB4201.7080304@yahoo.com.au> <42FB42BD.6020808@yahoo.com.au>
	 <42FB42EF.1040401@yahoo.com.au> <42FB4311.2070807@yahoo.com.au>
	 <42FB43A8.8060902@yahoo.com.au> <42FB43CB.5080403@yahoo.com.au>
	 <20050812013703.GP1300@us.ibm.com>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 14:38:35 +1000
Message-Id: <1123821515.5098.39.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 18:37 -0700, Paul E. McKenney wrote:
> On Thu, Aug 11, 2005 at 10:25:47PM +1000, Nick Piggin wrote:
> > 5/7
> > 
> > -- 
> > SUSE Labs, Novell Inc.
> > 
> 
> > Make radix tree lookups safe to be performed without locks.
> > Readers are protected against nodes being deleted by using RCU
> > based freeing. Readers are protected against new node insertion
> > by using memory barriers to ensure the node itself will be
> > properly written before it is visible in the radix tree.
> > 
> > Also introduce a lockfree gang_lookup_slot which will be used
> > by a future patch.
> 
> Interesting approach!  Don't claim to fully understand it, but
> see below (search for empty lines).  In the meantime, some questions:
> 

Basically, the main idea is this:

find_get_page (the current, locked version) will take the tree_lock,
elevate the refcount of the page currently in pagecache, and drop
the tree_lock.

tree_lock is used to a) ensure consistency of the radix tree, and
b) "pin" the page until we are able to take a reference to it.

After find_get_page returns the page with elevated refcount, it
has released the tree_lock, so there is no other atomicity /
serialisation provided other than the above 2 functions.

* Assuming my RCU'ed radix-tree is correct, that takes care of a.

* Now, we look up a 'struct page' that has existed in the pagecache
  at *some* point in time (ie. dereference the pagep pointer).

* Then, take a reference on that struct page, regardless of whether
  or not it is *now* in pagecache. This act of taking a reference
  is also a memory barrier.

* Now we can again check if the page existed in pagecache _after_
  taking that reference. If yes, we have a reference to the page
  we want.

* If it is no longer in pagecache, we assume it is the wrong page.
  Even if there is a new page in that part of the pagecache we can
  return NULL, because the pagecache would have had to be NULL at
  *some* point between the 2 times we load the pagep pointer.

With the above, we can meet the same requirements of the current
find_get_page. Which basically are:

x) If the page was ever[1] in pagecache, it may be returned
y) If the pagecache was ever[2] empty, NULL may be returned

[1], [2] - in accordance with the high level serialisation
schema, of course. The main point is that the tree_lock in
find_get_page can be taken at any arbitrary time and thus
doesn't provide anything past x and y.

Similar arguments for find_lock_page and find_get_pages, etc.


Anyway, that's the high level idea. All the rest of the machinery
is geared to handle the case where we have taken a reference to
the page after it has been removed from pagecache or used for
something else. This is admittedly fairly complex, but don't get
too hung up about it when getting an overview of it is supposed
to work.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
