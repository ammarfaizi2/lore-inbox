Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262600AbTDAPqu>; Tue, 1 Apr 2003 10:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262609AbTDAPqu>; Tue, 1 Apr 2003 10:46:50 -0500
Received: from air-2.osdl.org ([65.172.181.6]:63892 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262600AbTDAPqr>;
	Tue, 1 Apr 2003 10:46:47 -0500
Date: Tue, 1 Apr 2003 07:58:30 +0000
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz, rmk@arm.linux.org.uk
Subject: Re: 2.5.59: Input subsystem initialised really late
Message-Id: <20030401075830.5920a692.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(resending, didn't show up on lkml last night;
must have email problems at home)


on 18-jan-2003 Russell King wrote:
It appears to be impossible to get a SysRQ-T dump out of a kernel
which has hung during (eg) the SCSI initialisation with 2.5.

Unlike previous 2.4 kernels, the keyboard is no longer initialised
until fairly late - after many of the other drivers have initialised.
Unfortunately, this means that it is quite difficult to debug these
hangs (we'll leave discussion about in-kernel debuggers for another time!)

Can we initialise the input subsystem earlier (eg, after pci bus
initialisation, before disks etc) so that we do have the ability to
use the SysRQ features?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
and Vojtech replied:
I think this should be possible, yes.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
and I wrote:
Any updates to this?  Any clues?

I have changed 5 module_inits to be run a little earlier in the initcall
sequence (the 5 being:  atkbd_init, kbd_init, serio_init, input_init,
and chr_dev_init).
However, this still isn't enough to allow keyboard input (like
ctrl-S, ctrl-Q, SysRq) during init messages as can be done with 2.4.20.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By adding one more earlier initcall (i8042_init) I now have earlier use
of SysRq keys.  I still don't have ctrl-S/ctrl-Q to control scrolling,
but this is better...

I don't know that all 6 of these changes are needed, but I don't have time
to determine that tonight.

Russell, does this meet your needs?
I've obviously only addressed x86 in this patch...
Patch is to 2.5.66.


~Randy


diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/char/keyboard.c linux-2566-kbd/drivers/char/keyboard.c
--- linux-2566-pv/drivers/char/keyboard.c	2003-03-24 14:00:19.000000000 -0800
+++ linux-2566-kbd/drivers/char/keyboard.c	2003-03-31 21:44:07.000000000 -0800
@@ -1232,3 +1232,5 @@
 
 	return 0;
 }
+
+arch_initcall(kbd_init);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/char/mem.c linux-2566-kbd/drivers/char/mem.c
--- linux-2566-pv/drivers/char/mem.c	2003-03-24 14:00:39.000000000 -0800
+++ linux-2566-kbd/drivers/char/mem.c	2003-03-30 15:16:03.000000000 -0800
@@ -716,4 +716,4 @@
 	return 0;
 }
 
-__initcall(chr_dev_init);
+arch_initcall(chr_dev_init);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/char/vt.c linux-2566-kbd/drivers/char/vt.c
--- linux-2566-pv/drivers/char/vt.c	2003-03-24 14:01:23.000000000 -0800
+++ linux-2566-kbd/drivers/char/vt.c	2003-03-31 21:43:49.000000000 -0800
@@ -2536,7 +2536,6 @@
 	if (tty_register_driver(&console_driver))
 		panic("Couldn't register console driver\n");
 
-	kbd_init();
 	console_map_init();
 #ifdef CONFIG_PROM_CONSOLE
 	prom_con_init();
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/input.c linux-2566-kbd/drivers/input/input.c
--- linux-2566-pv/drivers/input/input.c	2003-03-24 14:00:44.000000000 -0800
+++ linux-2566-kbd/drivers/input/input.c	2003-03-31 21:56:18.000000000 -0800
@@ -717,5 +717,5 @@
 	devclass_unregister(&input_devclass);
 }
 
-module_init(input_init);
+postcore_initcall(input_init);
 module_exit(input_exit);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/keyboard/atkbd.c linux-2566-kbd/drivers/input/keyboard/atkbd.c
--- linux-2566-pv/drivers/input/keyboard/atkbd.c	2003-03-24 14:01:16.000000000 -0800
+++ linux-2566-kbd/drivers/input/keyboard/atkbd.c	2003-03-31 21:57:24.000000000 -0800
@@ -597,5 +597,5 @@
 	serio_unregister_device(&atkbd_dev);
 }
 
-module_init(atkbd_init);
+arch_initcall(atkbd_init);
 module_exit(atkbd_exit);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/serio/i8042.c linux-2566-kbd/drivers/input/serio/i8042.c
--- linux-2566-pv/drivers/input/serio/i8042.c	2003-03-24 14:00:00.000000000 -0800
+++ linux-2566-kbd/drivers/input/serio/i8042.c	2003-03-31 21:45:18.000000000 -0800
@@ -870,5 +870,5 @@
 	i8042_platform_exit();
 }
 
-module_init(i8042_init);
+arch_initcall(i8042_init);
 module_exit(i8042_exit);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/serio/serio.c linux-2566-kbd/drivers/input/serio/serio.c
--- linux-2566-pv/drivers/input/serio/serio.c	2003-03-24 13:59:54.000000000 -0800
+++ linux-2566-kbd/drivers/input/serio/serio.c	2003-03-31 21:57:55.000000000 -0800
@@ -216,5 +216,5 @@
 	wait_for_completion(&serio_exited);
 }
 
-module_init(serio_init);
+postcore_initcall(serio_init);
 module_exit(serio_exit);


