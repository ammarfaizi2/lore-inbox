Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261737AbVANIrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVANIrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 03:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVANIrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 03:47:25 -0500
Received: from one.firstfloor.org ([213.235.205.2]:48324 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261737AbVANIrT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 03:47:19 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Fri, 14 Jan 2005 09:47:17 +0100
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 14 Jan 2005 00:23:52 -0800")
Message-ID: <m1zmzcpfca.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> - Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>   haven't yet taken as close a look at LTT as I should have.  Probably neither
>   have you.

I think it would be better to have a standard set of kprobes instead
of all the ugly LTT hooks. kprobes could then log to relayfs or another
fast logging mechanism.

Advantage of this would be that it had no impact on fast paths 
unless enabled (LTT slows down a kernel quite considerable just
by compiling it in) 

>   As does relayfs, IMO.  It seems to need some regularised way in which a
>   userspace relayfs client can tell relayfs what file(s) to use.  LTT is
>   currently using some ghastly stick-a-pathname-in-/proc thing.  Relayfs
>   should provide this service.
>
>   relayfs needs a closer look too.  A lot of advanced instrumentation
>   projects seem to require it, but none of them have been merged.  Lots of
>   people say "use netlink instead" and lots of other people say "err, we think
>   relayfs is better".  This is a discussion which needs to be had.

imho relayfs and netlink are for completely problem spaces.
relayfs is for relaying a lot of data quickly (e.g. for kernel
instrumentation). There it fills a niche that printk doesn't fill
(since it's too slow). netlink is quite slow (allocates data for each
event, does lots of other gunk), but an useful extensible format
for low frequency events.

For the problems that relayfs solves netlink is totally unusable
due to low efficiency (you could as well use printk, but that is
also to slow). I think a low overhead logging mechanism is very
much needed, because I find myself reinventing it quite often
when I need to debug some timing sensitive problem. Trying to 
tackle these with printk is hopeless because it changes timing too much.

The problem relayfs has IMHO is that it is too complicated. It 
seems to either suffer from a overfull specification or second system
effect. There are lots of different options to do everything,
instead of a nice simple fast path that does one thing efficiently.
IMHO before merging it should go through a diet and only keep
the paths that are actually needed and dropping a lot of the current
baggage.

Preferably that would be only the fastest options (extremly simple
per CPU buffer with inlined fast path that drop data on buffer overflow), 
with leaving out anything more complicated. My ideal is something
like the old SGI ktrace which was an extremly simple mechanism
to do lockless per CPU logging of binary data efficiently and
reading that from a user daemon.

-Andi

