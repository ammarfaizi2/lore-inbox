Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTJCINT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263594AbTJCINT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:13:19 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:5314 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263592AbTJCINM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:13:12 -0400
To: Herbert Poetzl <herbert@13thfloor.at>
cc: linux-kernel@vger.kernel.org, vserver@solucorp.qc.ca,
       xen-devel@lists.sourceforge.net
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-Reply-To: Your message of "Fri, 03 Oct 2003 03:59:23 +0200."
             <20031003015923.GA5080@DUK2.13thfloor.at> 
Date: Fri, 03 Oct 2003 09:13:10 +0100
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1A5L3m-0003vr-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > One of the main differences is that we provide resource isolation, so
> > that each virtual machine only gets the resources that its sponsor
> > paid for. This allows companies providing virtual servers to
> > provide differentiated service according to the amount paid.
>
> although the resources are usually shared in vserver environments
> (this _is_ considered an advantage) Jacques' VServers allow the
> administrator to limit the resources available to each virtual
> server (like memory, file handles, processes, cpu power and disk
> space), which should provide similar functionality ...

Jacques' VServers patch is really nice work, and we've got quite
a bit of experience using it. However, the level of isolation it
provides between different users is actually pretty low. It might
be OK for a machine with broadly co-operative users, but
its pretty easy for a malicious user to hose the machine, e.g. by
causing the OS to do huge amounts of work on its behalf.

It's very tough to do real isolation within a 'nix kernel. There
are just so many interactions between processes that can cause
"QoS crosstalk" e.g. competition for locks and shared resources such
as the buffer cache.

Ensim's 'private virtual server' product is the most complete
attempt at doing this that I've heard of. They've made a real
effort to account memory usage, even in the buffer cache. I'm
still sceptical as to whether it could provide isolation in the
presence of malicious user. 

We built Xen for use in the XenoServers project, which aims to
create an 'Open Infrastructure for Global Distributed Computing'.
We envisage Xenoserver execution platforms scattered across the
globe and available for any member of the public to execute code
on.  The sponsor of the code will be billed for all the resources
used or reserved during the course of execution. You'd be able to
create on-demand 'dedicated servers' with tailored amounts of
RAM, CPU, net b/w, disk b/w and disk space, and run the OS of
your choice. For example, you could buy a slice of a machine to
run a counterstrike server for a few minutes while you play a
game with a couple of friends. You'd pick the server location
such as to minimize the maximum RTT between the server and the
players.

In this kind of environment, we need to ensure people get what
they pay for, and hence we really care about isolation.  Our
approach with Xen is to provide guest OSes with strict minimum
resource guarantees, but enable them to make use of resources
that are otherwise idle on a proportional best-effort basis. For
example, we have plans to allow currently unallocated memory to
be used by domains as a 'last chance' swap cache, or as a shared
buffer cache for files accessed from a special network file
filesystem (based on OpenAFS). This way, we get most of the
benefits of sharing back, but in a controlled fashion.

The actual CPU overhead of having multiple operating systems is
actually very small. In the SOSP paper we show results for an
application running on 128 guests OSes vs. running 128 copies on
the same OS. There's a memory overhead of running multiple guest
OSes, but it's only ~20KB per-guest in Xen, and a couple of MB
for a Linux kernel and its non-pageable data structures.

As Keir says, the vservers patch applies pretty cleanly over the
xen patched linux, so you can always do a combination of both
techniques.  In fact, I know of at least one heavily used
Xen/Linux installation that has a four month uptime that has
been doing exactly this. None of the users seem to have noticed
they're running over Xen. ;-)


Ian






