Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWHAEnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWHAEnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 00:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWHAEnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 00:43:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25736 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751260AbWHAEnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 00:43:40 -0400
Date: Mon, 31 Jul 2006 21:43:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: neilb@suse.de, nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 010 of 11] knfsd: make rpc threads pools numa
 aware
Message-Id: <20060731214328.5770f1a5.akpm@osdl.org>
In-Reply-To: <1154325296.21040.1850.camel@hole.melbourne.sgi.com>
References: <20060731103458.29040.patches@notabene>
	<1060731004234.29291@suse.de>
	<20060730211454.ccf803f3.akpm@osdl.org>
	<17613.35001.745409.144623@cse.unsw.edu.au>
	<1154320957.21040.1836.camel@hole.melbourne.sgi.com>
	<1154325296.21040.1850.camel@hole.melbourne.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 15:54:57 +1000
Greg Banks <gnb@melbourne.sgi.com> wrote:

> On Mon, 2006-07-31 at 14:42, Greg Banks wrote:
> > On Mon, 2006-07-31 at 14:36, Neil Brown wrote:
> > > On Sunday July 30, akpm@osdl.org wrote:
> > > > On Mon, 31 Jul 2006 10:42:34 +1000
> > > > NeilBrown <neilb@suse.de> wrote:
> > > > 
> > > > > +static int
> > > > > +svc_pool_map_init_percpu(struct svc_pool_map *m)
> > > > > +{
> > > > > +	unsigned int maxpools = num_possible_cpus();
> > > > > +	unsigned int pidx = 0;
> > > > > +	unsigned int cpu;
> > > > > +	int err;
> > > > > +
> > > > > +
> > > > 
> > > > That isn't right - it assumes that cpu_possible_map is not sparse.  If it
> > > > is sparse, we allocate undersized pools and then overindex them.
> > 
> > Umm, I think Andrew's right, num_possible_cpus() should be NR_CPUS.
> 
> How about this version of the patch?  It replaces num_possible_cpus()
> with highest_possible_processor_id()+1 and similarly for nodes.
> --
> 
> knfsd: Actually implement multiple pools.  On NUMA machines, allocate
> a svc_pool per NUMA node; on SMP a svc_pool per CPU; otherwise a single
> global pool.  Enqueue sockets on the svc_pool corresponding to the CPU
> on which the socket bh is run (i.e. the NIC interrupt CPU).  Threads
> have their cpu mask set to limit them to the CPUs in the svc_pool that
> owns them.
> 
> This is the patch that allows an Altix to scale NFS traffic linearly
> beyond 4 CPUs and 4 NICs.
> 
> Incorporates changes and feedback from Neil Brown, Trond Myklebust,
> Christoph Hellwig and Andrew Morton.
> 

Something has gone rather wrong here.

> -	serv = __svc_create(prog, bufsize, shutdown, /*npools*/1);
> +	serv = __svc_create(prog, bufsize, shutdown, npools);

__svc_create() is:

__svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
	   void (*shutdown)(struct svc_serv *serv))

so heaven knows what tree you're patching.

Incremental patches really are preferred.  So we can see what people are
monkeying with ;)

After fixing the rejects and cleaning a few things up, your proposed change
amounts to:

--- a/net/sunrpc/svc.c~knfsd-make-rpc-threads-pools-numa-aware-fix
+++ a/net/sunrpc/svc.c
@@ -116,7 +116,7 @@ fail:
 static int
 svc_pool_map_init_percpu(struct svc_pool_map *m)
 {
-	unsigned int maxpools = num_possible_cpus();
+	unsigned int maxpools = highest_possible_processor_id() + 1;
 	unsigned int pidx = 0;
 	unsigned int cpu;
 	int err;
@@ -136,6 +136,18 @@ svc_pool_map_init_percpu(struct svc_pool
 	return pidx;
 };
 
+static int
+highest_possible_node_id(void)
+{
+	unsigned int node;
+	unsigned int highest = 0;
+
+	for_each_node(node)
+		highest = node;
+
+	return highest;
+}
+
 
 /*
  * Initialise the pool map for SVC_POOL_PERNODE mode.
@@ -144,7 +156,7 @@ svc_pool_map_init_percpu(struct svc_pool
 static int
 svc_pool_map_init_pernode(struct svc_pool_map *m)
 {
-	unsigned int maxpools = num_possible_nodes();
+	unsigned int maxpools = highest_possible_node_id() + 1;
 	unsigned int pidx = 0;
 	unsigned int node;
 	int err;
_


Which shouldn't have compiled, due to the missing forward declaration.  And
I'd be surprised if it worked very well with CONFIG_NUMA=n.  And it's
naughty to be sneaking general library functions into the sunrpc code
anyway.

Please,

- Write a standalone patch which adds highest_possible_node_id() to
  lib/cpumask.c(?)

  Make sure it's inside #ifdef CONFIG_NUMA

  Remember to export it to modules.

  Provide a !CONFIG_NUMA version in include/linux/nodemask.h which just
  returns constant zero.

  Consider doing something more efficient than the for_each_node() loop. 
  Although I'm not sure what that would be, given that we don't have
  find_last_bit().

- Provide an incremental patch against
  knfsd-make-rpc-threads-pools-numa-aware.patch which utilises
  highest_possible_node_id().

  A replacement patch will be grudgingly accepted, but I'll only go and
  turn it into an incremental one, so you can't hide ;)

- Test it real good.  Modular, non-modular, NUMA, non-NUMA, !SMP.

Thanks.
