Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265390AbUFSAJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265390AbUFSAJP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbUFSAHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:07:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:4075 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265390AbUFRX7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 19:59:36 -0400
Date: Sat, 19 Jun 2004 01:59:30 +0200
From: Andi Kleen <ak@suse.de>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Add kallsyms_lookup() result cache
Message-Id: <20040619015930.6acf773c.ak@suse.de>
In-Reply-To: <Pine.SGI.4.58.0406181758200.5029@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0406181435570.5029@kzerza.americas.sgi.com>
	<20040619000326.067c3ff6.ak@suse.de>
	<Pine.SGI.4.58.0406181758200.5029@kzerza.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 18:31:27 -0500
Brent Casavant <bcasavan@sgi.com> wrote:

> On Sat, 19 Jun 2004, Andi Kleen wrote:
> 
> > On Fri, 18 Jun 2004 15:03:00 -0500
> > Brent Casavant <bcasavan@sgi.com> wrote:
> >
> > > On 2.6 based systems, the top command utilizes /proc/[pid]/wchan to
> > > determine WCHAN symbol name information.  This information is provided
> > > by the kernel function kallsyms_lookup(), which expands a stem-compressed
> >
> > That sounds more like a bug in your top to me. /proc/*/wchan itself
> > does not access kallsyms, it just outputs a number.
> 
> Strange.  All the 2.6 boxes I have access to output a symbol name.
> I've checked on Debian, SLES9, and Fedora Core 2.  It's not
> impossible that I have the same whacked-out configuration on all of
> them, but they definitely output symbol names, not just numbers.

Yes, that was my mistake. I looked at /proc/self/wchan, which is 
probably the only one who outputs a number ...

But anyways you can get the number from /proc/*/stat like in 2.4

> 
> > My top doesn't do that.
> 
> Hmm.  procps version 3.1.3 introduced the use of /proc/*/wchan where
> possible.  I'm using 2.0.13 normally, which appears to have the same
> behavior (can't find a changelong for the 2 series at the moment).
> Is it your recommendation that I take this up with the maintainers of
> procps?

Yes. Let them revert to the 2.4 code again, only change that they
should read /proc/kallsyms instead of /boot/System.map


> 
> > Are you saying your top reads /proc/kallsyms on each redisplay?
> > That sounds completely wrong - it should only read the file once
> > and cache it and then look the numbers it is reading from wchan
> > in the cache.
> 
> It would appear so from the performance improvements I observed upon
> implementing this cache.

I straced a fairly recent SUSE top and it didn't access wchan
in normal operation. 

> 
> > As an unrelated comment: i would suggest to avoid rwlocks until
> > absolutely needed. They are a lot slower than regular spinlocks.
> 
> The lock isn't very highly contended at all, and assuming the cache
> hits almost all of the time, the rwlock seemed better as it would
> cause the minimum amount of waiting.  That said, my first implementation

When it starts to get contended the read locks tend to be slower
because they have to bounce more cache lines around.

-Andi
