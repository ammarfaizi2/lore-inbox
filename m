Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSGQO0e>; Wed, 17 Jul 2002 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSGQO0e>; Wed, 17 Jul 2002 10:26:34 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1030 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314835AbSGQO0d>; Wed, 17 Jul 2002 10:26:33 -0400
Date: Wed, 17 Jul 2002 15:29:29 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org, jsimmons@transvirtual.com
Subject: Link errors with CONFIG_VT=n, CONFIG_SYSRQ=y
Message-ID: <20020717152929.A5856@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lkml, James,

When building 2.5.26 with CONFIG_VT=n and CONFIG_SYSRQ=y, the resulting
kernel can't be linked:

drivers/built-in.o: In function `sysrq_handle_unraw':
drivers/built-in.o(.text+0x14694): undefined reference to `fg_console'
drivers/built-in.o(.text+0x14698): undefined reference to `kbd_table'

The following is a work-around for this problem.  There is probably
a cleaner solution to this.

--- orig/drivers/char/sysrq.c	Wed Jul 17 15:10:39 2002
+++ linux/drivers/char/sysrq.c	Wed Jul 17 15:27:18 2002
@@ -81,10 +81,12 @@
 static void sysrq_handle_unraw(int key, struct pt_regs *pt_regs,
 			       struct tty_struct *tty) 
 {
+#ifdef CONFIG_VT
 	struct kbd_struct *kbd = &kbd_table[fg_console];
 
 	if (kbd)
 		kbd->kbdmode = VC_XLATE;
+#endif
 }
 static struct sysrq_key_op sysrq_unraw_op = {
 	handler:	sysrq_handle_unraw,

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

