Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUIZWeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUIZWeV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264530AbUIZWeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:34:21 -0400
Received: from gprs214-244.eurotel.cz ([160.218.214.244]:46465 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264500AbUIZWeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:34:16 -0400
Date: Mon, 27 Sep 2004 00:33:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, Stefan Seyfried <seife@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc2-mm3: swsusp horribly slow on AMD64
Message-ID: <20040926223351.GO28810@elf.ucw.cz>
References: <200409251214.28743.rjw@sisk.pl> <200409261337.53298.rjw@sisk.pl> <41572E05.9030406@suse.de> <200409270001.09311.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409270001.09311.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> --- pci-driver.c	2004-09-26 23:35:32.701574416 +0200
> +++ pci-driver.c.rjw	2004-09-26 23:35:18.441742240 +0200
> @@ -328,6 +328,7 @@
>   */
>  static void pci_default_resume(struct pci_dev *pci_dev)
>  {
> +	printk("pci_default_resume (0x%04x, 0x%04x): %ld\n", pci_dev->vendor, 
> pci_dev->device, jiffies/HZ);
>  	/* restore the PCI config space */
>  	pci_restore_state(pci_dev, pci_dev->saved_config_space);
>  	/* if the device was enabled before suspend, reenable */
> @@ -343,6 +344,7 @@
>  	struct pci_dev * pci_dev = to_pci_dev(dev);
>  	struct pci_driver * drv = pci_dev->driver;
>  
> +	printk("pci_device_resume (0x%04x, 0x%04x): %ld\n", pci_dev->vendor, 
> pci_dev->device, jiffies/HZ);
>  	if (drv && drv->resume)
>  		drv->resume(pci_dev);
>  	else
> 
> in order to identify the offending device.  I'm now almost sure that the 
> NVidia chipset is to blame but I don't know which part of it exactly.
> 
> I've got two logs (attached), one of which is taken from the system with all 
> modules loaded (swsusp.log), and the other comes from the system with no 
> modules except for ipv6 (swsusp-nomod.log).  As you can see from the first 
> log, the system with all modules loaded slows down significantly after 
> pci_device_resume() is called for the device having vendor id = 0x10de 
> (NVidia) and device id = 0x00d7 (no idea).  The system without modules is 

lspci, and take a look?

> capable of writing 80-83% of pages to the swap _before_ slows down too and I 
> have to wait for 1/2 h for the remaining ~20%.

Strange, *very* strange.

> I'm afraid I can't get any more info until I sort out the sysrq
> problem.

This should remap magic key to both-shifts-both-alts-key. Worked for
me once...
								Pavel

--- clean-mm/drivers/char/keyboard.c	2004-09-26 01:34:24.000000000 +0200
+++ linux-mm/drivers/char/keyboard.c	2004-09-26 01:42:24.000000000 +0200
@@ -1079,6 +1079,23 @@
 		sysrq_down = down;
 		return;
 	}
+	if (test_bit(KEY_LEFTALT, key_down) &&
+	    test_bit(KEY_RIGHTALT, key_down) &&
+	    test_bit(KEY_LEFTSHIFT, key_down) &&
+	    test_bit(KEY_RIGHTSHIFT, key_down) &&
+		down && !rep) {
+		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
+#ifdef CONFIG_KGDB_SYSRQ
+                sysrq_down = 0;        /* in case we miss the "up" event */
+#endif
+		return;
+	}
+
+	if (down)
+		set_bit(keycode, key_down);
+	else
+		clear_bit(keycode, key_down);
+
 	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
 #ifdef CONFIG_KGDB_SYSRQ
@@ -1114,11 +1131,6 @@
 		raw_mode = 1;
 	}
 
-	if (down)
-		set_bit(keycode, key_down);
-	else
-		clear_bit(keycode, key_down);
-
 	if (rep && (!vc_kbd_mode(kbd, VC_REPEAT) || (tty && 
 		(!L_ECHO(tty) && tty->driver->chars_in_buffer(tty))))) {
 		/*

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
