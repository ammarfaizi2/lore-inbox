Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVALNsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVALNsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 08:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVALNsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 08:48:32 -0500
Received: from [220.248.27.114] ([220.248.27.114]:54414 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261191AbVALNsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 08:48:18 -0500
Date: Wed, 12 Jan 2005 21:46:13 +0800
From: hugang@soulinfo.com
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH swsusp: page rellocation speed up
Message-ID: <20050112134612.GA29173@hugang.soulinfo.com>
References: <20050111010122.GA3013@mail.muni.cz> <20050112124948.GA15687@hugang.soulinfo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112124948.GA15687@hugang.soulinfo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 08:49:49PM +0800, hugang@soulinfo.com wrote:
> On Tue, Jan 11, 2005 at 02:01:23AM +0100, Lukas Hejtmanek wrote:
> > Hello,
> > 
> > attached patch should speed up page rellocation at time of resume. Please test.
> > The diff is against 2.6.10-bk8
> > 
> ....
> 
> really cool, Passed in my x86 and ppc.
> 
> Here is a patch to make pagedir using non-continuity page, 
>  2.6.10 -> mm1 -> this patch -> my patch
> 
...

After more deep test, I found A bug, Here is a patch to fix it.

--- 2.6.10-mm1-one-pbe-hg/kernel/power/pbe.h~mail	2005-01-12 21:10:39.000000000 +0800
+++ 2.6.10-mm1-one-pbe-hg/kernel/power/pbe.h	2005-01-12 21:21:41.000000000 +0800
@@ -267,7 +267,7 @@ static int __init check_pagedir(void)
 {
 	void **c, *f;
 	struct pbe *next, *pos;
-	int error, index, i;
+	int error, index;
 	suspend_pagedir_t *addr = NULL;
 	struct zone *zone;
 	unsigned long zone_pfn;
@@ -280,8 +280,9 @@ static int __init check_pagedir(void)
 	}
 
 	/* Clear orig address */
-	pbe_for_each(pos, next, i, nr_copy_pages, pagedir_nosave) {
-		pr_debug("clear <%p>\n", (void*)pos->orig_address);
+	pbe_for_each(pos, next, index, nr_copy_pages, pagedir_nosave) {
+		pr_debug("clear <%p>, <%p>, %d\n", 
+				pos, (void*)pos->orig_address, index);
 		ClearPageNosaveFree(virt_to_page(pos->orig_address));
 	}
 	
--- 2.6.10-mm1-one-pbe-hg/kernel/power/swsusp.c~mail	2005-01-12 21:10:43.000000000 +0800
+++ 2.6.10-mm1-one-pbe-hg/kernel/power/swsusp.c	2005-01-12 21:43:41.000000000 +0800
@@ -380,6 +380,8 @@ static int write_pagedir(void)
 
 	pgdir_for_each(pgdir, next, pagedir_nosave) {
 		error = write_page((unsigned long)pgdir, &swsusp_info.pagedir[n]);
+		pr_debug("write_pagedir: <%p>, %lu\n", 
+				pgdir, swp_offset(swsusp_info.pagedir[n]));
 		if (error) break;
 		n ++;
 	}
@@ -1008,6 +1010,7 @@ static int __init read_pagedir(void)
 	pgdir_for_each(pgdir, next, pagedir_nosave) {
 		error = read_one_pagedir(pgdir, i);
 		if (error) break;
+		pgdir[ONE_PAGE_PBE_NUM-1].dummy.val = next ? next->dummy.val : 0;
 		i++;
 	}
 	BUG_ON(i != n);

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
