Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293747AbSCKN7n>; Mon, 11 Mar 2002 08:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310128AbSCKN7e>; Mon, 11 Mar 2002 08:59:34 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26889 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S293746AbSCKN7Q>; Mon, 11 Mar 2002 08:59:16 -0500
Message-Id: <200203111356.g2BDuhq05400@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] KERN_INFO 2.4.19-pre2 init/* mm/*
Date: Mon, 11 Mar 2002 15:55:58 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
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

diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/init/main.c linux-new/init/main.c
--- linux-2.4.19-pre2/init/main.c	Tue Mar  5 12:43:03 2002
+++ linux-new/init/main.c	Mon Mar 11 12:16:22 2002
@@ -164,7 +164,7 @@
 
 	loops_per_jiffy = (1<<12);
 
-	printk("Calibrating delay loop... ");
+	printk(KERN_INFO "Calibrating delay loop... ");
 	while (loops_per_jiffy <<= 1) {
 		/* wait for "start of" clock tick */
 		ticks = jiffies;
@@ -316,12 +316,13 @@
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
@@ -355,9 +356,9 @@
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
@@ -417,7 +418,7 @@
 	ipc_init();
 #endif
 	check_bugs();
-	printk("POSIX conformance testing by UNIFIX\n");
+	printk(KERN_INFO "POSIX conformance testing by UNIFIX\n");
 
 	/* 
 	 *	We count on the initial thread going ok 
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/mm/filemap.c linux-new/mm/filemap.c
--- linux-2.4.19-pre2/mm/filemap.c	Tue Mar  5 12:43:04 2002
+++ linux-new/mm/filemap.c	Mon Mar 11 12:16:23 2002
@@ -3172,7 +3172,7 @@
 			__get_free_pages(GFP_ATOMIC, order);
 	} while(page_hash_table == NULL && --order > 0);
 
-	printk("Page-cache hash table entries: %d (order: %ld, %ld bytes)\n",
+	printk(KERN_INFO "Page cache hash table entries: %d (order: %ld, %ld bytes)\n",
 	       (1 << page_hash_bits), order, (PAGE_SIZE << order));
 	if (!page_hash_table)
 		panic("Failed to allocate page hash table\n");
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/mm/page_alloc.c linux-new/mm/page_alloc.c
--- linux-2.4.19-pre2/mm/page_alloc.c	Tue Mar  5 12:43:04 2002
+++ linux-new/mm/page_alloc.c	Mon Mar 11 12:16:23 2002
@@ -724,7 +724,7 @@
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			realtotalpages -= zholes_size[i];
 			
-	printk("On node %d totalpages: %lu\n", nid, realtotalpages);
+	printk(KERN_INFO "On node %d totalpages: %lu\n", nid, realtotalpages);
 
 	INIT_LIST_HEAD(&active_list);
 	INIT_LIST_HEAD(&inactive_list);
@@ -759,7 +759,7 @@
 		if (zholes_size)
 			realsize -= zholes_size[j];
 
-		printk("zone(%lu): %lu pages.\n", j, size);
+		printk(KERN_INFO "zone(%lu): %lu pages\n", j, size);
 		zone->size = size;
 		zone->name = zone_names[j];
 		zone->lock = SPIN_LOCK_UNLOCKED;
diff -u --recursive -x *.orig -x *.rej linux-2.4.19-pre2/mm/vmscan.c linux-new/mm/vmscan.c
--- linux-2.4.19-pre2/mm/vmscan.c	Tue Mar  5 12:43:04 2002
+++ linux-new/mm/vmscan.c	Mon Mar 11 12:16:23 2002
@@ -751,7 +751,7 @@
 
 static int __init kswapd_init(void)
 {
-	printk("Starting kswapd\n");
+	printk(KERN_INFO "Starting kswapd\n");
 	swap_setup();
 	kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
 	return 0;
