Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbWHWXjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbWHWXjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 19:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965189AbWHWXjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 19:39:52 -0400
Received: from rune.pobox.com ([208.210.124.79]:3566 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S965066AbWHWXjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 19:39:52 -0400
Date: Wed, 23 Aug 2006 18:39:44 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, anton@samba.org, simon.derr@bull.net,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-ID: <20060823233944.GG11309@localdomain>
References: <20060821132709.GB8499@krispykreme> <20060821104334.2faad899.pj@sgi.com> <20060821192133.GC8499@krispykreme> <20060821140148.435d15f3.pj@sgi.com> <20060821215120.244f1f6f.akpm@osdl.org> <20060822050401.GB11309@localdomain> <20060821221437.255808fa.pj@sgi.com> <20060823221114.GF11309@localdomain> <20060823153952.066e9a58.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823153952.066e9a58.pj@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nathan wrote:
> > How about this? 
> 
> The code likely works, and the locking seems ok at first blush.
> And this patch seems to match just what I asked for ;).
> 
> But the more I think about this, the less I like this direction.
> 
> Your patch, and what I initially asked for, impose a policy and create
> a side affect.  When you bring a cpu online, the top cpuset changes as
> a side affect, in order to impose a policy that the top cpuset tracks
> what is online.
> 
> The kernel should avoid such side affects and avoid imposing policy.

If you want to call that a policy that's fine, but it hardly seems to
be a non-intuitive behavior to me, especially in the case that the
administrator has not explicitly configured any cpusets.


> It should be user code that imposes the policy that the top cpuset
> tracks what is online.
> 
> The kernel gets things going with reasonable basic defaults at system
> boot, then adapts to whatever user space mandates from then on.
> 
> Kernels should provide generic, orthogonal mechanisms.

Maybe the cpuset code should just stay out of the way unless the admin
has instantiated one?


> Let user space figure out what it wants to do with them.

The user who initially reported this probably has no idea what cpusets
are or how to deal with the situation.


> It is not a kernel bug that the top cpuset doesn't track what is
> online.

It's a bug that one's ability to bind a task to a new cpu is entirely
dependent on whether you know your way around cpusets.  Doesn't sound
orthogonal to me.

Try looking at it this way.  You have an application that works on
distro x, where cpu hotplug is supported but cpusets is not enabled in
the kernel config.  That application is cpu hotplug-aware, and binding
a task to a new cpu just works.  Now, with distro x+1, cpusets is
enabled and that same scenario doesn't work anymore.  That's generally
viewed as a regression.

And no, I don't like pushing the responsibility for fixing up the
top-level cpuset out to userspace -- that would force apps to
busy-wait (and for how long?) for the new cpu to be added to the
top-level cpuset by the hotplug helper.  It means something as simple
as this:

# echo 1 > /sys/devices/system/cpu/cpu3/online
# taskset 0x8 foo

has a race condition, depending on your kernel's configuration.

