Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293092AbSCJQpz>; Sun, 10 Mar 2002 11:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293094AbSCJQpq>; Sun, 10 Mar 2002 11:45:46 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:58058 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S293092AbSCJQph>;
	Sun, 10 Mar 2002 11:45:37 -0500
Date: Sun, 10 Mar 2002 17:45:35 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203101645.RAA02322@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.6 compile warnings in ide-scsi.c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.5.6, compilation of ide-scsi.c generates some rather
unpleasant looking warnings:

ide-scsi.c: In function `idescsi_end_request':
ide-scsi.c:293: warning: comparison of distinct pointer types lacks a cast
ide-scsi.c: In function `get_timeout':
ide-scsi.c:310: warning: comparison of distinct pointer types lacks a cast

They turned out to be caused by type mismatches in uses of the
min() and max() macros. Fix below.

/Mikael

--- linux-2.5.6/drivers/scsi/ide-scsi.c.~1~	Sat Mar  9 12:53:13 2002
+++ linux-2.5.6/drivers/scsi/ide-scsi.c	Sun Mar 10 17:14:12 2002
@@ -290,7 +290,7 @@
 			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred && pc->actually_transferred <= 1024 && pc->buffer) {
 				printk(", rst = ");
 				scsi_buf = pc->scsi_cmd->request_buffer;
-				hexdump(scsi_buf, min(16, pc->scsi_cmd->request_bufflen));
+				hexdump(scsi_buf, min(16U, pc->scsi_cmd->request_bufflen));
 			} else printk("\n");
 		}
 	}
@@ -307,7 +307,7 @@
 
 static inline unsigned long get_timeout(idescsi_pc_t *pc)
 {
-	return max(WAIT_CMD, pc->timeout - jiffies);
+	return max((unsigned long)WAIT_CMD, pc->timeout - jiffies);
 }
 
 /*
