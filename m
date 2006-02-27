Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWB0CYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWB0CYg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 21:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWB0CYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 21:24:36 -0500
Received: from ns1.siteground.net ([207.218.208.2]:55211 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1750786AbWB0CYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 21:24:35 -0500
Date: Sun, 26 Feb 2006 18:25:03 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Lameter <clameter@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, clameter@sgi.com,
       manfred@colorfullife.com, mark.fasheh@oracle.com,
       alok.kataria@calsoftinc.com
Subject: Re: [PATCH] slab: Don't scan cache_cache
Message-ID: <20060227022503.GC3590@localhost.localdomain>
References: <Pine.LNX.4.58.0602240950050.16521@sbz-30.cs.Helsinki.FI> <Pine.LNX.4.64.0602240815010.20760@schroedinger.engr.sgi.com> <1140904214.11182.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140904214.11182.1.camel@localhost>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 11:50:13PM +0200, Pekka Enberg wrote:
> On Fri, 24 Feb 2006, Pekka J Enberg wrote:
> > > From: Pekka Enberg <penberg@cs.helsinki.fi>
> > 
> > Are you really seeing any measurable regression?
> 
> I haven't measured it but it seems obvious enough that especially for
> low end boxes. I don't think something more general is required because
> other static caches should use kmalloc() instead.
> 

I hope all of us mean "less used and not changing in usage over time"  when we
refer to static caches all throughout our discussion.  That said, for a
given workload,  one set of caches maybe static while the other is not
(networking loads may have networking slab caches grow and shrink, while the
fs driver caches stay static etc).  So I am not sure if static caches can
use kmalloc in general.  If scanning cache_cache is really a regression (it is
probably 1 of 15-20 other static caches on a system), then  IMHO, similar
treatment should be given to other static caches as well.  We could have a
counter on cachep (per-cpu of course) which keeps tracks of cachep usage,
and we could build logic not to scan these caches as frequently.

Now, it is not like cache_cache cannot grow at all or is absolutely static.
So not scanning just cache_cache, when SLAB_NO_REAP flag is taken out
does not make it look very good IMHO.  Sure, it was this way before, but
we had a flag to indicate so.  And if we think this is a regression, we
should generalize this for other less used caches too.

Thanks,
Kiran
