Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWDMVHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWDMVHr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWDMVHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:07:47 -0400
Received: from xenotime.net ([66.160.160.81]:8686 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964967AbWDMVHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:07:46 -0400
Date: Thu, 13 Apr 2006 14:10:10 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, jgarzik <jgarzik@pobox.com>, perex@suse.cz,
       chas@cmf.nrl.navy.mil
Subject: [PATCH 2/2] update 2 drivers for poison.h
Message-Id: <20060413141010.66ea08e8.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Update 2 drivers to use poison.h.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/atm/firestream.c    |    3 ++-
 include/linux/poison.h      |    6 ++++++
 sound/oss/via82cxxx_audio.c |    5 +++--
 3 files changed, 11 insertions(+), 3 deletions(-)

--- linux-2617-rc1g5.orig/drivers/atm/firestream.c
+++ linux-2617-rc1g5/drivers/atm/firestream.c
@@ -33,6 +33,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
+#include <linux/poison.h>
 #include <linux/errno.h>
 #include <linux/atm.h>
 #include <linux/atmdev.h>
@@ -754,7 +755,7 @@ static void process_txdone_queue (struct
 			fs_kfree_skb (skb);
 
 			fs_dprintk (FS_DEBUG_ALLOC, "Free trans-d: %p\n", td); 
-			memset (td, 0x12, sizeof (struct FS_BPENTRY));
+			memset (td, ATM_POISON_FREE, sizeof(struct FS_BPENTRY));
 			kfree (td);
 			break;
 		default:
--- linux-2617-rc1g5.orig/include/linux/poison.h
+++ linux-2617-rc1g5/include/linux/poison.h
@@ -42,4 +42,10 @@
 #define	POOL_POISON_FREED	0xa7	/* !inuse */
 #define	POOL_POISON_ALLOCATED	0xa9	/* !initted */
 
+/********** drivers/atm/ **********/
+#define ATM_POISON_FREE		0x12
+
+/********** sound/oss/ **********/
+#define OSS_POISON_FREE		0xAB
+
 #endif
--- linux-2617-rc1g5.orig/sound/oss/via82cxxx_audio.c
+++ linux-2617-rc1g5/sound/oss/via82cxxx_audio.c
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
+#include <linux/poison.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
@@ -3522,7 +3523,7 @@ err_out_have_mixer:
 
 err_out_kfree:
 #ifndef VIA_NDEBUG
-	memset (card, 0xAB, sizeof (*card)); /* poison memory */
+	memset (card, OSS_POISON_FREE, sizeof (*card)); /* poison memory */
 #endif
 	kfree (card);
 
@@ -3559,7 +3560,7 @@ static void __devexit via_remove_one (st
 	via_ac97_cleanup (card);
 
 #ifndef VIA_NDEBUG
-	memset (card, 0xAB, sizeof (*card)); /* poison memory */
+	memset (card, OSS_POISON_FREE, sizeof (*card)); /* poison memory */
 #endif
 	kfree (card);
 


---
