Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUDSXV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUDSXV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 19:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbUDSXV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 19:21:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:3543 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S261252AbUDSXVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 19:21:49 -0400
Subject: Re: DBT3-pgsql large performance improvement 2.6.6-rc1
From: Mary Edie Meredith <maryedie@osdl.org>
Reply-To: maryedie@osdl.org
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: OSDL
Message-Id: <1082416495.2890.77.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Apr 2004 16:14:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to copy the list.
-----Forwarded Message-----
From: Mary Edie Meredith <maryedie@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: DBT3-pgsql large performance improvement 2.6.6-rc1
Date: Mon, 19 Apr 2004 08:44:45 -0700


The full reports for the 8ways are at:

2.6.5  http://khack.osdl.org/stp/291346/
2.6.6-rc1 http://khack.osdl.org/stp/291915/

Most stats are broken up between the load phase, power (single stream),
and throughput phases.  By the way the load phase improved from 1:02:43
(HH:MM:SS) to 0:41:41 as well.

Another data point that I noticed is that a similar boost in performance
occurred at 2.6.5-mm5 compared to 2.6.5-mm3 (there were problems with
-mm4 so no data exists).  The 8way results for that are at:

http://khack.osdl.org/stp/291727/

Would the radix tree changes only apply to writing?  Don't the searches
for writable pages occur whether there are pages to write or not?  There
is a considerable amount of memory devoted to page cache in this set
up.  

On Fri, 2004-04-16 at 14:49, Andrew Morton wrote:
> Mary Edie Meredith <maryedie@osdl.org> wrote:
> >
> > Performance in DBT-3 (using PostgreSQL) has vastly
> > improved for _both in the "power" portion (single 
> > process/query) and in the "throughput" portion of 
> > the test (when the test is running multiple processes) 
> > on our 4-way(4GB) and 8-way(8GB) STP systems as 
> > compared 2.6.5  kernel results.
> > 
> > Using the default DBT-3 options (ie using LVM, ext2, 
> > PostgreSQL version 7.4.1) 
> > 
> > Note: Bigger numbers are better.
> > 
> > Kernel....Runid..CPUs.Power..%incP.Thruput %incT 
> > 2.6.5     291308   4  97.08  base   120.46  base   
> > 2.6.6-rc1 291876   4  146.11 50.5%  222.94 85.1%
> > 
> > Kernel....Runid..CPUs.Power..%incP..Thruput %incT
> > 2.6.5     291346   8  101.08  base   138.95 base
> > 2.6.6-rc1 291915   8  151.69  50.1%  273.69 97.0%
> > 
> > So the improvement is between 50% and 97%!
> 
> How odd.
> 
> > Profile 2.6.5 8way throughput phase:
> > http://khack.osdl.org/stp/291346/profile/after_throughput_test_1-tick.sort
> > Profile 2.6.6-r1 8way throughput phase:
> > http://khack.osdl.org/stp/291915/profile/after_throughput_test_1-tick.sort
> 
> Odder.  do_anonymous_page() is doing 10x more work in 2.6.6-rc1.  And the
> CPU scheduler cost has fallen a lot.
> 
> Frankly, I can't think of anything in 2.6.6-rc1 which would cause either of
> these things!
> 
> > What I notice is that radix_tree_lookup is in 
> > the top 20 in the 2.6.5 profile, but not in 
> > 2.6.6-rc1.  Could theradix tree changes be 
> > responsible for this?
> 
> I would certainly expect 2x or even higher throughput increases from either
> the writeback changes or the ext2&ext3 fsync changes.
> 
> > DBT-3 is a read mostly DSS workload and the throughput 
> > phase  is where we run multiple query streams (as 
> > many as we have CPUs).  In this workload, the database 
> > is stored on a file system, but it is small relative 
> > to the amount of memory (4GB and 8GB).  It almost 
> > completely caches in page cache early on.   So there 
> > is some physical IO in the first few minutes, but very 
> > little to none in the remainder. 
> 
> But you're not doing a significant amount of writing during the test, so
> scrub that theory.
> 
> Do you have full reports anywhere?  I'd be interested in seeing a vmstat
> trace from the entire run, both 2.6.5 and 2.6.6-rc1.
-- 
Mary Edie Meredith 
maryedie@osdl.org
503-626-2455 x42
Open Source Development Labs

