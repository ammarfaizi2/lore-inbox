Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbUC0Fsh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 00:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUC0Fsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 00:48:37 -0500
Received: from mail.cyclades.com ([64.186.161.6]:46996 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261462AbUC0Fsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 00:48:32 -0500
Date: Sat, 27 Mar 2004 02:39:23 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <20040327053922.GA6961@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Subject: [PATCH] Fix cyclades async driver timeout miscalculation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi, 

The attached patch fixes a problem where cy_wait_until_sent()
miscalculates (calculate -1 on a unsigned long) the "char_time" 
parameter passed to schedule_timeout(). 

Fix that by making it a signed long, and checking for 
negative value.

Please apply.

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cy_wait_fix.patch"

--- linux-2.6.4/drivers/char/cyclades.c.orig	2004-03-27 02:30:40.050030160 -0300
+++ linux-2.6.4/drivers/char/cyclades.c	2004-03-27 02:30:44.878296152 -0300
@@ -2679,7 +2679,8 @@ cy_wait_until_sent(struct tty_struct *tt
   struct cyclades_port * info = (struct cyclades_port *)tty->driver_data;
   unsigned char *base_addr;
   int card,chip,channel,index;
-  unsigned long orig_jiffies, char_time;
+  unsigned long orig_jiffies;
+  signed long char_time;
 	
     if (serial_paranoia_check(info, tty->name, "cy_wait_until_sent"))
 	return;
@@ -2699,7 +2700,7 @@ cy_wait_until_sent(struct tty_struct *tt
      */
     char_time = (info->timeout - HZ/50) / info->xmit_fifo_size;
     char_time = char_time / 5;
-    if (char_time == 0)
+    if (char_time <= 0)
 	char_time = 1;
     if (timeout < 0)
 	timeout = 0;

--EVF5PPMfhYS0aIcm--
