Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWFZPfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWFZPfg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 11:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030343AbWFZPfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 11:35:36 -0400
Received: from gold.veritas.com ([143.127.12.110]:15459 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030328AbWFZPff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 11:35:35 -0400
X-IronPort-AV: i="4.06,176,1149490800"; 
   d="scan'208"; a="60934487:sNHT30683756"
Date: Mon, 26 Jun 2006 16:35:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/5] mm: tracking dirty pages -v11
In-Reply-To: <20060623223103.11513.50991.sendpatchset@lappy>
Message-ID: <Pine.LNX.4.64.0606261603260.17119@blonde.wat.veritas.com>
References: <20060623223103.11513.50991.sendpatchset@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Jun 2006 15:35:34.0556 (UTC) FILETIME=[2A6ABDC0:01C69936]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jun 2006, Peter Zijlstra wrote:
> 
> I hope to have addressed all Hugh's latest comments in this version.
> Its against 2.6.17-mm1, however I wasted most of the day trying to 
> test it on that kernel. But due to various circumstances that failed.

Looks good - I'm happy that we leave the do_wp_page test reordering
(to fix up that third order ptrace poke issue) to a subsequent patch,
it's better separated.

> So I've tested something like this against something 2.6.17'ish and 
> respun against the -mm lineup.

Your next (final?) spin should be against Linus' current git tree,
http://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.17-git10.bz2
is the latest snapshot patch if you're not using git itself.  That will
suit Andrew better too: he prefers patches against Linus' current tree,
except when the changes are to work that's only in -mm.

You ought to respin, because the vma_wants_writenotify mods in mprotect.c
affect later patches in your series, giving rejects at present.  It does
look _much_ better with Linus' vma_wants_writenotify.  I did think of
asking you for that, but it seemed unfair because I knew you'd want
to use it in mprotect, and then get in trouble with backing-dev.h:
which you've solved by #including that now in mm.h - a pity,
but an unavoidable decision.

Given the reordering you had to make in mprotect_fixup to get its tests
working right (a little naughty!), I'd now do away with the "mask"
variable, and just work directly on "newflags" itself; but up to you.

> I've taken Hugh's msync changes too, looks a lot better and does indeed
> fix some boundary cases.

Thanks for reviewing: please add my
Signed-off-by: Hugh Dickins <hugh@veritas.com>
to that msync one.

In the respin of 1/5 you enquired:
> Bah Bah Bah, why didn't the page_mkwrite() patch re-protect clean pages?
> And is it a Bad-Thing (tm) that that can happen now?

You'll need a reply from David for the definitive answer, but I think
page_mkwrite is only wanting to know about the _first_ write to the
page e.g. so that it can allocate space on disk for that page.  And
many (most) calls to page_mkwrite won't be for that first write at
all, the filesystem already has to work out the irrelevant calls:
so it's no great problem that you'll be making some more such calls.

Hugh
