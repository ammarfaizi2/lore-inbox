Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVIKCqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVIKCqU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 22:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVIKCqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 22:46:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:42897 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932417AbVIKCqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 22:46:20 -0400
Date: Sat, 10 Sep 2005 19:46:08 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: ak@suse.de, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: NUMA mempolicy /proc code in mainline shouldn't have been merged
In-Reply-To: <20050910175901.7af1e437.akpm@osdl.org>
Message-ID: <Pine.LNX.4.62.0509101904070.20145@schroedinger.engr.sgi.com>
References: <200509101120.19236.ak@suse.de> <20050910023337.7b79db9a.akpm@osdl.org>
 <Pine.LNX.4.62.0509100921260.17110@schroedinger.engr.sgi.com>
 <20050910175901.7af1e437.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Sep 2005, Andrew Morton wrote:

> > Well its ugly because you said that the fixes to make it less ugly were 
> > "useless". I can still submit those fixes that make numa_maps a part of 
> > smaps and that cleanup the way policies are displayed.
> 
> It would be useful to see these.

URLs (these are not up to date and in particular the conversion
functions are much simpler in recent versions thanks to some help by
Paul Jackson since then)

http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.3/1662.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.3/1663.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0507.3/1665.html


> > > >  - it presents lots of kernel internal information and mempolicy
> > > >  internals (like how many people have a page mapped) etc.
> > > >  to userland that shouldn't be exposed to this.
> > Very important information.
> Important to whom?  Kernel developers or userspace developers?  If the
> latter, what use do they actually make of it?  Shouldn't it be documented?

Both. System administrators would like to know on which node an 
application has allocated memory. They would also like to change the way 
applications do allocate memory while they are running but Andi has 
philosophical concerns about that and will not even discuss methods to fix 
the design issues in order to make that possible. Got a couple here ready 
pull out if an opportunity arises.

> > Could you be more specific? The application is to figure out how memory is 
> > placed. Just to cat /proc/<pid>/numa_maps. Seems to be a favorite with 
> > some people.
> If it's useful to application developers then fine.  It it's only useful to
> kernel developers then the argument is weakened.  However there's still
> quite a lot of development going on in this area, so there's still some
> argument for having the monitoring ability in the mainline tree.

I still have a hard time to see how people can accept the line of 
reasoning that says:

 Users are not allowed to know on which nodes the operating system 
 allocated resources for a process and are also not allowed to see the 
 memory policies in effect for the memory areas

Then the application developers have to guess the effect that the memory 
policies have on memory allocation. For memory alloc debugging the poor 
app guys must today simply imagine what the operating system is doing. 
They can see the amount of total memory allocated on a node via other proc 
entries and then guess based on that which application has taken it. Then 
they modify their apps and do another run. 

My thinking today is that I'd rather leave /proc/<pid>/numa_stats 
instead of using smaps because the smaps format is a bit verbose and 
will make it difficult to see the allocation distribution. If we use smaps
then we probably need some tool to parse and present information. 
numa_stats is directly usable.

I have a new series of patches here that does a gradual thing with
the policy layer:

1. Clean up policy layer to properly use node macros instead of bitmaps.
   Some comments to explain certain limitations of the policy layer.

2. Clean up policy layer by doing do_xx and sys_xx separation
   [optional but this separates the dynamic bitmaps in user space from
   the static node maps in kernel space which I find very helpful]

3. Add mpol_to_str to policy layer and make numa_stats use mpol_to_str.

4. Solve the potential access issue when set_mempolicy is 
   updating task->mempolicy while numa_stats are being displayed by taking 
   a writelock on mmap_sem in set_mempolicy. This is in harmony with vma 
   mempolicy updates that also take a lock on mmap_sem and that are already
   safe to access since numa_stats always takes an mmap_sem readlock. The 
   patch is essentially inserting two lines.

Then I still have these evil intentions of making it possible to 
dynamically change memory policies from the outside. The mininum 
that we all need is to least be able to see whats going on.

Of course we would be happier if we would also be allowed to change 
policies to control memory allocation. The argument that the layer is not 
able to handle these is of course true since attempts to fix the issues 
have been blocked.
