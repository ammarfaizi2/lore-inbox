Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVDWVrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVDWVrz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVDWVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:47:55 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:41119 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262044AbVDWVrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:47:49 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: misc cleanups [1/4]
Date: Sat, 23 Apr 2005 23:25:57 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504232320.54477.rjw@sisk.pl>
In-Reply-To: <200504232320.54477.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504232325.57543.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch moves the recalculation of nr_copy_pages so that the
right number is used in the calculation of the size of memory and swap needed.

It prevents swsusp from attempting to suspend if there is not enough memory
and/or swap (which is unlikely anyway).

Please consider for applying.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nurp a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2005-04-22 14:48:04.000000000 +0200
+++ b/kernel/power/swsusp.c	2005-04-23 21:29:00.000000000 +0200
@@ -781,18 +781,18 @@ static int swsusp_alloc(void)
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
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

