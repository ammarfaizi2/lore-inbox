Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTI3J2t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbTI3J2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:28:49 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:19881 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261240AbTI3J2m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:28:42 -0400
Message-ID: <3F794CC8.1070105@namesys.com>
Date: Tue, 30 Sep 2003 13:28:40 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Reiser4 debugging status update
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The filesystem is getting reasonably stable. 

This weekend we hit a bug in space reservation, which we can't reproduce 
yet but probably isn't too hard to find by code inspection.  There is 
some thought that the assertion not the space reservation is buggy, in 
any case we'll release a snapshot after it is fixed.

Our performance is generally wonderful and getting better. 

It has the following weakpoints:

* We allocate a "jnode" per unformatted node in the filesystem.  The 
traversing of these jnodes consumes more CPU than performing the memcpy 
from user space to kernel space when doing large writes.  I don't yet 
really understand on an intuitive level why this is so, which is a 
reflection on my ignorance as it is consistent with stories I have heard 
from other implementors of filesystems who found that eliminating per 
page structures was an important part of optimizing large writes.  We 
will fix this by creating a new structure called an extent-node that 
will exist on a per extent basis, and this will probably cure the 
problem.  This will greatly simplify parts of our code for reasons I 
won't go into, and it will also take us 6 weeks to do it.  I don't think 
users should wait for it, and so we will ship without it.

* Our dbench performance was poor, has improved due to coding changes, 
and we need to test and analyze again.  Perhaps more fixes will be 
needed, we can't say yet.

* Our fsync performance is poor.  We will pay attention to this next 
year, frankly, after we have fully implemented the transactions API.  At 
that point we will say something like, if you care about fsync 
performance you should be using the transactions API and/or sponsoring 
us to tune for NVRAM, users will say back "but our legacy apps on 
hardware without NVRAM matter!", and we will grudgingly but effectively 
tune for this because we care about real users too.;-)

Nikita recently invented and implemented a clever bit of code that keeps 
track of the highest node in the tree that spans a directory, and then 
performs repeat lookups within the same directory starting from there 
rather than the root.  This is a nice answer to those who keep asking 
me, wouldn't it be faster to have separate trees for each directory?  
Now I have better answer for them --- nice work Nikita.  It also has the 
nice side effect of reducing spin lock contention on the root node for 
4-way SMP.

I am hoping to move my laptop to SuSE 9.0 running reiser4 sometime this 
week, and I am hoping we will ask for more outside testers to help us 
find bugs at that time.  While I have mentioned only the performance 
flaws in this email, our overall performance seems to leave little doubt 
that the filesystem as-is is far better than V3, and even though it will 
get much faster with another year or so of tuning, if now we are the 
fastest available on Linux, we should be shipping now (assuming we find 
no new bugs in the last round of internal testing).

Benchmarks can be found at www.namesys.com/benchmarks.html

As you can see in those benchmarks, in V4 tails IMPROVE performance due 
to saving IO transfer time.  This is a great improvement over V3, and 
generally speaking V4 stomps all over V3 performance.  It also scales 
better, has plugins, and improves semantics a little bit (big semantic 
improvements will be in the next major release not V4). 

You'll also notice that we increased the size of the fileset to be more 
fair to ext3, and we tested some ext3 configurations Andrew Morton 
suggested testing.

-- 
Hans


