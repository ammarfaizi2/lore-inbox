Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUIJJdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUIJJdL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUIJJba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:31:30 -0400
Received: from checkpoint-out.gate.uni-erlangen.de ([131.188.28.69]:42694 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267335AbUIJJa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:30:59 -0400
Date: Fri, 10 Sep 2004 10:47:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: progress in percent
Message-ID: <20040910084704.GB12751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

swsusp currently has very poor progress indication. Thanks to Erik
Rigtorp <erik@rigtorp.com>, we have percentages there, so people know
how long wait to expect. Please apply,

[I'd prefer this to be start of "next batch" of changes to linus. It
would be nice if linus could pull previous version from power tree...]

From: Erik Rigtorp <erik@rigtorp.com>
Signed-off-by: Pavel Machek <pavel@suse.cz>

								Pavel

--- clean-mm/kernel/power/disk.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/disk.c	2004-09-08 22:47:41.000000000 +0200
@@ -91,10 +91,20 @@
 
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
+	unsigned int i = 0;
+	unsigned int tmp;
+	unsigned long pages = 0;
+	char *p = "-\\|/";
+	
+	printk("Freeing memory...  ");
+	while ((tmp = shrink_all_memory(10000))) {
+		pages += tmp;
+		printk("\b%c", p[i]);
+		i++;
+		if (i > 3)
+			i = 0;
+	}
+	printk("\bdone (%li pages freed)\n", pages);
 }
 
 
--- clean-mm/kernel/power/swsusp.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-09-09 08:56:20.000000000 +0200
@@ -296,15 +292,19 @@
 {
 	int error = 0;
 	int i;
-
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	unsigned int mod = nr_copy_pages / 100;
+	
+	if (!mod)
+		mod = 1;
+	
+	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
 	for (i = 0; i < nr_copy_pages && !error; i++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = write_page((pagedir_nosave+i)->address,
 					  &((pagedir_nosave+i)->swap_address));
 	}
-	printk(" %d Pages done.\n",i);
+	printk("\b\b\b\bdone\n");
 	return error;
 }
 
@@ -1153,14 +1120,18 @@
 	struct pbe * p;
 	int error;
 	int i;
-
+	int mod = nr_copy_pages / 100;
+	
+	if (!mod)
+		mod = 1;
+	
 	if ((error = swsusp_pagedir_relocate()))
 		return error;
 
-	printk( "Reading image data (%d pages): ", nr_copy_pages );
+	printk( "Reading image data (%d pages):     ", nr_copy_pages );
 	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
-		if (!(i%100))
-			printk( "." );
+		if (!(i%mod))
+			printk( "\b\b\b\b%3d%%", i / mod );
 		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
 	}


