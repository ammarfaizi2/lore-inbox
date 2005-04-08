Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262821AbVDHNgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262821AbVDHNgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 09:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVDHNgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 09:36:22 -0400
Received: from smtp8.wanadoo.fr ([193.252.22.23]:45719 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262821AbVDHNdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 09:33:37 -0400
X-ME-UUID: 20050408133336433.0A8D71C000A2@mwinf0806.wanadoo.fr
Message-ID: <425687DB.4000205@innova-card.com>
Date: Fri, 08 Apr 2005 15:32:11 +0200
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bootmem.c clean up bad pfn convertions
Content-Type: multipart/mixed;
 boundary="------------000004060108060508070604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000004060108060508070604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

As I described in my previous email, bootmem.c does improper
pfn convertions into phys addr. This simple patch fixes that.

Regards,

       Franck.



-------------------------------------------------------------------------------
This message contains confidential information and is intended only for the
individual named. If you are not the named addressee you should not
disseminate, distribute or copy this e-mail. Please notify the sender
immediately by e-mail if you have received this e-mail by mistake and delete
this e-mail from your system. E-mail transmission cannot be guaranteed to be
secure or error-free as information could be intercepted, corrupted, lost,
destroyed, arrive late or incomplete, or contain viruses. The sender therefore
does not accept liability for any errors or omissions in the contents of this
message, which arise as a result of e-mail transmission. If verification is
required please request a hard-copy version.
INNOVA CARD will not therefore be liable for the message if modified.
-------------------------------------------------------------------------------

--------------000004060108060508070604
Content-Type: text/x-patch;
 name="bootmem.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootmem.c.patch"

--- bootmem.c	7 Apr 2005 16:39:24 -0000	1.2
+++ bootmem.c	8 Apr 2005 13:20:02 -0000
@@ -58,8 +58,8 @@ static unsigned long __init init_bootmem
 	pgdat_list = pgdat;
 
 	mapsize = (mapsize + (sizeof(long) - 1UL)) & ~(sizeof(long) - 1UL);
-	bdata->node_bootmem_map = phys_to_virt(mapstart << PAGE_SHIFT);
-	bdata->node_boot_start = (start << PAGE_SHIFT);
+	bdata->node_bootmem_map = phys_to_virt(pfn_to_phys(mapstart));
+	bdata->node_boot_start = pfn_to_phys(start);
 	bdata->node_low_pfn = end;
 
 	/*
@@ -86,11 +86,11 @@ static void __init reserve_bootmem_core(
 	unsigned long sidx = (addr - bdata->node_boot_start)/PAGE_SIZE;
 	unsigned long eidx = (addr + size - bdata->node_boot_start + 
 							PAGE_SIZE-1)/PAGE_SIZE;
-	unsigned long end = (addr + size + PAGE_SIZE-1)/PAGE_SIZE;
+	unsigned long end = phys_to_pfn(PAGE_ALIGN(addr + size));
 
 	BUG_ON(!size);
 	BUG_ON(sidx >= eidx);
-	BUG_ON((addr >> PAGE_SHIFT) >= bdata->node_low_pfn);
+	BUG_ON(phys_to_pfn(addr) >= bdata->node_low_pfn);
 	BUG_ON(end > bdata->node_low_pfn);
 
 	for (i = sidx; i < eidx; i++)
@@ -111,7 +111,7 @@ static void __init free_bootmem_core(boo
 	 */
 	unsigned long sidx;
 	unsigned long eidx = (addr + size - bdata->node_boot_start)/PAGE_SIZE;
-	unsigned long end = (addr + size)/PAGE_SIZE;
+	unsigned long end = phys_to_pfn(addr + size);
 
 	BUG_ON(!size);
 	BUG_ON(end > bdata->node_low_pfn);
@@ -260,6 +260,7 @@ static unsigned long __init free_all_boo
 	unsigned long i, count, total = 0;
 	unsigned long idx;
 	unsigned long *map; 
+	unsigned long mapsize;
 	int gofast = 0;
 
 	BUG_ON(!bdata->node_bootmem_map);
@@ -267,7 +268,7 @@ static unsigned long __init free_all_boo
 	count = 0;
 	/* first extant page of the node */
 	page = virt_to_page(phys_to_virt(bdata->node_boot_start));
-	idx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	idx = bdata->node_low_pfn - phys_to_pfn(bdata->node_boot_start);
 	map = bdata->node_bootmem_map;
 	/* Check physaddr is O(LOG2(BITS_PER_LONG)) page aligned */
 	if (bdata->node_boot_start == 0 ||
@@ -313,7 +314,9 @@ static unsigned long __init free_all_boo
 	 */
 	page = virt_to_page(bdata->node_bootmem_map);
 	count = 0;
-	for (i = 0; i < ((bdata->node_low_pfn-(bdata->node_boot_start >> PAGE_SHIFT))/8 + PAGE_SIZE-1)/PAGE_SIZE; i++,page++) {
+	mapsize = (bdata->node_low_pfn - phys_to_pfn(bdata->node_boot_start)+7)/8;
+	mapsize = (mapsize + PAGE_SIZE-1)/PAGE_SIZE;
+	for (i = 0; i < mapsize; i++, page++) {
 		count++;
 		__ClearPageReserved(page);
 		set_page_count(page, 1);

--------------000004060108060508070604--

