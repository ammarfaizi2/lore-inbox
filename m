Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbTIEXW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTIEXW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:22:57 -0400
Received: from hera.cwi.nl ([192.16.191.8]:56505 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265109AbTIEXWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:22:51 -0400
From: Andries.Brouwer@cwi.nl
Date: Sat, 6 Sep 2003 01:22:44 +0200 (MEST)
Message-Id: <UTC200309052322.h85NMi903303.aeb@smtp.cwi.nl>
To: akpm@osdl.org, torvalds@osdl.org, vojtech@suse.cz
Subject: [PATCH] more keyboard stuff
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked a bit more at the keyboard code and find a bug
and a probable bug.

(i) In case a synaptics touchpad has been detected, the comment
says "disable AUX". But we do not set the disable bit, but
instead .and. with the bit - no doubt getting zero.
This must be a bug.

(ii) Directly above this is the suspicious comment
"keyboard translation seems to be always off".
But every machine comes always up in translated scancode 2.
Translation is never off. But wait! by mistake the above .and.
cleared the XLATE bit.

So, I think bug (i) explains mystery (ii).

However, note that this is code reading only.
I do not have the hardware, so cannot test.

Andries

[line numbers will be off]


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Sat Aug  9 22:16:42 2003
+++ b/drivers/input/serio/i8042.c	Sat Sep  6 02:05:34 2003
@@ -618,16 +619,10 @@
 		(~param >> 4) & 0xf, ~param & 0xf);
 
 /*
- * In MUX mode the keyboard translation seems to be always off.
- */
- 
-	i8042_direct = 1;
-
-/*
  * Disable all muxed ports by disabling AUX.
  */
 
-	i8042_ctr &= I8042_CTR_AUXDIS;
+	i8042_ctr |= I8042_CTR_AUXDIS;
 	i8042_ctr &= ~I8042_CTR_AUXINT;
 
 	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR))
