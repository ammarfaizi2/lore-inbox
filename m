Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbVLMVRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbVLMVRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVLMVRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:17:20 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49100 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030235AbVLMVRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:17:18 -0500
Date: Tue, 13 Dec 2005 13:16:56 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Eric Dumazet <dada1@cosmosbay.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
In-Reply-To: <20051213130350.464a3054.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0512131313580.23636@schroedinger.engr.sgi.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
 <439D39A8.1020806@cosmosbay.com> <20051212020211.1394bc17.pj@sgi.com>
 <20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com>
 <439EF75D.50206@cosmosbay.com> <Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
 <439F0B43.4080500@cosmosbay.com> <20051213130350.464a3054.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Paul Jackson wrote:

> By using a dedicated slab cache, I was able to make an unusual use of
> Hugh Dicken's SLAB_DESTROY_BY_RCU implementation, and access a variable
> inside the cpuset structure safely, even after that cpuset structure
> might have been asynchronously free'd.  What I read from that variable
> might well be garbage, but at least the slab would not have freed that
> page of memory entirely, inside my rcu_read_lock section.

You can accomplish the same thing by using RCU directly without using so 
much storage. (and you said so later ...)

> And when is that memory required?  On many systems, that will have
> cpusets CONFIG_CPUSET enabled, but that are not using cpusets, just
> the kmem_cache_create() will be called to create cpuset_cache, but
> -no- kmem_cache_alloc() calls done.  On those systems using cpusets,
> there might be one 'struct cpuset' allocated per gigabyte of ram, as a
> rough idea.

In this case the slab would allocate one page for the one cpuset. However, 
there are lots of control structures allocated for all nodes that would go
unused. The control structures are allocated when the slab is created.
