Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTJDN6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 09:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTJDN6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 09:58:11 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:7313 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262051AbTJDN6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 09:58:07 -0400
Date: Sat, 4 Oct 2003 15:58:00 +0200 (MEST)
Message-Id: <200310041358.h94Dw0oB009815@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: torvalds@osdl.org
Subject: [PATCH][2.6.0-test6] fix drivers/char/misc.c module autoloading breakage
Cc: linux-kernel@vger.kernel.org, shemminger@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/misc.c was changed in 2.6.0-test6 to use the
common list macros instead of its own list code. The first
open does load the module and increment its use count, but
a bug in test6 causes a failure to be reported anyway. This
(1) signals an error to user-space where there is none, and
(2) makes the module non-unloadable.

Fixed by the patch below. Tested. Please apply.

/Mikael

diff -ruN linux-2.6.0-test6/drivers/char/misc.c linux-2.6.0-test6.char-misc-fix/drivers/char/misc.c
--- linux-2.6.0-test6/drivers/char/misc.c	2003-09-28 12:19:40.000000000 +0200
+++ linux-2.6.0-test6.char-misc-fix/drivers/char/misc.c	2003-10-04 14:55:45.000000000 +0200
@@ -157,12 +157,11 @@
 		list_for_each_entry(c, &misc_list, list) {
 			if (c->minor == minor) {
 				new_fops = fops_get(c->fops);
-				if (!new_fops)
-					goto fail;
 				break;
 			}
 		}
-		goto fail;
+		if (!new_fops)
+			goto fail;
 	}
 
 	err = 0;
