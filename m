Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVLMRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVLMRme (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVLMRmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:42:33 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:44265 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751176AbVLMRmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:42:33 -0500
Date: Tue, 13 Dec 2005 09:42:19 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       Simon.Derr@bull.net, ak@suse.de
Subject: Re: [PATCH] Cpuset: rcu optimization of page alloc hook
In-Reply-To: <439EF75D.50206@cosmosbay.com>
Message-ID: <Pine.LNX.4.62.0512130938130.22803@schroedinger.engr.sgi.com>
References: <20051211233130.18000.2748.sendpatchset@jackhammer.engr.sgi.com>
 <439D39A8.1020806@cosmosbay.com> <20051212020211.1394bc17.pj@sgi.com>
 <20051212021247.388385da.akpm@osdl.org> <20051213075345.c39f335d.pj@sgi.com>
 <439EF75D.50206@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Dec 2005, Eric Dumazet wrote:

> Say you move to read mostly most of struct kmem_cache *, they are guaranteed
> to stay in 'mostly read'.

True but then this variable is not frequently read. So false sharing would 
not have much of an impact.

> Mixing for example filp_cachep and dcache_lock in the same cache line is not a
> good thing. And this is what happening on typical kernel :
> 
> c04f15f0 B dcache_lock
> c04f15f4 B names_cachep
> c04f15f8 B filp_cachep
> c04f15fc b rename_lock
> 
> I do think we should have defined a special section for very hot (and written)
> spots. It's more easy to locate thos hot spots than 'mostly read and shared by
> all cpus without cache ping pongs' places...

In that case I would think we would want to place these very hot 
spots in their own cacheline and control which variables end up in 
that particular cacheline. Define a struct something {} and put all 
elements that need to go into the same cacheline into that struct. 
Then cacheline align the struct.
