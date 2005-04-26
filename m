Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVDZKtC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVDZKtC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVDZKtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:49:02 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44947 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261480AbVDZKqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:46:40 -0400
Date: Tue, 26 Apr 2005 12:46:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 3/3] swsusp: fix nr_copy_pages
Message-ID: <20050426104623.GA18028@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch moves the recalculation of nr_copy_pages so that the
right number is used in the calculation of the size of memory and swap needed.
    
It prevents swsusp from attempting to suspend if there is not enough memory
and/or swap (which is unlikely anyway).
    
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pavel Machek <pavel@suse.cz>

Index: kernel/power/swsusp.c
===================================================================
--- d8c41efce19593001c280a07cde0506788b4347d/kernel/power/swsusp.c  (mode:100644 sha1:c3bf8c03c883657ff6bc5237868fe9a6494372e4)
+++ 692e5ecfee912a0752ee685f9f757911040f6750/kernel/power/swsusp.c  (mode:100644 sha1:880a42b1dd1bee261ea61bee2a3cb839df1ef1d0)
@@ -781,18 +781,18 @@
 {
 	int error;
 
+	pagedir_nosave = NULL;
+	nr_copy_pages = calc_nr(nr_copy_pages);
+
 	pr_debug("suspend: (pages needed: %d + %d free: %d)\n",
 		 nr_copy_pages, PAGES_FOR_IO, nr_free_pages());
 
-	pagedir_nosave = NULL;
 	if (!enough_free_mem())
 		return -ENOMEM;
 
 	if (!enough_swap())
 		return -ENOSPC;
 
-	nr_copy_pages = calc_nr(nr_copy_pages);
-
 	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return -ENOMEM;



-- 
Boycott Kodak -- for their patent abuse against Java.
