Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbVHXWLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbVHXWLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVHXWLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:11:15 -0400
Received: from rwcrmhc14.comcast.net ([204.127.198.54]:59274 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932310AbVHXWLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:11:15 -0400
Date: Wed, 24 Aug 2005 15:12:02 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] Allow for arch-specific IOREMAP_MAX_ORDER
Message-ID: <20050824221202.GA28977@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 6 of the ARM architecture introduces the concept of 16MB pages
(supersections) and 36-bit (40-bit actually, but nobody uses this)
physical addresses. 36-bit addressed memory and I/O and ARMv6 can
only be mapped using supersections and the requirement on these is
that both virtual and physical addresses be 16MB aligned. In trying
to add support for ioremap() of 36-bit I/O, we run into the issue that
get_vm_area() allows for a maximum of 512K alignment via the 
IOREMAP_MAX_ORDER constant. To work around this, we can:

- Allocate a larger VM area than needed (size + (1ul << IOREMAP_MAX_ORDER))
  and then align the pointer ourselves, but this ends up with 512K of 
  wasted VM per ioremap().

- Provide a new __get_vm_area_aligned() API and make __get_vm_area() sit
  on top of this. I did this and it works but I don't like the idea 
  adding another VM API just for this one case.

- My preferred solution which is to allow the architecture to override
  the IOREMAP_MAX_ORDER constant with it's own version. 

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -10,6 +10,14 @@
 #define VM_MAP		0x00000004	/* vmap()ed pages */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
+/*
+ * Maximum alignment for ioremap() regions.
+ * Can be overriden by arch-specific value.
+ */
+#ifndef IOREMAP_MAX_ORDER
+#define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
+#endif
+
 struct vm_struct {
 	void			*addr;
 	unsigned long		size;
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -158,8 +158,6 @@ int map_vm_area(struct vm_struct *area, 
 	return err;
 }
 
-#define IOREMAP_MAX_ORDER	(7 + PAGE_SHIFT)	/* 128 pages */
-
 struct vm_struct *__get_vm_area(unsigned long size, unsigned long flags,
 				unsigned long start, unsigned long end)
 {

-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
