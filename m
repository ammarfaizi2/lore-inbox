Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUJHXSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUJHXSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 19:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266170AbUJHXSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 19:18:09 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:16011 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S266186AbUJHXPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 19:15:43 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: colpatch@us.ibm.com
Subject: Re: [Lse-tech] [RFC PATCH] scheduler: Dynamic sched_domains
Date: Sat, 9 Oct 2004 01:13:40 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       LSE Tech <lse-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>,
       simon.derr@bull.net, frankeh@watson.ibm.com
References: <1097110266.4907.187.camel@arrakis> <41666E90.2000208@yahoo.com.au> <1097261691.5650.23.camel@arrakis>
In-Reply-To: <1097261691.5650.23.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410090113.40589.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

I reply to this post because it has more examples ;-)

On Friday 08 October 2004 20:54, Matthew Dobson wrote:
> On Fri, 2004-10-08 at 03:40, Nick Piggin wrote:
> > And so you want to make a partition with CPUs {0,1,2,4,5}, and {3,6,7}
> > for some crazy reason, the new domains would look like this:
> > 
> > 0 1  2  4 5    3  6 7
> > ---  -  ---    -  ---  <- 0
> >   |   |   |     |   |
> >   -----   -     -   -   <- 1
> >     |     |     |   |
> >     -------     -----   <- 2 (global, partitioned)
> > 
> > Agreed? You don't need to get fancier than that, do you?
> > 
> > Then how to input the partitions... you could have a sysfs entry that
> > takes the complete partition info in the form:
> > 
> > 0,1,2,3 4,5,6 7,8 ...
> > 
> > Pretty dumb and simple.
> 
> How do we describe the levels other than the first?  We'd either need
> to:
> 1) come up with a language to describe the full tree.  For your example
> I quoted above:
>    echo "0,1,2,4,5 3,6 7,8;0,1,2 4,5 3 6,7;0,1 2 4,5 3 6,7" > partitions

This is not nice. Especially because changes cannot be made
gradually. You need to put in the whole tree each time you change
something. Concurrent processes modifying the structre need additional
mechanisms for synchronization.

> 2) have multiple files:
>    echo "0,1,2,4,5 3,6,7" > level2
>    echo "0,1,2 4,5 3 6,7" > level1
>    echo "0,1 2 4,5 3 6,7" > level0

Add a way to create levels. This one is hard to "parse" and again
there is no protection for the "own" domains and maybe trouble with
synchronization. 

> 3) Or do it hierarchically as Paul implemented in cpusets, and as I
> described in an earlier mail:
>    mkdir level2
>    echo "0,1,2,4,5 3,6,7" > level2/partitions
>    mkdir level1
>    echo "0,1,2 4,5 3 6,7" > level1/partitions
>    mkdir level0
>    echo "0,1 2 4,5 3 6,7" > level0/partitions
> 
> I personally like the hierarchical idea.  Machine topologies tend to
> look tree-like, and every useful sched_domain layout I've ever seen has
> been tree-like.  I think our interface should match that.

I like the hierarchical idea, too. The natural way to build it would
be by starting from the cpus and going up. This tree stands on its
leafs... and I'm not sure how to express that in a filesystem.

How about this:
If you would go from top (global) domain down the default could be to
have a directory

sched_domains/
              global/
                     cpu1
                     cpu2
                     ...

The cpuX files would always exist. All you'd need to do would be to
create subdirectories and move the cpuX files from one to the
other. You should be able to remove directories if they are empty.

  # cd sched_domains/global
  # mkdir node1 node2
  # mv cpu1 cpu2 node1
  # mv cpu3 cpu4 node2

sched_domains/
              global/
                     node1/
                           cpu1
                           cpu2
                     node2/
                           cpu3
                           cpu4

or disconnected domains:

  # cd sched_domains
  # mkdir interactive batch
  # mv global/cpu1 global/cpu2 interactive
  # mv global/cpu3 global/cpu4 batch
  # rmdir global

sched_domains/
              interactive/
                          cpu1
                          cpu2
              batch/
                    cpu3
                    cpu4


Regards,
Erich



