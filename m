Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUBFWlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 17:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266890AbUBFWlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 17:41:19 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:13190 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S266879AbUBFWky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 17:40:54 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] 2.4.25-rc1: Shutdown kernel on zone-alignment failure
Date: Sat, 7 Feb 2004 06:39:49 +0800
User-Agent: KMail/1.5.4
Cc: axboe@suse.de, "Randy.Dunlap" <rddunlap@osdl.org>, riel@redhat.com,
       linux-kernel@vger.kernel.org
References: <200402070534.46123.mhf@linuxmail.org>
In-Reply-To: <200402070534.46123.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402070639.49377.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcello,

Another thing,

The BUG() call on line 732 in mm/page_alloc.c is invalid as the BUG handler 
is not initialized. It just will hang.

This updated patch fixes that as well.

Regards
Michael

diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.25-rc1-Vanilla/include/linux/kernel.h linux-2.4.25-rc1-mhf176/include/linux/kernel.h
--- linux-2.4.25-rc1-Vanilla/include/linux/kernel.h	2004-02-06 17:09:26.000000000 +0800
+++ linux-2.4.25-rc1-mhf176/include/linux/kernel.h	2004-02-07 05:59:30.000000000 +0800
@@ -45,7 +45,7 @@
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
 
-# define NORET_TYPE    /**/
+# define NORET_TYPE   
 # define ATTRIB_NORET  __attribute__((noreturn))
 # define NORET_AND     noreturn,
 
@@ -104,7 +104,7 @@
 
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
-
+extern int force_bug;			/* If set, BUG() will be forced when handler initialized */
 extern int tainted;
 extern const char *print_tainted(void);
 
diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.25-rc1-Vanilla/init/main.c linux-2.4.25-rc1-mhf176/init/main.c
--- linux-2.4.25-rc1-Vanilla/init/main.c	2004-02-06 17:06:58.000000000 +0800
+++ linux-2.4.25-rc1-mhf176/init/main.c	2004-02-07 05:11:07.000000000 +0800
@@ -121,6 +121,7 @@
 extern void time_init(void);
 extern void softirq_init(void);
 
+int force_bug;
 int rows, cols;
 
 char *execute_command;
@@ -422,6 +423,14 @@
 	ccwcache_init();
 #endif
 	signals_init();
+
+	/*
+	 * Something went badly wrong during the early initialisation process,
+	 * so lets die before doing any damage or wasting people's time 
+	 * running a half dead kernel.
+	 */
+	if (force_bug)
+		BUG();
 #ifdef CONFIG_PROC_FS
 	proc_root_init();
 #endif
diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.25-rc1-Vanilla/mm/page_alloc.c linux-2.4.25-rc1-mhf176/mm/page_alloc.c
--- linux-2.4.25-rc1-Vanilla/mm/page_alloc.c	2004-02-06 17:06:58.000000000 +0800
+++ linux-2.4.25-rc1-mhf176/mm/page_alloc.c	2004-02-07 06:36:00.000000000 +0800
@@ -726,10 +726,19 @@
 	unsigned long i, j;
 	unsigned long map_size;
 	unsigned long totalpages, offset, realtotalpages;
-	const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);
+	const unsigned long zone_required_alignment = 1UL << (PAGE_SHIFT + MAX_ORDER-1);
+	unsigned long zone_bad_alignment;
 
-	if (zone_start_paddr & ~PAGE_MASK)
-		BUG();
+	/*
+	 * We abort when physical address is bad. arch/mm/init.c should catch it
+	 * if not, setup/main.c will
+	 */
+	if (zone_start_paddr & ~PAGE_MASK) {
+		printk("FATAL ERROR: wrong zone physical start address at: 0x%lx"
+			" - will force kernel BUG\n", zone_start_paddr);
+		force_bug = 1;
+		return;
+	}
 
 	totalpages = 0;
 	for (i = 0; i < MAX_NR_ZONES; i++) {
@@ -741,7 +750,8 @@
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			realtotalpages -= zholes_size[i];
 			
-	printk("On node %d totalpages: %lu\n", nid, realtotalpages);
+	printk("On node %d totalpages: %lu, zones aligned at: 0x%lx\n",
+	       nid, realtotalpages,zone_required_alignment);
 
 	/*
 	 * Some architectures (with lots of mem and discontinous memory
@@ -774,7 +784,20 @@
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		printk("zone(%lu): %lu pages.\n", j, size);
+		printk("zone(%lu): %lu pages, physical start address at: 0x%lx\n",
+		       j, size,zone_start_paddr);
+
+		/*
+		 * Here the alignment of a zone is checked. Should alignment
+		 * be wrong, all that can be done is to print an error message
+		 * and defer the the BUG handler as it is not yet initialized.
+		 */
+		if ((zone_bad_alignment = (zone_start_paddr & (zone_required_alignment-1)))) {
+			printk("zone(%lu): FATAL ERROR: wrong zone alignment: 0x%lx"
+			       " - will force kernel BUG\n",
+			       j,zone_bad_alignment);
+			force_bug = 1;
+		}
 		zone->size = size;
 		zone->realsize = realsize;
 		zone->name = zone_names[j];
@@ -784,7 +807,6 @@
 		zone->need_balance = 0;
 		 zone->nr_active_pages = zone->nr_inactive_pages = 0;
 
-
 		if (!size)
 			continue;
 
@@ -837,8 +859,6 @@
 		zone->zone_start_mapnr = offset;
 		zone->zone_start_paddr = zone_start_paddr;
 
-		if ((zone_start_paddr >> PAGE_SHIFT) & (zone_required_alignment-1))
-			printk("BUG: wrong zone alignment, it will crash\n");
 
 		/*
 		 * Initially all pages are reserved - free ones are freed

