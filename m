Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUDNHn3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbUDNHn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:43:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15336 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261723AbUDNHn1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:43:27 -0400
Message-ID: <407CEB91.1080503@pobox.com>
Date: Wed, 14 Apr 2004 03:43:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] conditionalize some boring buffer_head checks
Content-Type: multipart/mixed;
 boundary="------------000205040706020706040606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000205040706020706040606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


These checks are executed billions of times per day, with no stack dump 
bug reports sent to lkml.  Arguably, they will only trigger on buggy 
filesystems (programmer error), and thus IMO shouldn't even be executed 
in a non-debug kernel.

Even though BUG_ON() includes unlikely(), I think this patch -- or 
something like it -- is preferable.  The buffer_error() checks aren't 
even marked unlikely().

This is a micro-optimization on a key kernel fast path.



--------------000205040706020706040606
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== fs/buffer.c 1.237 vs edited =====
--- 1.237/fs/buffer.c	Wed Apr 14 03:18:09 2004
+++ edited/fs/buffer.c	Wed Apr 14 03:39:15 2004
@@ -2688,6 +2688,7 @@
 {
 	struct bio *bio;
 
+#ifdef BH_DEBUG
 	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
@@ -2698,6 +2699,7 @@
 		buffer_error();
 	if (rw == READ && buffer_dirty(bh))
 		buffer_error();
+#endif
 
 	/* Only clear out a write error when rewriting */
 	if (test_set_buffer_req(bh) && rw == WRITE)
===== include/linux/buffer_head.h 1.47 vs edited =====
--- 1.47/include/linux/buffer_head.h	Wed Apr 14 03:18:09 2004
+++ edited/include/linux/buffer_head.h	Wed Apr 14 03:39:31 2004
@@ -13,6 +13,8 @@
 #include <linux/wait.h>
 #include <asm/atomic.h>
 
+#undef BH_DEBUG
+
 enum bh_state_bits {
 	BH_Uptodate,	/* Contains valid data */
 	BH_Dirty,	/* Is dirty */

--------------000205040706020706040606--

