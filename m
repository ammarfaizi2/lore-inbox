Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752854AbWKBNW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbWKBNW3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752849AbWKBNW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:22:29 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:5310 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1752854AbWKBNW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:22:29 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, magnus.damm@gmail.com,
       Andi Kleen <ak@muc.de>
Date: Thu, 02 Nov 2006 22:20:53 +0900
Message-Id: <20061102132053.24699.24665.sendpatchset@localhost>
Subject: [PATCH] x86_64: e820.c - end_pfn namespace fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64: e820.c - end_pfn namespace fixes

The functions e820_end_of_ram() and e820_register_active_regions() both
use local variables named end_pfn. A global variable with the same name
is exported from the same file. This patch renames the local variables
to _end_pfn to avoid namespace mistakes.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies to 2.6.19-rc4.

 arch/x86_64/kernel/e820.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

--- 0005/arch/x86_64/kernel/e820.c
+++ work/arch/x86_64/kernel/e820.c	2006-11-02 21:44:59.000000000 +0900
@@ -167,20 +167,19 @@ unsigned long __init find_e820_area(unsi
  */
 unsigned long __init e820_end_of_ram(void)
 {
-	unsigned long end_pfn = 0;
-	end_pfn = find_max_pfn_with_active_regions();
+	unsigned long _end_pfn = find_max_pfn_with_active_regions();
 	
-	if (end_pfn > end_pfn_map) 
-		end_pfn_map = end_pfn;
+	if (_end_pfn > end_pfn_map) 
+		end_pfn_map = _end_pfn;
 	if (end_pfn_map > MAXMEM>>PAGE_SHIFT)
 		end_pfn_map = MAXMEM>>PAGE_SHIFT;
-	if (end_pfn > end_user_pfn)
-		end_pfn = end_user_pfn;
-	if (end_pfn > end_pfn_map) 
-		end_pfn = end_pfn_map; 
+	if (_end_pfn > end_user_pfn)
+		_end_pfn = end_user_pfn;
+	if (_end_pfn > end_pfn_map) 
+		_end_pfn = end_pfn_map; 
 
 	printk("end_pfn_map = %lu\n", end_pfn_map);
-	return end_pfn;	
+	return _end_pfn;	
 }
 
 /*
@@ -267,7 +266,7 @@ void __init e820_mark_nosave_regions(voi
 /* Walk the e820 map and register active regions within a node */
 void __init
 e820_register_active_regions(int nid, unsigned long start_pfn,
-							unsigned long end_pfn)
+							unsigned long _end_pfn)
 {
 	int i;
 	unsigned long ei_startpfn, ei_endpfn;
@@ -288,14 +287,14 @@ e820_register_active_regions(int nid, un
 		/* Skip if map is outside the node */
 		if (ei->type != E820_RAM ||
 				ei_endpfn <= start_pfn ||
-				ei_startpfn >= end_pfn)
+				ei_startpfn >= _end_pfn)
 			continue;
 
 		/* Check for overlaps */
 		if (ei_startpfn < start_pfn)
 			ei_startpfn = start_pfn;
-		if (ei_endpfn > end_pfn)
-			ei_endpfn = end_pfn;
+		if (ei_endpfn > _end_pfn)
+			ei_endpfn = _end_pfn;
 
 		/* Obey end_user_pfn to save on memmap */
 		if (ei_startpfn >= end_user_pfn)
