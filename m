Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSJ0Avv>; Sat, 26 Oct 2002 20:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbSJ0Avv>; Sat, 26 Oct 2002 20:51:51 -0400
Received: from mail2.uklinux.net ([80.84.72.32]:50888 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id <S262190AbSJ0Avu>;
	Sat, 26 Oct 2002 20:51:50 -0400
Date: Sun, 27 Oct 2002 01:58:06 +0100 (BST)
From: Peter Denison <lkml@marshadder.uklinux.net>
X-X-Sender: peterd@marshall.localnet
To: Alan Cox <alan@redhat.com>, Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide.c initialisation order
Message-ID: <Pine.LNX.4.44.0210270137110.6331-100000@marshall.localnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Move ide_init_default_hwifs to ide_init() from ide_init_data()

On non-PCI boxes, in ide_init_data called from very early ide_setup, the
ide_init_default_hwifs() function calls -> ide_register_hw ->
ide_probe_module -> ide_probe_init -> etc. well before loads of other
important things like command-line processing were done. Move it to
ide_init().

(I guess nobody is testing 2.5.xx IDE on non-PCI hardware!)

Whether this call should be there at all is a matter for debate. The whole
of IDE startup is an unholy mess, not least in the plethora of "init",
"register" and "probe" named functions, which are not consistent. However,
now is not the time to tackle that!

Applies: 2.5.44 (and probably others!)

--- drivers/ide/ide.c.old	2002-10-19 12:43:39.000000000 +0100
+++ drivers/ide/ide.c	2002-10-19 23:30:43.000000000 +0100
@@ -345,9 +347,6 @@
 	for (index = 0; index < MAX_HWIFS; ++index)
 		init_hwif_data(index);

-	/* Add default hw interfaces */
-	ide_init_default_hwifs();
-
 	idebus_parameter = 0;
 	system_bus_speed = 0;
 }
@@ -3444,6 +3443,9 @@

 	init_ide_data();

+	/* Add default hw interfaces */
+	ide_init_default_hwifs();
+
 	initializing = 1;
 	ide_init_builtin_drivers();
 	initializing = 0;

-- 
Peter Denison <peterd at marshadder dot uklinux dot net>
Please use the address above only for personal mail, not copied to any lists
that are gatewayed to news or web pages unless the addresses are removed.

