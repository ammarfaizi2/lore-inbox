Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264540AbUFRXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264540AbUFRXhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUFRXdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 19:33:02 -0400
Received: from cfcafw.sgi.com ([198.149.23.1]:40481 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265743AbUFRXbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:31:32 -0400
Date: Fri, 18 Jun 2004 18:31:27 -0500
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
In-Reply-To: <20040619000326.067c3ff6.ak@suse.de>
Message-ID: <Pine.SGI.4.58.0406181758200.5029@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
 <20040619000326.067c3ff6.ak@suse.de>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Andi Kleen wrote:

> On Fri, 18 Jun 2004 15:03:00 -0500
> Brent Casavant <bcasavan@sgi.com> wrote:
>
> > On 2.6 based systems, the top command utilizes /proc/[pid]/wchan to
> > determine WCHAN symbol name information.  This information is provided
> > by the kernel function kallsyms_lookup(), which expands a stem-compressed
>
> That sounds more like a bug in your top to me. /proc/*/wchan itself
> does not access kallsyms, it just outputs a number.

Strange.  All the 2.6 boxes I have access to output a symbol name.
I've checked on Debian, SLES9, and Fedora Core 2.  It's not
impossible that I have the same whacked-out configuration on all of
them, but they definitely output symbol names, not just numbers.

> My top doesn't do that.

Hmm.  procps version 3.1.3 introduced the use of /proc/*/wchan where
possible.  I'm using 2.0.13 normally, which appears to have the same
behavior (can't find a changelong for the 2 series at the moment).
Is it your recommendation that I take this up with the maintainers of
procps?

> Are you saying your top reads /proc/kallsyms on each redisplay?
> That sounds completely wrong - it should only read the file once
> and cache it and then look the numbers it is reading from wchan
> in the cache.

It would appear so from the performance improvements I observed upon
implementing this cache.

> Doing the cache in the kernel is the wrong place. This should be fixed
> in user space.

Hard to disagree with that -- as long as we're getting an address
out of the wchan file.  But that seems to be a point of some debate. :)
I'll have to get to the bottom of that next Monday (too tired to
think straight at the moment).

> As an unrelated comment: i would suggest to avoid rwlocks until
> absolutely needed. They are a lot slower than regular spinlocks.

The lock isn't very highly contended at all, and assuming the cache
hits almost all of the time, the rwlock seemed better as it would
cause the minimum amount of waiting.  That said, my first implementation
used spinlocks, and the difference in performance was lost in the
noise -- meaning we could really go either way and make little
difference which style of lock was used.

Thanks,
Brent

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
