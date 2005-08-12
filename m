Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVHLD73@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVHLD73 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVHLD73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:59:29 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:63118 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750796AbVHLD73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:59:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=5xt7/Fg5GU4nzWWFbqnMfAkWeyNcetH0egKJzYfi9c3SN66lIhwZ+hESuf9qZpMXLPKGT9kYjcqzyl7hDLipAlRK1ktp+fv/7nwlTTCSNGsz9byh+WW/zUj3TI1doqRfdBqXwCNace5Ego7F1yM8XdmLei2aQ/BIOtqNHzHysDQ=  ;
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
Date: Fri, 12 Aug 2005 13:59:19 +1000
Message-Id: <1123819159.5098.10.camel@npiggin-nld.site>
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

Thanks for comments and review - very helpful.

> o	What exactly is RCU protecting?  My first guess is that
> 	it protects the pointers and internal nodes of the
> 	radix tree, but not the objects in the leaves of the
> 	trees (in other words, the things pointed to by the
> 	return value from things like radix_tree_lookup_slot()).
> 

Ah OK, this wasn't initially apparent to me either, however I
believe it is needed.

Indeed we are protecting the internal nodes of the radix tree,
however the speculative get operation needs to dereference a
*pointer* to the page. The `struct page` itself doesn't go away,
and thus doesn't need any protection. However the *pointer* can
go away - it is contained within a radix tree node.

> 	But if this really is the case, then the rcu_read_lock() &
> 	rcu_read_unlock() pairs can be pushed down into
> 	radix_tree_lookup_slot() and friends.
> 
> o	The current code structure would lead me to believe that
> 	page_cache_get_speculative() is protected by RCU, but
> 	I don't see the corresponding call_rcu() or synchronize_rcu()
> 	that would cause this protection to be required.
> 

I believe this should answer your concern about the RCU protection
placement.

One thing we could do differently is this: instead of receiving
a pointer to the struct page from the radix tree lookup, we could
actually do as you say and push the rcu locking into the radix
tree lookup.

Then we would do a speculative get_page on that struct page,
finally we would lookup the radix tree again to see whether the
same page is still in the pagecache.

I discounted this idea not just for efficiency, but also because
it would require either a 2 phase speculative get (or a speculative
undo), or would require teaching speculative get about the pagecache
radix tree.

> > @@ -208,9 +219,13 @@ static int radix_tree_extend(struct radi
> >  				tag_set(node, tag, 0);
> >  		}
> >  
> > +		newheight = root->height+1;
> > +		node->height = newheight;
> >  		node->count = 1;
> > +		/* Make ->height visible before node visible via ->rnode */
> 
> > +		smp_wmb();
> >  		root->rnode = node;
> 
> The prior two lines should instead be:
> 
> 		rcu_assign_pointer(root->rnode, node);
> 

Great, thanks very much.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
