Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbUCIHsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 02:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUCIHsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 02:48:20 -0500
Received: from mx1.elte.hu ([157.181.1.137]:47573 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261626AbUCIHsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 02:48:18 -0500
Date: Tue, 9 Mar 2004 08:47:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040309074747.GA8021@elte.hu>
References: <20040308202433.GA12612@dualathlon.random> <1078781318.4678.9.camel@laptop.fenrus.com> <20040308230845.GD12612@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308230845.GD12612@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner-4.26.8-itk2 SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@suse.de> wrote:

> I agree that works fine for Oracle, that's becase Oracle is an extreme
> special case since most of this shared memory is an I/O cache, this is
> not the case of other apps, and those other apps really depends on the
> kernel vm paging algorithms for things more than istantiating a pte
> (or a pmd if it's a largepage). Other apps can't use mlock. Some of
> these apps works closely with oracle too.

what other apps use gigs of shared memory where that shared memory is
not an IO cache?

> dropping pte_chains through mlock was suggested around april 2003
> originally by Wli and I didn't like that idea since we really want to
> allow swapping if we run short of ram. [...]

dropping pte_chains on mlock() we implemented in RHEL3 and it works fine
to reduce the pte_chain overhead for those extreme shm users.

mind you, it still doesnt make high-end DB workloads viable on 32 GB
systems. (and no, not due to the pte_chain overhead.) 3:1 is simply not
enough at 32 GB and higher [possibly much ealier, for other workloads]. 
Trying to argue otherwise is sticking your head into the sand.

most of the anti-rmap sentiment (not this patch - this patch looks OK at
first sight, except the increase in struct page) is really backwards.
The right solution is to have rmap which is a _per page_ overhead and
the clear path to a mostly O(1) VM logic. Then we can increase the page
size (pgcl) to scale down the rmap overhead (both the per-page and the
locking overhead). What's so hard about this concept? Simple and
flexible data structure.

the x86 highmem issues are a quickly fading transient in history.

	Ingo
