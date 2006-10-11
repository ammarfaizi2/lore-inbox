Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbWJKSew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbWJKSew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWJKSew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:34:52 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:54161 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1750780AbWJKSev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:34:51 -0400
Date: Wed, 11 Oct 2006 11:34:04 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nick Piggin <npiggin@suse.de>, Hugh Dickins <hugh@veritas.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/5] mm: fault vs invalidate/truncate race fix
Message-ID: <20061011183404.GR6485@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20061009140354.13840.71273.sendpatchset@linux.site> <20061009140414.13840.90825.sendpatchset@linux.site> <20061009211013.GP6485@ca-server1.us.oracle.com> <452AF312.1020207@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452AF312.1020207@yahoo.com.au>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 11:10:42AM +1000, Nick Piggin wrote:
> If you want a stable patchset for testing, the previous one to linux-mm
> starting with "[patch 1/3] mm: fault vs invalidate/truncate check" went
> through some stress testing here...
Hmm, unfortunately my testing so far hasn't been particularly encouraging...

Shortly after my test starts, one of the "ocfs2-vote" processes on one of my
nodes will begin consuming cpu at a rate which indicates it might be in an
infinite loop. The soft lockup detection code seems to agree:

BUG: soft lockup detected on CPU#0!
Call Trace:
[C00000003795F220] [C000000000011310] .show_stack+0x50/0x1cc (unreliable)
[C00000003795F2D0] [C000000000086100] .softlockup_tick+0xf8/0x120
[C00000003795F380] [C000000000060DA8] .run_local_timers+0x1c/0x30
[C00000003795F400] [C000000000023B28] .timer_interrupt+0x110/0x500
[C00000003795F520] [C0000000000034EC] decrementer_common+0xec/0x100
--- Exception: 901 at ._raw_spin_lock+0x84/0x1a0
    LR = ._spin_lock+0x10/0x24
[C00000003795F810] [C000000000788FC8] init_thread_union+0xfc8/0x4000 (unreliable)
[C00000003795F8B0] [C0000000004A66B8] ._spin_lock+0x10/0x24
[C00000003795F930] [C00000000009EDBC] .unmap_mapping_range+0x88/0x2d4
[C00000003795FA90] [C0000000000967E4] .truncate_inode_pages_range+0x2b8/0x490
[C00000003795FBE0] [D0000000005FA8C0] .ocfs2_data_convert_worker+0x124/0x14c [ocfs2]
[C00000003795FC70] [D0000000005FB0BC] .ocfs2_process_blocked_lock+0x184/0xca4 [ocfs2]
[C00000003795FD50] [D000000000629DE8] .ocfs2_vote_thread+0x1a8/0xc18 [ocfs2]
[C00000003795FEE0] [C00000000007000C] .kthread+0x154/0x1a4
[C00000003795FF90] [C000000000027124] .kernel_thread+0x4c/0x68


A sysrq-t doesn't show anything interesting from any of the other OCFS2
processes. This is your patchset from the 10th, running against Linus' git
tree from that day, with my mmap patch merged in.

The stack seems to indicate that we're stuck in one of these
truncate_inode_pages_range() loops:

+                       while (page_mapped(page)) {
+                               unmap_mapping_range(mapping,
+                                 (loff_t)page_index<<PAGE_CACHE_SHIFT,
+                                 PAGE_CACHE_SIZE, 0);
+                       }


The test I run is over here btw:

http://oss.oracle.com/projects/ocfs2-test/src/trunk/programs/multi_node_mmap/multi_mmap.c

I ran it with the following parameters:

mpirun -np 6 n1-3 ./multi_mmap -w mmap -r mmap -i 1000 -b 1024 /ocfs2/mmap/test4.txt
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
