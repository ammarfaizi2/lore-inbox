Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161310AbWG1V0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWG1V0u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWG1V0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:26:50 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:27808 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161310AbWG1V0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:26:49 -0400
Date: Fri, 28 Jul 2006 14:26:16 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Thomas Gleixner <tglx@linutronix.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, alokk@calsoftinc.com
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
In-Reply-To: <20060728211227.GB3739@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607281422370.21238@schroedinger.engr.sgi.com>
References: <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
 <1154067247.27297.104.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
 <1154117501.10196.2.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
 <1154118476.10196.5.camel@localhost.localdomain> <1154118947.10196.10.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com>
 <1154119658.10196.17.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607281344410.20754@schroedinger.engr.sgi.com>
 <20060728211227.GB3739@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006, Ravikiran G Thirumalai wrote:

> Why should there be any problem taking the remote l3 lock?  If the remote
> node does not have cpu that does not mean we cannot take a lock from the
> local node!!! 
> 
> I think current git does not teach lockdep to ignore recursion for
> array_cache->lock when the array_cache->lock are from different cases.  As
> Arjan pointed out, I can see that l3->list_lock is special cased, but I
> cannot find where array_cache->lock is taken care of.

Ok.
 
> Again, if this is indeed a problem (recursion) machine should not boot even,
> when compiled without lockdep, tglx, can you please verify this?

We seem to be fine on that level.

I would still like to see someone thinking through this a bit more.

Allocations via page_alloc_node() may be redirected by cpusets and 
because nodes are low on memory. This means that we get memory on a 
different node than we requested. How does that impact the alien lock 
situation? In particular what happens if the off slab allocation for 
the management object was on a different node from the slab data?
