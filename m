Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTKRCKr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 21:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbTKRCKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 21:10:47 -0500
Received: from smtp13.eresmas.com ([62.81.235.113]:61863 "EHLO
	smtp13.eresmas.com") by vger.kernel.org with ESMTP id S261782AbTKRCKo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 21:10:44 -0500
Message-ID: <3FB97F8E.7090906@wanadoo.es>
Date: Tue, 18 Nov 2003 03:10:22 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Tosatti <marcelo.tosatti@cyclades.com>
Subject: [PATCH] LVM-1.0.8 for 2.4.23-rc1
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030609040109080505000308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030609040109080505000308
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Changelog for 1.0.7 to 1.0.8

Driver
------
o fixed list handling in lvm_find_exception_table()

o corrected physical extent counters

user space utils and complete patch at:
ftp://ftp.sistina.com/pub/LVM/1.0/

-thanks-
--
Software is like sex, it's better when it's bug free.


--------------030609040109080505000308
Content-Type: text/plain;
 name="lvm_1.0.8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lvm_1.0.8.diff"

diff -Nuar old/drivers/md/lvm.c new/drivers/md/lvm.c
--- old/drivers/md/lvm.c	2003-11-18 02:45:25.000000000 +0100
+++ new/drivers/md/lvm.c	2003-11-18 02:40:24.000000000 +0100
@@ -2594,8 +2594,9 @@
 				      new_lv->lv_block_exception[e].
 				      rsector_org, new_lv);
 
-		vg_ptr->pe_allocated -= old_lv->lv_allocated_le;
+		vg_ptr->pe_allocated -= old_lv->lv_allocated_snapshot_le;
 		vg_ptr->pe_allocated += new_lv->lv_allocated_le;
+		old_lv->lv_allocated_snapshot_le = new_lv->lv_allocated_le;
 	} else {
 		vfree(old_lv->lv_current_pe);
 		vfree(old_lv->lv_snapshot_hash_table);
diff -Nuar old/drivers/md/lvm-snap.c new/drivers/md/lvm-snap.c
--- old/drivers/md/lvm-snap.c	2003-11-18 02:45:25.000000000 +0100
+++ new/drivers/md/lvm-snap.c	2003-11-18 02:50:37.000000000 +0100
@@ -44,6 +44,7 @@
  *    26/06/2002 - support for new list_move macro [patch@luckynet.dynu.com]
  *    26/07/2002 - removed conditional list_move macro because we will
  *                 discontinue LVM1 before 2.6 anyway
+ *    27/08/2003 - fixed unsafe list handling in lvm_find_exception_table() [HM]
  *
  */
 
@@ -114,7 +115,7 @@
 							     org_start,
 							     lv_t * lv)
 {
-	struct list_head *hash_table = lv->lv_snapshot_hash_table, *next;
+	struct list_head *hash_table = lv->lv_snapshot_hash_table, *next, *n;
 	unsigned long mask = lv->lv_snapshot_hash_mask;
 	int chunk_size = lv->lv_chunk_size;
 	lv_block_exception_t *ret;
@@ -123,8 +124,9 @@
 	hash_table =
 	    &hash_table[hashfn(org_dev, org_start, mask, chunk_size)];
 	ret = NULL;
-	for (next = hash_table->next; next != hash_table;
-	     next = next->next) {
+
+	for (next = hash_table->next, n = next->next; next != hash_table;
+             next = n, n = next->next) {
 		lv_block_exception_t *exception;
 
 		exception = list_entry(next, lv_block_exception_t, hash);
diff -Nuar old/include/linux/lvm.h new/include/linux/lvm.h
--- old/include/linux/lvm.h	2003-11-18 02:45:19.000000000 +0100
+++ new/include/linux/lvm.h	2003-11-18 02:41:05.000000000 +0100
@@ -80,8 +80,8 @@
 #ifndef _LVM_H_INCLUDE
 #define _LVM_H_INCLUDE
 
-#define LVM_RELEASE_NAME "1.0.7"
-#define LVM_RELEASE_DATE "28/03/2003"
+#define LVM_RELEASE_NAME "1.0.8"
+#define LVM_RELEASE_DATE "17/11/2003"
 
 #define	_LVM_KERNEL_H_VERSION	"LVM "LVM_RELEASE_NAME" ("LVM_RELEASE_DATE")"
 


--------------030609040109080505000308--

