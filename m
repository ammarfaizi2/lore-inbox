Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269189AbUISIIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269189AbUISIIM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 04:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269187AbUISIIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 04:08:12 -0400
Received: from gate.crashing.org ([63.228.1.57]:14776 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269189AbUISIIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 04:08:10 -0400
Subject: [PATCH] Fix bound checking in do_mmap_pgoff()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1095581234.26670.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 19 Sep 2004 18:07:15 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

A small issue has been forever in do_mmap_pgoff() in the boundary checking
in the sense that it won't let you mmap with offset+len enclosing the last
page of the "address space". For example, an mmap of /dev/mem won't let you
map the last page of the physical address space (which I need for a ROM dump
tool on pmac). This fixes it:

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== mm/mmap.c 1.144 vs edited =====
--- 1.144/mm/mmap.c	2004-09-03 19:08:17 +10:00
+++ edited/mm/mmap.c	2004-09-19 18:04:34 +10:00
@@ -801,7 +801,7 @@
 		return -EINVAL;
 
 	/* offset overflow? */
-	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
+	if ((pgoff + (len >> PAGE_SHIFT) - 1) < pgoff)
 		return -EINVAL;
 
 	/* Too many mappings? */


