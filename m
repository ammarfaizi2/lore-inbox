Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263141AbUCRWOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 17:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbUCRWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 17:14:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52872
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263141AbUCRWN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 17:13:57 -0500
Date: Thu, 18 Mar 2004 23:14:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040318221447.GA3248@dualathlon.random>
References: <20040318022201.GE2113@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318022201.GE2113@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After one day of stress testing I could reproduce this:

M------------[ cut here ]------------
^Mkernel BUG at mm/objrmap.c:271!
^Minvalid operand: 0000 [#1]
^MSMP
^MCPU:    0
^MEIP:    0060:[<c014df45>]    Not tainted
^MEFLAGS: 00210246   (2.6.5-rc1-aa1)
^MEIP is at page_add_rmap+0x145/0x180
^Meax: 00000000   ebx: c18d8740   ecx: 00200246   edx: c1a0e6a0
^Mesi: e2c26ea8   edi: 4040a8cc   ebp: 00ab3d00   esp: c4323ec8
^Mds: 007b   es: 007b   ss: 0068
^MProcess python (pid: 16772, threadinfo=c4322000 task=e63285f0)
^MStack: 389c8025 00000000 f43c9028 c0149803 00000000 f43ca338 f3e50400 c18fb628
^M       c197d970 00000001 c18d8740 f3e50404 4040a8cc e2c26ea8 e27d3040 e27d3040
^M       e27d3060 e2c26ea8 e63285f0 c0117b24 00000000 c1a14040 00000000 4040a8cc
^MCall Trace:
^M [<c0149803>] handle_mm_fault+0x4c3/0x900
^M [<c0117b24>] do_page_fault+0x164/0x534
^M [<c011945a>] recalc_task_prio+0x8a/0x1c0
^M [<c011b413>] schedule+0x1e3/0x680
^M [<c014c04a>] do_munmap+0x2da/0x430
^M [<c01179c0>] do_page_fault+0x0/0x534
^M [<c0106d01>] error_code+0x2d/0x38

^MCode: 0f 0b 0f 01 13 00 39 c0 eb 90 0f 0b eb 00 13 00 39 c0 e9 2f


After some more debugging I realized what happened. It's a race condition very
hard to trigger.

There's one task with some anonymous memory swapped out, the pte points
the swp_entry. This task forks() and the swp_entry is duplicated.

One of the two childs generates a swapin with a _read_ (so it remains a
swapcache cow), so one of the two ptes is replaced with a pointer to a
swapcache instead of the swp_entry, the page has mapcount == 1 and count
==2.

Then the memory pressure cause try_to_unmap_one to unmap the swapcache
setting the pte back to the swp_entry, and since there was only 1
mapping, I also clear the PG_anon bitflag, but right before
try_to_unmap_one clears the PG_anon, the other process does a minor fault
like this:

	process 1			process 2
	----------			------------
	swapout
					do_swap_page
					lookup_swap_cache
					SetPageAnon
	ClearPageAnon
					page_add_rmap
					BUG_ON(!page->as.mapping) <- crash

the window for the race is incredibly small, it takes hours of heavy
swap on a real life system doing fork sleeping and touching ram readonly
to trigger it (my testbox never triggered it despite the load yet).

The fix is simple: always set and clear PG_anon under the page_map_lock,
this will avoid the race since all ClearPageAnon already runs under the
page_map_lock. I will implement and test in a few hours.

the other way to fix it is to return doing like Dave, that is to clear
PageAnon implicitly in __free_pages_ok but I don't like that, since it's
not robust, if we lose a bitflag with my code the kernel will oops
immediatly, so it's much easier to find the path that lost the bitflag.
I prefer the objrmap code to manage the PG_anon all explicitly
(atomically during the !mapcount++ and !--mapcount transitions) for both
the setting and the clearing of the bitflag, and if we lose it we crash
immediatly in __free_pages_ok (instead of silenty clearing the bitflag
like it would happen in the objrmap patch). I find this more robust.
