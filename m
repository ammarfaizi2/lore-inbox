Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUKUDUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUKUDUu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 22:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263208AbUKUDUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 22:20:50 -0500
Received: from dp.samba.org ([66.70.73.150]:63177 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263204AbUKUDU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 22:20:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16800.2371.421108.693783@samba.org>
Date: Sun, 21 Nov 2004 14:19:31 +1100
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <41A00205.1020704@namesys.com>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<419ECAB5.10203@namesys.com>
	<16798.59519.63931.494579@samba.org>
	<419F6D1F.10001@namesys.com>
	<16799.62734.463565.38876@samba.org>
	<41A00205.1020704@namesys.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans,

 > Would you be willing to do some variation on it that scaled itself to 
 > the size of the machine, and generated disk load rather than fitting in ram?

You can do that now by varying the number of simulated clients, or by
varying the load file.

 > I hope you understand my reluctance to optimize for tests that fit into 
 > ram.....

to some extent, yes, but "in memory" tests are actually pretty
important for file serving.

In a typical large office environment with one or two thousand users
you will only have between 20 and 100 of those users really actively
using the file server at any one time. The others are taking a nap, in
meetings or staring out the window. Or maybe (being generous), they
are all working furiously with cached data. I haven't actually gone
into the cubes to check - I just see the server side stats.

Of those that are active, they rarely have a working set size of over
100MB, and usually much less, so it is not uncommon for the whole
workload over a period of 5 minutes to fit in memory on typical file
servers. This is especially so on the modern big file servers that
might have 16G of ram or more, with modern clients that do agressive
lease based caching.

There are exceptions of course. Big print shops, rendering farms and
high performance computing sites are all examples of sites that have
active working sets much larger than typical system memory. 

The point is that you need to test a wide range of working set
sizes. You also might like to notice that in the published commercial
NetBench runs paid for by the big players (like Microsoft, NetApp, EMC
etc), you tend to find that the graph only extends to a number of
clients equal to the total machine memory divided by 25MB. That is
perhaps not a coincidence given that the working set size per client
of NetBench is about 22MB. The people who pay for the benchmarks want
their customers to see a graph that doesn't have a big cliff at the
right hand side.

Also, with journaled filesystems running in-memory benchmarks isn't as
silly as it first seems, as there are in fact big differences between
how the filesystems cope. It isn't just a memory bandwidth
test. Windows clients do huge numbers of meta-data operations, and
nearly all of those cause journal writes which hit the metal.

So while I sympathise with you wanting reiser4 to be tuned for "big"
storage, please remember that a good proportion of the installs are
likely to be running "in-memory" workloads.

Cheers, Tridge
