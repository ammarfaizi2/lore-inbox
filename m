Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUIGMVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUIGMVk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUIGMTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:19:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:40088 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267977AbUIGMOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:14:23 -0400
Date: Tue, 7 Sep 2004 14:14:18 +0200
From: Andi Kleen <ak@suse.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907121418.GC25051@wotan.suse.de>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907104017.GB10096@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 01:40:17PM +0300, Michael S. Tsirkin wrote:
> Hello!
> Quoting Andi Kleen (ak@suse.de) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> > On Wed, Sep 01, 2004 at 10:22:45AM +0300, Michael S. Tsirkin wrote:
> > > Hello!
> > > Currently, on the x86_64 architecture, its quite tricky to make
> > > a char device ioctl work for an x86 executables.
> > > In particular,
> > >    1. there is a requirement that ioctl number is unique -
> > >       which is hard to guarantee especially for out of kernel modules
> > 
> > Yes, that is a problem for some people. But you should
> > have used an unique number in the first place.
> 
> Do you mean the _IOC macro and friends?
> But their uniqueness depends on allocating a unique magic number
> in the first place.

Yep. It's not bullet proof, but works pretty well in practice with
a little care.

> 
> > There are some hackish ways to work around it for non modules[1], but at some
> > point we should probably support it better.
> > 
> > [1] it can be handled, except for module unloading, so you have
> > to disable that.
> 
> Why use the global hash at all?
> Why not, for example, pass a parameter to the ioctl function
> to make it possible to figure out this is a compat call?

The main reason is that traditionally there was some resistance
to put compat code into the drivers itself because it "looked too
ugly". So it was just put into a few centralized files. Patching 
all the f_ops wouldn't have been practical for this. 

Maybe it could be added as an additional mechanism now though.

> > >    2. there's a performance huge overhead for each compat call - there's
> > >       a hash lookup in a global hash inside a lock_kernel -
> > >       and I think compat performance *is* important.
> > 
> > Did you actually measure it? I doubt it is a big issue.
> > 
> 
> But that would depend on what the driver actually does inside
> the ioctl and on how many ioctls are already registered, would it not?

Most ioctls should be registered at boot, the additional ones
are probably negligible.

> 
> I built a silly driver example which just used a semaphore and a switch
> statement inside the ioctl.
> 
> ~/<1>tavor/tools/driver_new>time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
> 0.357u 4.760s 0:05.11 100.0%    0+0k 0+0io 0pf+0w
> ~/<1>tavor/tools/driver_new>time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
> 0.641u 6.486s 0:07.12 100.0%    0+0k 0+0io 0pf+0w
> 
> So just looking at system time there seems to be an overhead of
> about 20%.

That's with an empty ioctl? I would expect most ioctls to do
more work, so the overhead would be less.

Still it could be probably made better. 

> The overhead is bigger if there are collisions in the hash.
> 
> For muti-processor scenarious, the difference is much more pronounced
> (note I have dual-cpu Opteron system):
> 
> ~>time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0 & ;time /tmp/ioctltest32
> /dev/mst/mt23108_pci_cr0 &
> [2] 10829
> [3] 10830
> [2]    Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
> 0.435u 21.322s 0:21.76 99.9%    0+0k 0+0io 0pf+0w
> [3]    Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
> 0.683u 21.231s 0:21.92 99.9%    0+0k 0+0io 0pf+0w
> ~>
> 
> 
> ~>time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0 & ;time /tmp/ioctltest64
> /dev/mst/mt23108_pci_cr0 &
> [2] 10831
> [3] 10832
> [3]    Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
> 0.474u 11.194s 0:11.70 99.6%    0+0k 0+0io 0pf+0w
> [2]    Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
> 0.476u 11.277s 0:11.75 99.9%    0+0k 0+0io 0pf+0w
> ~>
> 
> So we get 50% slowdown.
> I imagine this is the result of BKL contention during the hash lookup.


Ok, this could be improved agreed (although I still think your microbenchmark
is a bit too artificial) 

In theory the BKL could be dropped from the lookup anyways
if RCU is needed for the cleanup. For locking the handler 
itself into memory it doesn't make any difference.

What happens when you just remove the lock_kernel() there? 
(as long as you don't unload any modules this should be safe) 

-Andi


