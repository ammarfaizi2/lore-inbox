Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263481AbTECXdA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 19:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263482AbTECXbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 19:31:51 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:50696 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263468AbTECXbo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 19:31:44 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10520054463981@movementarian.org>
Subject: [PATCH 4/8] OProfile update
In-Reply-To: <10520054461823@movementarian.org>
From: John Levon <levon@movementarian.org>
X-Mailer: gregkh_patchbomb
Date: Sun, 4 May 2003 00:44:06 +0100
Content-Transfer-Encoding: 7BIT
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
X-Spam-Score: -6.3 (------)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19C6fn-0009tl-42*SAwl7j304SE*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If there's are multiple tasks sleeping inside the read routine ever, this is necessary.

diff -Naur -X dontdiff linux-cvs/drivers/oprofile/event_buffer.c linux-me/drivers/oprofile/event_buffer.c
--- linux-cvs/drivers/oprofile/event_buffer.c	2002-12-21 19:18:20.000000000 +0000
+++ linux-me/drivers/oprofile/event_buffer.c	2003-04-29 01:09:35.000000000 +0100
@@ -151,11 +151,15 @@
 	if (count != max || *offset)
 		return -EINVAL;
 
-	/* wait for the event buffer to fill up with some data */
 	wait_event_interruptible(buffer_wait, atomic_read(&buffer_ready));
+
 	if (signal_pending(current))
 		return -EINTR;
 
+	/* can't currently happen */
+	if (!atomic_read(&buffer_ready))
+		return -EAGAIN;
+
 	down(&buffer_sem);
 
 	atomic_set(&buffer_ready, 0);

