Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264424AbRFIBB5>; Fri, 8 Jun 2001 21:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264425AbRFIBBr>; Fri, 8 Jun 2001 21:01:47 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:14603 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S264424AbRFIBBl>; Fri, 8 Jun 2001 21:01:41 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
cc: pmenage@ensim.com
Subject: [PATCH] Race between sys_swapon and /proc/swaps (2.2)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Jun 2001 17:59:14 -0700
Message-Id: <E158X5u-0004H2-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the equivalent patch for Linux 2.2 (prepared against 2.2.19) 
for the swapon/procfs race also described in my previous email.

sys_swapon() sets SWP_USED in p->flags when it begins to set up a swap
area, and then calls vmalloc() to allocate p->swap_map[], which may
sleep. Most other users of the swap info structures either traverse the
swap list (to which the new swap area hasn't yet been added) or check
SWP_WRITEOK (which hasn't yet been set), but get_swaparea_info() only
checks for SWP_USED, and then proceeds to dereference ptr->swap_map. So
reading /proc/swaps whilst doing a swapon() can Oops. 

This could either be solved by making get_swaparea_info() check for 
ptr->swap_map, or check for ((ptr->flags & SWP_WRITEOK) == SWP_WRITEOK).
The patch below (applicable to 2.2 - patch for 2.4 in previous email)
checks for the former on the grounds that that is what's causing the
immediate problem, and some people might want to be able to use 
/proc/swaps to track the progress of a swapoff().

Paul

diff -u linux/mm/swapfile.c linux/mm/swapfile.c
--- linux/mm/swapfile.c    Wed May  9 23:34:24 2001
+++ linux.new/mm/swapfile.c         Fri Jun  8 17:00:54 2001
@@ -448,7 +448,7 @@
 
 	len += sprintf(buf, "Filename\t\t\tType\t\tSize\tUsed\tPriority\n");
 	for (i = 0 ; i < nr_swapfiles ; i++, ptr++) {
-		if (ptr->flags & SWP_USED) {
+		if ((ptr->flags & SWP_USED) && ptr->swap_map) {
 			char * path = d_path(ptr->swap_file, page, PAGE_SIZE);
 
 			len += sprintf(buf + len, "%-31s ", path);


