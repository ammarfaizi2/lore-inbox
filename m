Return-Path: <linux-kernel-owner+w=401wt.eu-S1422833AbWLPXjc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422833AbWLPXjc (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 18:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422835AbWLPXjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 18:39:32 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:44793 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422833AbWLPXjb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 18:39:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eWZbTazTDg2B8AhydL+g5vhAQMPl5g+bVidsS28d/HJ9Yhbfu6sFFQIw3MqbCQcZVkp81rDfv7nD1JQFYuov8/9L4cAkFRomi7Nk2rgkhrM7hnBBHiPTTD+94k4XhNBMIW522Xi+7zAqvx5d5/RpmA5Bjy+AAuSkBZNtG3W8gXg=
Message-ID: <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
Date: Sat, 16 Dec 2006 23:39:30 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061216165738.GA5165@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <20061216165738.GA5165@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 16/12/06, Ingo Molnar <mingo@elte.hu> wrote:
> FYI, i'm working on integrating kmemleak into -rt. Firstly, i needed the
> fixes below when applying it ontop of 2.6.19-rt15.

Do you need these fixes to avoid a compiler error? If yes, this is
caused by a bug in gcc-4.x. The kmemleak container_of macro has
protection for non-constant offsets passed to container_of but the
faulty gcc always returns true for builtin_contant_p, even when this
is not the case. Previous versions (3.4) or one of the latest 4.x gcc
don't have this bug.

I wouldn't extend kmemleak to work around a gcc bug which was already fixed.

> Secondly, i'm wondering about the following recursion:
>
>  [<c045a7e1>] rt_spin_lock_slowlock+0x98/0x1dc
>  [<c045b16b>] rt_spin_lock+0x13/0x4b
>  [<c018f155>] kfree+0x3a/0xce
>  [<c0192e79>] hash_delete+0x58/0x5f
>  [<c019309b>] memleak_free+0xe9/0x1e6
>  [<c018ed2e>] __cache_free+0x27/0x414
>  [<c018f1d0>] kfree+0xb5/0xce
>  [<c02788dd>] acpi_ns_get_node+0xb1/0xbb
>  [<c02772fa>] acpi_ns_root_initialize+0x30f/0x31d
>  [<c0280194>] acpi_initialize_subsystem+0x58/0x87
>  [<c06a4641>] acpi_early_init+0x4f/0x12e
>  [<c06888bc>] start_kernel+0x41b/0x44b
>
> kfree() within kfree() ... this probably works on the upstream SLAB
> allocator but makes it pretty nasty to sort out SLAB locking in -rt.

I test kmemleak with lockdep enabled but I eliminated all the
dependencies on the vanilla kernel. When kfree(hnode) is called (in
hash_delete), no kmemleak locks are held and hence no dependency on
the kmemleak locks (since kmemleak is protected against re-entrance).
My understanding is that slab __cache_free is re-entrant anyway
(noticed this when using radix-tree instead of hash in kmemleak and
got some lockdep reports on l3->list_lock and memleak_lock) and
calling it again from kmemleak doesn't seem to have any problem on the
vanilla kernel.

In the -rt kernel, is there any protection against a re-entrant
__cache_free (via cache_flusharray -> free_block -> slab_destroy) or
this is not needed?

> Wouldnt it be better to just preallocate the hash nodes, like lockdep
> does, to avoid conceptual nesting? Basically debugging infrastructure
> should rely on other infrastructure as little as possible.

It would indeed be better to avoid using the slab infrastructure (and
not worry about kmemleak re-entrance and lock dependecies). I'll have
a look on how this is done in lockdep since the preallocation size
isn't known. There are also the memleak_object structures that need to
be allocated/freed. To avoid any locking dependencies, I ended up
delaying the memleak_object structures freeing in an RCU manner. It
might work if I do the same with the hash nodes.

> also, the number of knobs in the Kconfig is quite large:

I had some reasons and couldn't find a unified solution, but probably
only for one or two if them:

>  CONFIG_DEBUG_MEMLEAK=y
>  CONFIG_DEBUG_MEMLEAK_HASH_BITS=16

For my limited configurations (an x86 laptop and several ARM embedded
platforms), 16 bits were enough. I'm not sure this is enough on a
server machine for example.

>  CONFIG_DEBUG_MEMLEAK_TRACE_LENGTH=4

I thought this is a user preference. I could hard-code it to 16.
What's the trace length used by lockdep?

>  CONFIG_DEBUG_MEMLEAK_PREINIT_OBJECTS=512

I can probably hard-code this as well. This is a buffer to temporary
store memory allocations before kmemleak is fully initialised.
Kmemleak gets initialised quite early in the start_kernel function and
shouldn't be that different in other kernel configurations.

>  CONFIG_DEBUG_MEMLEAK_SECONDARY_ALIASES=y
>  CONFIG_DEBUG_MEMLEAK_TASK_STACKS=y

These could be eliminated as well.

There are also:

CONFIG_DEBUG_MEMLEAK_REPORT_THLD - can be removed
CONFIG_DEBUG_MEMLEAK_REPORTS_NR - can be removed
CONFIG_DEBUG_KEEP_INIT - this might be useful for other tools that
store the backtrace and display it at a later time. Could be made more
generic.

> plus the Kconfig dependency on SLAB_DEBUG makes it less likely for
> people to spontaneously try kmemleak. I'd suggest to offer KMEMLEAK
> unconditionally (when KERNEL_DEBUG is specified) and simply select
> SLAB_DEBUG.

I just followed the DEBUG_SLAB_LEAK configuration but I don't have any
problem with making it more visible.

Thanks for your comments.

-- 
Catalin
