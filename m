Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264012AbUFBUI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbUFBUI4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264002AbUFBUI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:08:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:27435 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264022AbUFBUIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:08:37 -0400
Date: Wed, 2 Jun 2004 21:08:26 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] vma_adjust adjust_next wrap
In-Reply-To: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406022107010.27696-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix vma_adjust adjust_next wrapping: Rajesh V. pointed out that if end
were 2GB or more beyond next->vm_start (on 32-bit), then next->vm_pgoff
would have been negatively adjusted.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/mmap.c |   27 +++++++++++++++++----------
 1 files changed, 17 insertions(+), 10 deletions(-)

--- 2.6.7-rc2/mm/mmap.c	2004-05-30 11:36:40.000000000 +0100
+++ linux/mm/mmap.c	2004-06-02 16:31:44.190703744 +0100
@@ -373,20 +373,27 @@ void vma_adjust(struct vm_area_struct *v
 
 	if (next && !insert) {
 		if (end >= next->vm_end) {
+			/*
+			 * vma expands, overlapping all the next, and
+			 * perhaps the one after too (mprotect case 6).
+			 */
 again:			remove_next = 1 + (end > next->vm_end);
 			end = next->vm_end;
 			anon_vma = next->anon_vma;
-		} else if (end < vma->vm_end || end > next->vm_start) {
+		} else if (end > next->vm_start) {
 			/*
-			 * vma shrinks, and !insert tells it's not
-			 * split_vma inserting another: so it must
-			 * be mprotect shifting the boundary down.
-			 *   Or:
 			 * vma expands, overlapping part of the next:
-			 * must be mprotect shifting the boundary up.
+			 * mprotect case 5 shifting the boundary up.
+			 */
+			adjust_next = (end - next->vm_start) >> PAGE_SHIFT;
+			anon_vma = next->anon_vma;
+		} else if (end < vma->vm_end) {
+			/*
+			 * vma shrinks, and !insert tells it's not
+			 * split_vma inserting another: so it must be
+			 * mprotect case 4 shifting the boundary down.
 			 */
-			BUG_ON(vma->vm_end != next->vm_start);
-			adjust_next = end - next->vm_start;
+			adjust_next = - ((vma->vm_end - end) >> PAGE_SHIFT);
 			anon_vma = next->anon_vma;
 		}
 	}
@@ -418,8 +425,8 @@ again:			remove_next = 1 + (end > next->
 	vma->vm_end = end;
 	vma->vm_pgoff = pgoff;
 	if (adjust_next) {
-		next->vm_start += adjust_next;
-		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
+		next->vm_start += adjust_next << PAGE_SHIFT;
+		next->vm_pgoff += adjust_next;
 	}
 
 	if (root) {

