Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVDCCBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVDCCBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 21:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVDCCBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 21:01:15 -0500
Received: from inet-tsb5.toshiba.co.jp ([202.33.96.24]:13467 "EHLO
	inet-tsb5.toshiba.co.jp") by vger.kernel.org with ESMTP
	id S261433AbVDCCBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 21:01:12 -0500
Subject: Isn't there race issue during fput() and the dentry_open()?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Date: Sun, 3 Apr 2005 10:56:44 +0900
Message-ID: <BF571719A4041A478005EF3F08EA6DF0D96394@pcsmail03.pcs.pc.ome.toshiba.co.jp>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Thread-Topic: Isn't there race issue during fput() and the dentry_open()?
Thread-Index: AcU38GMKTNe9eEtyQrGqQA/jCrCMaw==
From: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
To: "LKML" <linux-kernel@vger.kernel.org>
Cc: "Tomita, Haruo" <haruo.tomita@toshiba.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Isn't there race issue during fput() and the dentry_open()?
When booting kernel, the following deadlocks are experienced.

Stack traceback for pid 2130
0xf717f1b0	2130	1	1	0	R	0xf717f400 *irqbalance
ESP	EIP	Function (args)
0xf75bfe38 0xc02d04b2 _spin_lock+0x2e (0xf7441a80)
0xf75bff34 0xc015667c file_move+0x14 (0xf63080e4, 0xf75bff58, 0x0, 0xf74bf000)
0xf75bff40 0xc0154e37 dentry_open+0xb9 (0xf63080e4, 0xf7f5ad80, 0xc02d00e6, 0x100100, 0x246)
0xf75bff58 0xc0154d78 filp_open+0x36
0xf75bffb4 0xc0155079 sys_open+0x31
0xf75bffc4 0xc02d196f syscall_call+0x7

The patch was made. Is this patch right?

diff -urN linux-2.6.12-rc1.orig/fs/file_table.c linux-2.6.12-rc1/fs/file_table.c
--- linux-2.6.12-rc1.orig/fs/file_table.c	2005-03-02 16:37:47.000000000 +0900
+++ linux-2.6.12-rc1/fs/file_table.c	2005-03-31 17:50:46.323999320 +0900
@@ -209,11 +209,11 @@
 
 void file_kill(struct file *file)
 {
+	file_list_lock();
 	if (!list_empty(&file->f_list)) {
-		file_list_lock();
 		list_del_init(&file->f_list);
-		file_list_unlock();
 	}
+	file_list_unlock();
 }
 
 int fs_may_remount_ro(struct super_block *sb)

--
Haruo

