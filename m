Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291110AbSCDDRK>; Sun, 3 Mar 2002 22:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291148AbSCDDRB>; Sun, 3 Mar 2002 22:17:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291110AbSCDDQt>; Sun, 3 Mar 2002 22:16:49 -0500
Subject: Re: Unable to handle kernel paging request when accessing /proc/bus/pnp/escd
To: gandalf@wlug.westbo.se (Martin Josefsson)
Date: Mon, 4 Mar 2002 03:31:49 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0203040246470.8495-100000@tux.rsn.bth.se> from "Martin Josefsson" at Mar 04, 2002 02:55:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hjCX-0006Nt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was just looking around in /proc/bus a little and I tried 
> 'cat /proc/bus/pnp/escd' and I got this:

Your PnP BIOS appears to have choked

> EIP:    0068:[<00007598>]    Tainted: P 

          ^^^^ Trapped out in the BIOS (segment 0068)

Two things here. Firstly make sure Thomas gets the report so he can double
check it was called right. Secondly can try the following

--- arch/i386/kernel/traps.c~	Wed Feb 13 00:30:44 2002
+++ arch/i386/kernel/traps.c	Mon Mar  4 03:13:16 2002
@@ -241,6 +241,20 @@
 
 void die(const char * str, struct pt_regs * regs, long err)
 {
+#ifdef CONFIG_PNPBIOS		
+	if (regs->xcs == 0x60 || regs->xcs == 0x68)
+	{
+		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
+		extern u32 pnp_bios_is_utter_crap;
+		pnp_bios_is_utter_crap = 1;
+		printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
+		__asm__ volatile(
+			"movl %0, %%esp\n\t"
+			"jmp %1\n\t"
+			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
+		panic("do_trap: can't hit this");
+	}
+#endif	
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
@@ -272,20 +286,6 @@
 	if (vm86 && regs->eflags & VM_MASK)
 		goto vm86_trap;
 
-#ifdef CONFIG_PNPBIOS		
-	if (regs->xcs == 0x60 || regs->xcs == 0x68)
-	{
-		extern u32 pnp_bios_fault_eip, pnp_bios_fault_esp;
-		extern u32 pnp_bios_is_utter_crap;
-		pnp_bios_is_utter_crap = 1;
-		printk(KERN_CRIT "PNPBIOS fault.. attempting recovery.\n");
-		__asm__ volatile(
-			"movl %0, %%esp\n\t"
-			"jmp %1\n\t"
-			: "=a" (pnp_bios_fault_esp), "=b" (pnp_bios_fault_eip));
-		panic("do_trap: can't hit this");
-	}
-#endif	
 
 	if (!(regs->xcs & 3))
 		goto kernel_trap;

