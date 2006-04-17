Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDQMui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDQMui (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 08:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWDQMui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 08:50:38 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:4002 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1750730AbWDQMuh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 08:50:37 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH][urgent fix] swsusp: prevent possible image corruption on resume
Date: Mon, 17 Apr 2006 14:49:23 +0200
User-Agent: KMail/1.9.1
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>,
       Adrian Bunk <bunk@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604171449.24548.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function free_pagedir() used by swsusp for freeing its internal data
structures clears the PG_nosave and PG_nosave_free flags for each page being
freed.  However, during resume PG_nosave_free set means that the page
in question is "unsafe" (ie. it will be overwritten in the process of restoring the
saved system state from the image), so it should not be used for the image
data.  Therefore free_pagedir() should not clear PG_nosave_free if it's
called during resume (otherwise "unsafe" pages freed by it may be used for
storing the image data and the data may get corrupted later on).

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.17-rc1-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.17-rc1-mm2.orig/kernel/power/snapshot.c	2006-04-17 13:47:58.000000000 +0200
+++ linux-2.6.17-rc1-mm2/kernel/power/snapshot.c	2006-04-17 13:50:34.000000000 +0200
@@ -240,14 +240,15 @@ static void copy_data_pages(struct pbe *
  *	free_pagedir - free pages allocated with alloc_pagedir()
  */
 
-static void free_pagedir(struct pbe *pblist)
+static void free_pagedir(struct pbe *pblist, int clear_nosave_free)
 {
 	struct pbe *pbe;
 
 	while (pblist) {
 		pbe = (pblist + PB_PAGE_SKIP)->next;
 		ClearPageNosave(virt_to_page(pblist));
-		ClearPageNosaveFree(virt_to_page(pblist));
+		if (clear_nosave_free)
+			ClearPageNosaveFree(virt_to_page(pblist));
 		free_page((unsigned long)pblist);
 		pblist = pbe;
 	}
@@ -389,7 +390,7 @@ struct pbe *alloc_pagedir(unsigned int n
 		pbe->next = alloc_image_page(gfp_mask, safe_needed);
 	}
 	if (!pbe) { /* get_zeroed_page() failed */
-		free_pagedir(pblist);
+		free_pagedir(pblist, 1);
 		pblist = NULL;
         } else
 		create_pbe_list(pblist, nr_pages);
@@ -736,7 +737,7 @@ static int create_image(struct snapshot_
 		pblist = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 1);
 		if (pblist)
 			copy_page_backup_list(pblist, p);
-		free_pagedir(p);
+		free_pagedir(p, 0);
 		if (!pblist)
 			error = -ENOMEM;
 	}


