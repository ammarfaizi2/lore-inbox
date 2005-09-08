Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVIHW0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVIHW0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 18:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbVIHW0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 18:26:23 -0400
Received: from mail.kroah.org ([69.55.234.183]:38846 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965051AbVIHWW4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 18:22:56 -0400
Cc: johnpol@2ka.mipt.ru
Subject: [PATCH] w1: Added w1_reset_select_slave() - Resets the bus and then selects the slave by
In-Reply-To: <11262181613474@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 8 Sep 2005 15:22:41 -0700
Message-Id: <11262181611117@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] w1: Added w1_reset_select_slave() - Resets the bus and then selects the slave by

sending either a skip rom or a rom match.

Patch from Ben Gardner <bgardner@wabtec.com>

Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ea7d8f65c865ebfa1d7cd67c360a87333ff013c1
tree 1e687c32d53a92c10a61fb23ab14763459ff5779
parent db2d0008de519c5db6baec45f7831e08790301cf
author Evgeniy Polyakov <johnpol@2ka.mipt.ru> Thu, 11 Aug 2005 17:27:49 +0400
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 08 Sep 2005 14:41:26 -0700

 drivers/w1/w1_io.c    |   24 ++++++++++++++++++++++++
 drivers/w1/w1_io.h    |    1 +
 drivers/w1/w1_therm.c |   11 ++---------
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/w1/w1_io.c b/drivers/w1/w1_io.c
--- a/drivers/w1/w1_io.c
+++ b/drivers/w1/w1_io.c
@@ -277,6 +277,29 @@ void w1_search_devices(struct w1_master 
 		w1_search(dev, cb);
 }
 
+/**
+ * Resets the bus and then selects the slave by sending either a skip rom
+ * or a rom match.
+ * The w1 master lock must be held.
+ *
+ * @param sl	the slave to select
+ * @return 	0=success, anything else=error
+ */
+int w1_reset_select_slave(struct w1_slave *sl)
+{
+	if (w1_reset_bus(sl->master))
+		return -1;
+
+	if (sl->master->slave_count == 1)
+		w1_write_8(sl->master, W1_SKIP_ROM);
+	else {
+		u8 match[9] = {W1_MATCH_ROM, };
+		memcpy(&match[1], (u8 *)&sl->reg_num, 8);
+		w1_write_block(sl->master, match, 9);
+	}
+	return 0;
+}
+
 EXPORT_SYMBOL(w1_touch_bit);
 EXPORT_SYMBOL(w1_write_8);
 EXPORT_SYMBOL(w1_read_8);
@@ -286,3 +309,4 @@ EXPORT_SYMBOL(w1_delay);
 EXPORT_SYMBOL(w1_read_block);
 EXPORT_SYMBOL(w1_write_block);
 EXPORT_SYMBOL(w1_search_devices);
+EXPORT_SYMBOL(w1_reset_select_slave);
diff --git a/drivers/w1/w1_io.h b/drivers/w1/w1_io.h
--- a/drivers/w1/w1_io.h
+++ b/drivers/w1/w1_io.h
@@ -34,5 +34,6 @@ u8 w1_calc_crc8(u8 *, int);
 void w1_write_block(struct w1_master *, const u8 *, int);
 u8 w1_read_block(struct w1_master *, u8 *, int);
 void w1_search_devices(struct w1_master *dev, w1_slave_found_callback cb);
+int w1_reset_select_slave(struct w1_slave *sl);
 
 #endif /* __W1_IO_H */
diff --git a/drivers/w1/w1_therm.c b/drivers/w1/w1_therm.c
--- a/drivers/w1/w1_therm.c
+++ b/drivers/w1/w1_therm.c
@@ -176,15 +176,10 @@ static ssize_t w1_therm_read_bin(struct 
 	crc = 0;
 
 	while (max_trying--) {
-		if (!w1_reset_bus (dev)) {
+		if (!w1_reset_select_slave(sl)) {
 			int count = 0;
-			u8 match[9] = {W1_MATCH_ROM, };
 			unsigned int tm = 750;
 
-			memcpy(&match[1], (u64 *) & sl->reg_num, 8);
-
-			w1_write_block(dev, match, 9);
-
 			w1_write_8(dev, W1_CONVERT_TEMP);
 
 			while (tm) {
@@ -193,8 +188,7 @@ static ssize_t w1_therm_read_bin(struct 
 					flush_signals(current);
 			}
 
-			if (!w1_reset_bus (dev)) {
-				w1_write_block(dev, match, 9);
+			if (!w1_reset_select_slave(sl)) {
 
 				w1_write_8(dev, W1_READ_SCRATCHPAD);
 				if ((count = w1_read_block(dev, rom, 9)) != 9) {
@@ -205,7 +199,6 @@ static ssize_t w1_therm_read_bin(struct 
 
 				if (rom[8] == crc && rom[0])
 					verdict = 1;
-
 			}
 		}
 

