Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264421AbRFIA6R>; Fri, 8 Jun 2001 20:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264422AbRFIA6I>; Fri, 8 Jun 2001 20:58:08 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:39434 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S264421AbRFIA5x>; Fri, 8 Jun 2001 20:57:53 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: linux-kernel@vger.kernel.org
cc: pmenage@ensim.com, torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] Race between sys_swapon and /proc/swaps (2.4)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Jun 2001 17:55:25 -0700
Message-Id: <E158X2D-0004Gb-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sys_swapon() sets SWP_USED in p->flags when it begins to set up a swap
area, and then calls vmalloc() to allocate p->swap_map[], which may
sleep. Most other users of the swap info structures either traverse the
swap list (to which the new swap area hasn't yet been added) or check
SWP_WRITEOK (which hasn't yet been set), but get_swaparea_info() only
checks for SWP_USED, and then proceeds to dereference ptr->swap_map. So
reading /proc/swaps whilst doing a swapon() can Oops. 

This could either be solved by making get_swaparea_info() check for 
ptr->swap_map, or check for ((ptr->flags & SWP_WRITEOK) == SWP_WRITEOK).
The patch below (applicable to 2.4.5 - patch for 2.2 in following email)
checks for the former on the grounds that that is what's causing the
immediate problem, and some people might want to be able to use 
/proc/swaps to track the progress of a swapoff().

Paul


diff -Naur linux/mm/swapfile.c linux.new/mm/swapfile.c
--- linux/mm/swapfile.c        Wed Apr 11 21:59:56 2001
+++ linux.new/mm/swapfile.c Fri Jun  8 17:18:32 2001
@@ -503,7 +503,7 @@
 
 	len += sprintf(buf, "Filename\t\t\tType\t\tSize\tUsed\tPriority\n");
 	for (i = 0 ; i < nr_swapfiles ; i++, ptr++) {
-		if (ptr->flags & SWP_USED) {
+		if ((ptr->flags & SWP_USED) && ptr->swap_map) {
 			char * path = d_path(ptr->swap_file, ptr->swap_vfsmnt,
 				page, PAGE_SIZE);
 


