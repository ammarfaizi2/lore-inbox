Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUIGOQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUIGOQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUIGOQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:16:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:60395 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268085AbUIGOPZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:15:25 -0400
Date: Tue, 7 Sep 2004 16:15:24 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907141524.GA13862@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907134517.GA1016@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 04:45:18PM +0300, Michael S. Tsirkin wrote:
> > > I built a silly driver example which just used a semaphore and a switch
> > > statement inside the ioctl.
> > > 
> > > ~/<1>tavor/tools/driver_new>time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
> > > 0.357u 4.760s 0:05.11 100.0%    0+0k 0+0io 0pf+0w
> > > ~/<1>tavor/tools/driver_new>time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
> > > 0.641u 6.486s 0:07.12 100.0%    0+0k 0+0io 0pf+0w
> > > 
> > > So just looking at system time there seems to be an overhead of
> > > about 20%.
> > 
> > That's with an empty ioctl?
> 
> Not exactly empty - below's the code snippet.

Hmm, ok. Surprising then. Can you profile it to see where 
the bottleneck exactly is? 

> > I would expect most ioctls to do
> > more work, so the overhead would be less.
> > Still it could be probably made better. 
> 
> Then I expect you'll get bitten by the BKL taken while ioctl runs.

Yes, but that's a general problem, not specific to compat ioctls.

So far nobody dared to drop the BKL for ioctls because it would
require to audit/fix a *lot* of code.

The idea of taking the BKL during the hash lookup was that
when the BKL is taken anyways it doesn't make too much 
difference to take it a little bit longer. But this assumed
that the hash lookup is fast. If it isn't maybe the hash
function should just be optimized a bit or the table increased.

Most of the values are known at compile time, so maybe
some perfect hash generator like gperf could be used to
generate a better hash? 


> >
> > In theory the BKL could be dropped from the lookup anyways
> > if RCU is needed for the cleanup. For locking the handler 
> > itself into memory it doesn't make any difference.
> > 
> > What happens when you just remove the lock_kernel() there? 
> > (as long as you don't unload any modules this should be safe) 
> > 
> > -Andi
> 
> Well, I personally do want to enable module unloading.

It works fine as long as the compat function is in the same
module as the one providing the file_ops.

> I think I'll add a new entry point to f_ops  and see what *this* does
> to speed. That would be roughly equivalent, and cleaner, right?

It may help your module, but won't solve the general problem shorter
term.

-Andi

