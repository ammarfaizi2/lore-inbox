Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUIGOb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUIGOb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268111AbUIGOb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:31:26 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:8031 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S268108AbUIGO0z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:26:55 -0400
Date: Tue, 7 Sep 2004 17:25:30 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907142530.GB1016@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907141524.GA13862@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> On Tue, Sep 07, 2004 at 04:45:18PM +0300, Michael S. Tsirkin wrote:
> > > > I built a silly driver example which just used a semaphore and a switch
> > > > statement inside the ioctl.
> > > > 
> > > > ~/<1>tavor/tools/driver_new>time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
> > > > 0.357u 4.760s 0:05.11 100.0%    0+0k 0+0io 0pf+0w
> > > > ~/<1>tavor/tools/driver_new>time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
> > > > 0.641u 6.486s 0:07.12 100.0%    0+0k 0+0io 0pf+0w
> > > > 
> > > > So just looking at system time there seems to be an overhead of
> > > > about 20%.
> > > 
> > > That's with an empty ioctl?
> > 
> > Not exactly empty - below's the code snippet.
> 
> Hmm, ok. Surprising then. Can you profile it to see where 
> the bottleneck exactly is? 
> 
> 
>
> > > I would expect most ioctls to do
> > > more work, so the overhead would be less.
> > > Still it could be probably made better. 
> > 
> > Then I expect you'll get bitten by the BKL taken while ioctl runs.
> 
> Yes, but that's a general problem, not specific to compat ioctls.
> 
> So far nobody dared to drop the BKL for ioctls because it would
> require to audit/fix a *lot* of code.

But if we have a new entry point in f_ops, drivers will either
be audited as they are migrated to this, or will just take
the BKL themselves.

> The idea of taking the BKL during the hash lookup was that
> when the BKL is taken anyways it doesn't make too much 
> difference to take it a little bit longer. But this assumed
> that the hash lookup is fast. If it isn't maybe the hash
> function should just be optimized a bit or the table increased.
> 
> Most of the values are known at compile time, so maybe
> some perfect hash generator like gperf could be used to
> generate a better hash? 
> 
> 
> > >
> > > In theory the BKL could be dropped from the lookup anyways
> > > if RCU is needed for the cleanup. For locking the handler 
> > > itself into memory it doesn't make any difference.
> > > 
> > > What happens when you just remove the lock_kernel() there? 
> > > (as long as you don't unload any modules this should be safe) 
> > > 
> > > -Andi
> > 
> > Well, I personally do want to enable module unloading.
> 
> It works fine as long as the compat function is in the same
> module as the one providing the file_ops.
> 
> > I think I'll add a new entry point to f_ops  and see what *this* does
> > to speed. That would be roughly equivalent, and cleaner, right?
> 
> It may help your module, but won't solve the general problem shorter
> term.
> 
> -Andi

But longer term it will be better, so why not go there?
Once the infrastructure is there, drivers will be able to be
migrated as required.
MSt

