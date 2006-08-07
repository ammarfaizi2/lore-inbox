Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750994AbWHGDRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbWHGDRK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 23:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbWHGDRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 23:17:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36262 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750994AbWHGDRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 23:17:09 -0400
Subject: Re: [PATCH 010 of 11] knfsd: make rpc threads pools numa aware
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@suse.de>,
       Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060806024703.2fb9f307.akpm@osdl.org>
References: <20060731103458.29040.patches@notabene>
	 <1060731004234.29291@suse.de>  <20060806024703.2fb9f307.akpm@osdl.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1154920613.29877.85.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 07 Aug 2006 13:16:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-06 at 19:47, Andrew Morton wrote:
> On Mon, 31 Jul 2006 10:42:34 +1000
> NeilBrown <neilb@suse.de> wrote:
> 
> > knfsd: Actually implement multiple pools.  On NUMA machines, allocate
> > a svc_pool per NUMA node; on SMP a svc_pool per CPU; otherwise a single
> > global pool.  Enqueue sockets on the svc_pool corresponding to the CPU
> > on which the socket bh is run (i.e. the NIC interrupt CPU).  Threads
> > have their cpu mask set to limit them to the CPUs in the svc_pool that
> > owns them.
> > 
> > This is the patch that allows an Altix to scale NFS traffic linearly
> > beyond 4 CPUs and 4 NICs.
> > 
> > Incorporates changes and feedback from Neil Brown, Trond Myklebust,
> > and Christoph Hellwig.
> 
> This makes the NFS client go BUG.  Simple nfsv3 workload (ie: mount, read
> stuff).  Uniproc, FC5.  
> 
> +	BUG_ON(m->mode == SVC_POOL_NONE);

Aha, I see what I b0rked up.  On the client, lockd starts an RPC
service via the old svc_create() interface, which avoids calling
svc_pool_map_init().  When the first NLM callback arrives,
svc_sock_enqueue() calls svc_pool_for_cpu() which BUGs out because
the map is not initialised.  The BUG_ON() was introduced in one
of the rewrites in response to review feedback in the last few
days; previously the code was simpler and would trivially return
pool 0, which is the right thing to do in this case.  The bug was
hidden on my test machines because they have SLES userspaces,
where lockd is broken because both the kernel and userspace think
the other one is doing the rpc.statd functionality.

A simple patch should fix this, coming up as soon as I can find
a non-SLES machine and run some client tests.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


