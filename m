Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263288AbRFRCMZ>; Sun, 17 Jun 2001 22:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263294AbRFRCMF>; Sun, 17 Jun 2001 22:12:05 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12552 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S263288AbRFRCMB>;
	Sun, 17 Jun 2001 22:12:01 -0400
Date: Sun, 17 Jun 2001 23:11:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: [PATCH] saner limit for max_threads
Message-ID: <Pine.LNX.4.21.0106172308240.2056-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

by default the limit for max_threads is such that
the system will try to allocate up to half the
physical memory in task_structs.

Because for each 8kB task struct we'll often want
a struct_mm, a page directory, 3 page tables and
some more structures, this means that a fork bomb
will leave the box DEAD with root never ever getting
a chance of using his reserved tasks and killing the
bad user.

The patch below adjusts the max_threads calculation
to something which should be more sane, though quite
possibly still to high...

Please apply for the next -pre kernel.

thanks,

Rik
--
http://www.surriel.com/		http://distro.conectiva.com/


--- linux-2.4.6-pre3/kernel/fork.c.orig	Sun Jun 17 20:45:54 2001
+++ linux-2.4.6-pre3/kernel/fork.c	Sun Jun 17 23:07:20 2001
@@ -70,7 +70,7 @@
 	 * value: the thread structures can take up at most half
 	 * of memory.
 	 */
-	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 2;
+	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 16;
 
 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;

