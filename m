Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280416AbRKJB54>; Fri, 9 Nov 2001 20:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280417AbRKJB5g>; Fri, 9 Nov 2001 20:57:36 -0500
Received: from jalon.able.es ([212.97.163.2]:680 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S280416AbRKJB5a>;
	Fri, 9 Nov 2001 20:57:30 -0500
Date: Sat, 10 Nov 2001 02:57:22 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Alan Cox <laughing@shared-source.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: cache acoounting in Linus tree
Message-ID: <20011110025722.A1526@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Does Linus' tree need the cache accounting patch ? Listed below. Please,
confirm or deny....

--- linux-2.4.13-ac5/fs/proc/proc_misc.c.blkpg	Wed Oct 31 13:09:51 2001
+++ linux-2.4.13-ac5/fs/proc/proc_misc.c	Wed Oct 31 13:12:27 2001
@@ -140,7 +140,9 @@
 {
 	struct sysinfo i;
 	int len;
-	int pg_size ;
+	unsigned int cached;
+
+	cached = atomic_read(&page_cache_size) - atomic_read(&shmem_nrpages);

 /*
  * display in kilobytes.
@@ -149,14 +151,12 @@
 #define B(x) ((unsigned long long)(x) << PAGE_SHIFT)
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	pg_size = atomic_read(&page_cache_size) - i.bufferram ;
-
 	len = sprintf(page, "        total:    used:    free:  shared: buffers:  cached:\n"
 		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
 		"Swap: %8Lu %8Lu %8Lu\n",
 		B(i.totalram), B(i.totalram-i.freeram), B(i.freeram),
 		B(i.sharedram), B(i.bufferram),
-		B(pg_size), B(i.totalswap),
+		B(cached), B(i.totalswap),
 		B(i.totalswap-i.freeswap), B(i.freeswap));
 	/*
 	 * Tagged format, for easy grepping and expansion.
@@ -182,7 +182,7 @@
 		K(i.freeram),
 		K(i.sharedram),
 		K(i.bufferram),
-		K(pg_size - swapper_space.nrpages),
+		K(cached - swapper_space.nrpages),
 		K(swapper_space.nrpages),
 		K(nr_active_pages),
 		K(nr_inactive_pages),

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.15-pre2-beo #1 SMP Sat Nov 10 02:24:33 CET 2001 i686
