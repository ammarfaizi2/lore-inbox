Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261363AbSJPUNm>; Wed, 16 Oct 2002 16:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJPUNm>; Wed, 16 Oct 2002 16:13:42 -0400
Received: from 2-136.ctame701-1.telepar.net.br ([200.193.160.136]:1504 "EHLO
	2-136.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261363AbSJPUNl>; Wed, 16 Oct 2002 16:13:41 -0400
Date: Wed, 16 Oct 2002 18:19:30 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] show nr_running and nr_iowait_tasks
Message-ID: <Pine.LNX.4.44L.0210161817590.22993-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this trivial patch, against 2.5-current, exports nr_running
and nr_iowait_tasks in /proc/stat.  With this patch in vmstat
will no longer need to walk all the processes in the system
just to determine the number of running and blocked processes.

please apply,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


===== fs/proc/proc_misc.c 1.49 vs edited =====
--- 1.49/fs/proc/proc_misc.c	Tue Oct 15 20:32:38 2002
+++ edited/fs/proc/proc_misc.c	Wed Oct 16 18:17:24 2002
@@ -39,6 +39,7 @@
 #include <linux/seq_file.h>
 #include <linux/times.h>
 #include <linux/profile.h>
+#include <linux/blkdev.h>

 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -404,10 +405,14 @@
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
-		"processes %lu\n",
+		"processes %lu\n"
+		"procs_running %lu\n"
+		"procs_blocked %u\n",
 		nr_context_switches(),
 		xtime.tv_sec - jif / HZ,
-		total_forks);
+		total_forks,
+		nr_running(),
+		atomic_read(&nr_iowait_tasks));

 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

