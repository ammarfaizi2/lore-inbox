Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWCJMCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWCJMCB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 07:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750744AbWCJMCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 07:02:01 -0500
Received: from ns1.suse.de ([195.135.220.2]:49878 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750738AbWCJMCA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 07:02:00 -0500
From: Neil Brown <neilb@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Date: Fri, 10 Mar 2006 22:56:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17425.27016.704864.741297@cse.unsw.edu.au>
Cc: Jan Blunck <jblunck@suse.de>, akpm@osdl.org, viro@zeniv.linux.org.uk,
       olh@suse.de, bsingharora@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix shrink_dcache_parent() against shrink_dcache_memory()
 race (3rd updated patch)]
In-Reply-To: message from Kirill Korotaev on Friday March 10
References: <20060309165833.GK4243@hasse.suse.de>
	<441060D2.6090800@openvz.org>
	<17425.2594.967505.22336@cse.unsw.edu.au>
	<441138B7.9060809@sw.ru>
	<20060310105950.GL4243@hasse.suse.de>
	<44116198.7000000@sw.ru>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday March 10, dev@sw.ru wrote:
> just an idea which came to my mind:
> can't we fix it the following way:
> 1. fix select_parent() when called from generic_shutdown_super() to loop 
> until _all_ dentries are shrinked (not only those, with d_count = 1);
> this guarentees that no dentries are left.

You couldn't just busy-wait.  You would need to have some wait_queue
to wait on, and someone to wake it up.


> 2. no dentries are left, but iput() can be in progress.
> So can't we simply make invalidate_inodes() to be in a loop with 
> schedule() until no busy inodes are left?!

Again, you need to be more predictable than just calling schedule().

> 
> unregister_netdevice() for example, loops until netdev counter drops to 
> zero. Why can't we do it the same way? Any objections?

I'd really like to understand why the code was the way it is before
making that sort of change.  It could just be that there was nothing
obvious to wait on, so maybe just adding a suitable wait_queue would
do it...
But then the current patch essentially adds a wait_queue and waits on
it where appropriate.  So would you approach be that much cleaner?
Maybe...

NeilBrown
