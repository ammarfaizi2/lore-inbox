Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268129AbUIWBWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268129AbUIWBWn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUIWBWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:22:37 -0400
Received: from [12.177.129.25] ([12.177.129.25]:6340 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268131AbUIWBVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:21:16 -0400
Message-Id: <200409230226.i8N2QWiF004303@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
Subject: [PATCH] UML - Don't trash return value
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 22 Sep 2004 22:26:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Dumitru <doug@easyco.com>
I have been fighting a buffering error when sending large amounts of 
data out pty devices from UML.  I have tried a couple of patches that 
did not really fix the problem (and were rightly rejected by the group), 
but have finally found the real bug.

In /arch/um/drivers/line.c there is a function "buffer_data" that is 
responsible for storing data into the lines ring buffer.  The function 
is "supposed" to return the number of characters actually buffered. 
Unfortunately, in the case where the buffer wraps, the "len" variable is 
decremented by "end" before it is used as the return parameter.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.9-rc2-mm1-orig/arch/um/drivers/line.c
===================================================================
--- linux-2.6.9-rc2-mm1-orig.orig/arch/um/drivers/line.c	2004-09-22 20:39:58.000000000 -0400
+++ linux-2.6.9-rc2-mm1-orig/arch/um/drivers/line.c	2004-09-22 20:55:34.000000000 -0400
@@ -73,9 +73,8 @@
 	else {
 		memcpy(line->tail, buf, end);
 		buf += end;
-		len -= end;
-		memcpy(line->buffer, buf, len);
-		line->tail = line->buffer + len;
+		memcpy(line->buffer, buf, len - end);
+		line->tail = line->buffer + len - end;
 	}
 
 	return(len);

