Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269908AbUJMXKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269908AbUJMXKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269906AbUJMXKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:10:46 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:6551 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S269908AbUJMXKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:10:20 -0400
Date: Thu, 14 Oct 2004 01:10:42 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: linux-kernel@vger.kernel.org
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>
Subject: per-process shared information 
Message-ID: <20041013231042.GQ17849@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.6 kernel dropped the shared information for each task, the third
field in /proc/<pid>/statem is a fake largely overstimating the number
of shared pages (it gets even bigger than the rss, that's why people
noticed, because the shared information was even bigger than the rss of
the task, so clearly those pages couldn't be shared if they didn't
exist).

Nothing important goes wrong in practice, but some statistics gets
screwed (gets underflows since they're rightfully used to compute rss -
shared to find the "private" not shared anonymous data).

I guess I can simply resurrect the O(N) pagetable scanning and check for
page_mapcount > 1 out of order in task_mmu.c? I want to add a new file
"statm_phys_shared" instead of doing it in statm, to avoid slowing down
ps xav. So special apps can still get the information out of the kernel.

At first I considered providing the "shared" information in O(log(N))
but I believe it would waste quite some cpu in the fast paths (it would
require walking the prio trees or the anon-vmas in each page fault, and
it would need to keep track of each vma->mm that we already updated
during the prio-tree walking), so I'd prefer the statistics to be slow
in O(N) instead of hurting the fast paths. If I allow rescheduling and I
trap signals there should be no DoS involved even in the very huge
boxes.

Comments? (can you suggest a better name?)

Ps. if somebody like Hugh volunteers implementing it, you're very
welcome, just let me know (I'll eventually want to work on the oom
handling too, which is pretty screwed right now, I've plenty of bugs
open on that area and the lowmem zone protection needs a rewrite too to
be set to a sane default value no matter the pages_lows etc..).
