Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUC3Wsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 17:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbUC3Wpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 17:45:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:22158 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261500AbUC3Wna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 17:43:30 -0500
Date: Tue, 30 Mar 2004 23:43:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/6] fork vma order
Message-ID: <Pine.LNX.4.44.0403302340220.24019-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of six patches against 2.6.5-rc3, cleaning up mremap's move_vma,
and fixing truncation orphan issues raised by Rajesh Venkatasubramanian.
Originally done as part of the anonymous objrmap work on mremap move,
but useful fixes now extracted for mainline.  The mremap changes need
some exposure in the -mm tree first, but the first (fork one-liner)
is safe enough to go straight into 2.6.5.

 include/linux/mm.h |    3 
 kernel/fork.c      |    2 
 mm/mmap.c          |   70 ++++++++++++++--
 mm/mremap.c        |  221 +++++++++++++++++++----------------------------------
 mm/rmap.c          |    3 
 5 files changed, 149 insertions(+), 150 deletions(-)

[PATCH] 1/6 fork vma order

>From Rajesh Venkatasubramanian: despite the comment that child vma
should be inserted just after parent vma, 2.5.6 did exactly the reverse:
thus a racing vmtruncate may free the child's ptes, then advance to the
parent, and meanwhile copy_page_range has propagated more ptes from the
parent to the child, leaving file pages still mapped after truncation.

--- 2.6.5-rc3/kernel/fork.c	2004-03-11 01:56:07.000000000 +0000
+++ mremap1/kernel/fork.c	2004-03-30 21:24:25.839880544 +0100
@@ -322,7 +322,7 @@ static inline int dup_mmap(struct mm_str
       
 			/* insert tmp into the share list, just after mpnt */
 			down(&file->f_mapping->i_shared_sem);
-			list_add_tail(&tmp->shared, &mpnt->shared);
+			list_add(&tmp->shared, &mpnt->shared);
 			up(&file->f_mapping->i_shared_sem);
 		}
 

