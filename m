Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283810AbRK3Vfr>; Fri, 30 Nov 2001 16:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283807AbRK3Vfm>; Fri, 30 Nov 2001 16:35:42 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:38385 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S283806AbRK3Vf0>;
	Fri, 30 Nov 2001 16:35:26 -0500
Date: Sat, 1 Dec 2001 02:32:52 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] mm/swapfile.c/get_swaparea_info - a cosmetic change
Message-ID: <20011201023252.H23346@zzz.zzz.zzz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The header line of /proc/swaps does not match the consequence ones in
case of devfs' names.  These names are too long in comparison with the
<Filename> header's part.  So, I've added one tab into the header and
made the path's part of other lines to be of length 40-1 vs. 32-1.

Also, I've changed three calls for sprintf with one...

Linus, please, apply this cosmetic patch (it is against 2.4.16).


--- mm/swapfile.c.orig	Sat Dec  1 02:10:17 2001
+++ mm/swapfile.c	Wed Nov 28 22:05:00 2001
@@ -804,25 +804,17 @@ int get_swaparea_info(char *buf)
 {
 	char * page = (char *) __get_free_page(GFP_KERNEL);
 	struct swap_info_struct *ptr = swap_info;
-	int i, j, len = 0, usedswap;
+	int i, len;
 
 	if (!page)
 		return -ENOMEM;
 
-	len += sprintf(buf, "Filename\t\t\tType\t\tSize\tUsed\tPriority\n");
+	len = sprintf(buf, "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n");
 	for (i = 0 ; i < nr_swapfiles ; i++, ptr++) {
 		if ((ptr->flags & SWP_USED) && ptr->swap_map) {
 			char * path = d_path(ptr->swap_file, ptr->swap_vfsmnt,
 						page, PAGE_SIZE);
-
-			len += sprintf(buf + len, "%-31s ", path);
-
-			if (!ptr->swap_device)
-				len += sprintf(buf + len, "file\t\t");
-			else
-				len += sprintf(buf + len, "partition\t");
-
-			usedswap = 0;
+			int j, usedswap = 0;
 			for (j = 0; j < ptr->max; ++j)
 				switch (ptr->swap_map[j]) {
 					case SWAP_MAP_BAD:
@@ -831,8 +823,12 @@ int get_swaparea_info(char *buf)
 					default:
 						usedswap++;
 				}
-			len += sprintf(buf + len, "%d\t%d\t%d\n", ptr->pages << (PAGE_SHIFT - 10), 
-				usedswap << (PAGE_SHIFT - 10), ptr->prio);
+			len += sprintf(buf + len, "%-39s %s\t%d\t%d\t%d\n",
+				       path,
+				       ptr->swap_device ? "partition" : "file\t",
+				       ptr->pages << (PAGE_SHIFT - 10),
+				       usedswap << (PAGE_SHIFT - 10),
+				       ptr->prio);
 		}
 	}
 	free_page((unsigned long) page);
