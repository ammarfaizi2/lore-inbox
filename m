Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVL3THA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVL3THA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 14:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVL3THA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 14:07:00 -0500
Received: from thorn.pobox.com ([208.210.124.75]:60289 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S1751287AbVL3TG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 14:06:59 -0500
Date: Fri, 30 Dec 2005 11:06:53 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Cc: alan@redhat.com, willy@w.ods.org
Subject: [PATCH] add CommitLimit, Committed_AS to 2.4 strict VM overcommit
Message-ID: <20051230190653.GA7548@ip68-225-251-162.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two more lines of output to /proc/meminfo, CommitLimit
and Committed_AS. On a system running the strict VM overcommit patch,
these are useful bits of information (especially Committed_AS, which
lets you know how close you are to full committment).

This particular patch is part of a patch from the Red Hat Enterprise
Linux 3 kernel, rediffed against 2.4.33-pre1 + the strict VM overcommit
patch I posted earlier. However, the 2.6 kernel contains very similar
code that provides the same output in /proc/meminfo.

Signed-off-by: Barry K. Nathan <barryn@pobox.com>

diff -ruN linux-2.4.33-pre1-memA/Documentation/vm/overcommit-accounting linux-2.4.33-pre1-memB/Documentation/vm/overcommit-accounting
--- linux-2.4.33-pre1-memA/Documentation/vm/overcommit-accounting	Thu Dec 29 20:39:30 2005
+++ linux-2.4.33-pre1-memB/Documentation/vm/overcommit-accounting	Thu Dec 29 20:41:05 2005
@@ -22,6 +22,13 @@
 		will never kill a process accessing pages it has mapped
 		except due to a bug (ie report it!)
 
+The overcommit policy is set via the sysctl `vm.overcommit_memory'.
+
+The overcommit percentage is set via `vm.overcommit_ratio'.
+
+The current overcommit limit and amount committed are viewable in
+/proc/meminfo as CommitLimit and Committed_AS respectively.
+
 Gotchas
 -------
 
diff -ruN linux-2.4.33-pre1-memA/fs/proc/proc_misc.c linux-2.4.33-pre1-memB/fs/proc/proc_misc.c
--- linux-2.4.33-pre1-memA/fs/proc/proc_misc.c	Thu Dec 29 20:39:30 2005
+++ linux-2.4.33-pre1-memB/fs/proc/proc_misc.c	Thu Dec 29 20:41:05 2005
@@ -158,11 +158,9 @@
 	struct sysinfo i;
 	int len;
 	int pg_size ;
-	int committed;
+	unsigned long committed;
+	unsigned long allowed;
 
-	/* FIXME: needs to be in headers */
-	extern atomic_t vm_committed_space;
-	
 /*
  * display in kilobytes.
  */
@@ -172,6 +170,8 @@
 	si_swapinfo(&i);
 	pg_size = page_cache_size - i.bufferram;
 	committed = atomic_read(&vm_committed_space);
+	allowed = (i.totalram * sysctl_overcommit_ratio / 100)
+		  + total_swap_pages;
 
 	len = sprintf(page, "        total:    used:    free:  shared: buffers:  cached:\n"
 		"Mem:  %8Lu %8Lu %8Lu %8Lu %8Lu %8Lu\n"
@@ -199,7 +199,9 @@
 		"LowTotal:     %8lu kB\n"
 		"LowFree:      %8lu kB\n"
 		"SwapTotal:    %8lu kB\n"
-		"SwapFree:     %8lu kB\n",
+		"SwapFree:     %8lu kB\n"
+		"CommitLimit:  %8lu kB\n"
+		"Committed_AS: %8lu kB\n",
 		K(i.totalram),
 		K(i.freeram),
 		K(i.sharedram),
@@ -213,7 +215,9 @@
 		K(i.totalram-i.totalhigh),
 		K(i.freeram-i.freehigh),
 		K(i.totalswap),
-		K(i.freeswap));
+		K(i.freeswap),
+		K(allowed),
+		K(committed));
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef B
diff -ruN linux-2.4.33-pre1-memA/include/linux/mman.h linux-2.4.33-pre1-memB/include/linux/mman.h
--- linux-2.4.33-pre1-memA/include/linux/mman.h	Thu Dec 29 20:39:30 2005
+++ linux-2.4.33-pre1-memB/include/linux/mman.h	Thu Dec 29 20:41:05 2005
@@ -9,5 +9,7 @@
 extern int vm_enough_memory(long pages);
 extern void vm_unacct_memory(long pages);
 extern void vm_validate_enough(char *x);
+extern atomic_t vm_committed_space;
+extern int sysctl_overcommit_ratio;
 
 #endif /* _LINUX_MMAN_H */
