Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWAWKbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWAWKbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 05:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWAWKbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 05:31:07 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:62372
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932444AbWAWKbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 05:31:06 -0500
Message-Id: <43D4BE7F.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 23 Jan 2006 11:31:11 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tvec_bases too large for per-cpu data
References: <43CE4C98.76F0.0078.0@novell.com> <20060120232500.07f0803a.akpm@osdl.org>
In-Reply-To: <20060120232500.07f0803a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 21.01.06 08:25:00 >>>
>"Jan Beulich" <JBeulich@novell.com> wrote:
>>
>> The biggest arch-independent consumer is tvec_bases (over 4k on 32-bit
>>  archs,
>>  over 8k on 64-bit ones), which now gets converted to use dynamically
>>  allocated
>>  memory instead.
>
>ho hum, another pointer hop.
>
>Did you consider using alloc_percpu()?

I did, but I saw drawbacks with that (most notably the fact that all instances are allocated at
once, possibly wasting a lot of memory).

>The patch does trickery in init_timers_cpu() which, from my reading, defers
>the actual per-cpu allocation until the second CPU comes online. 
>Presumably because of some ordering issue which you discovered.  Readers of
>the code need to know what that issue was.

No, I don't see any trickery there (on demand allocation in CPU_UP_PREPARE is being done
elsewhere in very similar ways), and I also didn't see any ordering issues. Hence I also didn't
see any need to explain this in detail.

>And boot_tvec_bases will always be used for the BP, and hence one slot in
>the per-cpu array will forever be unused.  Until the BP is taken down and
>brought back up, in which case it will suddenly start to use a dynamically
>allocated structure.

Why? Each slot is allocated at most once, the BP's is never allocated (it will continue to use the
static one even when brought down and back up).

>But all of this modification was unchangelogged and is uncommented, so I'm
>somewhat guessing here.  Please always ensure that tricksy things like this
>have complete covering comments.
>
>Also, the new code would appear to leak one tvec_base_t per cpu-unplugging?

Not really, as it would be re-used the next time a cpu with the same ID gets brought up (that
is, compared with the current situation there is generally less memory wasted unless all NR_CPUs
are brought up and then one or more down again, in which case the amount of space wasted
would equal [neglecting the slack space resulting from kmalloc's way of allocating]).

Jan
