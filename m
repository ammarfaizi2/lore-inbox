Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTK1OPr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTK1OPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:15:47 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:4323 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S262319AbTK1OPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:15:44 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: jbarnes@sgi.com (Jesse Barnes), steiner@sgi.com, viro@math.psu.edu,
       wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
	<20031125204814.GA19397@sgi.com>
	<20031125130741.108bf57c.akpm@osdl.org>
	<20031125211424.GA32636@sgi.com>
	<20031125132439.3c3254ff.akpm@osdl.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 28 Nov 2003 09:15:02 -0500
In-Reply-To: <20031125132439.3c3254ff.akpm@osdl.org>
Message-ID: <yq0d6bcmvfd.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

Andrew> jbarnes@sgi.com (Jesse Barnes) wrote:
>> Something like that might be ok, but on our system, all memory is
>> in ZONE_DMA...

Andrew> Well yes, we'd want

Andrew> 	vfs_caches_init(min(num_physpages,
Andrew> some_platform_limit()));

Andrew> which on ia32 would evaluate to nr_free_buffer_pages() and on
Andrew> ia64 would evaluate to the size of one of those zones.

What about something like this? I believe node_present_pages should be
the same as nym_physpages on a non-NUMA machine. If not we can make it
min(num_physpages, NODE_DATA(0)->node_present_pages).

Of course this might not work perfectly if one has multiple nodes and
node 0 has no or very little memory. It would also be nice if one
could spread the various caches onto various nodes, but we can leave
that for stage 2 ;-)

Cheers,
Jes

--- orig/linux-2.6.0-test10/init/main.c	Sun Nov 23 17:31:14 2003
+++ linux-2.6.0-test10/init/main.c	Fri Nov 28 07:06:45 2003
@@ -447,7 +447,7 @@
 	proc_caches_init();
 	buffer_init();
 	security_scaffolding_startup();
-	vfs_caches_init(num_physpages);
+	vfs_caches_init(NODE_DATA(0)->node_present_pages);
 	radix_tree_init();
 	signals_init();
 	/* rootfs populating might need page-writeback */
