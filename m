Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263160AbTDBVc0>; Wed, 2 Apr 2003 16:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263161AbTDBVc0>; Wed, 2 Apr 2003 16:32:26 -0500
Received: from air-2.osdl.org ([65.172.181.6]:60036 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263160AbTDBVcY>;
	Wed, 2 Apr 2003 16:32:24 -0500
Date: Wed, 2 Apr 2003 13:43:45 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, mtd@infradead.org
Subject: [PATCH 2.5.66] Convert elan-104nc to to remove check_region().
Message-ID: <20030402214345.GA17147@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moved the request_region() call to replace check_region() and adds
release_region()'s in the error paths that occure before the old
call to request_region().  NOTE: This patch just updates comments.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17

diff -nru a/drivers/mtd/maps/elan-104nc.c b/drivers/mtd/maps/elan-104nc.c
--- a/drivers/mtd/maps/elan-104nc.c	wed apr  2 10:57:40 2003
+++ b/drivers/mtd/maps/elan-104nc.c	wed apr  2 10:57:40 2003
@@ -30,8 +30,8 @@
 the single flash device is divided into 3 partition which appear as separate
 mtd devices.
 
-linux thinks that the i/o port is used by the pic and hence check_region() will
-always fail.  so we don't do it.  i just hope it doesn't break anything.
+linux thinks that the i/o port is used by the pic and hence request_region()
+will always fail.  so we don't do it.  i just hope it doesn't break anything.
 */
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -227,14 +227,14 @@
 	}
 
 	iounmap((void *)iomapadr);
-	release_region(page_io,page_io_size);
+	/* release_region(page_io,page_io_size); */
 }
 
 int __init init_elan_104nc(void)
 {
 	/* urg! we use i/o port 0x22 without request_region()ing it */
 	/*
-	if (check_region(page_io,page_io_size) != 0) {
+	if (!request_region(page_io,page_io_size, "elan-104nc flash")) {
 		printk( kern_err"%s: io ports 0x%x-0x%x in use\n",
 			elan_104nc_map.name,
 			page_io, page_io+page_io_size-1 );
@@ -245,12 +245,11 @@
 	if (!iomapadr) {
 		printk( kern_err"%s: failed to ioremap memory region\n",
 			elan_104nc_map.name );
+		/*
+		release_region(page_io,page_io_size);
+		*/
 		return -eio;
 	}
-
-	/*
-	request_region( page_io, page_io_size, "elan-104nc flash" );
-	*/
 
 	printk( kern_info"%s: io:0x%x-0x%x mem:0x%x-0x%x\n",
 		elan_104nc_map.name,
