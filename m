Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbTJCIYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 04:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTJCIYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 04:24:30 -0400
Received: from ns.suse.de ([195.135.220.2]:65244 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263624AbTJCIYY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 04:24:24 -0400
To: Sylvain Pasche <sylvain_pasche@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 ACPI power off via sysrq not working
References: <1065168778.1740.10.camel@highscreen.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 03 Oct 2003 10:24:23 +0200
In-Reply-To: <1065168778.1740.10.camel@highscreen.suse.lists.linux.kernel>
Message-ID: <p73u16qybig.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sylvain Pasche <sylvain_pasche@yahoo.fr> writes:

> Hi, 
> 
> If I want to halt the system using sys-rq - o key, I get an oops instead
> of a power down.
> Inside pm.c:159, there is:
> 	
> 	if (in_interrupt())
> 		BUG();
> 
> But if we look at the trace, we are in the interrupt of the keyboard
> handler.
> One fix would be to comment out the BUG line, but there's certainly "a
> better way to do it".

Use this patch.

diff -u linux/drivers/acpi/system.c-o linux/drivers/acpi/system.c
--- linux/drivers/acpi/system.c-o	2003-09-07 16:20:44.000000000 +0200
+++ linux/drivers/acpi/system.c	2003-09-08 21:04:46.000000000 +0200
@@ -1192,11 +1192,21 @@
 
 #if defined(CONFIG_MAGIC_SYSRQ) && defined(CONFIG_PM)
 
+static int po_cb_active; 
+
+static void acpi_po_tramp(void *x)
+{ 
+	acpi_power_off();	
+} 
+
 /* Simple wrapper calling power down function. */
 static void acpi_sysrq_power_off(int key, struct pt_regs *pt_regs,
 	struct kbd_struct *kbd, struct tty_struct *tty)
-{
-	acpi_power_off();
+{	
+	static struct tq_struct tq = { .routine = acpi_po_tramp };
+	if (po_cb_active++)
+		return;
+	schedule_task(&tq); 
 }
 
 struct sysrq_key_op sysrq_acpi_poweroff_op = {


-Andi


