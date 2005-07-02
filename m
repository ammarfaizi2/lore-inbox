Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVGBQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVGBQMf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVGBQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 12:12:35 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:24448 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S261193AbVGBQMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 12:12:19 -0400
Message-ID: <42C6BCC5.8060809@keyaccess.nl>
Date: Sat, 02 Jul 2005 18:11:49 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [TRIVIAL] drivers/input/serio/i8042-x86ia64.h
Content-Type: multipart/mixed;
 boundary="------------010603090402020907080705"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010603090402020907080705
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

Non-trivial in that I'm unsure of original intent but trivial in that 
it's just a printk()...

On bootup, I see:

pnp: the driver 'i8042 kbd' has been registered
pnp: match found with the PnP device '00:05' and the driver 'i8042 kbd'
pnp: the driver 'i8042 aux' has been registered
PNP: PS/2 controller doesn't have AUX irq; using default 0xc
PNP: PS/2 Controller [PNP0303] at 0x60,0x64 irq 112
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1

That "irq 112" (last PNP: line) should read "irq 1,12" but is being run 
together:

printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %d%s%d\n",
	i8042_pnp_kbd_name,
	(result_kbd > 0 && result_aux > 0) ? "," : "",
	i8042_pnp_aux_name,
	i8042_data_reg,
	i8042_command_reg,
	i8042_kbd_irq,
	(result_aux > 0) ? "," : "", i8042_aux_irq);

That first 'foo ? "," : ""' construct there seems somewhat okay-ish 
since i8042_pnp_aux_name is a 0-string when result_aux <= 0, but this 
obviously does not work for i8042_aux_irq (an integer).

In my case result_aux is 0 due to my BIOS not exporting a PS/2 mouse PNP 
id after which the code just assigns the default irq 12 (the first PNP: 
line above) but winds up printing "irq 112". Due to that default 
assignment, the correct fix would seem to be to just have "%d,%d". 
Attachment does this (and takes the opportunity to change two %#x format 
specifiers for the IRQs to %d).

Did not know who to more specifically bother about this; hope that's okay.

Rene.

--------------010603090402020907080705
Content-Type: text/x-patch;
 name="linux-2.6.12.2_ps2_printk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12.2_ps2_printk.diff"

--- linux-2.6.12.2/drivers/input/serio/i8042-x86ia64io.h.orig	2005-07-02 16:49:16.000000000 +0200
+++ linux-2.6.12.2/drivers/input/serio/i8042-x86ia64io.h	2005-07-02 16:51:17.000000000 +0200
@@ -281,12 +281,12 @@
 	}
 
 	if (!i8042_pnp_kbd_irq) {
-		printk(KERN_WARNING "PNP: PS/2 controller doesn't have KBD irq; using default %#x\n", i8042_kbd_irq);
+		printk(KERN_WARNING "PNP: PS/2 controller doesn't have KBD irq; using default %d\n", i8042_kbd_irq);
 		i8042_pnp_kbd_irq = i8042_kbd_irq;
 	}
 
 	if (!i8042_pnp_aux_irq) {
-		printk(KERN_WARNING "PNP: PS/2 controller doesn't have AUX irq; using default %#x\n", i8042_aux_irq);
+		printk(KERN_WARNING "PNP: PS/2 controller doesn't have AUX irq; using default %d\n", i8042_aux_irq);
 		i8042_pnp_aux_irq = i8042_aux_irq;
 	}
 
@@ -300,10 +300,9 @@
 	i8042_kbd_irq = i8042_pnp_kbd_irq;
 	i8042_aux_irq = i8042_pnp_aux_irq;
 
-	printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %d%s%d\n",
+	printk(KERN_INFO "PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %d,%d\n",
 		i8042_pnp_kbd_name, (result_kbd > 0 && result_aux > 0) ? "," : "", i8042_pnp_aux_name,
-		i8042_data_reg, i8042_command_reg, i8042_kbd_irq,
-		(result_aux > 0) ? "," : "", i8042_aux_irq);
+		i8042_data_reg, i8042_command_reg, i8042_kbd_irq, i8042_aux_irq);
 
 	return 0;
 }

--------------010603090402020907080705--
