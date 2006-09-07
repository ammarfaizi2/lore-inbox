Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbWIGCu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbWIGCu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 22:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751802AbWIGCu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 22:50:58 -0400
Received: from mga02.intel.com ([134.134.136.20]:49587 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1750709AbWIGCu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 22:50:56 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,221,1154934000"; 
   d="scan'208"; a="122248355:sNHT22672958"
Subject: [PATCH] x86 microcode: don't check the size
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Tigran Aivazian <tigran@veritas.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 10:47:07 +0800
Message-Id: <1157597227.2782.55.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IA32 manual says if micorcode update's size is 0, then the size is
default size (2048 bytes). But this doesn't suggest all microcode
update's size should be above 2048 bytes to me. We actually had a
microcode update whose size is 1024 bytes. The patch just removed the
check.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>

---
 work/src/linux-2.6.18-rc5-mm1/arch/i386/kernel/microcode.c |   14 ++-----------
 1 files changed, 3 insertions(+), 11 deletions(-)

Index: root/work/src/linux-2.6.18-rc5-mm1/arch/i386/kernel/microcode.c
===================================================================
--- root.orig/work/src/linux-2.6.18-rc5-mm1/arch/i386/kernel/microcode.c	2006-09-06 06:51:03.000000000 +0800
+++ root/work/src/linux-2.6.18-rc5-mm1/arch/i386/kernel/microcode.c	2006-09-06 08:20:35.000000000 +0800
@@ -187,8 +187,7 @@ static int microcode_sanity_check(void *
 
 	total_size = get_totalsize(mc_header);
 	data_size = get_datasize(mc_header);
-	if ((data_size + MC_HEADER_SIZE > total_size)
-		|| (data_size < DEFAULT_UCODE_DATASIZE)) {
+	if (data_size + MC_HEADER_SIZE > total_size) {
 		printk(KERN_ERR "microcode: error! "
 			"Bad data size in microcode data file\n");
 		return -EINVAL;
@@ -365,8 +364,7 @@ static long get_next_ucode(void **mc, lo
 		return -EFAULT;
 	}
 	total_size = get_totalsize(&mc_header);
-	if ((offset + total_size > user_buffer_size)
-		|| (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+	if (offset + total_size > user_buffer_size) {
 		printk(KERN_ERR "microcode: error! Bad total size in microcode "
 				"data file\n");
 		return -EINVAL;
@@ -432,11 +430,6 @@ static ssize_t microcode_write (struct f
 {
 	ssize_t ret;
 
-	if (len < DEFAULT_UCODE_TOTALSIZE) {
-		printk(KERN_ERR "microcode: not enough data\n"); 
-		return -EINVAL;
-	}
-
 	if ((len >> PAGE_SHIFT) > num_physpages) {
 		printk(KERN_ERR "microcode: too much data (max %ld pages)\n", num_physpages);
 		return -EINVAL;
@@ -508,8 +501,7 @@ static long get_next_ucode_from_buffer(v
 	mc_header = (microcode_header_t *)(buf + offset);
 	total_size = get_totalsize(mc_header);
 
-	if ((offset + total_size > size)
-		|| (total_size < DEFAULT_UCODE_TOTALSIZE)) {
+	if (offset + total_size > size) {
 		printk(KERN_ERR "microcode: error! Bad data in microcode data file\n");
 		return -EINVAL;
 	}
