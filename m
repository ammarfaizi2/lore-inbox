Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVC3HZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVC3HZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 02:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVC3HZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 02:25:19 -0500
Received: from smtp.istop.com ([66.11.167.126]:7868 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261797AbVC3HYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 02:24:32 -0500
From: Daniel Phillips <phillips@istop.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC] DDRaid higher level cluster raid
Date: Wed, 30 Mar 2005 02:30:18 -0500
User-Agent: KMail/1.7
Cc: linux-cluster@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503300230.19017.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am pleased to be able to present today an interesting project that has kept 
me busy for the last couple of months.

DDRaid is a cluster block device that, together with a cluster filesystem like 
GFS, gives you the ability to operate a "distributed data cluster" where the 
cluster data is distributed redundantly over the nodes of a cluster rather 
than using a single, shared disk.  You could also use ddraid with iscsi or 
fiber channel disks, and it even works reasonably well as a local software 
raid.  But the interesting thing about it to me is the distributed data 
aspect.

As far as I know, ddraid is the first higher level cluster raid, or if that is 
not correct, it is certainly the first to appear as open source.  It is based 
on Raid 3.5, a simple raid scheme I investigated earlier, and presented a 
paper on at Linux Kongress 2002:

   http://sourceware.org/cluster/ddraid/raid35.pdf

Raid 3.5 has the attractive property that it can be implemented without any 
caching or read-before-write, which is very important for a cluster.  Cluster 
caching is a wretchedly complex affair that is normally implemented at a 
higher level by the cluster filesystem and/or vfs.  We certainly do not want 
to have two wretchedly complex layers of cluster caching if we can avoid it. 
This is what you would get by extending Raid 5, say, to operate across a 
cluster.

My Raid 3.5 scheme turned out to work pretty well.  Some initial benchmarks 
were posted yesterday, here:

   https://www.redhat.com/archives/linux-cluster/2005-March/msg00112.html

The executive summary is that on an ideal linear load, ddraid runs about 62% 
faster than a single raw disk.  An example of such a linear load is copying a 
large file.  On random IO loads, ddraid performs no worse than a single raw 
disk.  Of course, increased performance is only the secondary goal of ddraid.  
The primary goal is data redundancy.

Further details on ddraid were provided in the initial project announcement, 
and I will not repeat them here:

   https://www.redhat.com/archives/linux-cluster/2005-March/msg00034.html

My purpose today is twofold: to solicit feedback on some of the kernel issues 
in the ddraid driver, and to introduce some relatively approachable cluster 
code that is easy to install and try out, even if you don't have a cluster.  
In other words, I would like to begin the process of involving more of the 
kernel community in cluster issues.  The ddraid driver is a rather nice test 
case for this, because it touches on most of the interesting cluster issues 
without being particularly big and complex.

Let me start by defining the difference between a cluster block device and a 
non-cluster block device.  It is not necessarily what you would think.  For 
example, you can export a block device over the network, but that does not 
make it a cluster block device: you can still only mount one filesystem at a 
time on it.

Here are some of the things we expect of a cluster block device:

  * Since multiple nodes can access the device simultaneously, the cluster
    block device may need to prevent these accesses from interfering in
    situations that the cluster filesystem itself has no knowledge of and
    therefore cannot handle.

  * If the cluster block device has its own metadata, access to the metadata
    must be synchronized across the cluster

  * Cluster control: The cluster block device needs to respond to management
    commands arriving from other nodes.  For example, so that a instance of
    the device may be created simultaneously on all nodes of the cluster, and
    each instance will know how to access the same underlying hardware
    resources.

  * Fault tolerance: If the block device relies on services provided by other
    nodes, those services need to be able to fail over to other nodes in the
    event a node fails.  If a connection is temporarily broken, the cluster
    block device should be able to resume operation without failing any IO.

A cluster block device does not need to or should not provide:

  * Caching and cache synchronization.  Except for its own metadata, a cluster
    block device should let the cluster filesystem and vfs take care of this.

  * Multiple access.  Every block device already provides this, albeit not
    necessarily safely.

