Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbUCREcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 23:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUCREcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 23:32:07 -0500
Received: from dp.samba.org ([66.70.73.150]:3228 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262374AbUCREcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 23:32:02 -0500
Date: Thu, 18 Mar 2004 15:27:44 +1100
From: Anton Blanchard <anton@samba.org>
To: vojtech@suse.cz
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Recent input patch broke my keyboard
Message-ID: <20040318042744.GE28212@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

The patch below breaks my ppc64 box. None of the keys behave as expected :)
I also get a bunch of stuff in the dmesg:

atkbd.c: Use 'setkeycodes 66 <keycode>' to make it known.
atkbd.c: Unknown key pressed (translated set 2, code 0x66 on isa0060/serio0).

The boot messages show:

serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0

If I back the patch out, things work again and I get:

serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Logitech Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Raw Set 2 keyboard on isa0060/serio0

Sounds like assuming we are always in translate mode is bad for me.

Anton

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/03/03 15:14:01+01:00 vojtech@suse.cz 
#   input: i8042.c:
#     Assume the chip always is in XLATE mode, even when it doesn't
#     have the XLATE bit set - apparently IBM PS/2 model 70 behaves
#     this way.
# 
# drivers/input/serio/i8042.c
#   2004/03/03 15:13:56+01:00 vojtech@suse.cz +0 -8
#   input: i8042.c:
#     Assume the chip always is in XLATE mode, even when it doesn't
#     have the XLATE bit set - apparently IBM PS/2 model 70 behaves
#     this way.
# 
diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Mar 18 15:06:59 2004
+++ b/drivers/input/serio/i8042.c	Thu Mar 18 15:06:59 2004
@@ -722,14 +722,6 @@
 	}
 
 /*
- * If the chip is configured into nontranslated mode by the BIOS, don't
- * bother enabling translating and be happy.
- */
-
-	if (~i8042_ctr & I8042_CTR_XLATE)
-		i8042_direct = 1;
-
-/*
  * Set nontranslated mode for the kbd interface if requested by an option.
  * After this the kbd interface becomes a simple serial in/out, like the aux
  * interface is. We don't do this by default, since it can confuse notebook
