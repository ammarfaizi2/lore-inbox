Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263296AbTDNOes (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 10:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbTDNOes (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 10:34:48 -0400
Received: from franka.aracnet.com ([216.99.193.44]:40918 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263296AbTDNOer (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 10:34:47 -0400
Date: Mon, 14 Apr 2003 07:46:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Quick question about hyper-threading
Message-ID: <10480000.1050331589@[10.10.2.4]>
In-Reply-To: <nicoya-87F6BA.04060913042003@news.sc.shawcable.net>
References: <20030413031007$5a6f@gated-at.bofh.it> <20030413041007$6d72@gated-at.bofh.it> <nicoya-87F6BA.04060913042003@news.sc.shawcable.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Perhaps the same effect could be obtained by preferentially scheduling 
> processes to execute on the "node" (a node being a single cpu in an SMP 
> system, or an HT virtual CPU pair, or a NUMA node) that they were last 
> running on.

We do that already. In fact, they always do that unless they're explicitly
migrated (in both NUMA and SMP cases) by the rebalancer.

> I think the ideal semantics would probably be something along the lines of:
> 
>  - a newly fork()ed thread executes on the same node as the creating thread
>  - calling exec() sets a "feel free to shuffle me elsewhere" flag
>  - threads are otherwise only shuffled to other nodes when a certain load ratio 
> is exceeded (current-node:idle-node)

Read the code. It does pretty much exactly this already ;-)
Especially look at sched_balance_exec(), and balance_node()

> Unfortunatley the whole idea would seem to fall apart in the case of a 
> fast-spawning thread pool type load. Perhaps there's a way to handle that 
> automatically, or perhaps it would best be left as a scheduler tunable, 
> I don't know.

It does, kind of ... in fact they all stay on the same runqueue. We need
to train the numa rebalancer to move multiple tasks in the case of heavy
imbalances, but it needs some care to avoid migrating short load spikes.
Moving from nr_running snapshots to load averages will probably fix it.

> I seem to recall SGI found great benefit in writing the scheduler in IRIX to 
> work somewhat like this, though the loads on most SGI machines tend to be slow 
> spawning, long running and big memory - the textbook case for reduced node 
> shuffling. Linux would tend to have a much greater variety of load profiles, 
> some of which would be less pleasantly affected.

Right - that's why it's hard ;-) Fixing any one case is easy ... fixing
all of them simultaneously is extremely difficult ;-)

M.

