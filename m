Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSHVQGv>; Thu, 22 Aug 2002 12:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312560AbSHVQGv>; Thu, 22 Aug 2002 12:06:51 -0400
Received: from [195.223.140.120] ([195.223.140.120]:31588 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311749AbSHVQGu>; Thu, 22 Aug 2002 12:06:50 -0400
Date: Thu, 22 Aug 2002 18:12:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <20020822161216.GQ1117@dualathlon.random>
References: <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com> <2159880183.1029535922@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2159880183.1029535922@[10.10.2.3]>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 10:12:04PM -0700, Martin J. Bligh wrote:
> Yes, I guess you'd have to TLB flush on the context switch with 
> shared mm's which you don't have to do now, and you'd use an extra

Flushing tlb across thread context switch sounds the worst part. One of
the main reasons to use threads is to avoid tlb flushing across context
switches and to reduce the context switch nearly to a longjump through
kernel space (i.e. use threads instead of segmentation to skip the tlb
flushes across context switches). If we had ASN on the x86 that wouldn't
be such a big problem, a tlb flush in the common case would just bump
the current ASN, however the main lack of the x86 architecture is the
lack of tlb tagging (hope it'll be fixed soon, it's definitely fixable
without breaking backwards compatibility so eventually some x86
hardware vendor will wakeup and the others will have to follow).  So I
would guess adding some per-VM locking like a mm->kmap_sem to serialize
the use of the per-VM pool of kmaps, sounds better unless we get address
space numbers on 32bit x86, over days of computations there are going to
be much more context switches than page faults, however it also depends
on the workload. The point about needing the tlb flush anyways for
replicated .text is valid, however not all the SMP highmem boxes are
necessiarly NUMA boxes too, and if they aren't NUMA I guess they prefer
not to flush the tlb over context switches. You may probably want to do
some measurements about the overhead of tlb flushes by adding a
__flush_tlb() in switch_to across two tasks (not across kernel threads
though) to simulate the behaviour of your proposed per-task PMD design.

Andrea
