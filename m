Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWHGLZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHGLZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 07:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWHGLZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 07:25:34 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28096 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750724AbWHGLZd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 07:25:33 -0400
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
Message-Id: <1154949908.29877.130.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 07 Aug 2006 21:25:09 +1000
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
> 

Reproduced on RHAS4; this patch fixes it for me.
--

knfsd: Fix a regression on an NFS client where mounting an
NFS filesystem trips a spurious BUG_ON() in the server code.
Tested using cthon04 lock tests on RHAS4-U2 userspace.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---

 net/sunrpc/svc.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc2/net/sunrpc/svc.c
===================================================================
--- linux-2.6.18-rc2.orig/net/sunrpc/svc.c
+++ linux-2.6.18-rc2/net/sunrpc/svc.c
@@ -211,6 +211,11 @@ svc_pool_map_set_cpumask(unsigned int pi
 	struct svc_pool_map *m = &svc_pool_map;
 	unsigned int node; /* or cpu */
 
+	/*
+	 * The caller checks for sv_nrpools > 1, which
+	 * implies that we've been initialized and the
+	 * map mode is not NONE.
+	 */
 	BUG_ON(m->mode == SVC_POOL_NONE);
 
 	switch (m->mode)
@@ -241,7 +246,11 @@ svc_pool_for_cpu(struct svc_serv *serv, 
 	struct svc_pool_map *m = &svc_pool_map;
 	unsigned int pidx = 0;
 
-	BUG_ON(m->mode == SVC_POOL_NONE);
+	/*
+	 * SVC_POOL_NONE happens in a pure client when
+	 * lockd is brought up, so silently treat it the
+	 * same as SVC_POOL_GLOBAL.
+	 */
 
 	switch (m->mode) {
 	case SVC_POOL_PERCPU:





Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


