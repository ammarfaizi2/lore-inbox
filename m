Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135248AbREBN4y>; Wed, 2 May 2001 09:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135250AbREBN4o>; Wed, 2 May 2001 09:56:44 -0400
Received: from zeus.kernel.org ([209.10.41.242]:52616 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S135248AbREBN4e>;
	Wed, 2 May 2001 09:56:34 -0400
Date: Wed, 2 May 2001 15:35:03 +0200
From: Johannes Kolb <johannes.kolb@gmx.net>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Problem: file /proc/tty/driver/serial does not get deleted on module unload in Kernel 2.4.4
Message-ID: <20010502153503.A1701@miraculix.amg.schulen.regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] Summary: The file /proc/tty/driver/serial does not get deleted on module unload
[2.] Description: If the serial driver (compiled as module) is loaded and then 
      unloaded, the proc-entry tty/driver/serial does not get deleted. 
      The remaining file is invalid and produces a kernel-oops on access.
[3.] Keywords: procfs, tty, serial driver
[4.] Kernel version: 2.4.4

[6.] Shell script:
      #!/bin/bash
      insmod serial
      rmmod serial
      ls /proc/tty/driver

[7.] Environment     (IMHO irrelevant)
[7.1.] Software:
        Linux jk1 2.4.4 #3 Mon Apr 30 00:11:51 CEST 2001 i586 unknown
         
        Gnu C                  2.95.3
        Gnu make               3.79
        binutils               2.10.1
        mount                  2.9y
        modutils               2.4.1
        e2fsprogs              1.19
        reiserfsprogs          3.x.0b
        PPP                    2.4.0
        Linux C Library        2.2.2
        Dynamic linker (ldd)   2.2.2
        Procps                 2.0.2
        Net-tools              1.46
        Kbd                    0.96
        Sh-utils               1.12
        Modules Loaded         serial isa-pnp ipchains
       
[6.2.] Processor:  Intel Pentium, 90 MHz 

[X.] Other notes

I played with the source and found out that the following one-line-patch helps.
If the function proc_tty_unregister is called, the string driver->driver_name
is empty, but ent->name still contains the right filename; so by using this
the proc-entry is deleted correctly.

--- linux/fs/proc/vanilla/proc_tty.c	Sun Apr 29 23:34:09 2001
+++ linux/fs/proc/proc_tty.c	Sun Apr 29 23:46:32 2001
@@ -161,7 +161,7 @@
 	if (!ent)
 		return;
 		
-	remove_proc_entry(driver->driver_name, proc_tty_driver);
+	remove_proc_entry(ent->name, proc_tty_driver);
 	
 	driver->proc_entry = 0;
 }

I'm not on this list, so please answer with CC to me.

hope, I could help,
bye

Johannes Kolb
