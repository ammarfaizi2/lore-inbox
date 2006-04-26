Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWDZUzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWDZUzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWDZUzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:55:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27268 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932462AbWDZUzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:55:48 -0400
Date: Wed, 26 Apr 2006 13:58:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove softlockup from invalidate_mapping_pages.
Message-Id: <20060426135809.10a37ec3.akpm@osdl.org>
In-Reply-To: <20060426204809.GA15462@uio.no>
References: <20060420160549.7637.patches@notabene>
	<1060420062955.7727@suse.de>
	<20060420003839.1a41c36f.akpm@osdl.org>
	<20060426204809.GA15462@uio.no>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Steinar H. Gunderson" <sgunderson@bigfoot.com> wrote:
>
> I tried this patch against 2.6.17-rc2 (I hoped that it might be fixing my
> kswapd oopses too, as they seem related; see
> http://lkml.org/lkml/2006/4/26/124 and followups), and it simply makes my
> machine hang on bootup -- it seems to make modprobe hang forever on some lock
> or something right after it loads raid6.ko (pulled in by evms_activate) in
> initramfs. Without the patch, the machine boots just fine.

It had a silly bug.  Fixed version:


diff -puN mm/truncate.c~remove-softlockup-from-invalidate_mapping_pages mm/truncate.c
--- devel/mm/truncate.c~remove-softlockup-from-invalidate_mapping_pages	2006-04-21 19:45:11.000000000 -0700
+++ devel-akpm/mm/truncate.c	2006-04-21 19:46:14.000000000 -0700
@@ -230,14 +230,24 @@ unsigned long invalidate_mapping_pages(s
 			pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
+			pgoff_t index;
+			int lock_failed;
 
-			if (TestSetPageLocked(page)) {
-				next++;
-				continue;
-			}
-			if (page->index > next)
-				next = page->index;
+			lock_failed = TestSetPageLocked(page);
+
+			/*
+			 * We really shouldn't be looking at the ->index of an
+			 * unlocked page.  But we're not allowed to lock these
+			 * pages.  So we rely upon nobody altering the ->index
+			 * of this (pinned-by-us) page.
+			 */
+			index = page->index;
+			if (index > next)
+				next = index;
 			next++;
+			if (lock_failed)
+				continue;
+
 			if (PageDirty(page) || PageWriteback(page))
 				goto unlock;
 			if (page_mapped(page))
_

