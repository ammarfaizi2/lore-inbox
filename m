Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSGGO0e>; Sun, 7 Jul 2002 10:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSGGO0d>; Sun, 7 Jul 2002 10:26:33 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:8206 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315941AbSGGO0c>;
	Sun, 7 Jul 2002 10:26:32 -0400
Message-ID: <3D284E20.D5D00F99@torque.net>
Date: Sun, 07 Jul 2002 10:20:16 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dead keyboard in lk 2.5.25
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I first booted lk 2.5.25 on an Athlon box the AT keyboard 
was inactive. The mouse worked and the box was accessible across 
the network so it looked like a problem with the keyboard or its
driver.

/var/log/messages contained this sequence:

Jul  6 09:57:00 frig kernel: mice: PS/2 mouse device common for all mice
Jul  6 09:57:00 frig kernel: spurious 8259A interrupt: IRQ7.
Jul  6 09:57:00 frig kernel: i8042.c: Can't get irq 1 for KBD
Jul  6 09:57:00 frig kernel: i8042.c: Can't get irq 1 for KBD
Jul  6 09:57:00 frig kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Jul  6 09:57:00 frig kernel: input.c: hotplug returned -2

and /proc/interrupts indicated that irq 1 was owned by
"keyboard" which implied drivers/char/pc_keyb.c owned the
keyboard. The attempt by "i8042" to claim irq 1 returned
-EBUSY which caused the "can't get irq 1" line above.

Since nobody else has reported this error it could be
local to my environment. If you get this problem, the
crude patch below fixed it for me.

Doug Gilbert

--- linux/drivers/input/serio/i8042.c	Sat Jul  6 08:57:35 2002
+++ linux/drivers/input/serio/i8042.c2525fix	Sun Jul  7 09:52:50 2002
@@ -269,8 +269,11 @@
  */
 
 	if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
-		printk(KERN_ERR "i8042.c: Can't get irq %d for %s\n", values->irq, values->name);
-		return -1;
+		free_irq(values->irq, NULL);
+		if (request_irq(values->irq, i8042_interrupt, 0, "i8042", NULL)) {
+			printk(KERN_ERR "i8042.c: Can't get irq %d for %s\n", values->irq, values->name);
+			return -1;
+		}
 	}
 
 /*

