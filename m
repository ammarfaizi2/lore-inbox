Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265886AbSL3CHQ>; Sun, 29 Dec 2002 21:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSL3CHQ>; Sun, 29 Dec 2002 21:07:16 -0500
Received: from msg.vodafone.pt ([212.18.167.162]:19331 "EHLO msg.vodafone.pt")
	by vger.kernel.org with ESMTP id <S265886AbSL3CG6>;
	Sun, 29 Dec 2002 21:06:58 -0500
Date: Sun, 29 Dec 2002 22:36:52 +0000
From: "Paulo Andre'" <fscked@netvisao.pt>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.53 : drivers/scsi/qlogicfc.c locking fixes
Message-Id: <20021229223652.5592e63e.fscked@netvisao.pt>
Organization: Orion Enterprises
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 02:14:37.0073 (UTC) FILETIME=[33A74810:01C2AFA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small patch to fix the remaining deprecated
save_flags/cli/restore_flags construction in the qlogicfc.c scsi driver.

Please review.

		Paulo Andre'

---

--- qlogicfc.c.orig	2002-12-29 22:07:37.000000000 +0000
+++ qlogicfc.c	2002-12-29 22:12:38.000000000 +0000
@@ -108,6 +108,8 @@
 
 #define TRACE_BUF_LEN	(32*1024)
 
+static spinlock_t qlogicfc_lock = SPIN_LOCK_UNLOCKED;
+	
 struct {
 	u_long next;
 	struct {
@@ -122,14 +124,13 @@
 {								\
 	unsigned long flags;					\
 								\
-	save_flags(flags);					\
-	cli();							\
+	spin_lock_irqsave(&qlogicfc_lock, flags);		\
 	trace.buf[trace.next].name  = (w);			\
 	trace.buf[trace.next].time  = jiffies;			\
 	trace.buf[trace.next].index = (i);			\
 	trace.buf[trace.next].addr  = (long) (a);		\
 	trace.next = (trace.next + 1) & (TRACE_BUF_LEN - 1);	\
-	restore_flags(flags);					\
+	spin_unlock_irqrestore(&qlogicfc_lock, flags);		\
 }
 
 #else
