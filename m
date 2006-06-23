Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933005AbWFWKiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbWFWKiq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933007AbWFWKiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:38:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2769 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933005AbWFWKip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:38:45 -0400
Date: Fri, 23 Jun 2006 03:38:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 50/61] lock validator: special locking: hrtimer.c
Message-Id: <20060623033825.b62eec20.akpm@osdl.org>
In-Reply-To: <20060623100439.GI4889@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212709.GX3155@elte.hu>
	<20060529183556.602b1570.akpm@osdl.org>
	<20060623100439.GI4889@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:04:39 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > >  	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++)
> > > -		spin_lock_init(&base->lock);
> > > +		spin_lock_init_static(&base->lock);
> > >  }
> > >  
> > 
> > Perhaps the validator core's implementation of spin_lock_init() could 
> > look at the address and work out if it's within the static storage 
> > sections.
> 
> yeah, but there are two cases: places where we want to 'unify' array 
> locks into a single type, and places where we want to treat them 
> separately. The case where we 'unify' is the more common one: locks 
> embedded into hash-tables for example. So i went for annotating the ones 
> that are rarer. There are 2 right now: scheduler, hrtimers, with the 
> hrtimers one going away in the high-res-timers implementation. (we 
> unified the hrtimers locks into a per-CPU lock) (there's also a kgdb 
> annotation for -mm)
> 
> perhaps the naming should be clearer? I had it named 
> spin_lock_init_standalone() originally, then cleaned it up to be 
> spin_lock_init_static(). Maybe the original name is better?
> 

hm.  This is where a "term of art" is needed.  What is lockdep's internal
term for locks-of-a-different-type?  It should have such a term.

"class" would be a good term, although terribly overused.  Using that as an
example, spin_lock_init_standalone_class()?  ug.

<gives up>

You want spin_lock_init_singleton().
