Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbWAWK5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWAWK5X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWAWK5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:57:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56753 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751355AbWAWK5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:57:23 -0500
Date: Mon, 23 Jan 2006 02:57:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tvec_bases too large for per-cpu data
Message-Id: <20060123025702.1f116e70.akpm@osdl.org>
In-Reply-To: <43D4BE7F.76F0.0078.0@novell.com>
References: <43CE4C98.76F0.0078.0@novell.com>
	<20060120232500.07f0803a.akpm@osdl.org>
	<43D4BE7F.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> >>> Andrew Morton <akpm@osdl.org> 21.01.06 08:25:00 >>>
> >"Jan Beulich" <JBeulich@novell.com> wrote:
> >>
> >> The biggest arch-independent consumer is tvec_bases (over 4k on 32-bit
> >>  archs,
> >>  over 8k on 64-bit ones), which now gets converted to use dynamically
> >>  allocated
> >>  memory instead.
> >
> >ho hum, another pointer hop.
> >
> >Did you consider using alloc_percpu()?
> 
> I did, but I saw drawbacks with that (most notably the fact that all instances are allocated at
> once, possibly wasting a lot of memory).

It's 4k for each cpu which is in the possible_map but which will never be
brought online.  I don't think that'll be a lot of memory - are there
machines which have a lot of possible-but-not-really-there CPUs?

> >The patch does trickery in init_timers_cpu() which, from my reading, defers
> >the actual per-cpu allocation until the second CPU comes online. 
> >Presumably because of some ordering issue which you discovered.  Readers of
> >the code need to know what that issue was.
> 
> No, I don't see any trickery there (on demand allocation in CPU_UP_PREPARE is being done
> elsewhere in very similar ways), and I also didn't see any ordering issues. Hence I also didn't
> see any need to explain this in detail.

There _must_ be ordering issues.  Otherwise we'd just dynamically allocate
all the structs up-front and be done with it.

Presumably the ordering issue is that init_timers() is called before
kmem_cache_init().  That's non-obvious and should be commented.

> >And boot_tvec_bases will always be used for the BP, and hence one slot in
> >the per-cpu array will forever be unused.  Until the BP is taken down and
> >brought back up, in which case it will suddenly start to use a dynamically
> >allocated structure.
> 
> Why? Each slot is allocated at most once, the BP's is never allocated (it will continue to use the
> static one even when brought down and back up).

OK, I missed the `if (likely(!base))' test in there.  Patch seems OK from
that POV and we now seem to know what the ordering problem is.

- The `#ifdef CONFIG_NUMA' in init_timers_cpu() seems to be unnecessary -
  kmalloc_node() will use kmalloc() if !NUMA.

- The likely()s in init_timers_cpu() seems fairly pointless - it's not a
  fastpath.

- We prefer to do this:

	if (expr) {
		...
	} else {
		...
	}

  and not

	if (expr) {
		...
	}
	else {
		...
	}


