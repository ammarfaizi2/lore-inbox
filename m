Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUD2X6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUD2X6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 19:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUD2X6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 19:58:31 -0400
Received: from hera.kernel.org ([63.209.29.2]:15530 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S265027AbUD2X60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 19:58:26 -0400
To: linux-kernel@vger.kernel.org
From: Mary Edie Meredith <maryedie@osdl.org>
Subject: Re: DBT3-pgsql large performance improvement 2.6.6-rc1
Date: Thu, 29 Apr 2004 16:50:06 -0700
Organization: Open Source Development Labs
Message-ID: <409194AE.1000904@osdl.org>
References: <1082416495.2890.77.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1083283085 18434 172.20.1.91 (29 Apr 2004 23:58:05 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Thu, 29 Apr 2004 23:58:05 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mary Edie Meredith wrote:
.snip
> 
>>Mary Edie Meredith <maryedie@osdl.org> wrote:
>>
>>>Performance in DBT-3 (using PostgreSQL) has vastly
>>>improved for _both in the "power" portion (single 
>>>process/query) and in the "throughput" portion of 
>>>the test (when the test is running multiple processes) 
>>>on our 4-way(4GB) and 8-way(8GB) STP systems as 
>>>compared 2.6.5  kernel results.
>>>
>>>Using the default DBT-3 options (ie using LVM, ext2, 
>>>PostgreSQL version 7.4.1) 
>>>
>>>Note: Bigger numbers are better.
>>>
>>>Kernel....Runid..CPUs.Power..%incP.Thruput %incT 
>>>2.6.5     291308   4  97.08  base   120.46  base   
>>>2.6.6-rc1 291876   4  146.11 50.5%  222.94 85.1%
>>>
>>>Kernel....Runid..CPUs.Power..%incP..Thruput %incT
>>>2.6.5     291346   8  101.08  base   138.95 base
>>>2.6.6-rc1 291915   8  151.69  50.1%  273.69 97.0%
>>>
>>>So the improvement is between 50% and 97%!
>>
>>How odd.

Your instincts were right (as usual).

We took another closer look at this.  It appears that
a change slipped into the kit around April 13, which
probably made this stunning performance difference
not the kernel.

Results of second run of the linux-2.6.5 kernel using the
changed test kit showed that the numbers are comparable
to the latest 2.6.6-rc3 release.  Therefore,
it looks like the initial improvements posted were
most likely due to the change in datatypes
making the database size smaller, among other things.

....................Composite....Power...Throughput
 

initial linux 2.6.5   108.14      97.08    120.46
second linux 2.6.5    180.62     146.53    222.63
linux 2.6.6-rc3       181.83     147.16    224.68

Tests were compared on 4-way systems.  (Bigger is better).

We will run the 8-way numbers over night to see if there is
any difference for those systems.  We are also running some
IA64 results over night as well.


>>
>>
>>>Profile 2.6.5 8way throughput phase:
>>>http://khack.osdl.org/stp/291346/profile/after_throughput_test_1-tick.sort
>>>Profile 2.6.6-r1 8way throughput phase:
>>>http://khack.osdl.org/stp/291915/profile/after_throughput_test_1-tick.sort
>>
>>Odder.  do_anonymous_page() is doing 10x more work in 2.6.6-rc1.  And the
>>CPU scheduler cost has fallen a lot.
>>
>>Frankly, I can't think of anything in 2.6.6-rc1 which would cause either of
>>these things!
>>
>>
>>>What I notice is that radix_tree_lookup is in 
>>>the top 20 in the 2.6.5 profile, but not in 
>>>2.6.6-rc1.  Could theradix tree changes be 
>>>responsible for this?
>>
>>I would certainly expect 2x or even higher throughput increases from either
>>the writeback changes or the ext2&ext3 fsync changes.
>>
>>
>>>DBT-3 is a read mostly DSS workload and the throughput 
>>>phase  is where we run multiple query streams (as 
>>>many as we have CPUs).  In this workload, the database 
>>>is stored on a file system, but it is small relative 
>>>to the amount of memory (4GB and 8GB).  It almost 
>>>completely caches in page cache early on.   So there 
>>>is some physical IO in the first few minutes, but very 
>>>little to none in the remainder. 
>>
>>But you're not doing a significant amount of writing during the test, so
>>scrub that theory.
>>
>>Do you have full reports anywhere?  I'd be interested in seeing a vmstat
>>trace from the entire run, both 2.6.5 and 2.6.6-rc1.
