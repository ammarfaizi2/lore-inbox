Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbVIMTLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbVIMTLP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965135AbVIMTLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:11:14 -0400
Received: from silver.veritas.com ([143.127.12.111]:39029 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S965133AbVIMTLL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:11:11 -0400
Date: Tue, 13 Sep 2005 20:10:55 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: dev@sw.ru, torvalds@osdl.org, linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: Re: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
In-Reply-To: <20050913113703.53d53d6a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0509131945470.19481@goblin.wat.veritas.com>
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org>
 <43268C21.9090704@sw.ru> <20050913014008.0ee54c62.akpm@osdl.org>
 <Pine.LNX.4.61.0509131220540.7040@goblin.wat.veritas.com>
 <20050913113703.53d53d6a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 13 Sep 2005 19:11:11.0249 (UTC) FILETIME=[E724F010:01C5B896]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Andrew Morton wrote:
> 
> I don't think that it's any racier to move the allocation to after the
> check than to have it before the check.  If we're worried, take mmap_sem -
> most place already do that, but not all.

mmap_sem?  That locks a single mm, but here we're talking about
making reservations from what /proc/meminfo calls CommitLimit,
for the whole machine.  I really don't see any need to change
the ordering of what's done at present.

> > But change the naming by all means, it was never good,
> > and grew worse when "security_" got stuck on the front.
> 
> Yes, renaming it to something like alloc_vm_space() would suit.

Nor am I in any hurry to change the name, though I agree with
you and Alan that a name change would be good, in due course.

I'm more interested in fixing the bugs Kirill and co discovered,
and those I'm additionally finding on the way to fixing them in
insert_vm_struct.  Notice how running a 32-bit binary on x86_64
leaks 4kB into Committed_AS each time?

But I'm puzzled as to why the same leak into Committed_AS doesn't
occur on ppc64, each time an ELF binary is run, if vDSO is enabled.
Or is it indeed leaking, but nobody has noticed?  I don't have any
ppc64, could someone please check and see?  Thanks.

insert_vm_struct is certainly the way to go (it's not obvious to
callers whether VM_ACCOUNT is set or not), and there won't be any 
security_vm_enough_memory calls outside mm/ (and kernel/fork.c)
once I'm done: just a matter of where to stop (should it also
vm_stat_account? can we trust callers to maintain total_vm?
what about locked_vm?  rlimits?).

Hugh
