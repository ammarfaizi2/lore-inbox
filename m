Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWFVSdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWFVSdI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWFVSbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:31:14 -0400
Received: from mx1.suse.de ([195.135.220.2]:8586 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030356AbWFVSbE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:31:04 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Adrian Bunk <bunk@stusta.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/14] [PATCH] W1: possible cleanups
Reply-To: Greg KH <greg@kroah.com>
Date: Thu, 22 Jun 2006 11:27:14 -0700
Message-Id: <1151000872615-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <11510008691087-git-send-email-greg@kroah.com>
References: <20060622182645.GB5668@kroah.com> <11510008381000-git-send-email-greg@kroah.com> <11510008413045-git-send-email-greg@kroah.com> <11510008461301-git-send-email-greg@kroah.com> <11510008522327-git-send-email-greg@kroah.com> <11510008553417-git-send-email-greg@kroah.com> <11510008583492-git-send-email-greg@kroah.com> <11510008623474-git-send-email-greg@kroah.com> <11510008662311-git-send-email-greg@kroah.com> <11510008691087-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>

This patch contains the following possible cleanups:
- the following file did't #include the header with the prototypes for
  it's global functions:
  - w1_int.c
- #if 0 the following unused global function:
  - w1_family.c: w1_family_get()
- make the following needlessly global functions static:
  - w1_family.c: __w1_family_put()
  - w1_io.c: w1_delay()
  - w1_io.c: w1_touch_bit()
  - w1_io.c: w1_read_8()
- remove the following unused EXPORT_SYMBOL's:
  - w1_family.c: w1_family_put
  - w1_family.c: w1_family_registered

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/w1/w1.h        |    3 ---
 drivers/w1/w1_family.c |   18 ++++++++----------
 drivers/w1/w1_family.h |    2 --
 drivers/w1/w1_int.c    |    1 +
 drivers/w1/w1_io.c     |    6 +++---
 drivers/w1/w1_io.h     |    3 ---
 6 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/w1/w1.h b/drivers/w1/w1.h
index 3828f39..c90a928 100644
--- a/drivers/w1/w1.h
+++ b/drivers/w1/w1.h
@@ -187,11 +187,8 @@ struct w1_slave *w1_search_slave(struct 
 void w1_search_process(struct w1_master *dev, u8 search_type);
 struct w1_master *w1_search_master_id(u32 id);
 
-void w1_delay(unsigned long);
-u8 w1_touch_bit(struct w1_master *, int);
 u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
diff --git a/drivers/w1/w1_family.c b/drivers/w1/w1_family.c
index 0e32c11..a3c95bd 100644
--- a/drivers/w1/w1_family.c
+++ b/drivers/w1/w1_family.c
@@ -107,6 +107,12 @@ struct w1_family * w1_family_registered(
 	return (ret) ? f : NULL;
 }
 
+static void __w1_family_put(struct w1_family *f)
+{
+	if (atomic_dec_and_test(&f->refcnt))
+		f->need_exit = 1;
+}
+
 void w1_family_put(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
@@ -114,19 +120,14 @@ void w1_family_put(struct w1_family *f)
 	spin_unlock(&w1_flock);
 }
 
-void __w1_family_put(struct w1_family *f)
-{
-	if (atomic_dec_and_test(&f->refcnt))
-		f->need_exit = 1;
-}
-
+#if 0
 void w1_family_get(struct w1_family *f)
 {
 	spin_lock(&w1_flock);
 	__w1_family_get(f);
 	spin_unlock(&w1_flock);
-
 }
+#endif  /*  0  */
 
 void __w1_family_get(struct w1_family *f)
 {
@@ -135,8 +136,5 @@ void __w1_family_get(struct w1_family *f
 	smp_mb__after_atomic_inc();
 }
 
-EXPORT_SYMBOL(w1_family_get);
-EXPORT_SYMBOL(w1_family_put);
-EXPORT_SYMBOL(w1_family_registered);
 EXPORT_SYMBOL(w1_unregister_family);
 EXPORT_SYMBOL(w1_register_family);
diff --git a/drivers/w1/w1_family.h b/drivers/w1/w1_family.h
index 22a9d52..1e2ac40 100644
--- a/drivers/w1/w1_family.h
+++ b/drivers/w1/w1_family.h
@@ -57,10 +57,8 @@ struct w1_family
 
 extern spinlock_t w1_flock;
 
-void w1_family_get(struct w1_family *);
 void w1_family_put(struct w1_family *);
 void __w1_family_get(struct w1_family *);
-void __w1_family_put(struct w1_family *);
 struct w1_family * w1_family_registered(u8);
 void w1_unregister_family(struct w1_family *);
 int w1_register_family(struct w1_family *);
diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 475996c..357a2e0 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -27,6 +27,7 @@ #include <linux/kthread.h>
 #include "w1.h"
 #include "w1_log.h"
 #include "w1_netlink.h"
+#include "w1_int.h"
 
 static u32 w1_ids = 1;
 
diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
index 3253bb0..30b6fbf 100644
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -50,7 +50,7 @@ static u8 w1_crc8_table[] = {
 	116, 42, 200, 150, 21, 75, 169, 247, 182, 232, 10, 84, 215, 137, 107, 53
 };
 
-void w1_delay(unsigned long tm)
+static void w1_delay(unsigned long tm)
 {
 	udelay(tm * w1_delay_parm);
 }
@@ -61,7 +61,7 @@ static u8 w1_read_bit(struct w1_master *
 /**
  * Generates a write-0 or write-1 cycle and samples the level.
  */
-u8 w1_touch_bit(struct w1_master *dev, int bit)
+static u8 w1_touch_bit(struct w1_master *dev, int bit)
 {
 	if (dev->bus_master->touch_bit)
 		return dev->bus_master->touch_bit(dev->bus_master->data, bit);
@@ -177,7 +177,7 @@ u8 w1_triplet(struct w1_master *dev, int
  * @param dev     the master device
  * @return        the byte read
  */
-u8 w1_read_8(struct w1_master * dev)
+static u8 w1_read_8(struct w1_master * dev)
 {
 	int i;
 	u8 res = 0;
diff --git a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
index 2328601..9a76d2a 100644
--- a/drivers/w1/w1_io.h
+++ b/drivers/w1/w1_io.h
@@ -24,11 +24,8 @@ #define __W1_IO_H
 
 #include "w1.h"
 
-void w1_delay(unsigned long);
-u8 w1_touch_bit(struct w1_master *, int);
 u8 w1_triplet(struct w1_master *dev, int bdir);
 void w1_write_8(struct w1_master *, u8);
-u8 w1_read_8(struct w1_master *);
 int w1_reset_bus(struct w1_master *);
 u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
-- 
1.4.0