A cluster block device may use a cluster lock manager (e.g., gdlm) to 
implement whatever synchronization it needs.  I did not use this approach 
myself.  Instead I used streaming message based synchronization over standard 
sockets, something like DBus.  I did this for efficiency, but it also has the 
attractive side effect of avoiding a dependency on any particular cluster 
lock manager.  Instead I depend only on sockets.

Which brings up an issue.  I implement socket failover by arranging for a 
userspace process to open a new link and pass it to the kernel driver using 
SCM_RIGHTS.  I don't think I can do that with netlink.  So I use PF_UNIX, and 
kludge that to work in-kernel with what you might call user-space-in-kernel 
hacks.  I would like to clean this up one way or another.  I would appreciate 
feedback both on the strategy of passing a socket link to the kernel, and how 
I might clean up the PF_UNIX interface if that turns out to be the only way 
to do it.

Here is the ddraid kernel patch.  Look for SCM_RIGHTS, appreciate the full 
unadulterated ugliness:

   http://sourceware.org/cluster/ddraid/ddraid-2.6.11.3

Besides passing socket fds to the kernel, I use the PF_UNIX interface to 
control the raid device and to allow it to report error conditions such as 
broken links.  I use an anonymous socket for this purpose, which in itself is 
completely insecure.  I presume that I must pass credentials in order to 
secure this link, which is not yet in the patch.  Or is there some other 
standard way?

I like the convenience of anonymous sockets quite a lot.  However, it is not 
clear to me how to prevent or deal with collisions in the anonymous socket 
name space.  I would appreciate guidance on that.  I could always fall back 
to filesystem-based sockets, though I do not like having to delete the socket 
before using it.  The current code will work with either.

One big problem I find with sockets is shutting them down reliably, so that 
daemons waiting on them will unblock and the device mapper device can be 
removed.  The userspace socket shutdown facility relies on signals.  
In-kernel, I would have to explicitly field signals in order to make this 
interface work.  This falls rather short of elegant.  I would like to do 
something about the socket shutdown problem.  It would be very nice to be 
able to shut down a socket simply and reliably from within the kernel.

A huge, horrible, gaping wound of a problem, far from limited to ddraid, is 
memory inversion.  DDRaid uses a userspace server for synchronization.  The 
server may try to allocate working memory under low memory conditions, but 
the server sits in the block IO path.  If memory happens to be full of dirty 
data that needs to be written out over the ddraid device, we are in trouble.  
Moving the server into the kernel would not avoid the problem, because the 
real problem is that a process in PF_MEMALLOC state is being serviced by a 
process not in PF_MEMALLOC state, which just happens to be a user space 
process.  We could easily create a similar situation entirely within the 
kernel, and in fact, the ddraid driver is full of such situations.

Something coherent needs to be done about this.  This is not an easy problem 
at all, and ddraid is far from the only kernel code that suffers from it.

Here is a tarball, complete with kernel patch:

   http://sourceware.org/cluster/ddraid/ddraid.0.0.1.tgz

This is a snapshot as of yesterday's benchmarks.  There is little or no 
documentation on how to build and operate this subsystem, a deficiency I will 
correct shortly.  The tarball is designed to be unpacked into the root of a 
2.6.11.3 tree.  Userspace code will end up in a subdirectory of drivers/md, 
which is not where it is supposed to live permanently, but is how I prefer to 
work at this point.  Test code is driven by the same makefile that builds the 
userspace code.  The makefile is about all there is for documentation.

The code is in various states of disrepair, especially the ddraid server which 
was a quick hack done over a few days, and not simple at all.  How it works 
is an intersting subject in its own right.  The kernel code itself has 
moments of lucidity, but is also terminally crufty in places.  It reinvents 
some infrastructure that already exists, like work queues.  There are bugs, 
two that I know of.  SMP hasn't been tested at all, nor has big endianness 
(which is guaranteed not to work) or 64 bit builds.  There are masses of 
unhandled error conditions.  All that said, it is functional code, if you 
hold your tongue right.

The ddraid project page is here:

   http://sourceware.org/cluster/ddraid

If you are going to be at LCA in Canberra next month, I cordially invite you 
to attend my talk, where I will present a paper on ddraid.  (Rusty, if you 
are reading, it _was_ supposed to be a cluster mirror paper, but it evolved.)

Regards,

Daniel
