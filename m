Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUDPVwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbUDPVun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:50:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:54955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263863AbUDPVrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:47:24 -0400
Date: Fri, 16 Apr 2004 14:49:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: maryedie@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: DBT3-pgsql large performance improvement 2.6.6-rc1
Message-Id: <20040416144943.3fc5744a.akpm@osdl.org>
In-Reply-To: <1082134307.16437.461.camel@localhost>
References: <1082134307.16437.461.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mary Edie Meredith <maryedie@osdl.org> wrote:
>
> Performance in DBT-3 (using PostgreSQL) has vastly
> improved for _both in the "power" portion (single 
> process/query) and in the "throughput" portion of 
> the test (when the test is running multiple processes) 
> on our 4-way(4GB) and 8-way(8GB) STP systems as 
> compared 2.6.5  kernel results.
> 
> Using the default DBT-3 options (ie using LVM, ext2, 
> PostgreSQL version 7.4.1) 
> 
> Note: Bigger numbers are better.
> 
> Kernel....Runid..CPUs.Power..%incP.Thruput %incT 
> 2.6.5     291308   4  97.08  base   120.46  base   
> 2.6.6-rc1 291876   4  146.11 50.5%  222.94 85.1%
> 
> Kernel....Runid..CPUs.Power..%incP..Thruput %incT
> 2.6.5     291346   8  101.08  base   138.95 base
> 2.6.6-rc1 291915   8  151.69  50.1%  273.69 97.0%
> 
> So the improvement is between 50% and 97%!

How odd.

> Profile 2.6.5 8way throughput phase:
> http://khack.osdl.org/stp/291346/profile/after_throughput_test_1-tick.sort
> Profile 2.6.6-r1 8way throughput phase:
> http://khack.osdl.org/stp/291915/profile/after_throughput_test_1-tick.sort

Odder.  do_anonymous_page() is doing 10x more work in 2.6.6-rc1.  And the
CPU scheduler cost has fallen a lot.

Frankly, I can't think of anything in 2.6.6-rc1 which would cause either of
these things!

> What I notice is that radix_tree_lookup is in 
> the top 20 in the 2.6.5 profile, but not in 
> 2.6.6-rc1.  Could theradix tree changes be 
> responsible for this?

I would certainly expect 2x or even higher throughput increases from either
the writeback changes or the ext2&ext3 fsync changes.

> DBT-3 is a read mostly DSS workload and the throughput 
> phase  is where we run multiple query streams (as 
> many as we have CPUs).  In this workload, the database 
> is stored on a file system, but it is small relative 
> to the amount of memory (4GB and 8GB).  It almost 
> completely caches in page cache early on.   So there 
> is some physical IO in the first few minutes, but very 
> little to none in the remainder. 

But you're not doing a significant amount of writing during the test, so
scrub that theory.

Do you have full reports anywhere?  I'd be interested in seeing a vmstat
trace from the entire run, both 2.6.5 and 2.6.6-rc1.

