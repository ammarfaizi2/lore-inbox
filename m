Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261404AbUKFPaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbUKFPaE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 10:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUKFPaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 10:30:04 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:31639 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261404AbUKFP37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 10:29:59 -0500
Date: Sat, 6 Nov 2004 16:29:03 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041106152903.GA3851@dualathlon.random>
References: <20041106015051.GU8229@dualathlon.random> <Pine.LNX.4.44.0411060944150.2721-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411060944150.2721-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 09:47:56AM +0000, Hugh Dickins wrote:
> Problematic, yes: don't overlook that GFP_REPEAT and GFP_NOFAIL _can_
> fail, returning NULL: when the process is being OOM-killed (PF_MEMDIE).

that looks weird, why that? The oom killer must be robust against a task
not going anyway regardless of this (task can be stuck in nfs or
similar). If a fail path ever existed, __GFP_NOFAIL should not have been
used in the first place. I don't see many valid excuses to use
__GFP_NOFAIL if we can return NULL without the caller running into an
infinite loop.

btw, PF_MEMDIE has always been racy in the way it's being set, so it can
corrupt the p->flags, but the race window is very small to trigger it
(and even if it triggers, it probably wouldn't be fatal). That's why I
don't use PF_MEMDIE in 2.4-aa.
