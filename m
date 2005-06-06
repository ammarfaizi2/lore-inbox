Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261676AbVFFUFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbVFFUFN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 16:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVFFUDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 16:03:43 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:64820 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261658AbVFFT5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 15:57:33 -0400
Date: Mon, 6 Jun 2005 20:57:57 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Lameter <clameter@sgi.com>, Shai Fultheim <shai@scalex86.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] do_wp_page: cannot share file page
Message-ID: <Pine.LNX.4.61.0506062055350.5000@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 06 Jun 2005 19:56:57.0207 (UTC) 
    FILETIME=[E4F7A070:01C56AD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small optimization to do_wp_page's check for whether to avoid copy by
reusing the page already mapped.  It can never share a cached file page,
nor can it share a reserved page (often the empty zero page), so it's a
waste of time to lock and unlock in those cases.  Which nowadays can
both be neatly excluded by a preliminary PageAnon test.

Christoph has reported that a preliminary page_count test proved valuable
for scalability here, but PageAnon covers more common cases all at once.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/memory.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.12-rc6/mm/memory.c	2005-05-25 18:09:21.000000000 +0100
+++ linux/mm/memory.c	2005-06-04 20:41:55.000000000 +0100
@@ -1264,7 +1264,7 @@ static int do_wp_page(struct mm_struct *
 	}
 	old_page = pfn_to_page(pfn);
 
-	if (!TestSetPageLocked(old_page)) {
+	if (PageAnon(old_page) && !TestSetPageLocked(old_page)) {
 		int reuse = can_share_swap_page(old_page);
 		unlock_page(old_page);
 		if (reuse) {
