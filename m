Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268260AbUHTP0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268260AbUHTP0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267343AbUHTPYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:24:52 -0400
Received: from [193.12.224.70] ([193.12.224.70]:16075 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268230AbUHTPYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:24:01 -0400
Date: Fri, 20 Aug 2004 17:23:17 +0200
From: Erik Rigtorp <erik@rigtorp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] make swsusp produce nicer screen output
Message-ID: <20040820152317.GA7118@linux.nu>
Reply-To: erik@rigtorp.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

I made a small patch that makes swsusp produce a bit nicer screen output,
it's still a little rough though.

/Erik

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="swsusp-nicer-output.patch"

diff -Nru linux-2.6.8.1-mm2/kernel/power/disk.c linux-2.6.8.1-mm2-erkki/kernel/power/disk.c
--- linux-2.6.8.1-mm2/kernel/power/disk.c	2004-08-20 17:10:58.000000000 +0200
+++ linux-2.6.8.1-mm2-erkki/kernel/power/disk.c	2004-08-20 15:47:00.000000000 +0200
@@ -85,10 +85,17 @@
 
 static void free_some_memory(void)
 {
-	printk("Freeing memory: ");
-	while (shrink_all_memory(10000))
-		printk(".");
-	printk("|\n");
+	int i = 0;
+	char *p = "-\\|/";
+	
+	printk("Freeing memory:  ");
+	while (shrink_all_memory(10000)) {
+		printk("\b%c", p[i]);
+		i++;
+		if (i > 3)
+			i = 0;
+	}
+	printk("\bdone\n");
 }
 
 
diff -Nru linux-2.6.8.1-mm2/kernel/power/swsusp.c linux-2.6.8.1-mm2-erkki/kernel/power/swsusp.c
--- linux-2.6.8.1-mm2/kernel/power/swsusp.c	2004-08-20 17:10:58.000000000 +0200
+++ linux-2.6.8.1-mm2-erkki/kernel/power/swsusp.c	2004-08-20 16:13:29.000000000 +0200
@@ -296,15 +296,16 @@
 {
 	int error = 0;
 	int i;
-
-	printk( "Writing data to swap (%d pages): ", nr_copy_pages );
+	int mod = nr_copy_pages / 100;
+	
+	printk( "Writing data to swap (%d pages):     ", nr_copy_pages );
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
 
@@ -1150,14 +1151,15 @@
 	struct pbe * p;
 	int error;
 	int i;
-
+	int mod = nr_copy_pages / 100;
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

--bg08WKrSYDhXBjb5--
