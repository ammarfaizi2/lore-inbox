Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267831AbUIGKeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267831AbUIGKeb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267833AbUIGKeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:34:31 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:16324 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S267831AbUIGKe1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:34:27 -0400
Date: Tue, 7 Sep 2004 13:40:17 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040907104017.GB10096@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903080058.GB2402@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting Andi Kleen (ak@suse.de) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> On Wed, Sep 01, 2004 at 10:22:45AM +0300, Michael S. Tsirkin wrote:
> > Hello!
> > Currently, on the x86_64 architecture, its quite tricky to make
> > a char device ioctl work for an x86 executables.
> > In particular,
> >    1. there is a requirement that ioctl number is unique -
> >       which is hard to guarantee especially for out of kernel modules
> 
> Yes, that is a problem for some people. But you should
> have used an unique number in the first place.

Do you mean the _IOC macro and friends?
But their uniqueness depends on allocating a unique magic number
in the first place.

> There are some hackish ways to work around it for non modules[1], but at some
> point we should probably support it better.
> 
> [1] it can be handled, except for module unloading, so you have
> to disable that.

Why use the global hash at all?
Why not, for example, pass a parameter to the ioctl function
to make it possible to figure out this is a compat call?

> >    2. there's a performance huge overhead for each compat call - there's
> >       a hash lookup in a global hash inside a lock_kernel -
> >       and I think compat performance *is* important.
> 
> Did you actually measure it? I doubt it is a big issue.
> 

But that would depend on what the driver actually does inside
the ioctl and on how many ioctls are already registered, would it not?

I built a silly driver example which just used a semaphore and a switch
statement inside the ioctl.

~/<1>tavor/tools/driver_new>time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.357u 4.760s 0:05.11 100.0%    0+0k 0+0io 0pf+0w
~/<1>tavor/tools/driver_new>time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.641u 6.486s 0:07.12 100.0%    0+0k 0+0io 0pf+0w

So just looking at system time there seems to be an overhead of
about 20%.
The overhead is bigger if there are collisions in the hash.

For muti-processor scenarious, the difference is much more pronounced
(note I have dual-cpu Opteron system):

~>time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0 & ;time /tmp/ioctltest32
/dev/mst/mt23108_pci_cr0 &
[2] 10829
[3] 10830
[2]    Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.435u 21.322s 0:21.76 99.9%    0+0k 0+0io 0pf+0w
[3]    Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.683u 21.231s 0:21.92 99.9%    0+0k 0+0io 0pf+0w
~>


~>time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0 & ;time /tmp/ioctltest64
/dev/mst/mt23108_pci_cr0 &
[2] 10831
[3] 10832
[3]    Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.474u 11.194s 0:11.70 99.6%    0+0k 0+0io 0pf+0w
[2]    Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.476u 11.277s 0:11.75 99.9%    0+0k 0+0io 0pf+0w
~>

So we get 50% slowdown.
I imagine this is the result of BKL contention during the hash lookup.

MST
