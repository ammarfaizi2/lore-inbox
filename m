Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbUCZFP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 00:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbUCZFP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 00:15:58 -0500
Received: from waste.org ([209.173.204.2]:65201 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263941AbUCZFPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 00:15:54 -0500
Date: Thu, 25 Mar 2004 23:15:32 -0600
From: Matt Mackall <mpm@selenic.com>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: potential /dev/urandom scalability improvement
Message-ID: <20040326051532.GA4754@waste.org>
References: <20040325141923.7080c6f0.akpm@osdl.org> <20040325224726.GB8366@waste.org> <16483.35656.864787.827149@napali.hpl.hp.com> <20040325180014.29e40b65.akpm@osdl.org> <20040326041926.GG8366@waste.org> <16483.46826.466847.77987@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16483.46826.466847.77987@napali.hpl.hp.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 08:51:54PM -0800, David Mosberger wrote:
> >>>>> On Thu, 25 Mar 2004 22:19:26 -0600, Matt Mackall <mpm@selenic.com> said:
> 
> >  struct entropy_store {
> > +	/* mostly-read data: */
> > +	struct poolinfo poolinfo;
> > +	__u32		*pool;
> > +
> > +	/* read-write data: */
> > +	spinlock_t lock ____cacheline_aligned;
> >  	unsigned	add_ptr;
> >  	int		entropy_count;
> >  	int		input_rotate;
> > -	struct poolinfo poolinfo;
> > -	__u32		*pool;
> > -	spinlock_t lock;
> >  };
> 
>   Matt> Also, I think in general we'd prefer to stick the aligned bit at the
>   Matt> front of the structure rather than at the middle, as we'll avoid extra
>   Matt> padding. The size of cachelines is getting rather obscene on some
>   Matt> modern processors.
> 
> Not sharing the cacheline between the mostly-read data and the
> read-write data is the _point_ of this change.  If you reverse the
> order, the "poolinfo" and "pool" members will also get invalidated
> whenever someone updates the write-intensive data.

Ok, previous observation made no sense; I should really be taking a
nap right now. Hopefully this next one will make more sense: it ought
to be ____cacheline_aligned_in_smp as the zero-byte spinlock struct
still forces alignment.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
