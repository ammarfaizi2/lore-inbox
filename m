Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSLIV0o>; Mon, 9 Dec 2002 16:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbSLIV0o>; Mon, 9 Dec 2002 16:26:44 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:52114 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S266228AbSLIV0n>;
	Mon, 9 Dec 2002 16:26:43 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] Re: pc_keyb.c #define kbd_controller_present()
Date: Mon, 9 Dec 2002 14:29:35 -0700
User-Agent: KMail/1.4.3
Cc: Nat Ersoz <nat.ersoz@myrio.com>, <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212091429.35490.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should only need this:

+#ifndef CONFIG_PSKEYBOARD
+#define kbd_controller_present()       0
+#endif

I think the following hunk should be superfluous:

+#ifdef CONFIG_PSKEYBOARD
 #define kbd_read_input() inb(KBD_DATA_REG)
 #define kbd_read_status() inb(KBD_STATUS_REG)
 #define kbd_write_output(val) outb(val, KBD_DATA_REG)
 #define kbd_write_command(val) outb(val, KBD_CNTL_REG)
+#else
+#define kbd_read_input()       0
+#define kbd_read_status()      0
+#define kbd_write_output(val)
+#define kbd_write_command(val)
+#endif

Or is there some case where pc_keyb will use kbd_read_input() and
friends even if kbd_controller_present() is false?

We have the equivalent of the first hunk in asm-ia64/keyboard.h, and
the kbd_controller_present() hook should be used consistently to
avoid breakage.  For example, if you include the second hunk, and
pc_keyb.c changes to use kbd_read_input() even when kbd_controller_present()
is false, i386 might still work but ia64 would break.

Bjorn

