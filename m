Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSA1IIA>; Mon, 28 Jan 2002 03:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSA1IHv>; Mon, 28 Jan 2002 03:07:51 -0500
Received: from [195.66.192.167] ([195.66.192.167]:39692 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289139AbSA1IHh>; Mon, 28 Jan 2002 03:07:37 -0500
Message-Id: <200201280802.g0S82SE21806@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] KERN_INFO for init/*, mm/* files
Date: Mon, 28 Jan 2002 10:02:31 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Primary purpose of this patch is to make KERN_WARNING and
KERN_INFO log levels closer to their original meaning.
Today they are quite far from what was intended.
Just look what kernel writes at the WARNING level
each time you boot your box!

Diff for:
init/main.c
mm/filemap.c
mm/page_alloc.c
mm/vmscan.c
--
vda

diff --recursive -u linux-2.4.13-orig/init/main.c linux-2.4.13-new/init/main.c
--- linux-2.4.13-orig/init/main.c	Fri Oct 12 15:17:15 2001
+++ linux-2.4.13-new/init/main.c	Thu Nov  8 23:42:11 2001
@@ -340,7 +340,7 @@

 	loops_per_jiffy = (1<<12);

-	printk("Calibrating delay loop... ");
+	printk(KERN_INFO "Calibrating delay loop... ");
 	while (loops_per_jiffy <<= 1) {
 		/* wait for "start of" clock tick */
 		ticks = jiffies;
@@ -510,12 +510,13 @@
 	smp_commence();

 	/* Wait for the other cpus to set up their idle processes */
-	printk("Waiting on wait_init_idle (map = 0x%lx)\n", wait_init_idle);
+	printk(KERN_INFO "Waiting on wait_init_idle (map = 0x%lx)\n",
+		wait_init_idle);
 	while (wait_init_idle) {
 		cpu_relax();
 		barrier();
 	}
-	printk("All processors have done init_idle\n");
+	printk(KERN_INFO "All processors have done init_idle\n");
 }

 #endif
@@ -549,9 +550,9 @@
  * enable them
  */
 	lock_kernel();
-	printk(linux_banner);
+	printk(KERN_INFO); printk(linux_banner);
 	setup_arch(&command_line);
-	printk("Kernel command line: %s\n", saved_command_line);
+	printk(KERN_INFO "Kernel command line: %s\n", saved_command_line);
 	parse_options(command_line);
 	trap_init();
 	init_IRQ();
@@ -609,7 +610,7 @@
 	ipc_init();
 #endif
 	check_bugs();
-	printk("POSIX conformance testing by UNIFIX\n");
+	printk(KERN_INFO "POSIX conformance testing by UNIFIX\n");

 	/*
 	 *	We count on the initial thread going ok
diff --recursive -u linux-2.4.13-orig/mm/filemap.c linux-2.4.13-new/mm/filemap.c
--- linux-2.4.13-orig/mm/filemap.c	Tue Oct 23 22:52:48 2001
+++ linux-2.4.13-new/mm/filemap.c	Thu Nov  8 23:42:11 2001
@@ -2844,7 +2844,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while(page_hash_table == NULL && --order > 0);

-	printk("Page-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Page cache hash table entries: %d (order: %ld, %ld bytes)\n",
 	       (1 << page_hash_bits), order, (PAGE_SIZE << order));
 	if (!page_hash_table)
 		panic("Failed to allocate page hash table\n");
diff --recursive -u linux-2.4.13-orig/mm/page_alloc.c linux-2.4.13-new/mm/page_alloc.c
--- linux-2.4.13-orig/mm/page_alloc.c	Wed Oct 24 02:40:32 2001
+++ linux-2.4.13-new/mm/page_alloc.c	Thu Nov  8 23:42:11 2001
@@ -657,7 +657,7 @@
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			realtotalpages -= zholes_size[i];

-	printk("On node %d totalpages: %lu\n", nid, realtotalpages);
+	printk(KERN_INFO "On node %d totalpages: %lu\n", nid, realtotalpages);

 	INIT_LIST_HEAD(&active_list);
 	INIT_LIST_HEAD(&inactive_list);
@@ -703,7 +703,7 @@
 		if (zholes_size)
 			realsize -= zholes_size[j];

-		printk("zone(%lu): %lu pages.\n", j, size);
+		printk(KERN_INFO "zone(%lu): %lu pages\n", j, size);
 		zone->size = size;
 		zone->name = zone_names[j];
 		zone->lock = SPIN_LOCK_UNLOCKED;
diff --recursive -u linux-2.4.13-orig/mm/vmscan.c linux-2.4.13-new/mm/vmscan.c
--- linux-2.4.13-orig/mm/vmscan.c	Wed Oct 24 02:48:55 2001
+++ linux-2.4.13-new/mm/vmscan.c	Thu Nov  8 23:42:11 2001
@@ -730,7 +730,7 @@

 static int __init kswapd_init(void)
 {
-	printk("Starting kswapd\n");
+	printk(KERN_INFO "Starting kswapd\n");
 	swap_setup();
 	kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	return 0;
