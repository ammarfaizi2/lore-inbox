Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268040AbUJCSVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268040AbUJCSVU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 14:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268042AbUJCSVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 14:21:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:16383 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S268040AbUJCSVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 14:21:18 -0400
Date: Sun, 3 Oct 2004 19:21:01 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] vmtrunc: lowlat vmtruncate drop i_mmap_lock
Message-ID: <Pine.LNX.4.44.0410031914480.2739-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a set of patches against 2.6.9-rc3-mm1, or Ingo's -S7 VP tree:
allow lower latency in vmtruncate (more generally, unmap_mapping_range)
by dropping the i_mmap_lock when required.  Though I've been focussing
on correctness rather than latency myself: do these work for you, Ingo?

1/6 undoes something of Andrea's, 2/6 undoes something of Ingo's:
I thought I might as well provide patches as ask the questions, please
let us know why if you disagree with them.  3/6 is cosmetic, 4/6 is
the real work, 5/6 corrects some loose ends, 6/6 is for testing.

Worth the effort, and ~700 bytes bloat, and additional int in each vma?
If only root could run-bash-shared-mappings, I'd say not worth it; but
it seems a little like prio_tree itself, we're not sure we need it,
but feel more secure to have the solution.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 drivers/mtd/devices/blkmtd.c |    1 
 fs/inode.c                   |    1 
 include/linux/fs.h           |    2 
 include/linux/mm.h           |    8 +
 kernel/fork.c                |    1 
 mm/memory.c                  |  223 ++++++++++++++++++++++++++++++++++---------
 mm/mmap.c                    |   14 ++
 mm/mremap.c                  |   16 +--
 mm/rmap.c                    |    9 -
 mm/truncate.c                |    1 
 10 files changed, 215 insertions(+), 61 deletions(-)

