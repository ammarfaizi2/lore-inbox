Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWAXIc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWAXIc7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030371AbWAXIc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:32:59 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:18838
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030370AbWAXIc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:32:59 -0500
Message-Id: <43D5F44C.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 24 Jan 2006 09:33:00 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tvec_bases too large for per-cpu data
References: <43CE4C98.76F0.0078.0@novell.com> <20060120232500.07f0803a.akpm@osdl.org> <43D4BE7F.76F0.0078.0@novell.com> <20060123025702.1f116e70.akpm@osdl.org>
In-Reply-To: <20060123025702.1f116e70.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Did you consider using alloc_percpu()?
>> 
>> I did, but I saw drawbacks with that (most notably the fact that all instances are allocated at
>> once, possibly wasting a lot of memory).
>
>It's 4k for each cpu which is in the possible_map but which will never be
>brought online.  I don't think that'll be a lot of memory - are there
>machines which have a lot of possible-but-not-really-there CPUs?

I would suppose so. Why wouldn't a machine supporting CPU hotplug not reasonably be able to double,
triple, etc the number of CPUs originally present?

>There _must_ be ordering issues.  Otherwise we'd just dynamically allocate
>all the structs up-front and be done with it.
>
>Presumably the ordering issue is that init_timers() is called before
>kmem_cache_init().  That's non-obvious and should be commented.

That I can easily do, sure.

>- The `#ifdef CONFIG_NUMA' in init_timers_cpu() seems to be unnecessary -
>  kmalloc_node() will use kmalloc() if !NUMA.

That is correct, but I wanted the fallback if kmalloc_node() fails (from briefly looking at that code it didn't
seem like it would do such fallback itself). And calling kmalloc() twice if !NUMA seemed pointless.

>- The likely()s in init_timers_cpu() seems fairly pointless - it's not a
>  fastpath.

OK, will change that.

>- We prefer to do this:
>
>	if (expr) {
>		...
>	} else {
>		...
>	}
>
>  and not
>
>	if (expr) {
>		...
>	}
>	else {
>		...
>	}

I can change that, too, but I don't see why this gets pointed out again and again when there really
is no consistency across the entire kernel...

Jan
