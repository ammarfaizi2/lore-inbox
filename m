Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVCFKcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVCFKcS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 05:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVCFKcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 05:32:18 -0500
Received: from coderock.org ([193.77.147.115]:52136 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261358AbVCFKcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 05:32:03 -0500
Subject: [patch 2/6] 12/34: cdrom/cdu31a: replace interruptible_sleep_on() with wait_event_interruptible()
To: emoenke@gwdg.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 11:31:54 +0100
Message-Id: <20050306103155.4AC7D1F202@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use wait_event_interruptible() instead of the deprecated
interruptible_sleep_on(). The patch is straight-forward as the macros should 
result in the same execution. Patch is compile-tested (still throws out warnings
regarding {save,restore}_flags()).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/cdrom/cdu31a.c |   40 +++++++++++++++++-----------------------
 1 files changed, 17 insertions(+), 23 deletions(-)

diff -puN drivers/cdrom/cdu31a.c~int_sleep_on-drivers_cdrom_cdu31a drivers/cdrom/cdu31a.c
--- kj/drivers/cdrom/cdu31a.c~int_sleep_on-drivers_cdrom_cdu31a	2005-03-05 16:11:33.000000000 +0100
+++ kj-domen/drivers/cdrom/cdu31a.c	2005-03-05 16:11:33.000000000 +0100
@@ -166,6 +166,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/wait.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -865,15 +866,13 @@ do_sony_cd_cmd(unsigned char cmd,
 	save_flags(flags);
 	cli();
 	if (current != has_cd_task) {	/* Allow recursive calls to this routine */
-		while (sony_inuse) {
-			interruptible_sleep_on(&sony_wait);
-			if (signal_pending(current)) {
-				result_buffer[0] = 0x20;
-				result_buffer[1] = SONY_SIGNAL_OP_ERR;
-				*result_size = 2;
-				restore_flags(flags);
-				return;
-			}
+		wait_event_interruptible(sony_wait, !sony_inuse);
+		if (signal_pending(current)) {
+			result_buffer[0] = 0x20;
+			result_buffer[1] = SONY_SIGNAL_OP_ERR;
+			*result_size = 2;
+			restore_flags(flags);
+			return;
 		}
 		sony_inuse = 1;
 		has_cd_task = current;
@@ -1372,16 +1371,13 @@ static void do_cdu31a_request(request_qu
 	 */
 	save_flags(flags);
 	cli();
-	while (sony_inuse) {
-		interruptible_sleep_on(&sony_wait);
-		if (signal_pending(current)) {
-			restore_flags(flags);
+	wait_event_interruptible(sony_wait, !sony_inuse);
+	if (signal_pending(current)) {
+		restore_flags(flags);
 #if DEBUG
-			printk("Leaving do_cdu31a_request at %d\n",
-			       __LINE__);
+		printk("Leaving do_cdu31a_request at %d\n", __LINE__);
 #endif
-			return;
-		}
+		return;
 	}
 	sony_inuse = 1;
 	has_cd_task = current;
@@ -2326,12 +2322,10 @@ static int read_audio(struct cdrom_read_
 	 */
 	save_flags(flags);
 	cli();
-	while (sony_inuse) {
-		interruptible_sleep_on(&sony_wait);
-		if (signal_pending(current)) {
-			restore_flags(flags);
-			return -EAGAIN;
-		}
+	wait_event_interruptible(sony_wait, sony_inuse);
+	if (signal_pending(current)) {
+		restore_flags(flags);
+		return -EAGAIN;
 	}
 	sony_inuse = 1;
 	has_cd_task = current;
_
