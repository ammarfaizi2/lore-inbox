Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTJTHXx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 03:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbTJTHW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 03:22:28 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:35045 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262418AbTJTHWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 03:22:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH][v850]  Workaround for tty-driver init-order problem on v850 sim platform
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20031020072156.69FB63702@mcspd15.ucom.lsi.nec.co.jp>
Date: Mon, 20 Oct 2003 16:21:56 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use `late_initcall' instead of just `__initcall' as a workaround for
the fact that (1) simcons_tty_init can't be called before tty_init,
(2) tty_init is called via `module_init', (3) if statically linked,
module_init == device_init, and (4) there's no ordering of init lists.

We can do this easily because simcons is always statically linked, but
other tty drivers that depend on tty_init and which must use
`module_init' to declare their init routines are likely to be broken.

[Please apply -- this problem prevents this platform from booting.]

diff -ruN -X../cludes linux-2.6.0-test8-uc0/arch/v850/kernel/simcons.c linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/simcons.c
--- linux-2.6.0-test8-uc0/arch/v850/kernel/simcons.c	2003-07-14 13:14:39.000000000 +0900
+++ linux-2.6.0-test8-uc0-v850-20031020/arch/v850/kernel/simcons.c	2003-10-20 14:27:53.000000000 +0900
@@ -104,7 +104,14 @@
 	tty_driver = driver;
 	return 0;
 }
-__initcall (simcons_tty_init);
+/* We use `late_initcall' instead of just `__initcall' as a workaround for
+   the fact that (1) simcons_tty_init can't be called before tty_init,
+   (2) tty_init is called via `module_init', (3) if statically linked,
+   module_init == device_init, and (4) there's no ordering of init lists.
+   We can do this easily because simcons is always statically linked, but
+   other tty drivers that depend on tty_init and which must use
+   `module_init' to declare their init routines are likely to be broken.  */
+late_initcall(simcons_tty_init);
 
 /* Poll for input on the console, and if there's any, deliver it to the
    tty driver.  */
