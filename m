Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTJPTJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbTJPTJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 15:09:36 -0400
Received: from waste.org ([209.173.204.2]:39084 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263158AbTJPTJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 15:09:18 -0400
Date: Thu, 16 Oct 2003 14:08:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016190825.GQ5725@waste.org>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016102020.A7000@schatzie.adilger.int> <20031016174526.GM5725@waste.org> <20031016123828.F7000@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031016123828.F7000@schatzie.adilger.int>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 16, 2003 at 12:38:28PM -0600, Andreas Dilger wrote:
> On Oct 16, 2003  12:45 -0500, Matt Mackall wrote:
> > On Thu, Oct 16, 2003 at 10:20:20AM -0600, Andreas Dilger wrote:
> > > For Lustre we need a low-cost RNG for generating opaque 64-bit handles in
> > > the kernel.  The use of get_random_bytes() showed up near the top of
> > > our profiles and we had to invent our own low-cost crappy PRNG instead (it's
> > > good enough for the time being, but when we start working on real security
> > > it won't be enough).
> > 
> > Is this SMP? If so, how many processors? I wonder if you might be
> > running into some lock contention in the pool entropy transfer -
> > there's a lock held while mixing new samples into a given pool that
> > could potentially be a hit.
> 
> It was a 2-way SMP system.  We use the RNG a fair amount (enough to know
> that 2 CPUs can race and return the same value from get_random_bytes() ;-)

Sure this is a race and not a birthday paradox? How recent is this?
Possibly before locking was added to random.c?

> so we had to put a spinlock around our calls to that.  Even so, oprofile
> showed extract_entropy() and SHATransform() near the top of CPU users.

Ok, the lock contention would be with add_entropy_words. I've got code
that reduces calls to SHATransform for /dev/urandom, but it require
addressing the starvation issues between /dev/random and /dev/urandom first.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
