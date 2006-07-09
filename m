Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161089AbWGITvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161089AbWGITvT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 15:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbWGITvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 15:51:18 -0400
Received: from thunk.org ([69.25.196.29]:17862 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1161089AbWGITvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 15:51:18 -0400
Date: Sun, 9 Jul 2006 15:51:14 -0400
From: Theodore Tso <tytso@mit.edu>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] spinlocks: remove 'volatile'
Message-ID: <20060709195114.GB17128@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	David Schwartz <davids@webmaster.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <44B0FAD5.7050002@argo.co.il> <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2006 at 12:16:15PM -0700, David Schwartz wrote:
> > Volatile is useful for non device driver work, for example VJ-style
> > channels.  A portable volatile can help to code such things in a
> > compiler-neutral and platform-neutral way.  Linux doesn't care about
> > compiler neutrality, being coded in GNU C, and about platform
> > neutrality, having a per-arch abstraction layer, but other programs may
> > wish to run on multiple compilers and multiple platforms without
> > per-platform glue layers.
> 
> 	There is a portable volatile, it's called 'pthread_mutex_lock'. It allows
> you to code such things in a compiler-neutral and platform-neutral way. You
> don't have to worry about what the compiler might do, what the hardware
> might do, what atomic operations the CPU supports, or anything like that.
> The atomicity issues I've mentioned in my other posts make any attempt at
> creating a 'portable volatile' for shared memory more or less doomed from
> the start.

The other thing to add here is that if you're outside of the kernel,
you *don't* want to be implementing your own spinlock if for no other
reason than it's a performance disaster.  The scheduler doesn't know
that you are spinning waiting for a lock, so you will be scheduled and
burning cpu time (and energy, and heat budget) while waiting for the
the lock.  I once spent over a week on-site at a customer complaining
about Linux performance problems, and it turned out the reason why was
because they thought they were being "smart" by implementing their own
spinlock in userspace.  Bad bad bad.

So if a userspace progam ever uses volatile, it's almost certainly a
bug, one way or another.

						- Ted
