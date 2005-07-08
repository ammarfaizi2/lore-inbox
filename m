Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262639AbVGHMaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVGHMaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 08:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVGHMav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 08:30:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18348 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262639AbVGHM37 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 08:29:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050705142958.4075c5a7.akpm@osdl.org> 
References: <20050705142958.4075c5a7.akpm@osdl.org>  <1491.1120594224@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Provide better printk() support for SMP machines 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.4
Date: Fri, 08 Jul 2005 13:29:52 +0100
Message-ID: <31528.1120825792@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> hm, I guess it adds a theoretical deadlock if some other CPU is in the
> middle of printk and is trying to take some_lock and this CPU takes an oops
> while holding some_lock.  Probably that's an acceptable tradeoff though.

What it perhaps needs is a maximum number of spins or something like that.

> Does this guy really need to be volatile?

atomic_t is volatile, so that makes no difference.

Actually, I shouldn't use an atomic_t or a signed int as the CPU ID is
unsigned:-/

I'm using -1 / UINT_MAX as a "not in use" thing, but I'm not sure that's
strictly viable.

> Coud we use atomic_t and lose that wmb()?

I talked it over with David Woodhouse, and he's convinced me that we don't
need the barrier: the only thing we care about is getting a printk within a
printk on the CPU because of an oops. THEN we have to break the lock. And in
that case we're looking for the CPU number being set to that of our CPU, and
only our CPU will ever set that.

> Methinks this should be raw_smp_processor_id().

Not only that, but the whole function needs wrapping in preemption
disablement, lest the processor ID change under us.

David
