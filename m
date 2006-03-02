Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWCBB5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWCBB5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWCBB5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:57:45 -0500
Received: from ns2.suse.de ([195.135.220.15]:30912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751377AbWCBB5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:57:44 -0500
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
Date: Thu, 2 Mar 2006 02:57:28 +0100
User-Agent: KMail/1.9.1
Cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com> <200603012221.37271.ak@suse.de> <Pine.LNX.4.64.0603011411190.31997@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603011411190.31997@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603020257.29234.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 23:20, Christoph Lameter wrote:

> Interleave is only beneficial for special applications that use a common 
> pool of data and that implement no other means of locality control. At 
> that point we sacrifice the performance benefit that comes with node locality
> in order not to overload a single node. 

My rationale is the locality is only important for cache lines that
are very frequently accessed.   By far the most frequently accessed
items is user space data, system calls are still relatively rare
compare to that and system calls that touch files even less
so 

(often in my measurements 40% and more of all syscalls are gettimeofday 
actually)

Also we don't have very good balancing control on dcaches.

The problem is when one node runs updatedb or similar it will
end up allocating a lot of these objects, and then later when
a process ends up on that node it can have trouble allocating
node local memory (and a user process missing local memory is
typically much worse than a kernel object)

I guess your remote claim changes will help, but I'm not 
convinced they are the best solution.

[hmm, actually didn't we discuss this once at length anyways.
Apparently I failed to convince you back then @:]

> 
> Kernels before 2.6.16 suffer from special overload situations that are due 
> to not having the ability to reclaim the pagecache and the slab cache. 

Reclaiming is slow. Better not dig into this hole in the first place.

> > I would be in favour of it
> 
> Please run performance tests with single threaded processes if you 
> do not believe me before doing any of this.

Sure. But the motivation is less the single thread performance
anyways, but more the degradation under extreme loads.

-Andi
