Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936947AbWLDOyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936947AbWLDOyO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936937AbWLDOxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:53:47 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12981 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S936929AbWLDOxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:53:09 -0500
Date: Mon, 4 Dec 2006 15:53:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] extmem unbalanced spin_lock.
Message-ID: <20061204145304.GN32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] extmem unbalanced spin_lock.

segment save will exit with a lock held if the passed segment doesn't
exist. Any subsequent call to segment_save will lead to a deadlock.
Fix this and give up the lock before returning.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/extmem.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2006-12-04 14:50:45.000000000 +0100
@@ -563,8 +563,9 @@ segment_save(char *name)
 	seg = segment_by_name (name);
 
 	if (seg == NULL) {
-		PRINT_ERR ("could not find segment %s in segment_save, please report to linux390@de.ibm.com\n",name);
-		return;
+		PRINT_ERR("could not find segment %s in segment_save, please "
+			  "report to linux390@de.ibm.com\n", name);
+		goto out;
 	}
 
 	startpfn = seg->start_addr >> PAGE_SHIFT;
