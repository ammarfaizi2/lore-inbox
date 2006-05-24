Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWEXFrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWEXFrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWEXFrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:47:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56984 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932218AbWEXFro (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:47:44 -0400
Date: Wed, 24 May 2006 15:47:23 +1000
From: David Chinner <dgc@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Per-superblock unused dentry LRU lists.
Message-ID: <20060524054723.GF7418631@melbourne.sgi.com>
References: <20060524012412.GB7412499@melbourne.sgi.com> <1148435980.3049.11.camel@laptopd505.fenrus.org> <20060524040142.GC7418631@melbourne.sgi.com> <1148444589.3049.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148444589.3049.26.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 06:23:09AM +0200, Arjan van de Ven wrote:
> On Wed, 2006-05-24 at 14:01 +1000, David Chinner wrote:
> > Yup, that is what the current code I've written will do. I just
> > wanted someting that worked over all superblocks to begin with.
> > It's not very smart, but improving it can be done incrementally.
> 
> I think that if you say A you should say B, I mean, if you make the list
> per SB you probably just should do the step and make at least the
> counter per SB as well. That will also save in cacheline bounces I
> suppose...  but more importantly you keep the counters next to the list.

But it doesn't remove the need for the global counter. The
dcache_lock is far more heavily contended so the counter cacheline
bouncing is lost in the noise here. No to mention the counter can
only be updated while holding the dcache_lock.  Hence at this point,
adding per-sb counters is pure overhead unless the reclaim method
is made to use them.

> Which you'll also need to do any kind of scaling I suppose later on, so
> might as well keep the stats already.

The per-sb list improves scalability only by reducing the maximum
length of time the dcache_lock is held. Scalabilty for further
parallelism (and therefore better reclaim performance) is going to
require locking changes so that's when I'd expect the counters to
need changing. I don't want to over-optimise before we know what we
actually need to optimise...

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
