Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVDEErU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVDEErU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 00:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVDEErU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 00:47:20 -0400
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:24499 "EHLO
	inet-tsb5.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S261521AbVDEErP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 00:47:15 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Subject: RE: Isn't there race issue during fput() and the dentry_open()?
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Tue, 5 Apr 2005 13:46:49 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF0D96C8F@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Thread-Topic: Isn't there race issue during fput() and the dentry_open()?
Thread-Index: AcU5BB4FlV1Zk+c2TJah1OK+F3605gAlGuMQ
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: "Al Viro" <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "LKML" <linux-kernel@vger.kernel.org>,
       "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viro,

Thank you for your help and advice.
I made the following patches referring to your advice. 
I try to debugging by using this patch. 

Thanks again,
Haruo

diff -urN linux-2.6.12-rc2.orig/fs/file_table.c linux-2.6.12-rc2/fs/file_table.c
--- linux-2.6.12-rc2.orig/fs/file_table.c	2005-03-02 16:37:47.000000000 +0900
+++ linux-2.6.12-rc2/fs/file_table.c	2005-04-05 11:21:58.000000000 +0900
@@ -26,6 +26,7 @@
 
 /* public. Not pretty! */
  __cacheline_aligned_in_smp DEFINE_SPINLOCK(files_lock);
+pid_t holder_pid;
 
 static DEFINE_SPINLOCK(filp_count_lock);
 
diff -urN linux-2.6.12-rc2.orig/include/linux/fs.h linux-2.6.12-rc2/include/linux/fs.h
--- linux-2.6.12-rc2.orig/include/linux/fs.h	2005-04-05 11:12:53.000000000 +0900
+++ linux-2.6.12-rc2/include/linux/fs.h	2005-04-05 11:20:15.000000000 +0900
@@ -602,8 +602,17 @@
 	struct address_space	*f_mapping;
 };
 extern spinlock_t files_lock;
-#define file_list_lock() spin_lock(&files_lock);
-#define file_list_unlock() spin_unlock(&files_lock);
+extern pid_t holder_pid;
+#define file_list_lock() \
+	do { \
+		spin_lock(&files_lock); \
+		holder_pid = current->pid; \
+	}while(0)
+#define file_list_unlock() \
+	do { \
+		holder_pid = 0; \
+		spin_unlock(&files_lock); \
+	}while(0)
 
 #define get_file(x)	atomic_inc(&(x)->f_count)
 #define file_count(x)	atomic_read(&(x)->f_count)
