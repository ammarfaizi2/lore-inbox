Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbWKDKdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbWKDKdl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 05:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965284AbWKDKdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 05:33:41 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:11987 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965276AbWKDKdk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 05:33:40 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: Measure memory shrinking time
Date: Sat, 4 Nov 2006 11:31:39 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611041131.40323.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make swsusp measure and print the time needed to shrink memory during the
suspend.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/power.h  |    4 ++++
 kernel/power/swap.c   |   24 ++----------------------
 kernel/power/swsusp.c |   33 +++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 22 deletions(-)

Index: linux-2.6.19-rc4-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/power/power.h
+++ linux-2.6.19-rc4-mm2/kernel/power/power.h
@@ -171,3 +171,7 @@ extern int swsusp_read(void);
 extern int swsusp_write(void);
 extern void swsusp_close(void);
 extern int suspend_enter(suspend_state_t state);
+
+struct timeval;
+extern void swsusp_show_speed(struct timeval *, struct timeval *,
+				unsigned int, char *);
Index: linux-2.6.19-rc4-mm2/kernel/power/swap.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/power/swap.c
+++ linux-2.6.19-rc4-mm2/kernel/power/swap.c
@@ -133,26 +133,6 @@ static int wait_on_bio_chain(struct bio 
 	return ret;
 }
 
-static void show_speed(struct timeval *start, struct timeval *stop,
-			unsigned nr_pages, char *msg)
-{
-	s64 elapsed_centisecs64;
-	int centisecs;
-	int k;
-	int kps;
-
-	elapsed_centisecs64 = timeval_to_ns(stop) - timeval_to_ns(start);
-	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
-	centisecs = elapsed_centisecs64;
-	if (centisecs == 0)
-		centisecs = 1;	/* avoid div-by-zero */
-	k = nr_pages * (PAGE_SIZE / 1024);
-	kps = (k * 100) / centisecs;
-	printk("%s %d kbytes in %d.%02d seconds (%d.%02d MB/s)\n", msg, k,
-			centisecs / 100, centisecs % 100,
-			kps / 1000, (kps % 1000) / 10);
-}
-
 /*
  * Saving part
  */
@@ -375,7 +355,7 @@ static int save_image(struct swap_map_ha
 		error = err2;
 	if (!error)
 		printk("\b\b\b\bdone\n");
-	show_speed(&start, &stop, nr_to_write, "Wrote");
+	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
 	return error;
 }
 
@@ -562,7 +542,7 @@ static int load_image(struct swap_map_ha
 		if (!snapshot_image_loaded(snapshot))
 			error = -ENODATA;
 	}
-	show_speed(&start, &stop, nr_to_read, "Read");
+	swsusp_show_speed(&start, &stop, nr_to_read, "Read");
 	return error;
 }
 
Index: linux-2.6.19-rc4-mm2/kernel/power/swsusp.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/power/swsusp.c
+++ linux-2.6.19-rc4-mm2/kernel/power/swsusp.c
@@ -49,6 +49,7 @@
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/highmem.h>
+#include <linux/time.h>
 
 #include "power.h"
 
@@ -164,6 +165,34 @@ void free_all_swap_pages(int swap, struc
 }
 
 /**
+ *	swsusp_show_speed - print the time elapsed between two events represented by
+ *	@start and @stop
+ *
+ *	@nr_pages -	number of pages processed between @start and @stop
+ *	@msg -		introductory message to print
+ */
+
+void swsusp_show_speed(struct timeval *start, struct timeval *stop,
+			unsigned nr_pages, char *msg)
+{
+	s64 elapsed_centisecs64;
+	int centisecs;
+	int k;
+	int kps;
+
+	elapsed_centisecs64 = timeval_to_ns(stop) - timeval_to_ns(start);
+	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
+	centisecs = elapsed_centisecs64;
+	if (centisecs == 0)
+		centisecs = 1;	/* avoid div-by-zero */
+	k = nr_pages * (PAGE_SIZE / 1024);
+	kps = (k * 100) / centisecs;
+	printk("%s %d kbytes in %d.%02d seconds (%d.%02d MB/s)\n", msg, k,
+			centisecs / 100, centisecs % 100,
+			kps / 1000, (kps % 1000) / 10);
+}
+
+/**
  *	swsusp_shrink_memory -  Try to free as much memory as needed
  *
  *	... but do not OOM-kill anyone
@@ -187,8 +216,10 @@ int swsusp_shrink_memory(void)
 	unsigned long pages = 0;
 	unsigned int i = 0;
 	char *p = "-\\|/";
+	struct timeval start, stop;
 
 	printk("Shrinking memory...  ");
+	do_gettimeofday(&start);
 	do {
 		long size, highmem_size;
 
@@ -222,7 +253,9 @@ int swsusp_shrink_memory(void)
 		}
 		printk("\b%c", p[i++%4]);
 	} while (tmp > 0);
+	do_gettimeofday(&stop);
 	printk("\bdone (%lu pages freed)\n", pages);
+	swsusp_show_speed(&start, &stop, pages, "Freed");
 
 	return 0;
 }
