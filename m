Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129420AbQKBJWz>; Thu, 2 Nov 2000 04:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129697AbQKBJWp>; Thu, 2 Nov 2000 04:22:45 -0500
Received: from opal.biophys.uni-duesseldorf.de ([134.99.176.7]:38410 "EHLO
	opal.biophys.uni-duesseldorf.de") by vger.kernel.org with ESMTP
	id <S129420AbQKBJWf>; Thu, 2 Nov 2000 04:22:35 -0500
Date: Thu, 2 Nov 2000 10:22:24 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Eric Reischer <emr@engr.de.psu.edu>
cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        debian-powerpc@lists.debian.org
Subject: Re: Issue compiling 2.4test10
In-Reply-To: <4.2.0.58.20001101202452.00a79440@engr.de.psu.edu>
Message-ID: <Pine.LNX.4.10.10011021021110.19979-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am attempting to cross-compile a 2.4 kernel for a PowerPC arch on an
> Intel machine, of which I have Debian 2.2 installed.  I have successfully
> compiled a 2.4test9 kernel, but I got the following error message the first
> time I compiled (it failed due to this):
> 
> powerpc-unknown-linux-gnu-ld -T arch/ppc/mm/mm.o <blah blah blah on same
> command for about 11 lines>
> drivers/input/inputdrv.o: In function 'keybdev_event':
> drivers/input/inputdrv.o(.text+0x16bc): undefined reference to 'emulate_raw'
> drivers/input/inputdrv.o(.text+0x16bc): relocation truncated to fit:
> R_PPC_REL24 emulate_raw
> make: *** [vmlinux] Error 1

Would this patch help?

--- drivers/input/keybdev.c.org	Thu Nov  2 10:13:39 2000
+++ drivers/input/keybdev.c	Thu Nov  2 10:19:43 2000
@@ -36,7 +36,7 @@
 #include <linux/module.h>
 #include <linux/kbd_kern.h>
 
-#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__)
+#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__) || defined(CONFIG_MAC_HID)
 
 static int x86_sysrq_alt = 0;
 
@@ -133,8 +133,10 @@
 {
 	if (type != EV_KEY) return;
 
+#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__) || defined(CONFIG_MAC_HID) || defined(CONFIG_ADB_KEYBOARD)
 	if (emulate_raw(code, down))
 		printk(KERN_WARNING "keyboard.c: can't emulate rawmode for keycode %d\n", code);
+#endif
 
 	tasklet_schedule(&keyboard_tasklet);
 }

Untested, of course.

	Michael

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
