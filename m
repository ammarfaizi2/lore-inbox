Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030241AbWFTLwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030241AbWFTLwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWFTLwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:52:13 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:64385 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030243AbWFTLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:52:07 -0400
Message-Id: <20060620114907.145951000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:13 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, aia21@cam.ac.uk,
       aia21@cantab.net
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 13/13] NTFS: Critical bug fix (affects MIPS and possibly others)
Content-Disposition: inline; filename=ntfs-critical-bug-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Anton Altaparmakov <aia21@cam.ac.uk>

It fixes a crash in NTFS on architectures where flush_dcache_page()
is a real function.  I never noticed this as all my testing is done on
i386 where flush_dcache_page() is NULL.

http://bugzilla.kernel.org/show_bug.cgi?id=6700

Many thanks to Pauline Ng for the detailed bug report and analysis!

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 fs/ntfs/file.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.16.21.orig/fs/ntfs/file.c
+++ linux-2.6.16.21/fs/ntfs/file.c
@@ -1489,14 +1489,15 @@ static inline void ntfs_flush_dcache_pag
 		unsigned nr_pages)
 {
 	BUG_ON(!nr_pages);
+	/*
+	 * Warning: Do not do the decrement at the same time as the call to
+	 * flush_dcache_page() because it is a NULL macro on i386 and hence the
+	 * decrement never happens so the loop never terminates.
+	 */
 	do {
-		/*
-		 * Warning: Do not do the decrement at the same time as the
-		 * call because flush_dcache_page() is a NULL macro on i386
-		 * and hence the decrement never happens.
-		 */
+		--nr_pages;
 		flush_dcache_page(pages[nr_pages]);
-	} while (--nr_pages > 0);
+	} while (nr_pages > 0);
 }
 
 /**

--
