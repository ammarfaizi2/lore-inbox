Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUHQP1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUHQP1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 11:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUHQPZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 11:25:16 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:37596 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268270AbUHQPPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 11:15:05 -0400
Message-ID: <412220C3.1050306@ttnet.net.tr>
Date: Tue, 17 Aug 2004 18:14:11 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] more gcc3.4 inline fixes [1/10]
Content-Type: multipart/mixed;
	boundary="------------050806050307070809070307"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050806050307070809070307
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: 7bit


--------------050806050307070809070307
Content-Type: text/plain;
	name="gcc34_inline_01.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="gcc34_inline_01.diff"

--- 28p1/drivers/block/cpqarray.c~	2004-02-18 15:36:31.000000000 +0200
+++ 28p1/drivers/block/cpqarray.c	2004-08-16 20:50:37.000000000 +0300
@@ -960,6 +960,20 @@
 	return c;
 }
 
+static inline void complete_buffers(struct buffer_head *bh, int ok)
+{
+	struct buffer_head *xbh;
+	while(bh) {
+		xbh = bh->b_reqnext;
+		bh->b_reqnext = NULL;
+		
+		blk_finished_io(bh->b_size >> 9);
+		bh->b_end_io(bh, ok);
+
+		bh = xbh;
+	}
+}
+
 /*
  * Get a request and submit it to the controller.
  * This routine needs to grab all the requests it possibly can from the
@@ -1094,19 +1108,6 @@
 	}
 }
 
-static inline void complete_buffers(struct buffer_head *bh, int ok)
-{
-	struct buffer_head *xbh;
-	while(bh) {
-		xbh = bh->b_reqnext;
-		bh->b_reqnext = NULL;
-		
-		blk_finished_io(bh->b_size >> 9);
-		bh->b_end_io(bh, ok);
-
-		bh = xbh;
-	}
-}
 /*
  * Mark all buffers that cmd was responsible for
  */
--- 28p1/drivers/block/cciss.c~	2004-08-16 20:12:58.000000000 +0300
+++ 28p1/drivers/block/cciss.c	2004-08-16 21:04:26.000000000 +0300
@@ -168,6 +168,35 @@
 static void cciss_procinit(int i) {}
 #endif /* CONFIG_PROC_FS */
 
+/*
+ * Enqueuing and dequeuing functions for cmdlists.
+ */
+static inline void addQ(CommandList_struct **Qptr, CommandList_struct *c)
+{
+        if (*Qptr == NULL) {
+                *Qptr = c;
+                c->next = c->prev = c;
+        } else {
+                c->prev = (*Qptr)->prev;
+                c->next = (*Qptr);
+                (*Qptr)->prev->next = c;
+                (*Qptr)->prev = c;
+        }
+}
+
+static inline CommandList_struct *removeQ(CommandList_struct **Qptr, 
+						CommandList_struct *c)
+{
+        if (c && c->next != c) {
+                if (*Qptr == c) *Qptr = c->next;
+                c->prev->next = c->next;
+                c->next->prev = c->prev;
+        } else {
+                *Qptr = NULL;
+        }
+        return c;
+}
+
 static struct block_device_operations cciss_fops  = {
 	owner:			THIS_MODULE,
 	open:			cciss_open, 
@@ -629,6 +658,7 @@
 static inline void register_cciss_ioctl32(void) {}
 static inline void unregister_cciss_ioctl32(void) {}
 #endif
+
 /*
  * ioctl 
  */
@@ -2131,35 +2161,6 @@
         return (ulong) (page_remapped ? (page_remapped + page_offs) : 0UL);
 }
 
-/*
- * Enqueuing and dequeuing functions for cmdlists.
- */
-static inline void addQ(CommandList_struct **Qptr, CommandList_struct *c)
-{
-        if (*Qptr == NULL) {
-                *Qptr = c;
-                c->next = c->prev = c;
-        } else {
-                c->prev = (*Qptr)->prev;
-                c->next = (*Qptr);
-                (*Qptr)->prev->next = c;
-                (*Qptr)->prev = c;
-        }
-}
-
-static inline CommandList_struct *removeQ(CommandList_struct **Qptr, 
-						CommandList_struct *c)
-{
-        if (c && c->next != c) {
-                if (*Qptr == c) *Qptr = c->next;
-                c->prev->next = c->next;
-                c->next->prev = c->prev;
-        } else {
-                *Qptr = NULL;
-        }
-        return c;
-}
-
 /* 
  * Takes jobs of the Q and sends them to the hardware, then puts it on 
  * the Q to wait for completion. 

--------------050806050307070809070307--
