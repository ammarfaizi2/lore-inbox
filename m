Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVBDU3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVBDU3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264762AbVBDUMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:12:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54027 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S264925AbVBDULm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:11:42 -0500
Date: Fri, 4 Feb 2005 21:11:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.11-rc3-mm1: fix swsusp with gcc 3.4
Message-ID: <20050204201135.GD19408@stusta.de>
References: <20050204103350.241a907a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 10:33:50AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-rc2-mm2:
>...
> +swsusp-do-not-use-higher-order-memory-allocations-on-suspend.patch
> 
>  swsusp fix
>...

This broke compilation with gcc 3.4:

<--  snip  -->

...
  CC      kernel/power/swsusp.o
kernel/power/swsusp.c: In function `alloc_pagedir':
kernel/power/swsusp.c:608: sorry, unimplemented: inlining failed in call 
to 'free_pagedir': function body not available
kernel/power/swsusp.c:646: sorry, unimplemented: called from here
make[2]: *** [kernel/power/swsusp.o] Error 1

<--  snip  -->


The fix is simple:

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 kernel/power/swsusp.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

--- linux-2.6.11-rc3-mm1-full/kernel/power/swsusp.c.old	2005-02-04 20:50:16.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/kernel/power/swsusp.c	2005-02-04 20:51:18.000000000 +0100
@@ -605,7 +605,20 @@
 	return nr_copy;
 }
 
-static inline void free_pagedir(struct pbe *pblist);
+/**
+ *	free_pagedir - free pages allocated with alloc_pagedir()
+ */
+
+static inline void free_pagedir(struct pbe *pblist)
+{
+	struct pbe *pbe;
+
+	while (pblist) {
+		pbe = pblist + PB_PAGE_SKIP;
+		pblist = pbe->next;
+		free_page((unsigned long)pblist);
+	}
+}
 
 /**
  *	alloc_pagedir - Allocate the page directory.
@@ -651,21 +664,6 @@
 }
 
 /**
- *	free_pagedir - free pages allocated with alloc_pagedir()
- */
-
-static inline void free_pagedir(struct pbe *pblist)
-{
-	struct pbe *pbe;
-
-	while (pblist) {
-		pbe = pblist + PB_PAGE_SKIP;
-		pblist = pbe->next;
-		free_page((unsigned long)pblist);
-	}
-}
-
-/**
  *	free_image_pages - Free pages allocated for snapshot
  */
 

