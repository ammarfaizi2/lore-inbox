Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161039AbWGMXD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161039AbWGMXD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbWGMXD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:03:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41883
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1161035AbWGMXD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:03:59 -0400
Date: Thu, 13 Jul 2006 16:04:01 -0700 (PDT)
Message-Id: <20060713.160401.38711087.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
References: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Thu, 13 Jul 2006 14:18:33 +0200 (MEST)

> No actual problems, but I noticed some differences in the
> kernel log:

This should take care of all 4 issues.  The typo in the sunsab
driver causing the first port to not show up was good for a
laugh. :)

Let me know if it works for you too.

diff --git a/arch/sparc64/kernel/head.S b/arch/sparc64/kernel/head.S
index 75684b5..c8e9dc9 100644
--- a/arch/sparc64/kernel/head.S
+++ b/arch/sparc64/kernel/head.S
@@ -551,9 +551,10 @@ setup_trap_table:
 	save	%sp, -192, %sp
 
 	/* Force interrupts to be disabled. */
-	rdpr	%pstate, %o1
-	andn	%o1, PSTATE_IE, %o1
+	rdpr	%pstate, %l0
+	andn	%l0, PSTATE_IE, %o1
 	wrpr	%o1, 0x0, %pstate
+	rdpr	%pil, %l1
 	wrpr	%g0, 15, %pil
 
 	/* Make the firmware call to jump over to the Linux trap table.  */
@@ -622,11 +623,9 @@ setup_trap_table:
 	call	init_irqwork_curcpu
 	 nop
 
-	/* Now we can turn interrupts back on. */
-	rdpr	%pstate, %o1
-	or	%o1, PSTATE_IE, %o1
-	wrpr	%o1, 0, %pstate
-	wrpr	%g0, 0x0, %pil
+	/* Now we can restore interrupt state. */
+	wrpr	%l0, 0, %pstate
+	wrpr	%l1, 0x0, %pil
 
 	ret
 	 restore
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index b43de64..094d3e3 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -928,8 +928,6 @@ static void sparc64_start_timers(void)
 	__asm__ __volatile__("wrpr	%0, 0x0, %%pstate"
 			     : /* no outputs */
 			     : "r" (pstate));
-
-	local_irq_enable();
 }
 
 struct freq_table {
diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index 0dbd4df..979497f 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -1052,7 +1052,7 @@ static int __devinit sab_probe(struct of
 	if (err)
 		return err;
 
-	err = sunsab_init_one(&up[0], op, 0,
+	err = sunsab_init_one(&up[1], op, 0,
 			      (inst * 2) + 1);
 	if (err) {
 		of_iounmap(up[0].port.membase,
diff --git a/drivers/serial/sunsu.c b/drivers/serial/sunsu.c
index 93bdaa3..d3a5aee 100644
--- a/drivers/serial/sunsu.c
+++ b/drivers/serial/sunsu.c
@@ -1200,6 +1200,11 @@ static int __init sunsu_kbd_ms_init(stru
 	if (up->port.type == PORT_UNKNOWN)
 		return -ENODEV;
 
+	printk("%s: %s port at %lx, irq %u\n",
+	       to_of_device(up->port.dev)->node->full_name,
+	       (up->su_type == SU_PORT_KBD) ? "Keyboard" : "Mouse",
+	       up->port.mapbase, up->port.irq);
+
 #ifdef CONFIG_SERIO
 	serio = &up->serio;
 	serio->port_data = up;
