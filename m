Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVCFXte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVCFXte (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVCFXsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:48:12 -0500
Received: from coderock.org ([193.77.147.115]:62127 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261568AbVCFWhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:37:01 -0500
Subject: [patch 06/14] 16/34: char/istallion: replace interruptible_sleep_on() with wait_event_interruptible()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:33 +0100
Message-Id: <20050306223633.B13171EFA4@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use wait_event_interruptible() instead of the deprecated
interruptible_sleep_on(). The replacements were all straight-forward as every
sleep was conditionally-looped. Patch is compile-tested (still warns about
{save,restore}_flags(),cli()).

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/char/istallion.c |   76 ++++++++++++++++----------------------
 1 files changed, 33 insertions(+), 43 deletions(-)

diff -puN drivers/char/istallion.c~int_sleep_on-drivers_char_istallion drivers/char/istallion.c
--- kj/drivers/char/istallion.c~int_sleep_on-drivers_char_istallion	2005-03-05 16:11:34.000000000 +0100
+++ kj-domen/drivers/char/istallion.c	2005-03-05 16:11:34.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
+#include <linux/wait.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1068,11 +1069,10 @@ static int stli_open(struct tty_struct *
 	tty->driver_data = portp;
 	portp->refcount++;
 
-	while (test_bit(ST_INITIALIZING, &portp->state)) {
-		if (signal_pending(current))
-			return(-ERESTARTSYS);
-		interruptible_sleep_on(&portp->raw_wait);
-	}
+	wait_event_interruptible(portp->raw_wait,
+			!test_bit(ST_INITIALIZING, &portp->state));
+	if (signal_pending(current))
+		return(-ERESTARTSYS);
 
 	if ((portp->flags & ASYNC_INITIALIZED) == 0) {
 		set_bit(ST_INITIALIZING, &portp->state);
@@ -1275,12 +1275,11 @@ static int stli_rawopen(stlibrd_t *brdp,
  *	order of opens and closes may not be preserved across shared
  *	memory, so we must wait until it is complete.
  */
-	while (test_bit(ST_CLOSING, &portp->state)) {
-		if (signal_pending(current)) {
-			restore_flags(flags);
-			return(-ERESTARTSYS);
-		}
-		interruptible_sleep_on(&portp->raw_wait);
+	wait_event_interruptible(portp->raw_wait,
+			!test_bit(ST_CLOSING, &portp->state));
+	if (signal_pending(current)) {
+		restore_flags(flags);
+		return -ERESTARTSYS;
 	}
 
 /*
@@ -1309,13 +1308,10 @@ static int stli_rawopen(stlibrd_t *brdp,
  */
 	rc = 0;
 	set_bit(ST_OPENING, &portp->state);
-	while (test_bit(ST_OPENING, &portp->state)) {
-		if (signal_pending(current)) {
-			rc = -ERESTARTSYS;
-			break;
-		}
-		interruptible_sleep_on(&portp->raw_wait);
-	}
+	wait_event_interruptible(portp->raw_wait,
+			!test_bit(ST_OPENING, &portp->state));
+	if (signal_pending(current))
+		rc = -ERESTARTSYS;
 	restore_flags(flags);
 
 	if ((rc == 0) && (portp->rc != 0))
@@ -1352,12 +1348,11 @@ static int stli_rawclose(stlibrd_t *brdp
  *	occurs on this port.
  */
 	if (wait) {
-		while (test_bit(ST_CLOSING, &portp->state)) {
-			if (signal_pending(current)) {
-				restore_flags(flags);
-				return(-ERESTARTSYS);
-			}
-			interruptible_sleep_on(&portp->raw_wait);
+		wait_event_interruptible(portp->raw_wait,
+				!test_bit(ST_CLOSING, &portp->state));
+		if (signal_pending(current)) {
+			restore_flags(flags);
+			return -ERESTARTSYS;
 		}
 	}
 
@@ -1385,13 +1380,10 @@ static int stli_rawclose(stlibrd_t *brdp
  *	to come back.
  */
 	rc = 0;
-	while (test_bit(ST_CLOSING, &portp->state)) {
-		if (signal_pending(current)) {
-			rc = -ERESTARTSYS;
-			break;
-		}
-		interruptible_sleep_on(&portp->raw_wait);
-	}
+	wait_event_interruptible(portp->raw_wait,
+			!test_bit(ST_CLOSING, &portp->state));
+	if (signal_pending(current))
+		rc = -ERESTARTSYS;
 	restore_flags(flags);
 
 	if ((rc == 0) && (portp->rc != 0))
@@ -1420,22 +1412,20 @@ static int stli_cmdwait(stlibrd_t *brdp,
 
 	save_flags(flags);
 	cli();
-	while (test_bit(ST_CMDING, &portp->state)) {
-		if (signal_pending(current)) {
-			restore_flags(flags);
-			return(-ERESTARTSYS);
-		}
-		interruptible_sleep_on(&portp->raw_wait);
+	wait_event_interruptible(portp->raw_wait,
+			!test_bit(ST_CMDING, &portp->state));
+	if (signal_pending(current)) {
+		restore_flags(flags);
+		return -ERESTARTSYS;
 	}
 
 	stli_sendcmd(brdp, portp, cmd, arg, size, copyback);
 
-	while (test_bit(ST_CMDING, &portp->state)) {
-		if (signal_pending(current)) {
-			restore_flags(flags);
-			return(-ERESTARTSYS);
-		}
-		interruptible_sleep_on(&portp->raw_wait);
+	wait_event_interruptible(portp->raw_wait,
+			!test_bit(ST_CMDING, &portp->state));
+	if (signal_pending(current)) {
+		restore_flags(flags);
+		return -ERESTARTSYS;
 	}
 	restore_flags(flags);
 
_
