Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVINGBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVINGBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbVINGBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:01:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:61661 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965019AbVINGBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:01:40 -0400
Date: Tue, 13 Sep 2005 23:01:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: zippel@linux-m68k.org, akpm@osdl.org, torvalds@osdl.org,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050913230119.13be3fed.pj@sgi.com>
In-Reply-To: <20050913103724.19ac5efa.pj@sgi.com>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
	<20050912075155.3854b6e3.pj@sgi.com>
	<Pine.LNX.4.61.0509121821270.3743@scrub.home>
	<20050912153135.3812d8e2.pj@sgi.com>
	<Pine.LNX.4.61.0509131120020.3728@scrub.home>
	<20050913103724.19ac5efa.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> I'd expect the spinlocks to get taken
> and released in the following order on these cpusets:
> 
> 	    lock /A/B/C
> 	    lock /A/B
> 	    lock /A
> 	    lock /
> 	      ==> found what I was searching for
> 	    unlock /
> 	    unlock /A
> 	    unlock /A/B
> 	    unlock /A/B/C

The appropriate condition required to prevent deadlock is weaker than
stated above.  The condition should be:

     * A task can hold the spinlocks for multiple cpusets, but only
     * if it acquires in bottom up order.  That is, whenever a task
     * tries to lock a cpuset, the only cpusets it may already have
     * locked must be descendents of the one it is going for.

With this, the following sequence of lock operations would also
be acceptable, holding the bottom lock, while walking up the tree,
locking and unlocking each ancestor in turn, until one is found
that satisfies the present query.  Only the bottom most lock has
to be held in this approach, for the duration.

 	    lock /A/B/C
 	    lock /A/B
 	    unlock /A/B
 	    lock /A
 	    unlock /A
 	    lock /
 	      ==> found what I was searching for
 	    unlock /
 	    unlock /A/B/C

This sequence is a little easier to implement, because there is no need
to keep a variable length queue of locks to be undone.  At most two
locks are held at anytime.

If a variable length queue of locks to be undone had been needed, it
could have been implemented using one more field in each cpuset,
forming a LIFO linked list of cpusets to be unlocked.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
