Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVEaHNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVEaHNg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVEaHNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:13:36 -0400
Received: from gate.crashing.org ([63.228.1.57]:60334 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261280AbVEaHNX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:13:23 -0400
Subject: [PATCH] Don't explode on swsusp failure to find swap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 31 May 2005 17:13:05 +1000
Message-Id: <1117523585.5826.18.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

If we specify a swap device for swsusp using resume= kernel argument and
that device doesn't exist in the swap list, we end up calling
swsusp_free() before we have allocated pagedir_save. That causes us to
explode when trying to free it.

Pavel, does that look right ?

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/kernel/power/swsusp.c
===================================================================
--- linux-work.orig/kernel/power/swsusp.c	2005-05-31 16:29:22.000000000 +1000
+++ linux-work/kernel/power/swsusp.c	2005-05-31 16:57:30.000000000 +1000
@@ -730,10 +730,13 @@
 
 void swsusp_free(void)
 {
+	if (pagedir_save == NULL)
+		return;
 	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
 	BUG_ON(PageNosaveFree(virt_to_page(pagedir_save)));
 	free_image_pages();
 	free_pagedir(pagedir_save);
+	pagedir_save = NULL;
 }
 
 


