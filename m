Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757266AbWKWBeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbWKWBeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 20:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757267AbWKWBet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 20:34:49 -0500
Received: from smtp-out.google.com ([216.239.45.12]:61107 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1757266AbWKWBes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 20:34:48 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:content-type:
	organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=kc3SzOVBB9F9VmOnT9DkGlkgpUZRHDDKpG7EotVm6KsAG8SAeq1HuS9CRQmW4moBY
	tJI8lkDp8oSUZIZUwL3QA==
Subject: [Patch1/4]: fake numa for x86_64 patch
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Mel Gorman <mel@csn.ul.ie>,
       David Rientjes <rientjes@cs.washington.edu>,
       Paul Menage <menage@google.com>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 22 Nov 2006 17:34:09 -0800
Message-Id: <1164245649.29844.148.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides a IO hole size in a given address range.

Signed-off-by: David Rientjes <reintjes@google.com>
Signed-off-by: Paul Menage <menage@google.com>
Signed-off-by: Rohit Seth <rohitseth@google.com>

--- linux-2.6.19-rc5-mm2.org/include/asm-x86_64/e820.h	2006-11-22 12:20:39.000000000 -0800
+++ linux-2.6.19-rc5-mm2/include/asm-x86_64/e820.h	2006-11-22 12:17:25.000000000 -0800
@@ -46,6 +46,7 @@ extern void e820_mark_nosave_regions(voi
 extern void e820_print_map(char *who);
 extern int e820_any_mapped(unsigned long start, unsigned long end, unsigned type);
 extern int e820_all_mapped(unsigned long start, unsigned long end, unsigned type);
+extern unsigned long e820_hole_size(unsigned long start, unsigned long end);
 
 extern void e820_setup_gap(void);
 extern void e820_register_active_regions(int nid,
--- linux-2.6.19-rc5-mm2.org/arch/x86_64/kernel/e820.c	2006-11-22 12:20:55.000000000 -0800
+++ linux-2.6.19-rc5-mm2/arch/x86_64/kernel/e820.c	2006-11-21 18:48:15.000000000 -0800
@@ -184,6 +184,38 @@ unsigned long __init e820_end_of_ram(voi
 }
 
 /*
+ * Find the hole size in the range.
+ */
+unsigned long __init e820_hole_size(unsigned long start, unsigned long end)
+{
+	unsigned long ram = 0;
+	int i;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long last, addr;
+
+		if (ei->type != E820_RAM ||
+		    ei->addr+ei->size <= start ||
+		    ei->addr >= end)
+			continue;
+
+		addr = round_up(ei->addr, PAGE_SIZE);
+		if (addr < start)
+			addr = start;
+
+		last = round_down(ei->addr + ei->size, PAGE_SIZE);
+		if (last >= end)
+			last = end;
+
+		if (last > addr)
+			ram += last - addr;
+	}
+	return ((end - start) - ram);
+}
+
+
+/*
  * Mark e820 reserved areas as busy for the resource manager.
  */
 void __init e820_reserve_resources(void)


