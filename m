Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUJNWiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUJNWiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUJNWiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:38:11 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:14318 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S268060AbUJNWhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 18:37:12 -0400
Date: Fri, 15 Oct 2004 00:37:30 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: per-process shared information
Message-ID: <20041014223730.GI17849@dualathlon.random>
References: <20041013231042.GQ17849@dualathlon.random> <Pine.LNX.4.44.0410142205450.2702-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410142205450.2702-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 10:49:28PM +0100, Hugh Dickins wrote:
> Is "shared" generally expected to pair with rss?  Would it make

shared is expected to work like in linux 2.4 (and apparently solaris),
which means _physical_ pages mapped in more than one task.

> Sounds horrid to me!  I'm not inclined to volunteer for that: plus this

what's horrid? would you add a O(log(N)) slowdown in the fast paths to
provide the stat in O(1)? I much prefer an O(N) loop in the stats as far
as it catches signals and reschedules as soon as need_resched is set.

if you can suggest a not-horrid approach to avoid breaking binary
compatibility to 2.4 you're welcome ;)

> One, support anon_rss as a subset of rss, "shared" being (rss - anon_rss).
> Yes, that's a slight change in meaning of "shared" from in 2.4, but easy
> to support and I think very reasonable.  On the one hand, yes, of course

that's certainly much better than what we have right now, it's much
closer to the old semantics, but I'm not sure if it's enough to be
compliant with the other OS (including 2.4). I will ask. 

I also guess the app will stop breaking since rss - shared will not wrap
anymore.

> we know an anon page may actually be shared between several mms of the
> fork group, whereas it won't be counted in "shared" with this patch. But
> the old definition of "shared" was considerably more stupid, wasn't it?
> for example, a private page in pte and swap cache got counted as shared.

just checking mapcount > 1 would do it right in 2.6.

> Would this new meaning of "shared" suit your purposes well enough?

It'd be fine for me, but I'm no the one how's having troubles.

> shouldn't change that now, but add your statm_phys_shared; whatever,

the only reason to add statm_phys_shared was to keep ps xav fast, if you
don't slowdown pa xav you can add another field at the end of statm.

Ideally shared should have been set to 0 and it should have been moved
to statm_phys_shared. It's slow but not so horrid thanks to the mapcount
which makes it really strightforward (it's just a vma + pgtable walk,
the only tricky bit is the signal catch and need_resched).
