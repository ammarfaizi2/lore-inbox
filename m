Return-Path: <linux-kernel-owner+w=401wt.eu-S1751088AbXAFCaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbXAFCaF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbXAFC3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:29:03 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36427 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751103AbXAFC2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:28:45 -0500
Message-Id: <20070106023240.129725000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:13 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, hugh@veritas.com, pbadari@us.ibm.com
Subject: [patch 20/50] Fix for shmem_truncate_range() BUG_ON()
Content-Disposition: inline; filename=fix-for-shmem_truncate_range-bug_on.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Badari Pulavarty <pbadari@us.ibm.com>

Ran into BUG() while doing madvise(REMOVE) testing.  If we are punching a
hole into shared memory segment using madvise(REMOVE) and the entire hole
is below the indirect blocks, we hit following assert.

	        BUG_ON(limit <= SHMEM_NR_DIRECT);

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 mm/shmem.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- linux-2.6.19.1.orig/mm/shmem.c
+++ linux-2.6.19.1/mm/shmem.c
@@ -515,7 +515,12 @@ static void shmem_truncate_range(struct 
 			size = SHMEM_NR_DIRECT;
 		nr_swaps_freed = shmem_free_swp(ptr+idx, ptr+size);
 	}
-	if (!topdir)
+
+	/*
+	 * If there are no indirect blocks or we are punching a hole
+	 * below indirect blocks, nothing to be done.
+	 */
+	if (!topdir || (punch_hole && (limit <= SHMEM_NR_DIRECT)))
 		goto done2;
 
 	BUG_ON(limit <= SHMEM_NR_DIRECT);

--
