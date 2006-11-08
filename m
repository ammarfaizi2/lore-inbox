Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754621AbWKHSPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbWKHSPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbWKHSPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:15:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1754621AbWKHSPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:15:51 -0500
Date: Wed, 8 Nov 2006 13:04:31 -0500 (EST)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-20.boston.redhat.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, arjan@infradead.org, rdreier@cisco.com
Subject: Re: locking hierarchy based on lockdep
In-Reply-To: <20061107235342.GA5496@elte.hu>
Message-ID: <Pine.LNX.4.64.0611081254150.18340@dhcp83-20.boston.redhat.com>
References: <Pine.LNX.4.64.0611061315380.29750@dhcp83-20.boston.redhat.com>
 <20061106200529.GA15370@elte.hu> <Pine.LNX.4.64.0611071833450.22572@dhcp83-20.boston.redhat.com>
 <20061107235342.GA5496@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Nov 2006, Ingo Molnar wrote:

> 
> * Jason Baron <jbaron@redhat.com> wrote:
> 
> > > this would certainly be the simplest thing to do - we could extend 
> > > /proc/lockdep with the list of 'immediately after' locks separated by 
> > > commas. (that list already exists: it's the lock_class.locks_after list)
> >
> > So below is patch that does what you suggest, although i had to add 
> > the concept of 'distance' to the patch since the locks_after list 
> > loses this dependency info afaict. i also wrote a user space program 
> > to sort the locks into cluster of interelated locks and then sorted 
> > within these clusters...the results show one large clump of 
> > locks...perhaps there are a few locks that time them all together like 
> > scheduler locks...but i couldn't figure out which ones to exclude to 
> > make the list look really pretty (also, there could be a bug in my 
> > program :). Anyways i'm including my test program and its output 
> > too...
> 
> nice!
> 
> small detail: i'm wondering why 'distance' is needed explicitly? The 
> dependency graph as it is represented by locks_after should be a full 
> representation of all locking dependencies. What is the intended 
> definition of 'distance' - the distance from the root of the dependency 
> tree? (Maybe i'm misunderstanding what you are trying to achieve.)
> 

'distance' is associated with a link, and is meant to represent the number 
of intervening locks. So a distance of 1 b/w say lock a and b is to say 
there is no intervening lock, whereas 2 would mean there is 1 
intervening lock etc.

The reason i added this was that in my algorithm to order locks, say i 
come to lock a, which has lock b and lock c in its 'after' list. I don't 
know at that point if lock b needs to come before c, or maybe that c has 
to come before b.

You are right though, i think that the data in the locks after lists is 
sufficient to re-create the entire graph, since its acyclic, but by simply 
printing out nodes of distance '1', the algorithm is greatly simplified. 
Otherwise, i'd have to first reconstruct the graph...

Also, i was only looking for a link to be label as distance 1, or not...so 
we only need to associate 1 bit of information with each link, if you are 
concerned about struture bloat.

thanks,

-jason
