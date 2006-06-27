Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933436AbWF0EpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933436AbWF0EpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030695AbWF0Emu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:42:50 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:55771 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S932767AbWF0Emo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 05/13] [Suspend2] LRU paranoia patch.
Date: Tue, 27 Jun 2006 14:42:43 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044242.15066.61219.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the Set/Clear LRU flag macros to also BUG_ON() when freezing is
complete, iff CONFIG_PM_DEBUG is enabled. The LRU is supposed to be static
before the atomic copy is made. This just helps verify that this is
happening.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 include/linux/page-flags.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d276a4e..1e4d6a5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -7,6 +7,7 @@
 
 #include <linux/percpu.h>
 #include <linux/cache.h>
+#include <linux/freezer.h> /* For Suspend2 LRU paranoid Set|ClearPageLRU definitions */
 #include <asm/pgtable.h>
 
 /*
@@ -255,9 +256,16 @@ extern void __mod_page_state_offset(unsi
 #define TestClearPageDirty(page) test_and_clear_bit(PG_dirty, &(page)->flags)
 
 #define PageLRU(page)		test_bit(PG_lru, &(page)->flags)
+
+#ifdef CONFIG_PM_DEBUG
 #define SetPageLRU(page)	set_bit(PG_lru, &(page)->flags)
 #define ClearPageLRU(page)	clear_bit(PG_lru, &(page)->flags)
 #define __ClearPageLRU(page)	__clear_bit(PG_lru, &(page)->flags)
+#else
+#define SetPageLRU(page)	do { BUG_ON(test_freezer_state(FREEZING_COMPLETE)); set_bit(PG_lru, &(page)->flags); } while(0)
+#define ClearPageLRU(page)	do { BUG_ON(test_freezer_state(FREEZING_COMPLETE)); clear_bit(PG_lru, &(page)->flags); } while(0)
+#define __ClearPageLRU(page)	do { BUG_ON(test_freezer_state(FREEZING_COMPLETE)); __clear_bit(PG_lru, &(page)->flags); } while(0)
+#endif
 
 #define PageActive(page)	test_bit(PG_active, &(page)->flags)
 #define SetPageActive(page)	set_bit(PG_active, &(page)->flags)

--
Nigel Cunningham		nigel at suspend2 dot net
