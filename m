Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVIYSp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVIYSp0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 14:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbVIYSp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 14:45:26 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:966 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932260AbVIYSpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 14:45:25 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 1/3][Fix] swsusp: remove wrong code from data_free
Date: Sun, 25 Sep 2005 20:24:34 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200509252018.36867.rjw@sisk.pl>
In-Reply-To: <200509252018.36867.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509252024.34415.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch removes some wrong code from the data_free() function in
swsusp.

This function could only be called if there's an arror while writing the suspend
image to swap, so it is not triggered easily.  However, if triggered, it would
probably corrupt some memory.

Please apply,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-rc2-git3.orig/kernel/power/swsusp.c	2005-09-25 18:45:03.000000000 +0200
+++ linux-2.6.14-rc2-git3/kernel/power/swsusp.c	2005-09-25 18:49:00.000000000 +0200
@@ -402,15 +402,14 @@
 static void data_free(void)
 {
 	swp_entry_t entry;
-	int i;
+	struct pbe * p;
 
-	for (i = 0; i < nr_copy_pages; i++) {
-		entry = (pagedir_nosave + i)->swap_address;
+	for_each_pbe(p, pagedir_nosave) {
+		entry = p->swap_address;
 		if (entry.val)
 			swap_free(entry);
 		else
 			break;
-		(pagedir_nosave + i)->swap_address = (swp_entry_t){0};
 	}
 }
 

