Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWJTQYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWJTQYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbWJTQYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:24:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61906 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932269AbWJTQYE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:24:04 -0400
Message-ID: <4538F81A.2070007@redhat.com>
Date: Fri, 20 Oct 2006 11:23:54 -0500
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] more helpful WARN_ON and BUG_ON messages
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a few bugs I encountered in FC6 in buffer.c, with output like:

Kernel BUG at fs/buffer.c: 2791

where buffer.c contains:

...
        BUG_ON(!buffer_locked(bh));
        BUG_ON(!buffer_mapped(bh));
        BUG_ON(!bh->b_end_io);
...

around line 2790, it's awfully tedious to go get the exact failing kernel tree
just to see -which- BUG_ON was encountered.

Printing out the failing condition as a string would make this more helpful IMHO.

This is mostly just compile-tested... comments?

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.18/include/asm-generic/bug.h
===================================================================
--- linux-2.6.18.orig/include/asm-generic/bug.h
+++ linux-2.6.18/include/asm-generic/bug.h
@@ -12,13 +12,19 @@
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+#define BUG_ON(condition) do { \
+	if (unlikely((condition)!=0)) { \
+		printk("BUGging on (%s)\n", #condition); \
+		BUG(); \
+	} \
+} while(0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
 #define WARN_ON(condition) do { \
 	if (unlikely((condition)!=0)) { \
-		printk("BUG: warning at %s:%d/%s()\n", __FILE__, __LINE__, __FUNCTION__); \
+		printk("BUG: warning: (%s) at %s:%d/%s()\n", \
+			#condition, __FILE__, __LINE__, __FUNCTION__); \
 		dump_stack(); \
 	} \
 } while (0)


