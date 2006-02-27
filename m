Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWB0SbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWB0SbQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 13:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWB0SbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 13:31:14 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:3504 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751223AbWB0Sav (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 13:30:51 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: [RFC][PATCH -mm 2/2] mm: make shrink_all_memory try harder
Date: Mon, 27 Feb 2006 19:30:02 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200602271926.20294.rjw@sisk.pl>
In-Reply-To: <200602271926.20294.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602271930.03171.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make shrink_all_memory() repeat the attempts to free more memory if there
seems to be no pages to free.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 mm/vmscan.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

Index: linux-2.6.16-rc4-mm2/mm/vmscan.c
===================================================================
--- linux-2.6.16-rc4-mm2.orig/mm/vmscan.c
+++ linux-2.6.16-rc4-mm2/mm/vmscan.c
@@ -33,6 +33,7 @@
 #include <linux/cpuset.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
+#include <linux/delay.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1793,17 +1794,24 @@ unsigned long shrink_all_memory(unsigned
 	struct reclaim_state reclaim_state = {
 		.reclaimed_slab = 0,
 	};
+	int retry = 2;
 
 	current->reclaim_state = &reclaim_state;
-	for_each_pgdat(pgdat) {
-		unsigned long freed;
+	do {
+		for_each_pgdat(pgdat) {
+			unsigned long freed;
 
-		freed = balance_pgdat(pgdat, nr_to_free, 0);
-		ret += freed;
-		nr_to_free -= freed;
-		if (nr_to_free <= 0)
+			freed = balance_pgdat(pgdat, nr_to_free, 0);
+			ret += freed;
+			nr_to_free -= freed;
+			if (nr_to_free <= 0)
+				break;
+		}
+		if (ret > 0)
 			break;
-	}
+		if (retry)
+			msleep_interruptible(100);
+	} while (retry--);
 	current->reclaim_state = NULL;
 	return ret;
 }
